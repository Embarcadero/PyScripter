unit cAndroidPluginAdapter;

interface

uses
  System.Classes,
  System.IOUtils,
  System.StrUtils,
  cProjectClasses,
  cPySupportTypes,
  cAndroidPlugin,
  uEditAppIntfs;

type
  TPyAndroidPluginAdapter = class
  public
    class function CreateProject(const AProject: TProjectRootNode): TProjectModel;
    class procedure SetupProject([ref] AProject: TProjectModel;
      const ASettings: TRunConfiguration);
  end;

implementation

{ TPyAndroidPluginAdapter }

class function TPyAndroidPluginAdapter.CreateProject(
  const AProject: TProjectRootNode): TProjectModel;
begin
  Result := Default(TProjectModel);

  Result.ProjectName := AProject.Name;
  Result.ApplicationName := AProject.Caption;

  for var LFile in AProject.Children do begin
    if (TObject(LFile) is TProjectFileNode) then
      Result.AddFiles := Result.AddFiles + [TProjectFileNode(LFile).FileName]
    else if (TObject(LFile) is TProjectRunConfiguationNode) then
      Result.MainFile := TProjectRunConfiguationNode(LFile).RunConfig.ScriptName;
  end;

  if Result.MainFile.IsEmpty() and Assigned(Result.AddFiles) then
    Result.MainFile := Result.AddFiles[0];
end;

class procedure TPyAndroidPluginAdapter.SetupProject([ref] AProject: TProjectModel;
  const ASettings: TRunConfiguration);
var
  LMainFile: string;
begin
  if AProject.MainFile.IsEmpty() then begin
    var LEditor := GI_EditorFactory.GetEditorByFileId(ASettings.ScriptName);
    if Assigned(LEditor) then begin
      var LSource := LEditor.SynEdit.Text;
      LMainFile := TPath.Combine(TPath.GetTempPath(), TPath.ChangeExtension(ASettings.ScriptName, '.py'));
      TFile.WriteAllText(LMainFile, LSource);
    end else
      LMainFile := ASettings.ScriptName;

    if not MatchStr(LMainFile, AProject.AddFiles) then begin
      AProject.AddFiles := AProject.AddFiles + [LMainFile];
      AProject.MainFile := LMainFile;
    end;
  end;
end;

end.
