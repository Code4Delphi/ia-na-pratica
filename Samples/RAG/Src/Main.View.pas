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
  uDM,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

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
    gBoxDefaultsPrompts: TGroupBox;
    pnDefaultsPrompts01: TPanel;
    btnDadosCliente: TButton;
    btnEmailCliente: TButton;
    btnDadosProduto: TButton;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    pnResponseDetails: TPanel;
    Label9: TLabel;
    lbNumTokensResponse: TLabel;
    Label10: TLabel;
    lbPromptTokens: TLabel;
    Label11: TLabel;
    lbServiceModel: TLabel;
    Label12: TLabel;
    lbTotalTokens: TLabel;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnDadosClienteClick(Sender: TObject);
    procedure btnEmailClienteClick(Sender: TObject);
    procedure btnDadosProdutoClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSMCPCloudAI1.Settings.WebSearch := True;

  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 0;
end;

procedure TMainView.btnDadosProdutoClick(Sender: TObject);
begin
  mmQuestion.Text := 'Retorne o estoque do produto id 10';
end;

procedure TMainView.btnDadosClienteClick(Sender: TObject);
begin
  mmQuestion.Text := 'Retorne os dados do cliente ID 3';
end;

procedure TMainView.btnEmailClienteClick(Sender: TObject);
begin
  mmQuestion.Clear;
  mmQuestion.Lines.Add('- Pegue o nome do cliente ID 3.');
  mmQuestion.Lines.Add('- Depois crie o texto de um e-mail para este nome agradecendo sua inscrição no canal da Code4Delphi');
end;

procedure TMainView.btnExecuteClick(Sender: TObject);
begin
  mmResponse.Text := 'Processando...';

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  TMSMCPCloudAI1.Files.Clear;
  TMSMCPCloudAI1.AddFile('C:\IA\secret-test.txt', aiftText);

  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute;
  ProgressBar1.State := pbsNormal;
end;

procedure TMainView.Button1Click(Sender: TObject);
begin
  ListBox1.Clear;
  TMSMCPCloudAI1.GetFiles;
  for var i := 0 to Pred(TMSMCPCloudAI1.Files.Count) do
  begin
    ListBox1.Items.Add(TMSMCPCloudAI1.Files[i].FileName);
  end;
end;

procedure TMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines := AResponse.Content;
  lbPromptTokens.Caption := AResponse.PromptTokens.ToString;
  lbNumTokensResponse.Caption := AResponse.CompletionTokens.ToString;
  lbTotalTokens.Caption := AResponse.TotalTokens.ToString;
  lbServiceModel.Caption := AResponse.ServiceModel;
end;

end.
