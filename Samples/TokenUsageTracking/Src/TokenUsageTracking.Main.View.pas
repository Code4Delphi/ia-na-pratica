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
  TMS.MCP.CloudAI;

type
  TTokenUsageTrackingMainView = class(TForm)
    pnTop: TPanel;
    pnButtonsTop: TPanel;
    Splitter1: TSplitter;
    ProgressBar1: TProgressBar;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    pnResponseDetails: TPanel;
    Label9: TLabel;
    lbNumTokensResponse: TLabel;
    Label10: TLabel;
    lbPromptTokens: TLabel;
    Label11: TLabel;
    lbServiceModel: TLabel;
    Label12: TLabel;
    lbTotalTokens: TLabel;
    gBoxTanscription: TGroupBox;
    mmTanscription: TMemo;
    OpenDialog1: TOpenDialog;
    pnOpcoesTranslate: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
    procedure ClearResponse;
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
  TMSMCPCloudAI1.Service := aiOpenAI;
  TMSMCPCloudAI1.Settings.WebSearch := True;
end;

procedure TTokenUsageTrackingMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TTokenUsageTrackingMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  if AHttpStatusCode div 100 <> 2 then
  begin
    mmResponse.Lines.Text := 'Error: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
  lbPromptTokens.Caption := AResponse.PromptTokens.ToString;
  lbNumTokensResponse.Caption := AResponse.CompletionTokens.ToString;
  lbTotalTokens.Caption := AResponse.TotalTokens.ToString;
  lbServiceModel.Caption := AResponse.ServiceModel;
end;

end.
