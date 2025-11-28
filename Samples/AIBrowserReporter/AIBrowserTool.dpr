program AIBrowserTool;

uses
  Vcl.Forms,
  BrowserTool.View in 'BrowserTool.View.pas' {BrowserToolView},
  TMS.MCP.CloudAIBrowserTool in 'TMS.MCP.CloudAIBrowserTool.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TBrowserToolView, BrowserToolView);
  Application.Run;
end.
