unit Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudAI,
  uDM;

type
  TMainView = class(TForm)
    pnTop: TPanel;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    Splitter1: TSplitter;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    TMSFNCCloudAI1: TTMSFNCCloudAI;
    procedure FormCreate(Sender: TObject);
    procedure cBoxIAServiceChange(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure TMSFNCCloudAI1Tools0Execute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure TMSFNCCloudAI1Tools1Execute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure TMSFNCCloudAI1Tools2Execute(Sender: TObject; Args: TJSONObject; var Result: string);
  private
    function GetEndereco(const ACEP: string): string;
  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  TMSFNCCloudAI1.Logging := True;
  TMSFNCCloudAI1.LogFileName := '..\..\Files\FunctionCalling.log';

  TMSFNCCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  cBoxIAService.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 2; //6
  cBoxIAServiceChange(cBoxIAService);
end;

procedure TMainView.cBoxIAServiceChange(Sender: TObject);
begin
  var i := Integer(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(i);
end;

procedure TMainView.btnExecuteClick(Sender: TObject);
begin
  TMSFNCCloudAI1.Context := mmQuestion.Lines;
  TMSFNCCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

procedure TMainView.TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
end;

procedure TMainView.TMSFNCCloudAI1Tools0Execute(Sender: TObject; Args: TJSONObject; var Result: string);
begin
  Result := FloatToStr(Args.GetValue<Integer>('IdProduto') * 10);
end;

procedure TMainView.TMSFNCCloudAI1Tools1Execute(Sender: TObject; Args: TJSONObject; var Result: string);
begin
  Result := Self.GetEndereco(Args.GetValue<string>('CEP'));
end;

function TMainView.GetEndereco(const ACEP: string): string;
var
  LRequest: TTMSFNCCloudBase;
  LResult: string;
begin
  LRequest := TTMSFNCCloudBase.Create;
  try
    LRequest.Request.Host := 'https://viacep.com.br/ws/';
    LRequest.Request.Path := Format('%s/json', [ACEP.Replace('-', '', [])]);

    LRequest.ExecuteRequest(
      procedure(const ARequestResult: TTMSFNCCloudBaseRequestResult)
      begin
        LResult := ARequestResult.ResultString;
      end, nil, False);

    Result := LResult;
  finally
    LRequest.Free;
  end;
end;

procedure TMainView.TMSFNCCloudAI1Tools2Execute(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LDataIni: TDate;
  LDataFim: TDate;
begin
  LDataIni := StrToDateDef(Args.GetValue<string>('DataIni'), 0);
  LDataFim := StrToDateDef(Args.GetValue<string>('DataFim'), 0);

  DM.VendasListar(LDataIni, LDataFim);
  if DM.TBVendas.IsEmpty then
  begin
    Result := 'Não foram encontadas vendas neste período'; Result := Result + sLineBreak + DM.TBVendas.SQL.Text;
    Exit;
  end;

  Result := 'Vendas encontadas: ' + DM.TBVendas.RecordCount.ToString;

  DM.TBVendas.First;
  while not DM.TBVendas.Eof do
  begin
    Result := Result + sLineBreak +
      Format('%d - %s - %s', [DM.TBVendasId.AsInteger, DM.TBVendasdata.AsString, DM.TBVendasClienteNome.AsString]);

    DM.TBVendas.Next;
  end;

  Result := Result + sLineBreak + DM.TBVendas.SQL.Text;
end;

end.
