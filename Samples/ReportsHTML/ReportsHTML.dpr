program ReportsHTML;

uses
  Vcl.Forms,
  ReportsHTML.Main.View in 'Src\ReportsHTML.Main.View.pas' {ReportsHTMLMainView},
  TMS.MCP.CloudAIBrowserTool in 'Src\TMS.MCP.CloudAIBrowserTool.pas',
  Database.Dm in 'Src\Database.Dm.pas' {DatabaseDm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabaseDm, DatabaseDm);
  Application.CreateForm(TReportsHTMLMainView, ReportsHTMLMainView);
  Application.Run;
end.
