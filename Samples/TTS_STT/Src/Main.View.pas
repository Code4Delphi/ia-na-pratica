unit Main.View;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  AudioRecorder,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TMainView = class(TForm)
    pnTop: TPanel;
    pnButtonsTop: TPanel;
    btnStartRecording: TButton;
    btnStopRecording: TButton;
    Splitter1: TSplitter;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    gBoxTanscription: TGroupBox;
    mmTanscription: TMemo;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    pnResponseDetails: TPanel;
    Label9: TLabel;
    lbNumTokensResponse: TLabel;
    Label10: TLabel;
    lbPromptTokens: TLabel;
    Label11: TLabel;
    lbServiceModel: TLabel;
    Label12: TLabel;
    lbTotalTokens: TLabel;
    ProgressBar1: TProgressBar;
    cBoxLanguage: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartRecordingClick(Sender: TObject);
    procedure btnStopRecordingClick(Sender: TObject);
    procedure TMSMCPCloudAI1SpeechAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult: string;
      SoundBuffer: TMemoryStream);
    procedure TMSMCPCloudAI1TranscribeAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult, Text: string);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
  private
    FAudioRecorder: TAudioRecorder;
    procedure ScreenRecordingOn;
    procedure ScreenRecordingOff;
    procedure ClearResponse;
    function GetLanguage: string;
  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  FAudioRecorder := TAudioRecorder.Create;
  Self.ScreenRecordingOff;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSMCPCloudAI1.Service := aiOpenAI;
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
   FAudioRecorder.Free;
end;

procedure TMainView.ScreenRecordingOn;
begin
  ProgressBar1.State := pbsNormal;
  btnStartRecording.Enabled := False;
  btnStopRecording.Enabled := True;
  Self.ClearResponse;
end;

procedure TMainView.ScreenRecordingOff;
begin
  btnStartRecording.Enabled := True;
  btnStopRecording.Enabled := False;
  ProgressBar1.State := pbsPaused;
end;

procedure TMainView.ClearResponse;
begin
  mmResponse.Lines.Clear;
  lbPromptTokens.Caption := '0';
  lbNumTokensResponse.Caption := '0';
  lbTotalTokens.Caption := '0';
  lbServiceModel.Caption := '';
end;

function TMainView.GetLanguage: string;
begin
  Result := '';
  if cBoxLanguage.ItemIndex <= 0 then
    Exit;

  Result := Copy(cBoxLanguage.Text, Length(cBoxLanguage.Text) - 1, 2);
end;

procedure TMainView.btnStartRecordingClick(Sender: TObject);
begin
  Self.ScreenRecordingOn;
  FAudioRecorder.ClearRecordedData;
  FAudioRecorder.StartRecording;
end;

procedure TMainView.btnStopRecordingClick(Sender: TObject);
var
  LAudioStream: TMemoryStream;
begin
  FAudioRecorder.StopRecording;
  LAudioStream := FAudioRecorder.GetMP3Stream(20500);
  try
    LAudioStream.Position := 0;
    TMSMCPCloudAI1.Transcribe(LAudioStream, Self.GetLanguage); //, 'pt' 'en'
    //FAudioRecorder.PlayMP3FromStream(LAudioStream);
  finally
    LAudioStream.Free;
  end;
end;

procedure TMainView.TMSMCPCloudAI1SpeechAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult: string;
  SoundBuffer: TMemoryStream);
begin
  FAudioRecorder.PlayMP3FromStream(SoundBuffer);
end;

procedure TMainView.TMSMCPCloudAI1TranscribeAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult, Text: string);
begin
  if HttpStatusCode div 100 <> 2 then
  begin
    mmTanscription.Lines.Text := 'Error: ' + HttpStatusCode.ToString + sLineBreak + HttpResult;
    Self.ScreenRecordingOff;
    Exit;
  end;

  mmTanscription.Lines.Text := Text;
  TMSMCPCloudAI1.Context.Text := Text;
  TMSMCPCloudAI1.Execute;
end;

procedure TMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
  AHttpResult: string);
begin
  Self.ScreenRecordingOff;
  if AHttpStatusCode div 100 <> 2 then
  begin
    mmResponse.Lines.Text := 'Error: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;
  lbPromptTokens.Caption := AResponse.PromptTokens.ToString;
  lbNumTokensResponse.Caption := AResponse.CompletionTokens.ToString;
  lbTotalTokens.Caption := AResponse.TotalTokens.ToString;
  lbServiceModel.Caption := AResponse.ServiceModel;
end;

end.
