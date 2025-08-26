program Toolsets;

uses
  Vcl.Forms,
  Toolsets.Main.View in 'Src\Toolsets.Main.View.pas' {ToolsetsMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TToolsetsMainView, ToolsetsMainView);
  Application.Run;
end.
