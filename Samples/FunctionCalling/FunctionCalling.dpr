program FunctionCalling;

uses
  Vcl.Forms,
  Main.View in 'Src\Main.View.pas' {MainView},
  uDM in 'Src\uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
