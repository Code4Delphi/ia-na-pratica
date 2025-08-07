unit RAG.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.UITypes,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TRAGMainView = class(TForm)
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
    ListBox1: TListBox;
    btnGetFiles: TButton;
    btnUploadFile: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnGetFilesClick(Sender: TObject);
    procedure btnUploadFileClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure TMSMCPCloudAI1GetFiles(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure cBoxIAServiceChange(Sender: TObject);
  private

  public

  end;

var
  RAGMainView: TRAGMainView;

implementation

{$R *.dfm}

procedure TRAGMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSMCPCloudAI1.Settings.WebSearch := False;

  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 2;
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
end;

procedure TRAGMainView.btnExecuteClick(Sender: TObject);
begin
  mmResponse.Text := 'Processando...';

  //TMSMCPCloudAI1.Files.Clear;
  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

procedure TRAGMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
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

procedure TRAGMainView.btnGetFilesClick(Sender: TObject);
begin
  ListBox1.Clear;
  ProgressBar1.State := pbsNormal;
  TMSMCPCloudAI1.GetFiles;
end;

procedure TRAGMainView.TMSMCPCloudAI1GetFiles(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  for var i := 0 to Pred(TMSMCPCloudAI1.Files.Count) do
  begin
    ListBox1.Items.Add(Format('%s | %s | %d', [TMSMCPCloudAI1.Files[i].ID, TMSMCPCloudAI1.Files[i].FileName, TMSMCPCloudAI1.Files[i].FileSize]));
  end;
end;

procedure TRAGMainView.btnUploadFileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;

  TMSMCPCloudAI1.UploadFile(OpenDialog1.FileName, aiftPDF);
end;

procedure TRAGMainView.btnDeleteClick(Sender: TObject);
const
  MSG = 'Deseja realmente deletar os %d arquivos?';
begin
  if TMSMCPCloudAI1.Files.Count < 0 then
    raise Exception.Create('Não existem arquivos para serem excluídos');

  if MessageDlg(Format(MSG, [TMSMCPCloudAI1.Files.Count]), mtConfirmation, [mbYes, mbNo], 0) = IDNO then
    Exit;

  for var i := Pred(TMSMCPCloudAI1.Files.Count) downto 0 do
    TMSMCPCloudAI1.Files[i].Delete;

  TMSMCPCloudAI1.Files.Clear;
end;

procedure TRAGMainView.cBoxIAServiceChange(Sender: TObject);
begin
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
end;

end.
