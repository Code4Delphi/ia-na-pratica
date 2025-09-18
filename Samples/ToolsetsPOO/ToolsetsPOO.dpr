program ToolsetsPOO;

uses
  Vcl.Forms,
  ToolsetsPOO.Main.View in 'Src\ToolsetsPOO.Main.View.pas' {ToolsetsPOOMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TToolsetsPOOMainView, ToolsetsPOOMainView);
  Application.Run;
end.
