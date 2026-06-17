program IAChat;

uses
  Vcl.Forms,
  Chat.Main.View in 'Src\Chat.Main.View.pas' {ChatMainView},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TChatMainView, ChatMainView);
  Application.Run;
end.
