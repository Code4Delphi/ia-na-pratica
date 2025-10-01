unit Ollama.Main.View;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Data.DB,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TOllamaMainView = class(TForm)
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    pnTop: TPanel;
    Label13: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbPort: TLabel;
    edtTemperature: TEdit;
    btnShowModels: TButton;
    cBoxModel: TComboBox;
    edtHost: TEdit;
    edtPath: TEdit;
    edtPort: TEdit;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    Splitter1: TSplitter;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnShowModelsClick(Sender: TObject);
    procedure TMSMCPCloudAI1GetModels(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
    procedure Settings;
    procedure ComponentToScreen;
  public

  end;

var
  OllamaMainView: TOllamaMainView;

implementation

{$R *.dfm}

procedure TOllamaMainView.FormCreate(Sender: TObject);
begin
  Self.ComponentToScreen;
end;

procedure TOllamaMainView.ComponentToScreen;
begin
  cBoxModel.Items.Add(TMSMCPCloudAI1.Settings.OllamaModel);
  edtTemperature.Text := TMSMCPCloudAI1.Settings.Temperature.ToString;

  edtHost.Text := TMSMCPCloudAI1.Settings.OllamaHost;
  edtPath.Text := TMSMCPCloudAI1.Settings.OllamaPath;
  edtPort.Text := TMSMCPCloudAI1.Settings.OllamaPort.ToString;
end;

procedure TOllamaMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
end;

procedure TOllamaMainView.TMSMCPCloudAI1GetModels(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Text := 'AHttpStatusCode: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  cBoxModel.Items := TMSMCPCloudAI1.Models;

  mmResponse.Lines.Clear;
  mmResponse.Lines.Add(Format('Foram encontrados %d models', [TMSMCPCloudAI1.Models.Count]));
  mmResponse.Lines.Add(TMSMCPCloudAI1.Models.Text);
end;

procedure TOllamaMainView.btnShowModelsClick(Sender: TObject);
begin
  Self.Settings;

  ProgressBar1.State := pbsNormal;
  cBoxModel.Items.Clear;
  TMSMCPCloudAI1.GetModels();
end;

procedure TOllamaMainView.Settings;
begin
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService.aiOllama;
  TMSMCPCloudAI1.Settings.OllamaModel := cBoxModel.Text;
  TMSMCPCloudAI1.Settings.OllamaHost := edtHost.Text;
  TMSMCPCloudAI1.Settings.OllamaPath := edtPath.Text;
  TMSMCPCloudAI1.Settings.OllamaPort := StrToIntDef(edtPort.Text, 11434);

  TMSMCPCloudAI1.Settings.Temperature := StrToFloatDef(edtTemperature.Text, 0);
end;

procedure TOllamaMainView.btnExecuteClick(Sender: TObject);
begin
  if Trim(cBoxModel.Text).IsEmpty then
  begin
    mmResponse.Text := 'Informe o modelo';
    Exit;
  end;

  mmResponse.Lines.Clear;
  Self.Settings;

  TMSMCPCloudAI1.Context.Text := mmQuestion.Lines.Text;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

end.
