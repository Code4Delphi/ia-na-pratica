program TTS_STT_Translate;

uses
  Vcl.Forms,
  Translate.Main.View in 'Src\Translate.Main.View.pas' {TranslateMainView},
  AudioRecorder in 'DelphiAudio\AudioRecorder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTranslateMainView, TranslateMainView);
  Application.Run;
end.
