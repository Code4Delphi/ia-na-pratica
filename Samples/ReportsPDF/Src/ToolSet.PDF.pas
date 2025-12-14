unit ToolSet.PDF;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  ShellAPI,
  Vcl.Dialogs,
  TMS.MCP.CloudAI,
  fPDF;

type
  TToolSetPDF = class(TTMSMCPCloudAIToolSet)
  private
    procedure GerarPDFJSONArray(const AJSONArray: TJSONArray; const AFileName: string);
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
  LTool.Description := 'Loads the returned JSON content to generate the PDF report'; //'Carrega o conteúdo JSON retornado para gerar o relatório em PDF';
  LTool.Name := 'LoadJSON';

  LParameter := LTool.Parameters.Add;
  LParameter.&Type := ptString;
  LParameter.Required := true;
  LParameter.Name := 'JSON';
  LParameter.Description := 'JSON returned';

  LTool.OnExecute := DoLoadJSON;

  EndUpdate;
end;

procedure TToolSetPDF.DoLoadJSON(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LJSON: string;
  LRoot: TJSONObject;
  LJSONArray: TJSONArray;
  LFileName: string;
begin
  if not Assigned(Args) or (Args.Count = 0) then
    Exit;

  LJSON := Args.GetValue<string>('JSON');

  LRoot := TJSONObject.ParseJSONValue(LJSON) as TJSONObject;
  try
    LJSONArray := LRoot.GetValue('data') as TJSONArray;

    var LSaveDialog := TSaveDialog.Create(nil);
    try
      LSaveDialog.DefaultExt := 'PDF';
      LSaveDialog.Filter := 'Files PDF (*.pdf)|*.pdf';
      if not LSaveDialog.Execute then
        Exit;

      LFileName := LSaveDialog.FileName;
    finally
      LSaveDialog.Free;
    end;

    Self.GerarPDFJSONArray(LJSONArray, LFileName);
  finally
    LRoot.Free;
  end;
end;

procedure TToolSetPDF.GerarPDFJSONArray(const AJSONArray: TJSONArray; const AFileName: string);
var
  LPDF: TFPDF;
  I: Integer;
  J: Integer;
  LItem: TJSONObject;
  LPair: TJSONPair;
  LFields: TArray<string>;
  LColWidth: Double;
begin
  if not Assigned(AJSONArray) or (AJSONArray.Count = 0) then
    Exit;

  LPDF := TFPDF.Create;
  try
    LPDF.AddPage;
    LPDF.SetFont('Arial', '', 10);

    //HEADER
    LItem := AJSONArray.Items[0] as TJSONObject;
    SetLength(LFields, LItem.Count);
    LColWidth := LPDF.GetPageWidth / LItem.Count - 5;

    LPDF.SetFont('Arial', 'B', 10);
    for J := 0 to Pred(LItem.Count) do
    begin
      LFields[J] := LItem.Pairs[J].JsonString.Value;
      LPDF.Cell(LColWidth, 8, LFields[J], '1');
    end;
    LPDF.Ln;

    //DATA
    LPDF.SetFont('Arial', '', 10);
    for I := 0 to AJSONArray.Count - 1 do
    begin
      LItem := AJSONArray.Items[I] as TJSONObject;

      for J := 0 to Pred(Length(LFields)) do
      begin
        LPair := LItem.Get(LFields[J]);
        if Assigned(LPair) then
          LPDF.Cell(LColWidth, 8, LPair.JsonValue.Value, '1')
        else
          LPDF.Cell(LColWidth, 8, '', '1');
      end;

      LPDF.Ln;
    end;

    //TOTALIZER
    LPDF.Ln(5);
    LPDF.SetFont('Arial', 'B', 10);
    LPDF.Cell(LColWidth * Length(LFields), 8, 'Total records: ' + IntToStr(AJSONArray.Count), '1');

    LPDF.SaveToFile(AFileName);
    ShellExecute(0, 'open', PChar(AFileName), nil, nil, 1);
  finally
    LPDF.Free;
  end;
end;

function TToolSetPDF.ConfigPrompt(const APrompt: string): string;
const
  PROMPT_PDF = '. Return the data in JSON format directly into an array named "data" for the "LoadJSON" tool';
    //'. Retorne os dados no formato JSON diretamente em um array com nome "data" para a tool "LoadJSON"';
begin
  Result := APrompt;
  if Result.ToLower.Contains('relatório') or Result.ToLower.Contains('report')then
    Result := Result + sLineBreak + PROMPT_PDF;
end;

end.
