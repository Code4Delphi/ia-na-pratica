unit Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  Data.DB,
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
    gBoxDefaultsPrompts: TGroupBox;
    pnDefaultsPrompts01: TPanel;
    Button3: TButton;
    Button4: TButton;
    pnDefaultsPrompts02: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure TMSFNCCloudAI1Tools0Execute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure TMSFNCCloudAI1Tools1Execute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure TMSFNCCloudAI1Tools2Execute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TMSFNCCloudAI1Tools3Execute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
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

  TMSFNCCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSFNCCloudAI1.Settings.WebSearch := True;

  cBoxIAService.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 0;
end;

procedure TMainView.Button5Click(Sender: TObject);
begin
  mmQuestion.Text := 'Retorne o estoque do produto informado id 10';
end;

procedure TMainView.Button3Click(Sender: TObject);
begin
  mmQuestion.Text := 'Retorne os dados do cliente ID 3';
end;

procedure TMainView.Button4Click(Sender: TObject);
begin
  mmQuestion.Clear;
  mmQuestion.Lines.Add('- Pegue o nome do cliente ID 3.');
  mmQuestion.Lines.Add('- Depois crie o texto de um e-mail para este nome agradecendo sua inscrição no canal da Code4Delphi');
end;

procedure TMainView.Button1Click(Sender: TObject);
begin
  mmQuestion.Text := 'Retorne os dados das vendas do periodo 01/06/2025 a 24/06/2025';
end;

procedure TMainView.Button2Click(Sender: TObject);
begin
  cBoxIAService.ItemIndex := 0;
  mmQuestion.Text := 'Retorne os dados das vendas do periodo 01/06/2025 a 25/06/2025' + sLineBreak +
    'Mostre as 5 primeiras vendas';
end;

procedure TMainView.Button6Click(Sender: TObject);
begin
  mmQuestion.Text := 'Qual é o endereço do CEP: 13098-615';
end;

procedure TMainView.Button7Click(Sender: TObject);
begin
  mmQuestion.Clear;
  mmQuestion.Lines.Add('- Qual é o endereço do CEP: 13098-615.');
  mmQuestion.Lines.Add('- Logo depois pesquise na internet quantos habitantes tem a cidade do CEP.');
end;

procedure TMainView.btnExecuteClick(Sender: TObject);
begin
  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

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
var
  LIdProduto: Integer;
begin
  LIdProduto := Args.GetValue<Integer>('IdProduto', 0);
  if LIdProduto <= 0 then
  begin
    Result := 'Código do produto não pode ser recuperado';
    Exit;
  end;

  DM.ProdutosGet(LIdProduto);
  if dm.TBProdutos.IsEmpty then
  begin
    Result := 'Nenhum produto foi encontrado com o código: ' + LIdProduto.ToString;
    Exit;
  end;

  Result := DM.TBProdutosid.AsString + sLineBreak +
    'Nome: ' + DM.TBProdutosnome.AsString + sLineBreak +
    'Estoque: ' + DM.TBProdutosestoque.AsString + sLineBreak +
    'Preço: ' + DM.TBProdutospreco.AsString;
end;

procedure TMainView.TMSFNCCloudAI1Tools3Execute(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LIdCLiente: Integer;
begin
  LIdCLiente := Args.GetValue<Integer>('IdCliente', 0);
  if LIdCLiente <= 0 then
  begin
    Result := 'Código do cliente não pode ser recuperado';
    Exit;
  end;

  DM.ClienteGet(LIdCLiente);
  if dm.TBClientes.IsEmpty then
  begin
    Result := 'Nenhum cliente foi encontrado com o código: ' + LIdCLiente.ToString;
    Exit;
  end;

  Result := DM.TBClientesId.AsString + ' - ' +  DM.TBClientesnome.AsString;
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
    Result := 'Não foram encontadas vendas neste período';
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
end;



end.
