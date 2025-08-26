unit Toolsets.Main.View;

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
  Vcl.ComCtrls,
  VCL.TMSFNCCloudAIToolSets,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TToolsetsMainView = class(TForm)
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
    TMSFNCCloudAIDataSet1: TTMSFNCCloudAIDataSet;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    TMSFNCCloudAIFileSystem1: TTMSFNCCloudAIFileSystem;
    procedure FormCreate(Sender: TObject);
    procedure cBoxIAServiceChange(Sender: TObject);
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
    procedure ModelsComponentToScreen;
    procedure ModelsScreenToComponent;
    procedure ProcessDatabaseConnection;
  public

  end;

var
  ToolsetsMainView: TToolsetsMainView;

implementation

{$R *.dfm}

const
  KEYS_FILE = '..\..\Files\aikeys.cfg';
  KEYS_PASSWORD = 'PasswordTest';

procedure TToolsetsMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  Self.LoadKeys;

  //CARREGAR IAS DISPONIVEIS
  cBoxIAService.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 6;
  cBoxIAServiceChange(cBoxIAService);

  Self.Settings;
  Self.ModelsComponentToScreen;

  Self.ProcessDatabaseConnection;
end;

procedure TToolsetsMainView.ProcessDatabaseConnection;
begin
  try
    FDConnection1.Params.Database := '..\BD\dados.db';
    FDQuery1.Open;
  except on E: Exception do
    ShowMessage('Não foi possível buscar os dados no banco. ' + sLineBreak +
      'Caminho do arquivo: ' + FDConnection1.Params.Database + sLineBreak +
      E.Message);
  end;
end;

procedure TToolsetsMainView.Settings;
begin
  TMSFNCCloudAI1.Logging := ckGerarLogs.Checked;
  TMSFNCCloudAI1.LogFileName := '..\..\Files\Chat.log';

  TMSFNCCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSFNCCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
  TMSFNCCloudAI1.Settings.WebSearch := ckWebSearch.Checked;
end;

procedure TToolsetsMainView.btnLoadKeysClick(Sender: TObject);
begin
  Self.LoadKeys;
end;

procedure TToolsetsMainView.btnSaveKeysClick(Sender: TObject);
begin
  Self.SaveKeys;
end;

procedure TToolsetsMainView.LoadKeys;
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

procedure TToolsetsMainView.SaveKeys;
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

procedure TToolsetsMainView.ModelsComponentToScreen;
begin
  edtModelClaude.Text := TMSFNCCloudAI1.Settings.ClaudeModel;
  edtModelDeepSeek.Text := TMSFNCCloudAI1.Settings.DeepSeekModel;
  edtModelGemini.Text := TMSFNCCloudAI1.Settings.GeminiModel;
  edtModelGrok.Text := TMSFNCCloudAI1.Settings.GrokModel;
  edtModelMistral.Text := TMSFNCCloudAI1.Settings.MistralModel;
  edtModelOpenAI.Text := TMSFNCCloudAI1.Settings.OpenAIModel;
  edtModelPerplexity.Text := TMSFNCCloudAI1.Settings.PerplexityModel;
end;

procedure TToolsetsMainView.ModelsScreenToComponent;
begin
  TMSFNCCloudAI1.Settings.ClaudeModel := edtModelClaude.Text;
  TMSFNCCloudAI1.Settings.DeepSeekModel := edtModelDeepSeek.Text;
  TMSFNCCloudAI1.Settings.GeminiModel := edtModelGemini.Text;
  TMSFNCCloudAI1.Settings.GrokModel := edtModelGrok.Text;
  TMSFNCCloudAI1.Settings.MistralModel := edtModelMistral.Text;
  TMSFNCCloudAI1.Settings.OpenAIModel := edtModelOpenAI.Text;
  TMSFNCCloudAI1.Settings.PerplexityModel := edtModelPerplexity.Text;
end;

procedure TToolsetsMainView.cBoxIAServiceChange(Sender: TObject);
var
  i: Integer;
begin
  i := Integer(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(i);
end;

procedure TToolsetsMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TToolsetsMainView.btnExecuteClick(Sender: TObject);
begin
  Self.ClearResponse;
  Self.Settings;
  Self.ModelsScreenToComponent;

  TMSFNCCloudAI1.Context.Text := mmQuestion.Lines.Text;
  TMSFNCCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

procedure TToolsetsMainView.TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
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
