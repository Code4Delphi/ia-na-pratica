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
  Vcl.Grids,
  Vcl.DBGrids,
  Datasnap.DBClient,
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
    btnGetFiles: TButton;
    btnUploadFile: TButton;
    btnDelete: TButton;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Index: TIntegerField;
    ClientDataSet1ID: TStringField;
    ClientDataSet1FileName: TStringField;
    ClientDataSet1FileSize: TLargeintField;
    ClientDataSet1URL: TStringField;
    ClientDataSet1MimeType: TStringField;
    DataSource1: TDataSource;
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
    procedure TMSMCPCloudAI1FileUpload(Sender: TObject; HttpStatusCode: Integer; HttpResult: string; Index: Integer);
    procedure TMSMCPCloudAI1FileDeleted(Sender: TObject; HttpStatusCode: Integer; HttpResult: string; Index: Integer);
  private
    procedure GetListFilesAI;
    procedure ComponentToDataSet(const AIndex: Integer);
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

procedure TRAGMainView.cBoxIAServiceChange(Sender: TObject);
begin
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
end;

procedure TRAGMainView.btnExecuteClick(Sender: TObject);
begin
  mmResponse.Text := 'Processando...';

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
  Self.GetListFilesAI;
end;

procedure TRAGMainView.GetListFilesAI;
begin
  ClientDataSet1.EmptyDataSet;
  ProgressBar1.State := pbsNormal;
  TMSMCPCloudAI1.GetFiles;
end;

procedure TRAGMainView.TMSMCPCloudAI1GetFiles(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'GetFiles failed. HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  for var i := 0 to Pred(TMSMCPCloudAI1.Files.Count) do
    Self.ComponentToDataSet(i);
end;

procedure TRAGMainView.ComponentToDataSet(const AIndex: Integer);
begin
  ClientDataSet1.Append;
  ClientDataSet1Index.AsInteger := AIndex;
  ClientDataSet1ID.AsString := TMSMCPCloudAI1.Files[AIndex].ID;
  ClientDataSet1FileName.AsString := TMSMCPCloudAI1.Files[AIndex].FileName;
  ClientDataSet1FileSize.AsLargeInt := TMSMCPCloudAI1.Files[AIndex].FileSize;
  ClientDataSet1MimeType.AsString :=  TMSMCPCloudAI1.Files[AIndex].MimeType;
  ClientDataSet1URL.AsString := TMSMCPCloudAI1.Files[AIndex].URL;
  ClientDataSet1.Post;
end;

procedure TRAGMainView.btnUploadFileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;

  ProgressBar1.State := pbsNormal;
  TMSMCPCloudAI1.UploadFile(OpenDialog1.FileName, FileExtToFileType(OpenDialog1.FileName));
end;

procedure TRAGMainView.TMSMCPCloudAI1FileUpload(Sender: TObject; HttpStatusCode: Integer; HttpResult: string;
  Index: Integer);
begin
  ProgressBar1.State := pbsPaused;

  if HttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'Upload failed. HTTP error code: ' + HttpStatusCode.ToString + sLineBreak + HttpResult;
    Exit;
  end;

  Self.ComponentToDataSet(Index);
end;

procedure TRAGMainView.btnDeleteClick(Sender: TObject);
begin
  if TMSMCPCloudAI1.Files.Count < 0 then
    raise Exception.Create('Não existem arquivos para serem excluídos');

  if ClientDataSet1.IsEmpty then
    raise Exception.Create('Não existem arquivo selecionado para ser excluído');

  if MessageDlg('Deseja realmente deletar este registro?', mtConfirmation, [mbYes, mbNo], 0) = IDNO then
    Exit;

  ProgressBar1.State := pbsNormal;
  TMSMCPCloudAI1.Files[ClientDataSet1Index.AsInteger].Delete;
end;

procedure TRAGMainView.TMSMCPCloudAI1FileDeleted(Sender: TObject; HttpStatusCode: Integer; HttpResult: string;
  Index: Integer);
begin
  ProgressBar1.State := pbsPaused;

  if HttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'FileDeleted failed. HTTP error code: ' + HttpStatusCode.ToString + sLineBreak + HttpResult;
    Exit;
  end;

  Self.GetListFilesAI;
end;

end.
