unit ToolSet.PDF;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  ShellAPI,
  Vcl.Dialogs,
  TMS.MCP.CloudAI;

type
  TToolSetPDF = class(TTMSMCPCloudAIToolSet)
  private
  protected
    procedure DoLoadJSON(Sender: TObject; Args: TJSONObject; var Result: string);
  public
    procedure DefineTools; override;
    function ConfigPrompt(const APrompt: string): string;
  end;

implementation

procedure TToolSetPDF.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParameter: TTMSMCPCloudAIParameter;
begin
  inherited;
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Description := 'Carrega o conteúdo JSON retornado para gerar o relatório em PDF'; //'Load the returned JSON file to generate the PDF report';
  LTool.Name := 'LoadJSON';

  LParameter := LTool.Parameters.Add;
  LParameter.&Type := ptString;
  LParameter.Required := true;
  LParameter.Name := 'JSON';
  LParameter.Description := 'JSON retornado'; //'JSON returned to generate the PDF report';

  LTool.OnExecute := DoLoadJSON;

  EndUpdate;
end;

procedure TToolSetPDF.DoLoadJSON(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LJSON: string;
  LFileName: string;
begin
  if not Assigned(Args) or (Args.Count <= 0) then
    Exit;

  LJSON := Args.GetValue<string>('JSON');

  var LSaveDialog := TSaveDialog.Create(nil);
  try
    LSaveDialog.DefaultExt := 'json';
    LSaveDialog.Filter := 'Files JSON (*.json)|*.json';
    if not LSaveDialog.Execute then
      Exit;

    LFileName := LSaveDialog.FileName;
  finally
    LSaveDialog.Free;
  end;

  if ExtractFileExt(LFileName).Trim.IsEmpty then
    LFileName := LFileName+ '.json';

  LJSON := LJSON.Replace('```json', '').Replace('```', '');
  ShowMessage(LJSON);
  var LStr := TStringList.Create;
  try
    LStr.Add(LJSON);
    LStr.SaveToFile(LFileName);
  finally
    LStr.Free;
  end;

  ShellExecute(0, 'open', PChar(LFileName), nil, nil, 1);
end;

function TToolSetPDF.ConfigPrompt(const APrompt: string): string;
const
  PROMPT_PDF = '. Retorne os dados no formato JSON diretamente em um array com nome "dados" para a tool "LoadJSON"';
begin
  Result := APrompt;
  if Result.ToLower.Contains('relatório') or Result.ToLower.Contains('report')then
    Result := Result + sLineBreak + PROMPT_PDF;
end;

end.
