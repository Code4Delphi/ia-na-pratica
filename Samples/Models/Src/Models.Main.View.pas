unit Models.Main.View;

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
  Vcl.ComCtrls,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TModelsMainView = class(TForm)
    pnTop: TPanel;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    btnShowModels: TButton;
    ProgressBar1: TProgressBar;
    pnBottom: TPanel;
    Label2: TLabel;
    lbTotalModels: TLabel;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    procedure FormCreate(Sender: TObject);
    procedure btnShowModelsClick(Sender: TObject);
    procedure TMSMCPCloudAI1GetModels(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private

  public

  end;

var
  ModelsMainView: TModelsMainView;

implementation

{$R *.dfm}

procedure TModelsMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 2;
end;

procedure TModelsMainView.btnShowModelsClick(Sender: TObject);
begin
  ProgressBar1.State := pbsNormal;
  lbTotalModels.Caption := '0';

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSMCPCloudAI1.GetModels();
end;

procedure TModelsMainView.TMSMCPCloudAI1GetModels(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Text := 'AHttpStatusCode: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Text := TMSMCPCloudAI1.Models.Text;
  lbTotalModels.Caption := TMSMCPCloudAI1.Models.Count.ToString;
end;

end.
