unit APIKey.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Winapi.ShellAPI,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TAPIKeyMainView = class(TForm)
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
    pnBottom: TPanel;
    Label1: TLabel;
    lbPathFile: TLabel;
    btnOpenFolder: TButton;
    Label22: TLabel;
    edtKeyOpenRouter: TEdit;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadKeysClick(Sender: TObject);
    procedure btnSaveKeysClick(Sender: TObject);
    procedure btnOpenFolderClick(Sender: TObject);
  private
    procedure LoadKeys;
    procedure SaveKeys;

  public

  end;

var
  APIKeyMainView: TAPIKeyMainView;

implementation

{$R *.dfm}

procedure TAPIKeyMainView.FormCreate(Sender: TObject);
begin
  lbPathFile.Caption := ExpandFileName('..\..\Files\aikeys.cfg');
  Self.LoadKeys;
end;

procedure TAPIKeyMainView.btnOpenFolderClick(Sender: TObject);
begin
  if DirectoryExists(ExtractFileDir(lbPathFile.Caption)) then
    ShellExecute(0, 'open', PChar(ExtractFileDir(lbPathFile.Caption)), nil, nil, SW_SHOWNORMAL);
end;

procedure TAPIKeyMainView.btnLoadKeysClick(Sender: TObject);
begin
  Self.LoadKeys;
end;

procedure TAPIKeyMainView.LoadKeys;
begin
  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  edtKeyClaude.Text := TMSMCPCloudAI1.APIKeys.Claude;
  edtKeyDeepSeek.Text := TMSMCPCloudAI1.APIKeys.DeepSeek;
  edtKeyGemini.Text := TMSMCPCloudAI1.APIKeys.Gemini;
  edtKeyGrok.Text := TMSMCPCloudAI1.APIKeys.Grok;
  edtKeyMistral.Text := TMSMCPCloudAI1.APIKeys.Mistral;
  edtKeyOpenAI.Text := TMSMCPCloudAI1.APIKeys.OpenAI;
  edtKeyPerplexity.Text := TMSMCPCloudAI1.APIKeys.Perplexity;
  edtKeyOpenRouter.Text := TMSMCPCloudAI1.APIKeys.OpenRouter;
end;

procedure TAPIKeyMainView.btnSaveKeysClick(Sender: TObject);
begin
  Self.SaveKeys;
end;

procedure TAPIKeyMainView.SaveKeys;
begin
  TMSMCPCloudAI1.APIKeys.Claude := edtKeyClaude.Text;
  TMSMCPCloudAI1.APIKeys.DeepSeek := edtKeyDeepSeek.Text;
  TMSMCPCloudAI1.APIKeys.Gemini := edtKeyGemini.Text;
  TMSMCPCloudAI1.APIKeys.Grok := edtKeyGrok.Text;
  TMSMCPCloudAI1.APIKeys.Mistral := edtKeyMistral.Text;
  TMSMCPCloudAI1.APIKeys.OpenAI := edtKeyOpenAI.Text;
  TMSMCPCloudAI1.APIKeys.Perplexity := edtKeyPerplexity.Text;
  TMSMCPCloudAI1.APIKeys.OpenRouter := edtKeyOpenRouter.Text;

  TMSMCPCloudAI1.APIKeys.SaveToFile('..\..\Files\aikeys.cfg', 'PasswordTest');
end;

end.
