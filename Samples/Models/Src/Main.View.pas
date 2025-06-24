unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCCustomComponent, VCL.TMSFNCCloudBase, VCL.TMSFNCCloudAI, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TMainView = class(TForm)
    pnTop: TPanel;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    TMSFNCCloudAI1: TTMSFNCCloudAI;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    btnShowModels: TButton;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure cBoxIAServiceChange(Sender: TObject);
    procedure btnShowModelsClick(Sender: TObject);
    procedure TMSFNCCloudAI1GetModels(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  TMSFNCCloudAI1.Logging := True;
  TMSFNCCloudAI1.LogFileName := '..\..\Files\FunctionCalling.log';

  TMSFNCCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');

  cBoxIAService.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 2; //6
  cBoxIAServiceChange(cBoxIAService);
end;

procedure TMainView.cBoxIAServiceChange(Sender: TObject);
begin
  var i := Integer(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(i);
end;

procedure TMainView.btnShowModelsClick(Sender: TObject);
begin
  ProgressBar1.State := pbsNormal;
  TMSFNCCloudAI1.GetModels();
end;

procedure TMainView.TMSFNCCloudAI1GetModels(Sender: TObject; AResponse: TTMSFNCCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Text := 'AHttpStatusCode: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  //mmResponse.Text := AResponse.Content.Text;
  mmResponse.Text := TMSFNCCloudAI1.Models.Text;
end;

end.
