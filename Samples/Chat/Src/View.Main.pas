unit View.Main;

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
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudAI,
  Vcl.Buttons,
  Vcl.ComCtrls;

type
  TViewMain = class(TForm)
    pnTop: TPanel;
    cBoxModel: TComboBox;
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
    TMSFNCCloudAI1: TTMSFNCCloudAI;
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
    procedure FormCreate(Sender: TObject);
    procedure cBoxModelChange(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnSaveKeysClick(Sender: TObject);
    procedure btnLoadKeysClick(Sender: TObject);
  private
    procedure LoadKeys;
    procedure SaveKeys;
    procedure ClearResponse;
    procedure Settings;
    procedure SetManualModel;
  public

  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

const
  KEYS_FILE = './aikeys.cfg';
  KEYS_PASSWORD = 'Code4Delphi';

procedure TViewMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  Self.LoadKeys;

  //CARREGAR IAS DISPONIVEIS
  cBoxModel.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxModel.ItemIndex := 6;
  cBoxModelChange(cBoxModel);

  Self.SetManualModel;
  Self.Settings;
end;

procedure TViewMain.SetManualModel;
begin
  TMSFNCCloudAI1.Settings.OllamaModel := 'tinyllama';
  //TMSFNCCloudAI1.Settings.OllamaModel := 'llama3.1';
  //TMSFNCCloudAI1.Settings.ClaudeModel := 'claude-opus-4-20250514';
end;

procedure TViewMain.Settings;
begin
  //LOG
  TMSFNCCloudAI1.Logging := ckGerarLogs.Checked;
  TMSFNCCloudAI1.LogFileName := ExtractFilePath(ParamStr(0)) + 'IAChat.log';

  TMSFNCCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSFNCCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
  TMSFNCCloudAI1.Settings.WebSearch := ckWebSearch.Checked;
end;

procedure TViewMain.btnLoadKeysClick(Sender: TObject);
begin
  Self.LoadKeys;
end;

procedure TViewMain.btnSaveKeysClick(Sender: TObject);
begin
  Self.SaveKeys;
end;

procedure TViewMain.LoadKeys;
begin
  TMSFNCCloudAI1.APIKeys.LoadFromFile(KEYS_FILE, KEYS_PASSWORD);

  edtKeyClaude.Text := TMSFNCCloudAI1.APIKeys.Claude;
  edtKeyDeepSeek.Text := TMSFNCCloudAI1.APIKeys.DeepSeek;
  edtKeyGemini.Text := TMSFNCCloudAI1.APIKeys.Gemini;
  edtKeyGrok.Text := TMSFNCCloudAI1.APIKeys.Grok;
  edtKeyMistral.Text := TMSFNCCloudAI1.APIKeys.Mistral;
  edtKeyOpenAI.Text := TMSFNCCloudAI1.APIKeys.OpenAI;
  edtKeyPerplexity.Text := TMSFNCCloudAI1.APIKeys.Perplexity;
end;

procedure TViewMain.SaveKeys;
begin
  TMSFNCCloudAI1.APIKeys.Claude := edtKeyClaude.Text;
  TMSFNCCloudAI1.APIKeys.DeepSeek := edtKeyDeepSeek.Text;
  TMSFNCCloudAI1.APIKeys.Gemini := edtKeyGemini.Text;
  TMSFNCCloudAI1.APIKeys.Grok := edtKeyGrok.Text;
  TMSFNCCloudAI1.APIKeys.Mistral := edtKeyMistral.Text;
  TMSFNCCloudAI1.APIKeys.OpenAI := edtKeyOpenAI.Text;
  TMSFNCCloudAI1.APIKeys.Perplexity := edtKeyPerplexity.Text;

  TMSFNCCloudAI1.APIKeys.SaveToFile(KEYS_FILE, KEYS_PASSWORD);
end;

procedure TViewMain.cBoxModelChange(Sender: TObject);
var
  i: Integer;
begin
  i := Integer(cBoxModel.Items.Objects[cBoxModel.ItemIndex]);
  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(i);
end;

procedure TViewMain.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TViewMain.btnExecuteClick(Sender: TObject);
begin
  Self.ClearResponse;
  Self.Settings;

  TMSFNCCloudAI1.Context.Text := mmQuestion.Lines.Text;
  TMSFNCCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

procedure TViewMain.TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
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
