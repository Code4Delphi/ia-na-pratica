program RAG;

uses
  Vcl.Forms,
  RAG.Main.View in 'Src\RAG.Main.View.pas' {RAGMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRAGMainView, RAGMainView);
  Application.Run;
end.
