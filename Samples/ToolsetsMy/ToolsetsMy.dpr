program ToolsetsMy;

uses
  Vcl.Forms,
  ToolsetsMy.Main.View in 'Src\ToolsetsMy.Main.View.pas' {ToolsetsMyMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TToolsetsMyMainView, ToolsetsMyMainView);
  Application.Run;
end.
