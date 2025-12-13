program ReportsExcel;

uses
  Vcl.Forms,
  ReportsExcel.Main.View in 'Src\ReportsExcel.Main.View.pas' {ReportsExcelMainView},
  Database.Dm in 'Src\Database.Dm.pas' {DatabaseDm: TDataModule},
  ToolSet.Excel in 'Src\ToolSet.Excel.pas',
  ToolSet.Database in 'Src\ToolSet.Database.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabaseDm, DatabaseDm);
  Application.CreateForm(TReportsExcelMainView, ReportsExcelMainView);
  Application.Run;
end.
