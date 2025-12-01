unit TMS.MCP.CloudAIExcelTool;

interface

uses
  System.Classes,
  System.JSON,
  Vcl.Dialogs,
  TMS.MCP.CloudAI;

type
  TTMSMCPCloudAIExcelTool = class(TTMSMCPCloudAIToolSet)
  private

  protected
    procedure DoLoadCSV(Sender: TObject; Args: TJSONObject; var Result: string);
  public
    procedure DefineTools; override;
  end;

implementation

procedure TTMSMCPCloudAIExcelTool.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParameter: TTMSMCPCloudAIParameter;
begin
  inherited;
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Description := 'Carregar CSV retornado';
  LTool.Name := 'LoadCSV';

  LParameter := LTool.Parameters.Add;
  LParameter.&Type := ptString;
  LParameter.Required := true;
  LParameter.Name := 'csv';
  LParameter.Description := 'CSV retornado';

  LTool.OnExecute := DoLoadCSV;

  EndUpdate;
end;

procedure TTMSMCPCloudAIExcelTool.DoLoadCSV(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LCSV: string;
begin
  if not Assigned(Args) or (Args.Count <= 0) then
    Exit;

  LCSV := Args.GetValue<string>('csv');
  ShowMessage(LCSV);
end;

end.
