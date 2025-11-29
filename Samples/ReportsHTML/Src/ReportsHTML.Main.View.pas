unit ReportsHTML.Main.View;

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
  VCL.TMSFNCTypes,
  VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI,
  TMS.MCP.Helpers,
  TMS.MCP.CloudAIBrowserTool,
  Database.Dm, Vcl.Menus;

type
  TReportsHTMLMainView = class(TForm)
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
    TMSFNCWebBrowser1: TTMSFNCWebBrowser;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    Listartabelasdobanco1: TMenuItem;
    Crieumrelatriocomas10ltimasvendas1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Crieumgrficodepizzacomadataeototaldasvendasde01062025a300620251: TMenuItem;
    CrieumrelatriodeclientescompaginaoeopoparaDownload1: TMenuItem;
    Panel2: TPanel;
    imgPopupQuestions: TImage;
    procedure FormCreate(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnExecuteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Listartabelasdobanco1Click(Sender: TObject);
    procedure imgPopupQuestionsClick(Sender: TObject);
  private
    procedure ClearResponse;
    procedure Settings;
    procedure DefineTools;
    procedure DefineToolRunQuery;
    procedure DefineToolGetTables;
    procedure DefineToolGetTableInfo;
  public
    FBrowserTool: TTMSMCPCloudAIBrowser;
  end;

var
  ReportsHTMLMainView: TReportsHTMLMainView;

implementation

{$R *.dfm}

const
  KEYS_FILE = '..\..\Files\aikeys.cfg';
  KEYS_PASSWORD = 'PasswordTest';

procedure TReportsHTMLMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile(KEYS_FILE, KEYS_PASSWORD);
  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 6;

  FBrowserTool := TTMSMCPCloudAIBrowser.Create(Self);
  FBrowserTool.Browser := TMSFNCWebBrowser1;
  FBrowserTool.AI := TMSMCPCloudAI1;

  Self.Settings;
  Self.DefineTools;
end;

procedure TReportsHTMLMainView.FormDestroy(Sender: TObject);
begin
  FBrowserTool.Free;
end;

procedure TReportsHTMLMainView.imgPopupQuestionsClick(Sender: TObject);
begin
  PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TReportsHTMLMainView.Listartabelasdobanco1Click(Sender: TObject);
begin
  mmQuestion.Lines.Text := TMenuItem(Sender).Hint;
end;

procedure TReportsHTMLMainView.Settings;
begin
  TMSMCPCloudAI1.Logging := ckGerarLogs.Checked;
  TMSMCPCloudAI1.LogFileName := '..\..\Files\Chat.log';

  TMSMCPCloudAI1.Settings.Temperature := StrToIntDef(edtTemperature.Text, 0);
  TMSMCPCloudAI1.Settings.MaxTokens := StrToIntDef(edtMaxTokens.Text, 0);
end;

procedure TReportsHTMLMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

procedure TReportsHTMLMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
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

procedure TReportsHTMLMainView.btnExecuteClick(Sender: TObject);
begin
  Self.ClearResponse;
  Self.Settings;

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  mmResponse.Text := 'Processando...';
  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute;
  ProgressBar1.State := pbsNormal;
end;

procedure TReportsHTMLMainView.DefineTools;
begin
  Self.DefineToolRunQuery;
  Self.DefineToolGetTables;
  Self.DefineToolGetTableInfo;
end;

procedure TReportsHTMLMainView.DefineToolRunQuery;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  LTool := TMSMCPCloudAI1.Tools.Add;
  LTool.Name := 'RunQuery';
  LTool.Description := 'Execute an SQL query';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'sql';
  LParam.&Type := TTMSMCPCloudAIParameterType.ptString;
  LParam.Required := True;
  LParam.Description := 'SQL query to execute (SELECT queries only)';

  LTool.OnExecute := DatabaseDm.RunSQLQuery;
end;

procedure TReportsHTMLMainView.DefineToolGetTables;
var
  LTool: TTMSMCPCloudAITool;
begin
  LTool := TMSMCPCloudAI1.Tools.Add;
  LTool.Name := 'GetTables';
  LTool.Description := 'Get a list of available tables';
  LTool.OnExecute := DatabaseDm.GetTableList;
end;

procedure TReportsHTMLMainView.DefineToolGetTableInfo;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  LTool := TMSMCPCloudAI1.Tools.Add;
  LTool.Name := 'GetTableInfo';
  LTool.Description := 'Get information about a table';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'tableName';
  LParam.&Type := TTMSMCPCloudAIParameterType.ptString;
  LParam.Required := True;
  LParam.Description := 'Name of the table to get information about';

  LTool.OnExecute := DatabaseDm.GetTableInfo;
end;

end.
