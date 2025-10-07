unit TokenUsageTracking.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI, Vcl.Buttons;

type
  TTokenUsageTrackingMainView = class(TForm)
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    pnTop: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cBoxIAService: TComboBox;
    ckGerarLogs: TCheckBox;
    edtTemperature: TEdit;
    ckWebSearch: TCheckBox;
    edtMaxTokens: TEdit;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    gBoxTokensConsumedCurrentRequest: TGroupBox;
    Label9: TLabel;
    lbNumTokensResponse: TLabel;
    Label10: TLabel;
    lbPromptTokens: TLabel;
    Label11: TLabel;
    lbServiceModel: TLabel;
    Label12: TLabel;
    lbTotalTokens: TLabel;
    gBoxTokensUsedSession: TGroupBox;
    Label2: TLabel;
    lbNumTokensResponseUsedSession: TLabel;
    Label4: TLabel;
    lbPromptTokensUsedSession: TLabel;
    Label8: TLabel;
    lbTotalTokensUsedSession: TLabel;
    btnUsageReset: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnUsageResetClick(Sender: TObject);
  private
    procedure ClearResponse;
    procedure Settings;
  public

  end;

var
  TokenUsageTrackingMainView: TTokenUsageTrackingMainView;

implementation

{$R *.dfm}

procedure TTokenUsageTrackingMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 6;

  Self.Settings;
end;

procedure TTokenUsageTrackingMainView.Settings;
begin
  TMSMCPCloudAI1.Logging := ckGerarLogs.Checked;
  TMSMCPCloudAI1.LogFileName := '..\..\Files\Chat.log';

  TMSMCPCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSMCPCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
  TMSMCPCloudAI1.Settings.WebSearch := ckWebSearch.Checked;
end;

procedure TTokenUsageTrackingMainView.btnUsageResetClick(Sender: TObject);
begin
  TMSMCPCloudAI1.Usage.Reset;
  Self.ClearResponse;
end;

procedure TTokenUsageTrackingMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';

  lbPromptTokensUsedSession.Caption := '0';
  lbNumTokensResponseUsedSession.Caption := '0';
  lbTotalTokensUsedSession.Caption := '0';
end;

procedure TTokenUsageTrackingMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
  lbServiceModel.Caption := AResponse.ServiceModel;

  lbPromptTokens.Caption := AResponse.PromptTokens.ToString;
  lbNumTokensResponse.Caption := AResponse.CompletionTokens.ToString;
  lbTotalTokens.Caption := AResponse.TotalTokens.ToString;

  lbPromptTokensUsedSession.Caption := TMSMCPCloudAI1.Usage.PromptTokens.ToString;
  lbNumTokensResponseUsedSession.Caption := TMSMCPCloudAI1.Usage.CompletionTokens.ToString;
  lbTotalTokensUsedSession.Caption := TMSMCPCloudAI1.Usage.TotalTokens.ToString;
end;

procedure TTokenUsageTrackingMainView.btnExecuteClick(Sender: TObject);
begin
  Self.ClearResponse;
  Self.Settings;

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  mmResponse.Text := 'Processando...';
  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

end.
