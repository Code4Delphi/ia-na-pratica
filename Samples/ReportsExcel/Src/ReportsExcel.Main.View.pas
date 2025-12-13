unit ReportsExcel.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.Menus,
  VCL.TMSFNCTypes,
  VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCCustomControl,
  ShellAPI,
  Database.Dm,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI,
  TMS.MCP.Helpers,
  ToolSet.Database,
  ToolSet.Excel;

type
  TReportsExcelMainView = class(TForm)
    pnTop: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cBoxIAService: TComboBox;
    ckGerarLogs: TCheckBox;
    edtTemperature: TEdit;
    edtMaxTokens: TEdit;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    gBoxResponse: TGroupBox;
    pnResponseDetails: TPanel;
    Label9: TLabel;
    lbNumTokensResponse: TLabel;
    Label10: TLabel;
    lbPromptTokens: TLabel;
    Label11: TLabel;
    lbServiceModel: TLabel;
    Label12: TLabel;
    lbTotalTokens: TLabel;
    mmResponse: TMemo;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    Listartabelasdobanco1: TMenuItem;
    Crieumrelatriocomas10ltimasvendas1: TMenuItem;
    N1: TMenuItem;
    CrieumrelatriodeclientescompaginaoeopoparaDownload1: TMenuItem;
    Panel2: TPanel;
    imgPopupQuestions: TImage;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnExecuteClick(Sender: TObject);
    procedure Listartabelasdobanco1Click(Sender: TObject);
    procedure imgPopupQuestionsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FToolSetDatabase: TToolSetDatabase;
    FToolSetExcel: TToolSetExcel;
    procedure ClearResponse;
    procedure Settings;
  public

  end;

var
  ReportsExcelMainView: TReportsExcelMainView;

implementation

{$R *.dfm}

const
  KEYS_FILE = '..\..\Files\aikeys.cfg';
  KEYS_PASSWORD = 'PasswordTest';

procedure TReportsExcelMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile(KEYS_FILE, KEYS_PASSWORD);
  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 6;

  FToolSetDatabase := TToolSetDatabase.Create(Self);
  FToolSetDatabase.AI := TMSMCPCloudAI1;

  FToolSetExcel := TToolSetExcel.Create(Self);
  FToolSetExcel.AI := TMSMCPCloudAI1;

  Self.Settings;
end;

procedure TReportsExcelMainView.FormDestroy(Sender: TObject);
begin
  FToolSetExcel.Free;
  FToolSetDatabase.Free;
end;

procedure TReportsExcelMainView.imgPopupQuestionsClick(Sender: TObject);
begin
  PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TReportsExcelMainView.Listartabelasdobanco1Click(Sender: TObject);
begin
  mmQuestion.Lines.Text := TMenuItem(Sender).Hint;
end;

procedure TReportsExcelMainView.Settings;
begin
  TMSMCPCloudAI1.Logging := ckGerarLogs.Checked;
  TMSMCPCloudAI1.LogFileName := '..\..\Files\Chat.log';

  TMSMCPCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSMCPCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
end;

procedure TReportsExcelMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TReportsExcelMainView.btnExecuteClick(Sender: TObject);
begin
  Self.ClearResponse;
  Self.Settings;

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  mmResponse.Text := 'Processando...';
  TMSMCPCloudAI1.Context.Text := FToolSetExcel.ConfigPrompt(mmQuestion.Lines.Text);
  TMSMCPCloudAI1.Execute;
  ProgressBar1.State := pbsNormal;
end;

procedure TReportsExcelMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
  lbServiceModel.Caption := AResponse.ServiceModel;

  lbPromptTokens.Caption := AResponse.PromptTokens.ToString;
  lbNumTokensResponse.Caption := AResponse.CompletionTokens.ToString;
  lbTotalTokens.Caption := AResponse.TotalTokens.ToString;
end;

end.
