unit ToolSet.Excel;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  ShellAPI,
  Vcl.Dialogs,
  TMS.MCP.CloudAI;

type
  TToolSetExcel = class(TTMSMCPCloudAIToolSet)
  private
  protected
    procedure DoLoadCSV(Sender: TObject; Args: TJSONObject; var Result: string);
  public
    procedure DefineTools; override;
    function ConfigPrompt(const APrompt: string): string;
  end;

implementation

procedure TToolSetExcel.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParameter: TTMSMCPCloudAIParameter;
begin
  inherited;
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Description := 'Load the returned CSV file to generate the Excel report.';
  LTool.Name := 'LoadCSV';

  LParameter := LTool.Parameters.Add;
  LParameter.&Type := ptString;
  LParameter.Required := true;
  LParameter.Name := 'csv';
  LParameter.Description := 'CSV retornado para gerar o relatório excel';

  LTool.OnExecute := DoLoadCSV;

  EndUpdate;
end;

procedure TToolSetExcel.DoLoadCSV(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LCSV: string;
  LFileName: string;
begin
  if not Assigned(Args) or (Args.Count <= 0) then
    Exit;

  LCSV := Args.GetValue<string>('csv');

  var LSaveDialog := TSaveDialog.Create(nil);
  try
    LSaveDialog.DefaultExt := 'csv';
    LSaveDialog.Filter := 'Files CSV (*.csv)|*.csv';
    if not LSaveDialog.Execute then
      Exit;

    LFileName := LSaveDialog.FileName;
  finally
    LSaveDialog.Free;
  end;

  if ExtractFileExt(LFileName).Trim.IsEmpty then
    LFileName := LFileName+ '.csv';

  LCSV := LCSV.Replace('```csv', '').Replace('```', '');
  var LStr := TStringList.Create;
  try
    LStr.Add(LCSV);
    LStr.SaveToFile(LFileName);
  finally
    LStr.Free;
  end;

  ShellExecute(0, 'open', PChar(LFileName), nil, nil, 1);
end;

function TToolSetExcel.ConfigPrompt(const APrompt: string): string;
const
  PROMPT_EXCEL = '. Retorne os dados no formato CSV usando ; como separador. ' +
    'Retorne o CSV para que seja gerando um relatório no Excel';
begin
  Result := APrompt;
  if Result.ToLower.Contains('relatório') or Result.ToLower.Contains('report')then
    Result := Result + sLineBreak + PROMPT_EXCEL;
end;

end.
