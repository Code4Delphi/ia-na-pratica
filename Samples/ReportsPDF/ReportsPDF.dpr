program ReportsPDF;

uses
  Vcl.Forms,
  ReportsPDF.Main.View in 'Src\ReportsPDF.Main.View.pas' {ReportsPDFMainView},
  Database.Dm in 'Src\Database.Dm.pas' {DatabaseDm: TDataModule},
  ToolSet.PDF in 'Src\ToolSet.PDF.pas',
  ToolSet.Database in 'Src\ToolSet.Database.pas',
  fpdf in 'Src\fpdf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabaseDm, DatabaseDm);
  Application.CreateForm(TReportsPDFMainView, ReportsPDFMainView);
  Application.Run;
end.
