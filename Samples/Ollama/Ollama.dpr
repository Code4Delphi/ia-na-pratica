program Ollama;

uses
  Vcl.Forms,
  Ollama.Main.View in 'Src\Ollama.Main.View.pas' {OllamaMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TOllamaMainView, OllamaMainView);
  Application.Run;
end.
