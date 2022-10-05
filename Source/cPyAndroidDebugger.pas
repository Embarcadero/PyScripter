unit cPyAndroidDebugger;

interface

uses
  WinApi.Windows,
  System.UITypes,
  System.SysUtils,
  System.Classes,
  System.Threading,
  PythonEngine,
  cPyBaseDebugger,
  cPyDebugger,
  cPyRemoteDebugger,
  cPySupportTypes,
  cProjectClasses,
  cAndroidPlugin,
  uEditAppIntfs;

type
  TPyRemoteAndroidInterpreter = class(TPyRemoteInterpreter)
  private
    FPlugin: TPyAndroidPlugin;
    function IsRunning(): boolean;
    procedure CheckRunning();
  protected
    fInterpreterCapabilities : TInterpreterCapabilities;
    fEngineType : TPythonEngineType;
    fCanDoPostMortem : Boolean;
    function SystemTempFolder: string; override;
    //TPyRemoteInterpreter
    procedure CreateAndRunServerProcess; override;
    procedure ConnectToServer; override;
    procedure ShutDownServer; override;
  public
    constructor Create();
    destructor Destroy; override;

    procedure Initialize; override;
    // Create matching debugger
    function CreateDebugger: TPyBaseDebugger; override;
    // Python Path
    function SysPathAdd(const Path : string) : boolean; override;
    function SysPathRemove(const Path : string) : boolean; override;
    procedure SysPathToStrings(Strings : TStrings); override;
    procedure StringsToSysPath(Strings : TStrings); override;
    // NameSpace
    function GetGlobals : TBaseNameSpaceItem; override;
    procedure GetModulesOnPath(const Path : Variant; SL : TStrings); override;
    function NameSpaceFromExpression(const Expr : string) : TBaseNameSpaceItem; override;
    function CallTipFromExpression(const Expr : string;
      var DisplayString, DocString : string) : Boolean; override;
    // Service routines
    procedure HandlePyException(Traceback: TPythonTraceback; ErrorMsg : string; SkipFrames : integer = 1); override;
    procedure SetCommandLine(ARunConfig : TRunConfiguration); override;
    procedure RestoreCommandLine; override;
    procedure ReInitialize; override;
    procedure CheckConnected(Quiet : Boolean = False; Abort : Boolean = True);  override;
    // FileName conversion
    function ToPythonFileName(const FileName: string): string; override;
    function FromPythonFileName(const FileName: string): string; override;
    // Main interface
    function ImportModule(Editor : IEditor; AddToNameSpace : Boolean = False) : Variant; override;
    procedure Run(ARunConfig : TRunConfiguration); override;
    function RunSource(Const Source, FileName : Variant; symbol : string = 'single') : boolean; override;
    procedure RunScript(FileName : string); override;
    function EvalCode(const Expr : string) : Variant; override;
    procedure SystemCommand(const Cmd : string); override;
    function GetObjectType(Ob : Variant) : string; override;
    function UnitTestResult : Variant; override;
    function NameSpaceItemFromPyObject(aName : string; aPyObject : Variant): TBaseNameSpaceItem; override;
    function RunTimeOnly: boolean; override;
  end;

  TPyRemAndroidDebugger = class(TPyRemDebugger)
  private
    function IsRunning(): boolean;
    procedure CheckRunning();
  protected
    procedure InitializeDebugger; override;
    procedure SetCommandLine(ARunConfig : TRunConfiguration); override;
    procedure RestoreCommandLine; override;
    procedure SetDebuggerBreakpoints; override;
    function GetPostMortemEnabled: boolean; override;
  public
    // Debugging
    procedure Debug(ARunConfig : TRunConfiguration; InitStepIn : Boolean = False;
            RunToCursorLine : integer = -1); override;
    procedure RunToCursor(Editor : IEditor; ALine: integer); override;
    procedure StepInto; override;
    procedure StepOver; override;
    procedure StepOut; override;
    procedure Resume; override;
    procedure Pause; override;
    procedure Abort; override;
    // Evaluate expression in the current frame
    procedure Evaluate(const Expr : string; out ObjType, Value : string); overload; override;
    function Evaluate(const Expr : string) : TBaseNamespaceItem; overload; override;
    // Like the InteractiveInterpreter runsource but for the debugger frame
    function RunSource(Const Source, FileName : Variant; symbol : string = 'single') : boolean; override;
    // functions to get TBaseNamespaceItems corresponding to a frame's gloabals and locals
    function GetFrameGlobals(Frame : TBaseFrameInfo) : TBaseNameSpaceItem; override;
    function GetFrameLocals(Frame : TBaseFrameInfo) : TBaseNameSpaceItem; override;
    function NameSpaceFromExpression(const Expr : string) : TBaseNameSpaceItem; override;
    procedure MakeThreadActive(Thread : TThreadInfo); override;
    procedure MakeFrameActive(Frame : TBaseFrameInfo); override;
    // post mortem stuff
    function HaveTraceback : boolean; override;
    procedure EnterPostMortem; override;
    procedure ExitPostMortem; override;
  end;

implementation

uses
  System.StrUtils,
  Vcl.Dialogs,
  JvGnugettext,
  uCommonFunctions,
  cPyControl,
  cAndroidPluginAdapter,
  cPyScripterSettings,
  VarPyth;

{ TPyRemoteAndroidInterpreter }

constructor TPyRemoteAndroidInterpreter.Create();
begin
  inherited Create(peRemoteAndroid);
  DebuggerClass := TPyRemAndroidDebugger;
  FPlugin := TPyAndroidPlugin.Create();
end;

destructor TPyRemoteAndroidInterpreter.Destroy;
begin
  FPlugin.Free();
  inherited;
end;

function TPyRemoteAndroidInterpreter.CallTipFromExpression(const Expr: string;
  var DisplayString, DocString: string): Boolean;
begin
  if IsRunning() then
    Result := inherited
  else
    Result := false;
end;

procedure TPyRemoteAndroidInterpreter.CheckConnected(Quiet, Abort: Boolean);
begin
  if not (fServerIsAvailable and fConnected) then
    inherited;
end;

procedure TPyRemoteAndroidInterpreter.CheckRunning;
begin
  if not IsRunning() then begin
    TThread.Synchronize(nil, procedure() begin
      StyledMessageDlg(_('The Android interpreter is only available while app is running in debug mode.'), mtError, [mbAbort], 0);
    end);
    Abort;
  end;
end;

procedure TPyRemoteAndroidInterpreter.ConnectToServer;
var
  SuppressOutput : IInterface;
  I: Integer;
  Source : string;
  InitScriptName : string;
  PySource : Variant;
begin
  fConnected := False;

  SuppressOutput := GI_PyInterpreter.OutputSuppressor; // Do not show errors

  // Try to connect a few times
  for i := 1 to 5 do begin
    try
      Conn := Rpyc.classic.connect('localhost', fSocketPort);
      fConnected := True;
      break;
    except
      // wait and try again
      with GetPythonEngine do if PyErr_Occurred <> nil then PyErr_Clear;
      Sleep(500);
    end;
  end;

  if fConnected then begin
    Conn._config.__setitem__('sync_request_timeout', None);

    InitScriptName := 'Rpyc_Init';
    Source := CleanEOLs(GI_PyIDEServices.GetStoredScript(InitScriptName).Text)+#10;
    PySource := VarPythonCreate(Source);
    Conn.execute(PySource);
    RPI := Conn.namespace.__getitem__('_RPI');
    Conn.namespace.__delitem__('_RPI');
    if PyIDEOptions.PrettyPrintOutput then
      RPI.setupdisplayhook();
    GetPythonEngine.CheckError;
    Initialize;

    var sys := Import('sys');
    Conn.modules.sys.stdout := sys.stdout;
  end;
end;

function TPyRemoteAndroidInterpreter.EvalCode(const Expr: string): Variant;
begin
  Result := inherited;
end;

procedure TPyRemoteAndroidInterpreter.CreateAndRunServerProcess;
begin
  fServerIsAvailable := false;

  if not Assigned(ActiveProject)
    or not Assigned(PyControl.RunConfig)
    or PyControl.RunConfig.ScriptName.IsEmpty() then
      Exit;

  var LProjectModel := TPyAndroidPluginAdapter.CreateProject(ActiveProject);
  TPyAndroidPluginAdapter.SetupProject(LProjectModel, PyControl.RunConfig);
  LProjectModel.PythonVersion := TPythonVersion.cp310;
  LProjectModel.Architecture := TArchitecture.arm64;

  if FPlugin.ProjectExists(LProjectModel.ProjectName) then
    FPlugin.RemoveProject(LProjectModel.ProjectName);

  if FPlugin.CreateProject(LProjectModel.ProjectName, false) then begin
    FPlugin.UpdateProject(LProjectModel);
    fServerIsAvailable := FPlugin.BuildProject(LProjectModel.ProjectName, true)
      and FPlugin.DeployProject(LProjectModel.ProjectName)
      and FPlugin.RunProject(LProjectModel.ProjectName, '', true, true);
  end;

  if fServerIsAvailable then
    fSocketPort := 5678;
end;

function TPyRemoteAndroidInterpreter.CreateDebugger: TPyBaseDebugger;
begin
  Result := TPyRemAndroidDebugger.Create(Self);
end;

procedure TPyRemoteAndroidInterpreter.SetCommandLine(
  ARunConfig: TRunConfiguration);
begin
  inherited;
end;

procedure TPyRemoteAndroidInterpreter.ShutDownServer;
var
  OldExceptHook : Variant;
begin
  if fServerIsAvailable then begin
    if Assigned(PyControl.ActiveDebugger) then
       PyControl.ActiveDebugger.Abort;

    if fConnected then begin
      try
        Conn.close();
      except
      end;
    end;
    fConnected := False;
    try
      VarClear(OutputRedirector);
    except
    end;
    try
      if not PyControl.Finalizing then
        GI_PyIDEServices.ClearPythonWindows;

      VarClear(fOldArgv);
      VarClear(RPI);
      VarClear(Conn);

      // Restore excepthook
      OldExceptHook := Varpyth.SysModule.__excepthook__;
      SysModule.excepthook := OldExceptHook;
    except
     // swallow exceptions
    end;
    Sleep(100);
  end;

  ServerTask := nil;
  fServerIsAvailable := False;
  fConnected := False;
end;

procedure TPyRemoteAndroidInterpreter.StringsToSysPath(Strings: TStrings);
begin
  inherited;
end;

function TPyRemoteAndroidInterpreter.SysPathAdd(const Path: string): boolean;
begin
  Result := inherited;
end;

function TPyRemoteAndroidInterpreter.SysPathRemove(const Path: string): boolean;
begin
  Result := inherited;
end;

procedure TPyRemoteAndroidInterpreter.SysPathToStrings(Strings: TStrings);
begin
  inherited;
end;

procedure TPyRemoteAndroidInterpreter.SystemCommand(const Cmd: string);
begin
  inherited;
end;

function TPyRemoteAndroidInterpreter.SystemTempFolder: string;
begin
  Result := inherited;
end;

function TPyRemoteAndroidInterpreter.FromPythonFileName(
  const FileName: string): string;
begin
  Result := inherited;
end;

function TPyRemoteAndroidInterpreter.GetGlobals: TBaseNameSpaceItem;
begin
  Result := inherited;
end;

procedure TPyRemoteAndroidInterpreter.GetModulesOnPath(const Path: Variant;
  SL: TStrings);
begin
  inherited;
end;

function TPyRemoteAndroidInterpreter.GetObjectType(Ob: Variant): string;
begin
  Result := inherited;
end;

procedure TPyRemoteAndroidInterpreter.HandlePyException(
  Traceback: TPythonTraceback; ErrorMsg: string; SkipFrames: integer);
begin
  inherited;
end;

function TPyRemoteAndroidInterpreter.ImportModule(Editor: IEditor;
  AddToNameSpace: Boolean): Variant;
begin
  Result := inherited;
end;

procedure TPyRemoteAndroidInterpreter.Initialize;
begin
  inherited;
end;

function TPyRemoteAndroidInterpreter.IsRunning: boolean;
begin
  Result := fConnected;
end;

function TPyRemoteAndroidInterpreter.NameSpaceFromExpression(
  const Expr: string): TBaseNameSpaceItem;
begin
  if IsRunning() then
    Result := inherited
  else
    Result := nil;
end;

function TPyRemoteAndroidInterpreter.NameSpaceItemFromPyObject(aName: string;
  aPyObject: Variant): TBaseNameSpaceItem;
begin
  if IsRunning() then
    Result := inherited
  else
    Result := nil;
end;

procedure TPyRemoteAndroidInterpreter.ReInitialize;
begin
  inherited;
end;

procedure TPyRemoteAndroidInterpreter.RestoreCommandLine;
begin
  inherited;
end;

procedure TPyRemoteAndroidInterpreter.Run(ARunConfig: TRunConfiguration);
begin
  inherited;
end;

procedure TPyRemoteAndroidInterpreter.RunScript(FileName: string);
begin
  inherited;
end;

function TPyRemoteAndroidInterpreter.RunSource(const Source, FileName: Variant;
  symbol: string): boolean;
begin
  CheckRunning();
  Result := inherited;
end;

function TPyRemoteAndroidInterpreter.RunTimeOnly: boolean;
begin
  Result := true;
end;

function TPyRemoteAndroidInterpreter.ToPythonFileName(const FileName: string): string;
begin
  Result := inherited;
end;

function TPyRemoteAndroidInterpreter.UnitTestResult: Variant;
begin
  Result := inherited;
end;

{ TPyRemAndroidDebugger }

function TPyRemAndroidDebugger.IsRunning: boolean;
begin
  Result := fRemotePython.Connected;
end;

procedure TPyRemAndroidDebugger.CheckRunning;
const
  ANDROID_DBG_MODE_ONLY = 'The Android debugger is only available while app is running in debug mode.';
begin
  if not IsRunning() then begin
    TThread.Synchronize(nil, procedure() begin
      StyledMessageDlg(_(ANDROID_DBG_MODE_ONLY), mtError, [mbAbort], 0);
    end);
    System.SysUtils.Abort;
  end;
end;

procedure TPyRemAndroidDebugger.InitializeDebugger;
begin
  if IsRunning() then
    inherited;
end;

procedure TPyRemAndroidDebugger.EnterPostMortem;
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.Evaluate(const Expr: string; out ObjType,
  Value: string);
begin
  CheckRunning();
  inherited;
end;

function TPyRemAndroidDebugger.Evaluate(const Expr: string): TBaseNamespaceItem;
begin
  CheckRunning();
  Result := inherited;
end;

procedure TPyRemAndroidDebugger.ExitPostMortem;
begin
  CheckRunning();
  inherited;
end;

function TPyRemAndroidDebugger.GetFrameGlobals(
  Frame: TBaseFrameInfo): TBaseNameSpaceItem;
begin
  CheckRunning();
  Result := inherited;
end;

function TPyRemAndroidDebugger.GetFrameLocals(
  Frame: TBaseFrameInfo): TBaseNameSpaceItem;
begin
  CheckRunning();
  Result := inherited;
end;

function TPyRemAndroidDebugger.GetPostMortemEnabled: boolean;
begin
  if IsRunning() then
    Result := inherited
  else
    Result := false;
end;

function TPyRemAndroidDebugger.HaveTraceback: boolean;
begin
  if IsRunning() then
    Result := inherited
  else
    Result := false;
end;

procedure TPyRemAndroidDebugger.MakeFrameActive(Frame: TBaseFrameInfo);
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.MakeThreadActive(Thread: TThreadInfo);
begin
  CheckRunning();
  inherited;
end;

function TPyRemAndroidDebugger.NameSpaceFromExpression(
  const Expr: string): TBaseNameSpaceItem;
begin
  CheckRunning();
  Result := inherited;
end;

procedure TPyRemAndroidDebugger.RestoreCommandLine;
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.RunToCursor(Editor: IEditor; ALine: integer);
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.SetCommandLine(ARunConfig: TRunConfiguration);
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.SetDebuggerBreakpoints;
begin
  CheckRunning();
  inherited;
end;

function TPyRemAndroidDebugger.RunSource(const Source, FileName: Variant;
  symbol: string): boolean;
begin
  CheckRunning();
  Result := inherited;
end;

procedure TPyRemAndroidDebugger.Debug(ARunConfig: TRunConfiguration;
  InitStepIn: Boolean; RunToCursorLine: integer);
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.Abort;
begin
  if IsRunning() then
    inherited;
end;

procedure TPyRemAndroidDebugger.Pause;
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.Resume;
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.StepInto;
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.StepOut;
begin
  CheckRunning();
  inherited;
end;

procedure TPyRemAndroidDebugger.StepOver;
begin
  CheckRunning();
  inherited;
end;

end.
