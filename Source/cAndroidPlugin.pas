unit cAndroidPlugin;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  WinApi.Windows,
  cTools,
  JclSysUtils;

type
  TEnvironmentModel = record
  public
    //SDK Settings
    SdkBasePath: string;
    ApkSignerLocation: string;
    AdbLocation: string;
    AAptLocation: string;
    SdkApiLocation: string;
    ZipAlignLocation: string;
    //JDK Settings
    JdkBasePath: string;
    KeyToolLocation: string;
    JarSignerLocation: string;
    //Debugger Settings
    RemoteDebuggerHost: string;
    RemoteDebuggerPort: integer;
    RemoteRootPath: string;
  end;

  TPythonVersion = (cp38, cp39, cp310);
  TArchitecture = (arm32, arm64);

  TProjectModel = record
  public
    ProjectName: string;
    ApplicationName: string;
    PackageName: string;
    VersionCode: integer;
    VersionName: string;
    PythonVersion: TPythonVersion;
    Architecture: TArchitecture;
    //Files
    MainFile: string;
    AddFiles: TArray<string>;
    RemoveFiles: TArray<string>;
    //Splash
    DrawableSmall: string;
    DrawableNormal: string;
    DrawableLarge: string;
    DrawableXLarge: string;
    //Icon
    DrawableLdpi: string;
    DrawableMdpi: string;
    DrawableHdpi: string;
    DrawableXhdpi: string;
    DrawableXxhdpi: string;
    DrawableXxxhdpi: string;
  end;

  TPyAndroidPlugin = class
  private
    const FAILURE_MAP: array [0..1] of string = (
      '',
      '');
  private
    FToolPath: string;
    FSubprocessOptions: TJclExecuteCmdProcessOptions;
    FExitCode: integer;
    FOutput: string;
    FError: string;
    FCallback: TProc<string>;
    procedure SetupSubprocess();
    procedure OnOutput(const Bytes: TBytes; BytesRead: Cardinal);
    procedure OnError(const Bytes: TBytes; BytesRead: Cardinal);
  protected
    procedure CheckTool(const ATool: string);
    function ExecuteCommand(const ACmd: string; ATool: string = ''): integer;
  public
    constructor Create();
    destructor Destroy(); override;
    //FMXBuilder availability knowlegment
    function IsAvailable(): boolean;
    //Common routines
    function ListDevices(): TArray<string>;
    function ListProjects(): TArray<string>;
    function ProjectExists(const AProjectName: string): boolean;
    //Entity routines
    function UpdateEnvironment(const AEnvironmentModel: TEnvironmentModel;
      const AUseFinder: boolean;
      const AAllowFinderOverrides: boolean): boolean;
    function UpdateProject(
      const AProjectModel: TProjectModel): boolean;
    //Project creation/remotion routines
    function CreateProject(const AProjectName: string;
      const ACreateMainFile: boolean = false): boolean;
    function RemoveProject(const AProjectName: string): boolean;
    //Project building routines
    function BuildProject(const AProjectName: string;
      const ADebugMode: boolean = false; const AVerbose: boolean = false;
      const ACallback: TProc<string> = nil): boolean;
    function DeployProject(const AProjectName: string;
      const ADevice: string = ''; const AUninstall: boolean = true;
      const AVerbose: boolean = false;
      const ACallback: TProc<string> = nil): boolean;
    function RunProject(const AProjectName: string;
      const ADevice: string = ''; const ADebugMode: boolean = false;
      const AVerbose: boolean = false;
      const ACallback: TProc<string> = nil): boolean;
    //FMXBuilder path
    property ToolPath: string read FToolPath write FToolPath;
    //Last execution status flags
    property ExitCode: integer read FExitCode;
    property Output: string read FOutput;
    property Error: string read FError;
  end;

  TPythonVersionHelper = record helper for TPythonVersion
  public
    function ToString(): string;
  end;

  TArchitectureHelper = record helper for TArchitecture
  public
    function ToString(): string;
  end;

implementation

uses
  System.IOUtils,
  System.StrUtils;

{ TPyAndroidPlugin }

constructor TPyAndroidPlugin.Create;
begin
  inherited;
  FToolPath := TPath.Combine(
    TPath.GetDirectoryName(ParamStr(0)),
    TPath.Combine(
      TPath.Combine('plugins', 'fmxbuilder'),
      'pythonfmxbuildercli.exe'));
  SetupSubprocess();
end;

destructor TPyAndroidPlugin.Destroy;
begin
  FSubprocessOptions.Free();
  inherited;
end;

function TPyAndroidPlugin.IsAvailable: boolean;
begin
  Result := TFile.Exists(FToolPath);
end;

procedure TPyAndroidPlugin.CheckTool(const ATool: string);
begin
  if not TFile.Exists(ATool) then
    raise Exception.CreateFmt('The "%s" tool is not available.', [ATool]);
end;

function TPyAndroidPlugin.ExecuteCommand(const ACmd: string; ATool: string): integer;
begin
  FExitCode := 0;
  FError := String.Empty;
  FOutput := String.Empty;
  if ATool.Trim().IsEmpty() then
    ATool := FToolPath;
  CheckTool(ATool);
  FSubprocessOptions.CommandLine := ATool + ' ' + ACmd;
  ExecuteCmdProcess(FSubprocessOptions);
  FExitCode := FSubprocessOptions.ExitCode;
  Result := FExitCode;
end;

procedure TPyAndroidPlugin.OnError(const Bytes: TBytes; BytesRead: Cardinal);
begin
  var LStr := TEncoding.UTF8.GetString(Bytes, 0, BytesRead);
  FError := FError + LStr;
  if Assigned(FCallback) then
    FCallback(LStr);
end;

procedure TPyAndroidPlugin.OnOutput(const Bytes: TBytes; BytesRead: Cardinal);
begin
  var LStr := TEncoding.UTF8.GetString(Bytes, 0, BytesRead);
  FOutput := FOutput + LStr;
  if Assigned(FCallback) then
    FCallback(LStr);
end;

function TPyAndroidPlugin.ProjectExists(const AProjectName: string): boolean;
begin
  Result := MatchStr(AProjectName, ListProjects());
end;

procedure TPyAndroidPlugin.SetupSubprocess;
begin
  FSubprocessOptions := TJclExecuteCmdProcessOptions.Create('');
  FSubprocessOptions.OutputBufferCallback := OnOutput;
  FSubprocessOptions.ErrorBufferCallback := OnError;
  FSubprocessOptions.CreateProcessFlags :=
    FSubprocessOptions.CreateProcessFlags or CREATE_NO_WINDOW or CREATE_UNICODE_ENVIRONMENT;
  FSubprocessOptions.StartupVisibility := svNotSet;
  FSubprocessOptions.MergeError := False;
  FSubprocessOptions.RawOutput := True;
  FSubprocessOptions.RawError := True;
end;

function TPyAndroidPlugin.ListDevices: TArray<string>;
begin
  if ExecuteCommand('device -l') <> 0 then
    Result := TArray<string>.Create()
  else
    Result := FOutput.Trim().Split([sLineBreak]);
end;

function TPyAndroidPlugin.ListProjects: TArray<string>;
begin
  if ExecuteCommand('list') <> 0 then
    Result := TArray<string>.Create()
  else
    Result := FOutput.Trim().Split([sLineBreak]);
end;

function TPyAndroidPlugin.UpdateEnvironment(
  const AEnvironmentModel: TEnvironmentModel; const AUseFinder,
  AAllowFinderOverrides: boolean): boolean;
begin
  var LCmd := 'environment';

  //SDK
  if not AEnvironmentModel.SdkBasePath.Trim().IsEmpty() then
    LCmd := LCmd + ' --sdk_base_path ' + AEnvironmentModel.SdkBasePath.Trim();

  if not AUseFinder then begin
    if not AEnvironmentModel.ApkSignerLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --apk_signer_location ' + AEnvironmentModel.ApkSignerLocation.Trim();

    if not AEnvironmentModel.AdbLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --adb_location ' + AEnvironmentModel.AdbLocation.Trim();

    if not AEnvironmentModel.AAptLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --apt_location ' + AEnvironmentModel.AAptLocation.Trim();

    if not AEnvironmentModel.SdkApiLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --sdk_api_location ' + AEnvironmentModel.SdkApiLocation.Trim();

    if not AEnvironmentModel.ZipAlignLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --zip_align_location ' + AEnvironmentModel.ZipAlignLocation.Trim();
  end;

  //JDK
  if not AEnvironmentModel.JdkBasePath.Trim().IsEmpty() then
    LCmd := LCmd + ' --jdk_base_path ' + AEnvironmentModel.JdkBasePath.Trim();

  if not AUseFinder then begin
    if not AEnvironmentModel.KeyToolLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --key_tool_location ' + AEnvironmentModel.KeyToolLocation.Trim();

    if not AEnvironmentModel.JarSignerLocation.Trim().IsEmpty() then
      LCmd := LCmd + ' --jar_signer_location ' + AEnvironmentModel.JarSignerLocation.Trim();
  end;

  //Debugger
  //if not AEnvironmentModel.AdbLocation.Trim().IsEmpty() then
  //  LCmd := LCmd + ' --adb_location ' + AEnvironmentModel.AdbLocation.Trim();

  //if not AEnvironmentModel.AdbLocation.Trim().IsEmpty() then
  //  LCmd := LCmd + ' --adb_location ' + AEnvironmentModel.AdbLocation.Trim();

  //if not AEnvironmentModel.AdbLocation.Trim().IsEmpty() then
  //  LCmd := LCmd + ' --adb_location ' + AEnvironmentModel.AdbLocation.Trim();

  if AUseFinder then
    LCmd := LCmd + ' -f';

  if AUseFinder and AAllowFinderOverrides then
    LCmd := LCmd + ' -o';

  Result := ExecuteCommand(LCmd) = 0;
end;

function TPyAndroidPlugin.UpdateProject(
  const AProjectModel: TProjectModel): boolean;
begin
  var LCmd := 'project ' + AProjectModel.ProjectName.Trim();

  if not AProjectModel.ApplicationName.Trim().IsEmpty() then
    LCmd := LCmd + ' --application_name ' + AProjectModel.ApplicationName.Trim();

  if not AProjectModel.PackageName.Trim().IsEmpty() then
    LCmd := LCmd + ' --package_name ' + AProjectModel.PackageName.Trim();

  if AProjectModel.VersionCode > 0 then
    LCmd := LCmd + ' --version_code ' + AProjectModel.VersionCode.ToString();

  if not AProjectModel.VersionName.Trim().IsEmpty() then
    LCmd := LCmd + ' --version_name ' + AProjectModel.VersionName.Trim();

  LCmd := LCmd + ' --python_version ' + AProjectModel.PythonVersion.ToString();

  LCmd := LCmd + ' --architecture ' + AProjectModel.Architecture.ToString();

  if not AProjectModel.MainFile.Trim().IsEmpty() then
    LCmd := LCmd + ' --main_file ' + AProjectModel.MainFile.Trim();

  for var LFile in AProjectModel.AddFiles do begin
    LCmd := LCmd + ' --add_file ' + LFile.Trim();
  end;

  for var LFile in AProjectModel.RemoveFiles do begin
    LCmd := LCmd + ' --remove_file ' + LFile.Trim();
  end;

  if not AProjectModel.DrawableSmall.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_small ' + AProjectModel.DrawableSmall.Trim();

  if not AProjectModel.DrawableNormal.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_normal ' + AProjectModel.DrawableNormal.Trim();

  if not AProjectModel.DrawableLarge.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_large ' + AProjectModel.DrawableLarge.Trim();

  if not AProjectModel.DrawableXLarge.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_xlarge ' + AProjectModel.DrawableXLarge.Trim();

  if not AProjectModel.DrawableLdpi.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_ldpi ' + AProjectModel.DrawableLdpi.Trim();

  if not AProjectModel.DrawableMdpi.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_mdpi ' + AProjectModel.DrawableMdpi.Trim();

  if not AProjectModel.DrawableHdpi.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_hdpi ' + AProjectModel.DrawableHdpi.Trim();

  if not AProjectModel.DrawableXhdpi.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_xhdpi ' + AProjectModel.DrawableXhdpi.Trim();

  if not AProjectModel.DrawableXxhdpi.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_xxhdpi ' + AProjectModel.DrawableXxhdpi.Trim();

  if not AProjectModel.DrawableXxxhdpi.Trim().IsEmpty() then
    LCmd := LCmd + ' --drawable_xxxhdpi ' + AProjectModel.DrawableXxxhdpi.Trim();

  Result := ExecuteCommand(LCmd) = 0;
end;

function TPyAndroidPlugin.CreateProject(const AProjectName: string;
  const ACreateMainFile: boolean): boolean;
begin
  var LCmd := Format('create --name %s', [AProjectName]);
  if ACreateMainFile then
    LCmd := LCmd + ' -main';

  Result := ExecuteCommand(LCmd) = 0;
end;

function TPyAndroidPlugin.RemoveProject(const AProjectName: string): boolean;
begin
  Result := ExecuteCommand(Format('remove --name %s -y', [AProjectName])) = 0;
end;

function TPyAndroidPlugin.BuildProject(const AProjectName: string;
  const ADebugMode: boolean; const AVerbose: boolean;
  const ACallback: TProc<string>): boolean;
begin
  var LCmd := Format('build --name %s', [AProjectName]);
  if AVerbose then
    LCmd := LCmd + ' -v';

  if ADebugMode then
    LCmd := LCmd + ' --debugger rpyc';

  FCallback := ACallback;
  try
    Result := ExecuteCommand(LCmd) = 0;
  finally
    FCallback := nil;
  end;
end;

function TPyAndroidPlugin.DeployProject(const AProjectName, ADevice: string;
  const AUninstall, AVerbose: boolean; const ACallback: TProc<string>): boolean;
begin
  var LCmd := Format('deploy --name %s', [AProjectName]);

  if not ADevice.Trim().IsEmpty() then
    LCmd := LCmd + Format('--device %s', [ADevice]);

  if AUninstall then
    LCmd := LCmd + ' -u';

  if AVerbose then
    LCmd := LCmd + ' -v';

  FCallback := ACallback;
  try
    Result := ExecuteCommand(LCmd) = 0;
  finally
    FCallback := nil;
  end;
end;

function TPyAndroidPlugin.RunProject(const AProjectName, ADevice: string;
  const ADebugMode, AVerbose: boolean; const ACallback: TProc<string>): boolean;
begin
  var LCmd := Format('run --name %s', [AProjectName]);

  if not ADevice.Trim().IsEmpty() then
    LCmd := LCmd + Format('--device %s', [ADevice]);

  if ADebugMode then
    LCmd := LCmd + ' -dbg';

  if AVerbose then
    LCmd := LCmd + ' -v';

  FCallback := ACallback;
  try
    Result := ExecuteCommand(LCmd) = 0;
  finally
    FCallback := nil;
  end;
end;

{ TPythonVersionHelper }

function TPythonVersionHelper.ToString: string;
begin
  case Self of
    cp38 : Result := 'cp38';
    cp39 : Result := 'cp39';
    cp310: Result := 'cp310';
  end;
end;

{ TArchitectureHelper }

function TArchitectureHelper.ToString: string;
begin
  case Self of
    arm32: Result := 'arm32';
    arm64: Result := 'arm64';
  end;
end;

end.
