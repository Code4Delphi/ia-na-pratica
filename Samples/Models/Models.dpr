program Models;

uses
  Vcl.Forms,
  Models.Main.View in 'Src\Models.Main.View.pas' {ModelsMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TModelsMainView, ModelsMainView);
  Application.Run;
end.
