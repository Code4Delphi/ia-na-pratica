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
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudAI,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TModelsMainView = class(TForm)
    pnTop: TPanel;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    TMSFNCCloudAI1: TTMSFNCCloudAI;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    btnShowModels: TButton;
    ProgressBar1: TProgressBar;
    pnBottom: TPanel;
    Label2: TLabel;
    lbTotalModels: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnShowModelsClick(Sender: TObject);
    procedure TMSFNCCloudAI1GetModels(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
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
  TMSFNCCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  cBoxIAService.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 2;
end;

procedure TModelsMainView.btnShowModelsClick(Sender: TObject);
begin
  ProgressBar1.State := pbsNormal;
  lbTotalModels.Caption := '0';

  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSFNCCloudAI1.GetModels();
end;

procedure TModelsMainView.TMSFNCCloudAI1GetModels(Sender: TObject; AResponse: TTMSFNCCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Text := 'AHttpStatusCode: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Text := TMSFNCCloudAI1.Models.Text;
  lbTotalModels.Caption := TMSFNCCloudAI1.Models.Count.ToString;
end;

end.
