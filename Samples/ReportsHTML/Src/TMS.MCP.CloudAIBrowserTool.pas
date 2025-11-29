unit TMS.MCP.CloudAIBrowserTool;

interface

uses
  System.Classes,
  TMS.MCP.CloudAI,
  VCL.TMSFNCWebBrowser,
  System.JSON;

type
  TTMSMCPCloudAIBrowser = class(TTMSMCPCloudAIToolSet)
  private
    FBrowser: TTMSFNCWebBrowser;
  protected
    procedure DoLoadHTML(Sender: TObject; Args: TJSONObject; var Result: string);
  public
    procedure DefineTools; override;
    property Browser: TTMSFNCWebBrowser read FBrowser write FBrowser;
  end;

implementation

procedure TTMSMCPCloudAIBrowser.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParameter: TTMSMCPCloudAIParameter;
begin
  inherited;
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Description := 'load and show HTML into the browser';
  LTool.Name := 'LoadHTML';

  LParameter := LTool.Parameters.Add;
  LParameter.&Type := ptString;
  LParameter.Required := true;
  LParameter.Name := 'html';
  LParameter.Description := 'string of the HTML/JavaScript that was generated for the browser';

  LTool.OnExecute := DoLoadHTML;

  EndUpdate;
end;

procedure TTMSMCPCloudAIBrowser.DoLoadHTML(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LHTML: string;
begin
  if Assigned(Args) and (Args.Count > 0) and Assigned(FBrowser) then
  begin
    LHTML := Args.GetValue<string>('html');
    FBrowser.LoadHTML(LHTML);
  end;
end;

end.
