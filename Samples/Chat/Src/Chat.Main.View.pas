unit Chat.Main.View;

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
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TChatMainView = class(TForm)
    pnTop: TPanel;
    cBoxIAService: TComboBox;
    Label1: TLabel;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    Splitter1: TSplitter;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    PageControl1: TPageControl;
    tabAPIKeys: TTabSheet;
    tabChat: TTabSheet;
    ProgressBar1: TProgressBar;
    pnAPIKeysBack: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtKeyClaude: TEdit;
    edtKeyDeepSeek: TEdit;
    edtKeyGemini: TEdit;
    edtKeyGrok: TEdit;
    edtKeyMistral: TEdit;
    edtKeyOpenAI: TEdit;
    edtKeyPerplexity: TEdit;
    btnLoadKeys: TButton;
    btnSaveKeys: TButton;
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
    tabModels: TTabSheet;
    pnModelsBack: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtModelClaude: TEdit;
    edtModelDeepSeek: TEdit;
    edtModelGemini: TEdit;
    edtModelGrok: TEdit;
    edtModelMistral: TEdit;
    edtModelOpenAI: TEdit;
    edtModelPerplexity: TEdit;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    procedure FormCreate(Sender: TObject);
    procedure cBoxIAServiceChange(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnSaveKeysClick(Sender: TObject);
    procedure btnLoadKeysClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
    procedure LoadKeys;
    procedure SaveKeys;
    procedure ClearResponse;
    procedure Settings;
    procedure ModelsComponentToScreen;
    procedure ModelsScreenToComponent;
  public

  end;

var
  ChatMainView: TChatMainView;

implementation

{$R *.dfm}

const
  KEYS_FILE = '..\..\Files\aikeys.cfg';
  KEYS_PASSWORD = 'PasswordTest';

procedure TChatMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  Self.LoadKeys;

  //CARREGAR IAS DISPONIVEIS
  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 6;
  cBoxIAServiceChange(cBoxIAService);

  Self.Settings;
  Self.ModelsComponentToScreen;
end;

procedure TChatMainView.Settings;
begin
  TMSMCPCloudAI1.Logging := ckGerarLogs.Checked;
  TMSMCPCloudAI1.LogFileName := '..\..\Files\Chat.log';

  TMSMCPCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSMCPCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
  TMSMCPCloudAI1.Settings.WebSearch := ckWebSearch.Checked;
end;

procedure TChatMainView.btnLoadKeysClick(Sender: TObject);
begin
  Self.LoadKeys;
end;

procedure TChatMainView.btnSaveKeysClick(Sender: TObject);
begin
  Self.SaveKeys;
end;

procedure TChatMainView.LoadKeys;
begin
  TMSMCPCloudAI1.APIKeys.LoadFromFile(KEYS_FILE, KEYS_PASSWORD);

  edtKeyClaude.Text := TMSMCPCloudAI1.APIKeys.Claude;
  edtKeyDeepSeek.Text := TMSMCPCloudAI1.APIKeys.DeepSeek;
  edtKeyGemini.Text := TMSMCPCloudAI1.APIKeys.Gemini;
  edtKeyGrok.Text := TMSMCPCloudAI1.APIKeys.Grok;
  edtKeyMistral.Text := TMSMCPCloudAI1.APIKeys.Mistral;
  edtKeyOpenAI.Text := TMSMCPCloudAI1.APIKeys.OpenAI;
  edtKeyPerplexity.Text := TMSMCPCloudAI1.APIKeys.Perplexity;
end;

procedure TChatMainView.SaveKeys;
begin
  TMSMCPCloudAI1.APIKeys.Claude := edtKeyClaude.Text;
  TMSMCPCloudAI1.APIKeys.DeepSeek := edtKeyDeepSeek.Text;
  TMSMCPCloudAI1.APIKeys.Gemini := edtKeyGemini.Text;
  TMSMCPCloudAI1.APIKeys.Grok := edtKeyGrok.Text;
  TMSMCPCloudAI1.APIKeys.Mistral := edtKeyMistral.Text;
  TMSMCPCloudAI1.APIKeys.OpenAI := edtKeyOpenAI.Text;
  TMSMCPCloudAI1.APIKeys.Perplexity := edtKeyPerplexity.Text;

  TMSMCPCloudAI1.APIKeys.SaveToFile(KEYS_FILE, KEYS_PASSWORD);
end;

procedure TChatMainView.ModelsComponentToScreen;
begin
  edtModelClaude.Text := TMSMCPCloudAI1.Settings.ClaudeModel;
  edtModelDeepSeek.Text := TMSMCPCloudAI1.Settings.DeepSeekModel;
  edtModelGemini.Text := TMSMCPCloudAI1.Settings.GeminiModel;
  edtModelGrok.Text := TMSMCPCloudAI1.Settings.GrokModel;
  edtModelMistral.Text := TMSMCPCloudAI1.Settings.MistralModel;
  edtModelOpenAI.Text := TMSMCPCloudAI1.Settings.OpenAIModel;
  edtModelPerplexity.Text := TMSMCPCloudAI1.Settings.PerplexityModel;
end;

procedure TChatMainView.ModelsScreenToComponent;
begin
  TMSMCPCloudAI1.Settings.ClaudeModel := edtModelClaude.Text;
  TMSMCPCloudAI1.Settings.DeepSeekModel := edtModelDeepSeek.Text;
  TMSMCPCloudAI1.Settings.GeminiModel := edtModelGemini.Text;
  TMSMCPCloudAI1.Settings.GrokModel := edtModelGrok.Text;
  TMSMCPCloudAI1.Settings.MistralModel := edtModelMistral.Text;
  TMSMCPCloudAI1.Settings.OpenAIModel := edtModelOpenAI.Text;
  TMSMCPCloudAI1.Settings.PerplexityModel := edtModelPerplexity.Text;
end;

procedure TChatMainView.cBoxIAServiceChange(Sender: TObject);
var
  i: Integer;
begin
  i := Integer(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(i);
end;

procedure TChatMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TChatMainView.btnExecuteClick(Sender: TObject);
begin
  Self.ClearResponse;
  Self.Settings;
  Self.ModelsScreenToComponent;

  TMSMCPCloudAI1.Context.Text := mmQuestion.Lines.Text;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

procedure TChatMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
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


end.
