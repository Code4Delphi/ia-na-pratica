program IAChat;

uses
  Vcl.Forms,
  Chat.Main.View in 'Src\Chat.Main.View.pas' {ChatMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TChatMainView, ChatMainView);
  Application.Run;
end.
