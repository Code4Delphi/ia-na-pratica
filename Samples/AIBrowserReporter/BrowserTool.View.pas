unit BrowserTool.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase, TMS.MCP.CloudAI, TMS.MCP.CloudAIToolSets, Data.DB,
  Datasnap.DBClient, Vcl.StdCtrls, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  TMS.MCP.CloudAIBrowserTool, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TBrowserToolView = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    btnGraphSample: TButton;
    btnDBReportSample: TButton;
    btnExecutePrompt: TButton;
    DBGrid1: TDBGrid;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    TMSFNCWebBrowser1: TTMSFNCWebBrowser;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure btnGraphSampleClick(Sender: TObject);
    procedure btnDBReportSampleClick(Sender: TObject);
    procedure btnExecutePromptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
  public
    FBrowserTool: TTMSMCPCloudAIBrowser;
    FDataSetTool: TTMSMCPCloudAIDataSet;
  end;

var
  BrowserToolView: TBrowserToolView;

implementation

{$R *.dfm}

procedure TBrowserToolView.FormCreate(Sender: TObject);
begin
  FBrowserTool := TTMSMCPCloudAIBrowser.Create(Self);
  FBrowserTool.Browser := TMSFNCWebBrowser1;
  FBrowserTool.AI := TMSMCPCloudAI1;

  FDataSetTool := TTMSMCPCloudAIDataSet.Create(Self);
  FDataSetTool.DataSource := DataSource1;
  FDataSetTool.AI := TMSMCPCloudAI1;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSMCPCloudAI1.Logging := true;
  TMSMCPCloudAI1.LogFileName := '.\..\..\browserai.log';
  TMSMCPCloudAI1.Service := aiOpenAI;
end;

procedure TBrowserToolView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FBrowserTool.Free;
  FDataSetTool.Free;
end;

procedure TBrowserToolView.btnGraphSampleClick(Sender: TObject);
begin
  memo1.Lines.LoadFromFile('.\..\..\prompt_co2.txt');
end;

procedure TBrowserToolView.btnDBReportSampleClick(Sender: TObject);
begin
  memo1.Lines.LoadFromFile('.\..\..\prompt_ds.txt');
end;

procedure TBrowserToolView.btnExecutePromptClick(Sender: TObject);
begin
  ProgressBar1.Style := pbstMarquee;
  TMSMCPCloudAI1.Context.Text := Memo1.Lines.Text;
  TMSMCPCloudAI1.Execute('abc');
end;

procedure TBrowserToolView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.Style := pbstNormal;
end;

end.
