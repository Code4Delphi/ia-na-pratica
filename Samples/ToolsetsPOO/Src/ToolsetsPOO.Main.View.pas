unit ToolsetsPOO.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  TMS.MCP.CustomComponent,
  TMS.MCP.Server,
  TMS.MCP.CloudAI,
  TMS.MCP.CloudBase;

type
  TToolSetCEP = class(TTMSMCPCloudAIToolSet)
  private
    procedure ToolSetCepExecute(Sender: TObject; Args: TJSONObject; var Result: string);
    function GetEndereco(const ACEP: string): string;
  protected
    procedure DefineTools; override;
  end;

  TToolsetsPOOMainView = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
  private
    FCloudAI: TTMSMCPCloudAI;
    FToolSetCEP: TToolSetCEP;
    procedure OnCloudAIExecuted(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
      AHttpStatusCode: Integer; AHttpResult: string);
  public

  end;

var
  ToolsetsPOOMainView: TToolsetsPOOMainView;

implementation

{$R *.dfm}

procedure TToolsetsPOOMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  FCloudAI := TTMSMCPCloudAI.Create(Self);
  FCloudAI.OnExecuted := Self.OnCloudAIExecuted;
  FCloudAI.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  FToolSetCEP := TToolSetCEP.Create(FCloudAI);
  FToolSetCEP.AI := FCloudAI;

  cBoxIAService.Items.Assign(FCloudAI.GetServices(True));
  cBoxIAService.ItemIndex := 0;
end;

procedure TToolsetsPOOMainView.OnCloudAIExecuted(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines := AResponse.Content;
end;

procedure TToolsetsPOOMainView.btnExecuteClick(Sender: TObject);
begin
  FCloudAI.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  mmResponse.Text := 'Processando...';
  FCloudAI.Context := mmQuestion.Lines;
  FCloudAI.Execute();
  ProgressBar1.State := pbsNormal;
end;

{ TToolSetCEP }
procedure TToolSetCEP.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Name := 'RetornaEndereco';
  LTool.Description := 'Retorna o endereço do CEP informado';
  LTool.OnExecute := Self.ToolSetCepExecute;

  LParam := LTool.Parameters.Add;
  LParam.Name := 'CEP';
  LParam.Description := 'CEP a ser utilizado para buscar endereço';

  EndUpdate;
end;

procedure TToolSetCEP.ToolSetCepExecute(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LCep: string;
begin
  LCep := Args.GetValue<string>('CEP', '');
  Result := Self.GetEndereco(LCep);
end;

function TToolSetCEP.GetEndereco(const ACEP: string): string;
var
  LRequest: TTMSMCPCloudBase;
  LResult: string;
begin
  LRequest := TTMSMCPCloudBase.Create;
  try
    LRequest.Request.Host := 'https://viacep.com.br/ws/';
    LRequest.Request.Path := Format('%s/json', [ACEP.Replace('-', '', [])]);

    LRequest.ExecuteRequest(
      procedure(const ARequestResult:TTMSMCPCloudBaseRequestResult)
      begin
        LResult := ARequestResult.ResultString;
      end, nil, False);

    Result := LResult;
  finally
    LRequest.Free;
  end;
end;

end.
