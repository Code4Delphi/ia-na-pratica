{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2025                                      }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit SpeechMap.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.Math,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  VCL.TMSFNCTypes,
  VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCMapsCommonTypes,
  VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser,
  VCL.TMSFNCMaps,
  Vcl.ExtCtrls,  
  VCL.TMSFNCCustomComponent,  
  VCL.TMSFNCDirections,
  VCL.TMSFNCRouteCalculator,
  VCL.TMSFNCCloudBase,
  TMS.MCP.CloudAI,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,  
  AudioRecorder;

type
  TSpeechMapMainView = class(TForm)
    TMSFNCMaps1: TTMSFNCMaps;
    TMSFNCDirections1: TTMSFNCDirections;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    pnTop: TPanel;
    pnButtonsTop: TPanel;
    btnStartRecording: TButton;
    btnStopRecording: TButton;
    ProgressBar1: TProgressBar;
    cBoxLanguage: TComboBox;
    ckSpeakAudioRecording: TCheckBox;
    ckSpeakResponse: TCheckBox;
    btnAddExampleText: TButton;
    gBoxTanscription: TGroupBox;
    mmTanscription: TMemo;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    btnStopTalking: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAddExampleTextClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TMSMCPCloudAI1TranscribeAudio(Sender: TObject;
      HttpStatusCode: Integer; HttpResult, Text: string);
    procedure TMSMCPCloudAI1SpeechAudio(Sender: TObject;
      HttpStatusCode: Integer; HttpResult: string; SoundBuffer: TMemoryStream);
    procedure btnStartRecordingClick(Sender: TObject);
    procedure btnStopRecordingClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure btnStopTalkingClick(Sender: TObject);
  private
    procedure ScreenRecordingOff;
    procedure ScreenRecordingOn;
    function GetLanguage: string;
  public
    FAudioRecorder: TAudioRecorder;
    procedure InitTools;
    procedure ShowRoute(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure ShowDirections(FromPlace, ToPlace: string; FromCoord, ToCoord: TTMSFNCMapsCoordinateRec);
  end;

var
  SpeechMapMainView: TSpeechMapMainView;

implementation

{$R *.dfm}

const
  //GENERATE THE API KEY: https://openrouteservice.org/dev/#/api-docs
  KEY_OPENROUTE = 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImYwYzZjMDA2OWQxMjQ5YTQ4M2NiYTBhOTdhZWYyYTgzIiwiaCI6Im11cm11cjY0In0=';

procedure TSpeechMapMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSMCPCloudAI1.Service := aiOpenAI;

  TMSFNCDirections1.Service := dsOpenRouteService;
  TMSFNCDirections1.APIKey := KEY_OPENROUTE;

  TMSFNCMaps1.Service := msOpenLayers;

  Self.InitTools;

  FAudioRecorder := TAudioRecorder.Create;
  Self.ScreenRecordingOff;
end;

procedure TSpeechMapMainView.FormDestroy(Sender: TObject);
begin
  if Assigned(FAudioRecorder) then
    FAudioRecorder.Free;
end;

procedure TSpeechMapMainView.ScreenRecordingOn;
begin
  ProgressBar1.State := pbsNormal;
  btnStartRecording.Enabled := False;
  btnStopRecording.Enabled := True;
  btnStopTalking.Enabled := False;
  btnAddExampleText.Enabled := False;
  mmTanscription.Lines.Clear;
  mmResponse.Lines.Clear;
end;

procedure TSpeechMapMainView.ScreenRecordingOff;
begin
  btnStartRecording.Enabled := True;
  btnStopRecording.Enabled := False;
  btnStopTalking.Enabled := False;
  btnAddExampleText.Enabled := True;
  ProgressBar1.State := pbsPaused;
end;

function TSpeechMapMainView.GetLanguage: string;
begin
  Result := '';
  if cBoxLanguage.ItemIndex <= 0 then
    Exit;

  Result := Copy(cBoxLanguage.Text, Length(cBoxLanguage.Text) - 1, 2);
end;

procedure TSpeechMapMainView.btnStartRecordingClick(Sender: TObject);
begin
  Self.ScreenRecordingOn;  
  FAudioRecorder.ClearRecordedData;
  FAudioRecorder.StartRecording;
end;

procedure TSpeechMapMainView.btnStopRecordingClick(Sender: TObject);
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

procedure TSpeechMapMainView.btnAddExampleTextClick(Sender: TObject);
begin
  mmTanscription.Lines.Text := 'Show the route from Madrid to Salamanca';
  TMSMCPCloudAI1.Context.Text := mmTanscription.Lines.Text;
  TMSMCPCloudAI1.Execute;
end;

procedure TSpeechMapMainView.btnStopTalkingClick(Sender: TObject);
begin
  FAudioRecorder.PlayMP3FromFile('');
  btnStopTalking.Enabled := False;
end;

procedure TSpeechMapMainView.InitTools;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  inherited;

  LTool := TMSMCPCloudAI1.Tools.Add;
  LTool.Name := 'ShowRoute';
  LTool.Description := 'Show the route between two places, based on geocoordinate points on the map';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'startplace';
  LParam.&Type := ptString;
  LParam.Required := true;
  LParam.Description := 'the name of the first place';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'startlon';
  LParam.&Type := ptString;
  LParam.Required := true;
  LParam.Description := 'the longitude of the start coordinate';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'startlat';
  LParam.&Type := ptString;
  LParam.Required := true;
  LParam.Description := 'the latitude of the start coordinate';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'endplace';
  LParam.&Type := ptString;
  LParam.Required := true;
  LParam.Description := 'the name of the second place';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'endlon';
  LParam.&Type := ptString;
  LParam.Required := true;
  LParam.Description := 'the longitude of the end coordinate';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'endlat';
  LParam.&Type := ptString;
  LParam.Required := true;
  LParam.Description := 'the latitude of the end coordinate';

  LTool.OnExecute := ShowRoute;
end;

function InflateBounds(Bounds: TTMSFNCMapsBoundsRec; Percent: double): TTMSFNCMapsBoundsRec;
var
  LLatDiff: Double;
  LLonDiff: Double;
  LExpandLat: Double;
  LExpandLon: Double;
begin
  LLatDiff := Bounds.NorthEast.Latitude - Bounds.SouthWest.Latitude;
  LLonDiff := Bounds.NorthEast.Longitude - Bounds.SouthWest.Longitude;

  // Expansion in each direction (Percent / 100 * half-span)
  LExpandLat := (LLatDiff * (Percent / 100)) / 2;
  LExpandLon := (LLonDiff * (Percent / 100)) / 2;

  // Apply expansion
  Result.NorthEast.Latitude  := Bounds.NorthEast.Latitude  + LExpandLat;
  Result.NorthEast.Longitude := Bounds.NorthEast.Longitude + LExpandLon;

  Result.SouthWest.Latitude  := Bounds.SouthWest.Latitude  - LExpandLat;
  Result.SouthWest.Longitude := Bounds.SouthWest.Longitude - LExpandLon;
end;

procedure TSpeechMapMainView.ShowDirections(FromPlace, ToPlace: string; FromCoord, ToCoord: TTMSFNCMapsCoordinateRec);
begin
  TMSFNCDirections1.GetDirections(FromCoord, ToCoord,
    procedure(const ARequest: TTMSFNCDirectionsRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult)
    var
      it: TTMSFNCDirectionsItem;
      p: TTMSFNCMapsPolyline;
      Bounds: TTMSFNCMapsBoundsRec;
    begin
      TMSFNCMaps1.ClearPolylines;
      TMSFNCMaps1.ClearMarkers;

      if ARequestResult.Success then
      begin
        if ARequest.Items.Count > 0 then
        begin
          TMSFNCMaps1.BeginUpdate;
          it := ARequest.Items[0];

          TMSFNCMaps1.AddMarker(it.Legs[0].StartLocation.ToRec, FromPlace, DEFAULTWAYPOINTMARKER);
          TMSFNCMaps1.AddMarker(it.Legs[0].EndLocation.ToRec, ToPlace, DEFAULTENDMARKER);

          p := TTMSFNCMapsPolyline(TMSFNCMaps1.AddPolyline(it.Coordinates.ToArray));
          p.StrokeColor := gcBlue;
          p.StrokeOpacity := 0.5;
          p.StrokeWidth := 5;

          // grow the boundary 15%
          Bounds := InflateBounds(it.Coordinates.Bounds.ToRec, 15);

          TMSFNCMaps1.ZoomToBounds(Bounds);
          TMSFNCMaps1.EndUpdate;
        end;
      end;
    end);
end;

procedure TSpeechMapMainView.ShowRoute(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LcStart: TTMSFNCMapsCoordinateRec;
  LcEnd: TTMSFNCMapsCoordinateRec;
  LnStart: string;
  LnEnd: string;
begin
  if Args.Count > 0 then
  begin   
    LnStart := Args.GetValue<string>('startplace');
    LcStart.Longitude := Args.GetValue<double>('startlon');
    LcStart.Latitude := Args.GetValue<double>('startlat');

    LnEnd := Args.GetValue<string>('endplace');
    LcEnd.Longitude := Args.GetValue<double>('endlon');
    LcEnd.Latitude := Args.GetValue<double>('endlat');

    if not ckSpeakResponse.Checked then  
     TMSMCPCloudAI1.Speak(Format('Estou calculando a rota de %s para %s', [LnStart, LnEnd]));

    ShowDirections(LnStart, LnEnd, LcStart, LcEnd);
  end;
end;

procedure TSpeechMapMainView.TMSMCPCloudAI1SpeechAudio(Sender: TObject;
  HttpStatusCode: Integer; HttpResult: string; SoundBuffer: TMemoryStream);
begin
  btnStopTalking.Enabled := True;
  FAudioRecorder.PlayMP3FromStream(SoundBuffer);
end;

procedure TSpeechMapMainView.TMSMCPCloudAI1TranscribeAudio(Sender: TObject;
  HttpStatusCode: Integer; HttpResult, Text: string);
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

procedure TSpeechMapMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  Self.ScreenRecordingOff;
  if AHttpStatusCode div 100 <> 2 then
  begin
    mmResponse.Lines.Text := 'Error: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines.Text := AResponse.Content.Text;

  if ckSpeakResponse.Checked then
    TMSMCPCloudAI1.Speak(AResponse.Content.Text);
end;

end.
