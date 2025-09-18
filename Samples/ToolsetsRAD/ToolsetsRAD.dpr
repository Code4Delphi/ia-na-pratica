program ToolsetsRAD;

uses
  Vcl.Forms,
  ToolsetsRAD.Main.View in 'Src\ToolsetsRAD.Main.View.pas' {ToolsetsRADMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TToolsetsRADMainView, ToolsetsRADMainView);
  Application.Run;
end.
