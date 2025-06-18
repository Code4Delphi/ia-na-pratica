program IAChat;

uses
  Vcl.Forms,
  View.Main in 'Src\View.Main.pas' {ViewMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
