unit Ollama.Main.View;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Data.DB,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TOllamaMainView = class(TForm)
    pnTop: TPanel;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    Splitter1: TSplitter;
    gBoxResponse: TGroupBox;
    PageControl1: TPageControl;
    tabChat: TTabSheet;
    ProgressBar1: TProgressBar;
    pnResponseDetails: TPanel;
    Label9: TLabel;
    lbNumTokensResponse: TLabel;
    Label10: TLabel;
    lbPromptTokens: TLabel;
    Label11: TLabel;
    lbServiceModel: TLabel;
    Label12: TLabel;
    lbTotalTokens: TLabel;
    ckGerarLogs: TCheckBox;
    Label13: TLabel;
    edtTemperature: TEdit;
    ckWebSearch: TCheckBox;
    Label14: TLabel;
    edtMaxTokens: TEdit;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    mmResponse: TMemo;
    btnShowModels: TButton;
    Label1: TLabel;
    cBoxModel: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnShowModelsClick(Sender: TObject);
    procedure TMSMCPCloudAI1GetModels(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
    procedure ClearResponse;
    procedure Settings;
    procedure ModelsComponentToScreen;
    procedure ModelsScreenToComponent;
  public

  end;

var
  OllamaMainView: TOllamaMainView;

implementation

{$R *.dfm}

procedure TOllamaMainView.FormCreate(Sender: TObject);
begin
  Self.Settings;
  Self.ModelsComponentToScreen;
end;

procedure TOllamaMainView.Settings;
begin
  TMSMCPCloudAI1.Logging := ckGerarLogs.Checked;
  TMSMCPCloudAI1.LogFileName := '..\..\Files\Chat.log';

  TMSMCPCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSMCPCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
  TMSMCPCloudAI1.Settings.WebSearch := ckWebSearch.Checked;

  //OLLAMA
  TMSMCPCloudAI1.Settings.OllamaModel := cBoxModel.Text; //'mistral:latest';
//  TMSMCPCloudAI1.Settings.OllamaHost := '';
//  TMSMCPCloudAI1.Settings.OllamaPath := '';
//  TMSMCPCloudAI1.Settings.OllamaPort := 11434

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService.aiOllama;
end;

procedure TOllamaMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
  lbPromptTokens.Caption := AResponse.PromptTokens.ToString;
  lbNumTokensResponse.Caption := AResponse.CompletionTokens.ToString;
  lbTotalTokens.Caption := AResponse.TotalTokens.ToString;
  lbServiceModel.Caption := AResponse.ServiceModel;
end;

procedure TOllamaMainView.TMSMCPCloudAI1GetModels(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Text := 'AHttpStatusCode: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  cBoxModel.Items := TMSMCPCloudAI1.Models;
  mmResponse.Text := TMSMCPCloudAI1.Models.Text;
  //lbTotalModels.Caption := TMSMCPCloudAI1.Models.Count.ToString;
end;

procedure TOllamaMainView.ModelsComponentToScreen;
begin
  //edtModelClaude.Text := TMSMCPCloudAI1.Settings.ClaudeModel;
end;

procedure TOllamaMainView.ModelsScreenToComponent;
begin
  //TMSMCPCloudAI1.Settings.ClaudeModel := edtModelClaude.Text;
end;

procedure TOllamaMainView.btnShowModelsClick(Sender: TObject);
begin
  ProgressBar1.State := pbsNormal;
  cBoxModel.Items.Clear;
  TMSMCPCloudAI1.GetModels();
end;

procedure TOllamaMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TOllamaMainView.btnExecuteClick(Sender: TObject);
begin
  if Trim(cBoxModel.Text).IsEmpty then
  begin
    mmResponse.Text := 'Informe o modelo';
    Exit;
  end;

  Self.ClearResponse;
  Self.Settings;
  Self.ModelsScreenToComponent;

  TMSMCPCloudAI1.Context.Text := mmQuestion.Lines.Text;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

end.
