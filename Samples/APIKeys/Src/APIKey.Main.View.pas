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
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudAI;

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
    TMSFNCCloudAI1: TTMSFNCCloudAI;
    pnBottom: TPanel;
    Label1: TLabel;
    lbPathFile: TLabel;
    btnOpenFolder: TButton;
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
  TMSFNCCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  edtKeyClaude.Text := TMSFNCCloudAI1.APIKeys.Claude;
  edtKeyDeepSeek.Text := TMSFNCCloudAI1.APIKeys.DeepSeek;
  edtKeyGemini.Text := TMSFNCCloudAI1.APIKeys.Gemini;
  edtKeyGrok.Text := TMSFNCCloudAI1.APIKeys.Grok;
  edtKeyMistral.Text := TMSFNCCloudAI1.APIKeys.Mistral;
  edtKeyOpenAI.Text := TMSFNCCloudAI1.APIKeys.OpenAI;
  edtKeyPerplexity.Text := TMSFNCCloudAI1.APIKeys.Perplexity;
end;

procedure TAPIKeyMainView.btnSaveKeysClick(Sender: TObject);
begin
  Self.SaveKeys;
end;

procedure TAPIKeyMainView.SaveKeys;
begin
  TMSFNCCloudAI1.APIKeys.Claude := edtKeyClaude.Text;
  TMSFNCCloudAI1.APIKeys.DeepSeek := edtKeyDeepSeek.Text;
  TMSFNCCloudAI1.APIKeys.Gemini := edtKeyGemini.Text;
  TMSFNCCloudAI1.APIKeys.Grok := edtKeyGrok.Text;
  TMSFNCCloudAI1.APIKeys.Mistral := edtKeyMistral.Text;
  TMSFNCCloudAI1.APIKeys.OpenAI := edtKeyOpenAI.Text;
  TMSFNCCloudAI1.APIKeys.Perplexity := edtKeyPerplexity.Text;

  TMSFNCCloudAI1.APIKeys.SaveToFile('..\..\Files\aikeys.cfg', 'PasswordTest');
end;

end.
