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
    ProgressBar1: TProgressBar;
    cBoxLanguage: TComboBox;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    ckSpeakAudioRecording: TCheckBox;
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
    gBoxTanscription: TGroupBox;
    mmTanscription: TMemo;
    ckSpeakResponse: TCheckBox;
    btnStopTalking: TButton;
    btnLoadAudio: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartRecordingClick(Sender: TObject);
    procedure btnStopRecordingClick(Sender: TObject);
    procedure TMSMCPCloudAI1SpeechAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult: string;
      SoundBuffer: TMemoryStream);
    procedure TMSMCPCloudAI1TranscribeAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult, Text: string);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnStopTalkingClick(Sender: TObject);
    procedure btnLoadAudioClick(Sender: TObject);
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
  TMSMCPCloudAI1.Settings.WebSearch := True;
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
  btnStopTalking.Enabled := False;
  btnLoadAudio.Enabled := False;
  Self.ClearResponse;
end;

procedure TMainView.ScreenRecordingOff;
begin
  btnStartRecording.Enabled := True;
  btnStopRecording.Enabled := False;
  btnStopTalking.Enabled := False;
  btnLoadAudio.Enabled := True;
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
  btnStopRecording.Enabled := False;

  FAudioRecorder.StopRecording;
  LAudioStream := FAudioRecorder.GetMP3Stream(20500);
  try
    LAudioStream.Position := 0;
    TMSMCPCloudAI1.Transcribe(LAudioStream, Self.GetLanguage); //'en'

    if ckSpeakAudioRecording.Checked then
    begin
      btnStopTalking.Enabled := True;
      FAudioRecorder.PlayMP3FromStream(LAudioStream);
    end;
  finally
    LAudioStream.Free;
  end;
end;

procedure TMainView.btnStopTalkingClick(Sender: TObject);
begin
  FAudioRecorder.PlayMP3FromFile('');
  btnStopTalking.Enabled := False;
end;

procedure TMainView.TMSMCPCloudAI1SpeechAudio(Sender: TObject; HttpStatusCode: Integer; HttpResult: string;
  SoundBuffer: TMemoryStream);
begin
  btnStopTalking.Enabled := True;
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

  if ckSpeakResponse.Checked then
    TMSMCPCloudAI1.Speak(AResponse.Content.Text);
end;

procedure TMainView.btnLoadAudioClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;

  TMSMCPCloudAI1.Transcribe(OpenDialog1.FileName, Self.GetLanguage); //'en'

  if ckSpeakAudioRecording.Checked then
  begin
    btnStopTalking.Enabled := True;
    FAudioRecorder.PlayMP3FromFile(OpenDialog1.FileName);
  end;
end;

end.
