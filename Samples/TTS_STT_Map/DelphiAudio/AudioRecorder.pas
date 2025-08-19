{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2025                                      }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{********************************************************************}

unit AudioRecorder;

interface

uses
  Windows, MMSystem, Classes, SysUtils;

type
  TBE_ERR = DWORD;
  THBE_STREAM = DWORD;

  TMP3Encoder = class
  private
    FLameDLL: HMODULE;

    beInitStream: function(var pbeConfig; var dwSamples, dwBufferSize: DWORD; var hbeStream: THBE_STREAM): TBE_ERR; stdcall;
    beEncodeChunk: function(hbeStream: THBE_STREAM; nSamples: DWORD; var pSample; var pOutput; var pdwOutput: DWORD): TBE_ERR; stdcall;
    beDeinitStream: function(hbeStream: THBE_STREAM; var pOutput; var pdwOutput: DWORD): TBE_ERR; stdcall;
    beCloseStream: function(hbeStream: THBE_STREAM): TBE_ERR; stdcall;
    beWriteVBRHeader: procedure(MP3FileName: PAnsiChar); stdcall;

    procedure LoadLameDLL;
    procedure UnloadLameDLL;
    procedure GetLameFunctions;
  public
    constructor Create;
    destructor Destroy; override;

    procedure EncodeFileToMP3(const WavFile, MP3File: string; BitRate: Integer);
    function EncodeStreamToMP3(WavStream: TStream; BitRate: Integer): TMemoryStream;
  end;

  TAudioRecorder = class
  private
    FWaveIn: HWAVEIN;
    FWaveFormat: TWAVEFORMATEX;
    FWaveHeaders: array[0..1] of TWAVEHDR;
    FBuffers: array[0..1] of array[0..8191] of Byte;
    FRecordedData: TMemoryStream;
    FRecording: Boolean;
    FCurrentBuffer: Integer;
    FDeviceList: TStringList;
    FMP3Encoder: TMP3Encoder;
    procedure InitializeWaveFormat;
    procedure PrepareBuffers;
    procedure UnprepareBuffers;
    procedure AddWaveHeader(BufferIndex: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function GetDevices: TStringList;
    function StartRecording(DeviceIndex: integer = -1): Boolean;
    function StopRecording: Boolean;
    function GetWaveStream: TMemoryStream;
    function GetMP3Stream(BitRate: Integer): TMemoryStream;
    procedure SaveToFile(const FileName: string);
    procedure SaveToMP3(const FileName: string; BitRate: Integer = 44100);
    function SaveToMP3Base64(BitRate: Integer = 44100): string;
    procedure ClearRecordedData;

    property Recording: Boolean read FRecording;

    procedure PlayMP3FromFile(const FileName: string);
    procedure PlayMP3FromStream(Stream: TMemoryStream);
  end;

implementation

uses
  System.NetEncoding;

procedure WaveInProc(hWaveIn: HWAVEIN; uMsg: UINT; dwInstance: DWORD_PTR;
                    dwParam1: DWORD_PTR; dwParam2: DWORD_PTR); stdcall;
var
  WaveHeader: PWAVEHDR;
  Recorder: TAudioRecorder;
begin
  if uMsg = WIM_DATA then
  begin
    Recorder := TAudioRecorder(dwInstance);
    WaveHeader := PWAVEHDR(dwParam1);

    if Assigned(Recorder) and Recorder.Recording and (WaveHeader^.dwBytesRecorded > 0) then
    begin
      Recorder.FRecordedData.Write(WaveHeader^.lpData^, WaveHeader^.dwBytesRecorded);

      if Recorder.Recording then
      begin
        waveInUnprepareHeader(hWaveIn, WaveHeader, SizeOf(TWAVEHDR));
        waveInPrepareHeader(hWaveIn, WaveHeader, SizeOf(TWAVEHDR));
        waveInAddBuffer(hWaveIn, WaveHeader, SizeOf(TWAVEHDR));
      end;
    end;
  end;
end;

{ TMP3Encoder }

constructor TMP3Encoder.Create;
begin
  inherited;
  LoadLameDLL;
end;

destructor TMP3Encoder.Destroy;
begin
  UnloadLameDLL;
  inherited;
end;

procedure TMP3Encoder.LoadLameDLL;
begin
  FLameDLL := LoadLibrary('lame_enc.dll');
  if FLameDLL = 0 then
    raise Exception.Create('Cannot load lame_enc.dll');
  GetLameFunctions;
end;

procedure TMP3Encoder.UnloadLameDLL;
begin
  if FLameDLL <> 0 then
    FreeLibrary(FLameDLL);
  FLameDLL := 0;
end;

procedure TMP3Encoder.GetLameFunctions;
begin
  @beInitStream := GetProcAddress(FLameDLL, 'beInitStream');
  @beEncodeChunk := GetProcAddress(FLameDLL, 'beEncodeChunk');
  @beDeinitStream := GetProcAddress(FLameDLL, 'beDeinitStream');
  @beCloseStream := GetProcAddress(FLameDLL, 'beCloseStream');
  @beWriteVBRHeader := GetProcAddress(FLameDLL, 'beWriteVBRHeader');

  if not Assigned(beInitStream) or not Assigned(beEncodeChunk) or
     not Assigned(beDeinitStream) or not Assigned(beCloseStream) or
     not Assigned(beWriteVBRHeader) then
    raise Exception.Create('Failed to load LAME functions.');
end;

procedure TMP3Encoder.EncodeFileToMP3(const WavFile, MP3File: string; BitRate: Integer);
var
  WavStream, MP3Stream: TMemoryStream;
begin
  WavStream := TMemoryStream.Create;
  try
    WavStream.LoadFromFile(WavFile);
    MP3Stream := EncodeStreamToMP3(WavStream, BitRate);
    try
      MP3Stream.SaveToFile(MP3File);
      beWriteVBRHeader(PAnsiChar(AnsiString(MP3File)));
    finally
      MP3Stream.Free;
    end;
  finally
    WavStream.Free;
  end;
end;

function TMP3Encoder.EncodeStreamToMP3(WavStream: TStream; BitRate: Integer): TMemoryStream;
const
  BE_CONFIG_LAME = 256;
  BE_MP3_MODE_MONO = 3;
  BE_MP3_MODE_STEREO = 0;

type
  TLHV1 = packed record
    dwStructVersion, dwStructSize: DWORD;
    dwSampleRate, dwReSampleRate: DWORD;
    nMode: Integer;
    dwBitrate, dwMaxBitrate: DWORD;
    nQuality: Integer;
    dwMpegVersion, dwPsyModel, dwEmphasis: DWORD;
    bPrivate, bCRC, bCopyright, bOriginal: LongBool;
    bWriteVBRHeader, bEnableVBR: LongBool;
    nVBRQuality: Integer;
    btReserved: array[0..255] of Byte;
  end;

  TBEConfig = packed record
    dwConfig: DWORD;
    format: packed record
      lhv1: TLHV1;
    end;
  end;

  TWaveHeader = packed record
    RiffID: array[0..3] of AnsiChar;
    FileSize: DWORD;
    WaveID: array[0..3] of AnsiChar;
    FmtID: array[0..3] of AnsiChar;
    FmtSize: DWORD;
    AudioFormat: WORD;
    NumChannels: WORD;
    SampleRate, ByteRate: DWORD;
    BlockAlign: WORD;
    BitsPerSample: WORD;
    DataID: array[0..3] of AnsiChar;
    DataSize: DWORD;
  end;

var
  Header: TWaveHeader;
  Config: TBEConfig;
  dwSamples, dwBufferSize: DWORD;
  hbeStream: THBE_STREAM;
  pBuffer: PSmallInt;
  pMP3Buffer: PByte;
  error: TBE_ERR;
  done, ToRead, ToWrite: DWORD;
  ChannelMode: Integer;
begin
  WavStream.Position := 0;
  if WavStream.Read(Header, SizeOf(Header)) <> SizeOf(Header) then
    raise Exception.Create('Invalid WAV header.');
  if (Header.RiffID <> 'RIFF') or (Header.WaveID <> 'WAVE') or
     (Header.FmtID <> 'fmt ') or (Header.DataID <> 'data') then
    raise Exception.Create('Invalid WAV format.');
  if Header.BitsPerSample <> 16 then
    raise Exception.Create('Only 16-bit WAV PCM supported.');

  FillChar(Config, SizeOf(Config), 0);
  Config.dwConfig := BE_CONFIG_LAME;

  Config.format.lhv1.dwStructVersion := 1;
  Config.format.lhv1.dwStructSize := 331;
  Config.format.lhv1.dwSampleRate := Header.SampleRate;
  Config.format.lhv1.dwReSampleRate := 0;
  if Header.NumChannels = 1 then
    ChannelMode := BE_MP3_MODE_MONO
  else
    ChannelMode := BE_MP3_MODE_STEREO;
  Config.format.lhv1.nMode := ChannelMode;
  Config.format.lhv1.dwBitrate := BitRate;
  Config.format.lhv1.dwMaxBitrate := BitRate;
  Config.format.lhv1.nQuality := 4;
  Config.format.lhv1.dwMpegVersion := 1;
  Config.format.lhv1.dwPsyModel := 0;
  Config.format.lhv1.dwEmphasis := 0;
  Config.format.lhv1.bPrivate := False;
  Config.format.lhv1.bCRC := True;
  Config.format.lhv1.bCopyright := True;
  Config.format.lhv1.bOriginal := True;
  Config.format.lhv1.bWriteVBRHeader := True;
  Config.format.lhv1.bEnableVBR := False;
  Config.format.lhv1.nVBRQuality := 0;

  error := beInitStream(Config, dwSamples, dwBufferSize, hbeStream);
  if error <> 0 then
    raise Exception.Create('beInitStream failed.');

  GetMem(pBuffer, dwSamples * Header.NumChannels * SizeOf(SmallInt));
  GetMem(pMP3Buffer, dwBufferSize);
  try
    Result := TMemoryStream.Create;
    done := SizeOf(Header);
    WavStream.Position := done;

    while done < WavStream.Size do
    begin
      if done + dwSamples * Header.NumChannels * SizeOf(SmallInt) < WavStream.Size then
        ToRead := dwSamples * Header.NumChannels * SizeOf(SmallInt)
      else
      begin
        ToRead := WavStream.Size - done;
        FillChar(pBuffer^, dwSamples * Header.NumChannels * SizeOf(SmallInt), 0);
      end;

      WavStream.Read(pBuffer^, ToRead);

      error := beEncodeChunk(hbeStream, ToRead div (Header.NumChannels * SizeOf(SmallInt)), pBuffer^, pMP3Buffer^, ToWrite);
      if error <> 0 then
        raise Exception.Create('Encoding error.');

      if ToWrite > 0 then
        Result.Write(pMP3Buffer^, ToWrite);

      done := done + ToRead;
    end;

    error := beDeinitStream(hbeStream, pMP3Buffer^, ToWrite);
    if error <> 0 then
      raise Exception.Create('beDeinitStream error.');

    if ToWrite > 0 then
      Result.Write(pMP3Buffer^, ToWrite);

    beCloseStream(hbeStream);
    Result.Position := 0;
  finally
    FreeMem(pBuffer);
    FreeMem(pMP3Buffer);
  end;
end;

{ TAudioRecorder }

constructor TAudioRecorder.Create;
begin
  inherited;
  FDeviceList := TStringList.Create;
  FRecordedData := TMemoryStream.Create;
  FRecording := False;
  FCurrentBuffer := 0;
  FMP3Encoder := TMP3Encoder.Create;
  InitializeWaveFormat;
end;

destructor TAudioRecorder.Destroy;
begin
  FDeviceList.Free;
  if FRecording then
    StopRecording;
  FMP3Encoder.Free;
  FRecordedData.Free;
  inherited;
end;

procedure TAudioRecorder.InitializeWaveFormat;
begin
  FillChar(FWaveFormat, SizeOf(TWAVEFORMATEX), 0);
  FWaveFormat.wFormatTag := WAVE_FORMAT_PCM;
  FWaveFormat.nChannels := 1;              // Mono
  FWaveFormat.nSamplesPerSec := 44100;     // 44.1 kHz
  FWaveFormat.wBitsPerSample := 16;        // 16-bit
  FWaveFormat.nBlockAlign := (FWaveFormat.nChannels * FWaveFormat.wBitsPerSample) div 8;
  FWaveFormat.nAvgBytesPerSec := FWaveFormat.nSamplesPerSec * FWaveFormat.nBlockAlign;
  FWaveFormat.cbSize := 0;
end;

procedure TAudioRecorder.PlayMP3FromFile(const FileName: string);
var
  S: string;
begin
  // Close any previously opened device
  mciSendString('close all', nil, 0, 0);

  // Use double quotes in case path has spaces
  S := Format('open "%s" type mpegvideo alias MP3File', [FileName]);
  mciSendString(PChar(S), nil, 0, 0);
  mciSendString('play MP3File', nil, 0, 0);
end;

function GetTempMP3FileName: string;
var
  TempPath: array[0..MAX_PATH] of Char;
  TempFile: array[0..MAX_PATH] of Char;
begin
  // Get the temp directory
  if GetTempPath(MAX_PATH, TempPath) = 0 then
    RaiseLastOSError;

  // Create a unique temp file (with .tmp extension by default)
  if GetTempFileName(TempPath, 'MP3', 0, TempFile) = 0 then
    RaiseLastOSError;

  // Change extension to .mp3
  Result := ChangeFileExt(string(TempFile), '.mp3');
end;

procedure TAudioRecorder.PlayMP3FromStream(Stream: TMemoryStream);
var
  TempFileName: string;
begin
  TempFileName := GetTempMP3FileName;

  Stream.Position := 0;
  Stream.SaveToFile(TempFileName);

  PlayMP3FromFile(TempFileName);
end;

procedure TAudioRecorder.PrepareBuffers;
var
  i: Integer;
begin
  for i := 0 to High(FWaveHeaders) do
  begin
    FillChar(FWaveHeaders[i], SizeOf(TWAVEHDR), 0);
    FWaveHeaders[i].lpData := @FBuffers[i][0];
    FWaveHeaders[i].dwBufferLength := SizeOf(FBuffers[i]);
    FWaveHeaders[i].dwFlags := 0;
  end;
end;

procedure TAudioRecorder.UnprepareBuffers;
var
  i: Integer;
begin
  for i := 0 to High(FWaveHeaders) do
  begin
    if FWaveHeaders[i].dwFlags and WHDR_PREPARED <> 0 then
      waveInUnprepareHeader(FWaveIn, @FWaveHeaders[i], SizeOf(TWAVEHDR));
  end;
end;

procedure TAudioRecorder.AddWaveHeader(BufferIndex: Integer);
begin
  waveInPrepareHeader(FWaveIn, @FWaveHeaders[BufferIndex], SizeOf(TWAVEHDR));
  waveInAddBuffer(FWaveIn, @FWaveHeaders[BufferIndex], SizeOf(TWAVEHDR));
end;

function TAudioRecorder.StartRecording(DeviceIndex: integer= -1): Boolean;
var
  Result_Code: MMRESULT;
  DevID: UINT;
  i: integer;
begin
  Result := False;

  if FRecording then
    Exit;

  FRecordedData.Clear;

  if DeviceIndex >= 0 then
    DevID := DeviceIndex
  else
    DevID := WAVE_MAPPER;

  Result_Code := waveInOpen(@FWaveIn, DevID, @FWaveFormat,
                            DWORD_PTR(@WaveInProc), DWORD_PTR(Self), CALLBACK_FUNCTION);

  if Result_Code <> MMSYSERR_NOERROR then
    Exit;

  try
    PrepareBuffers;
    for i := 0 to High(FWaveHeaders) do
      AddWaveHeader(i);

    Result_Code := waveInStart(FWaveIn);
    if Result_Code = MMSYSERR_NOERROR then
    begin
      FRecording := True;
      Result := True;
    end;
  except
    waveInClose(FWaveIn);
    raise;
  end;
end;

function TAudioRecorder.StopRecording: Boolean;
begin
  Result := False;
  if not FRecording then Exit;

  FRecording := False;
  waveInStop(FWaveIn);
  waveInReset(FWaveIn);
  UnprepareBuffers;
  waveInClose(FWaveIn);
  Result := True;
end;

function TAudioRecorder.GetWaveStream: TMemoryStream;
type
  TWaveHeader = packed record
    RiffID: array[0..3] of AnsiChar;
    FileSize: DWORD;
    WaveID: array[0..3] of AnsiChar;
    FmtID: array[0..3] of AnsiChar;
    FmtSize: DWORD;
    AudioFormat: WORD;
    NumChannels: WORD;
    SampleRate: DWORD;
    ByteRate: DWORD;
    BlockAlign: WORD;
    BitsPerSample: WORD;
    DataID: array[0..3] of AnsiChar;
    DataSize: DWORD;
  end;
var
  WaveStream: TMemoryStream;
  Header: TWaveHeader;
  DataSize: DWORD;
begin
  WaveStream := TMemoryStream.Create;
  try
    DataSize := FRecordedData.Size;

    FillChar(Header, SizeOf(Header), 0);
    Header.RiffID := 'RIFF';
    Header.FileSize := SizeOf(TWaveHeader) - 8 + DataSize;
    Header.WaveID := 'WAVE';
    Header.FmtID := 'fmt ';
    Header.FmtSize := 16;
    Header.AudioFormat := WAVE_FORMAT_PCM;
    Header.NumChannels := FWaveFormat.nChannels;
    Header.SampleRate := FWaveFormat.nSamplesPerSec;
    Header.BitsPerSample := FWaveFormat.wBitsPerSample;
    Header.BlockAlign := FWaveFormat.nBlockAlign;
    Header.ByteRate := FWaveFormat.nAvgBytesPerSec;
    Header.DataID := 'data';
    Header.DataSize := DataSize;

    WaveStream.Write(Header, SizeOf(Header));
    FRecordedData.Position := 0;
    WaveStream.CopyFrom(FRecordedData, FRecordedData.Size);
    WaveStream.Position := 0;

    Result := WaveStream;
  except
    WaveStream.Free;
    raise;
  end;
end;

function TAudioRecorder.GetDevices: TStringList;
var
  NumDevs, i: UINT;
  Caps: TWAVEINCAPS;
  DevName: string;
begin
  Result := FDeviceList;
  FDeviceList.BeginUpdate;
  try
    FDeviceList.Clear;
    // How many capture devices are present
    NumDevs := waveInGetNumDevs;
    for i := 0 to NumDevs - 1 do
    begin
      ZeroMemory(@Caps, SizeOf(Caps));
      // Query capabilities for device i
      if waveInGetDevCaps(i, @Caps, SizeOf(Caps)) = MMSYSERR_NOERROR then
      begin
        // szPname is a null-terminated array of WideChars, convert to Delphi string
        DevName := WideCharToString(Caps.szPname);
        FDeviceList.Add(Format('Device %d: %s', [i, DevName]));
      end
      else
        FDeviceList.Add(Format('Device %d: <error retrieving name>', [i]));
    end;

    if NumDevs = 0 then
      FDeviceList.Add('No WaveIn devices found.');
  finally
    FDeviceList.EndUpdate;
  end;
end;

function TAudioRecorder.GetMP3Stream(BitRate: Integer): TMemoryStream;
var
  WavStream: TMemoryStream;
begin
  WavStream := GetWaveStream;
  try
    Result := FMP3Encoder.EncodeStreamToMP3(WavStream, BitRate);
  finally
    WavStream.Free;
  end;
end;

procedure TAudioRecorder.SaveToFile(const FileName: string);
var
  WaveStream: TMemoryStream;
begin
  WaveStream := GetWaveStream;
  try
    WaveStream.SaveToFile(FileName);
  finally
    WaveStream.Free;
  end;
end;

procedure TAudioRecorder.SaveToMP3(const FileName: string; BitRate: Integer = 44100);
var
  MP3Stream: TMemoryStream;
begin
  MP3Stream := GetMP3Stream(BitRate);
  try
    MP3Stream.SaveToFile(FileName);
  finally
    MP3Stream.Free;
  end;
end;

function TAudioRecorder.SaveToMP3Base64(BitRate: Integer = 44100): string;
var
  Bytes: TBytes;
  MP3Stream: TMemoryStream;
begin
  MP3Stream := GetMP3Stream(BitRate);
  // Set the stream position to the beginning
  MP3Stream.Position := 0;

  // Copy the memory stream contents into a byte array
  SetLength(Bytes, MP3Stream.Size);
  MP3Stream.ReadBuffer(Bytes[0], MP3Stream.Size);

  // Encode the byte array as Base64
  Result := TNetEncoding.Base64.EncodeBytesToString(Bytes);
end;

procedure TAudioRecorder.ClearRecordedData;
begin
  FRecordedData.Clear;
end;

end.

