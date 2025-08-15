program TTS_STT;

uses
  Vcl.Forms,
  Main.View in 'Src\Main.View.pas' {MainView},
  AudioRecorder in 'DelphiAudio\AudioRecorder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
