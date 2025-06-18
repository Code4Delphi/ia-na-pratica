unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, VCL.TMSFNCCustomComponent, VCL.TMSFNCCloudBase,
  VCL.TMSFNCCloudAI, Vcl.Buttons, Vcl.ComCtrls;

type
  TViewMain = class(TForm)
    pnTop: TPanel;
    cBoxModel: TComboBox;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    Splitter1: TSplitter;
    TMSFNCCloudAI1: TTMSFNCCloudAI;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure cBoxModelChange(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private

  public

  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

procedure TViewMain.FormCreate(Sender: TObject);
begin
  //ATIVAR LOG
  TMSFNCCloudAI1.Logging := True;
  TMSFNCCloudAI1.LogFileName := ExtractFilePath(ParamStr(0)) + 'IAChat.log';

  //CARREGAR IAS DISPONIVEIS
  cBoxModel.Items.Assign(TMSFNCCloudAI1.GetServices(True));
  cBoxModel.ItemIndex := 6;
  cBoxModelChange(cBoxModel);

  //SETANDO MODELOS MANUALMENTE
  //TMSFNCCloudAI1.Settings.ClaudeModel := 'claude-opus-4-20250514';
  //TMSFNCCloudAI1.Settings.GeminiModel := 'gemini-2.5-pro-preview-tts';
  //TMSFNCCloudAI1.Settings.MistralModel := 'mistral-medium-latest';
  //TMSFNCCloudAI1.Settings.OllamaModel := 'tinyllama';
end;

procedure TViewMain.TMSFNCCloudAI1Executed(Sender: TObject; AResponse: TTMSFNCCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text
end;

procedure TViewMain.cBoxModelChange(Sender: TObject);
var
  i: Integer;
begin
  i := Integer(cBoxModel.Items.Objects[cBoxModel.ItemIndex]);
  TMSFNCCloudAI1.Service := TTMSFNCCloudAIService(i);
end;

procedure TViewMain.btnExecuteClick(Sender: TObject);
begin
  mmResponse.Lines.Clear;

  TMSFNCCloudAI1.Context.Text := mmQuestion.Lines.Text;
  TMSFNCCloudAI1.Execute;
end;

end.
