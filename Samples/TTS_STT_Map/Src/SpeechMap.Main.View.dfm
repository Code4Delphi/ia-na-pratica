object SpeechMapMainView: TSpeechMapMainView
  Left = 0
  Top = 0
  Caption = 
    'AI TTS and STT demo integrated with LLM function calling and dir' +
    'ections'
  ClientHeight = 726
  ClientWidth = 1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object TMSFNCMaps1: TTMSFNCMaps
    Left = 0
    Top = 245
    Width = 1072
    Height = 481
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 0
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    ElementContainers = <>
    Labels = <>
    HeadLinks = <>
    Options.DefaultLatitude = 40.689247000000000000
    Options.DefaultLongitude = -74.044501999999990000
    Options.DefaultZoomLevel = 12.000000000000000000
    ExplicitTop = 249
    ExplicitHeight = 420
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1072
    Height = 245
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 3
    object pnButtonsTop: TPanel
      Left = 2
      Top = 2
      Width = 1068
      Height = 39
      Align = alTop
      TabOrder = 0
      DesignSize = (
        1068
        39)
      object btnStartRecording: TButton
        AlignWithMargins = True
        Left = 155
        Top = 4
        Width = 121
        Height = 31
        Align = alLeft
        Caption = 'Start recording'
        TabOrder = 0
        OnClick = btnStartRecordingClick
      end
      object btnStopRecording: TButton
        AlignWithMargins = True
        Left = 282
        Top = 4
        Width = 121
        Height = 31
        Align = alLeft
        Caption = 'Stop recording'
        TabOrder = 1
        OnClick = btnStopRecordingClick
      end
      object cBoxLanguage: TComboBox
        AlignWithMargins = True
        Left = 4
        Top = 9
        Width = 145
        Height = 26
        Margins.Top = 8
        Align = alLeft
        DropDownCount = 15
        TabOrder = 2
        Text = 'Auto  '
        Items.Strings = (
          'Auto  '
          'Ingl'#234's - EN'
          'Portugu'#234's - PT'
          'Espanhol - ES'
          'Franc'#234's - FR'
          'Italiano - IT'
          'Japon'#234's - JA'
          #193'rabe - AR')
      end
      object ckSpeakAudioRecording: TCheckBox
        Left = 917
        Top = 1
        Width = 150
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Speak audio recording'
        TabOrder = 3
      end
      object ckSpeakResponse: TCheckBox
        Left = 917
        Top = 18
        Width = 150
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Speak response'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object btnAddExampleText: TButton
        AlignWithMargins = True
        Left = 505
        Top = 4
        Width = 121
        Height = 31
        Align = alLeft
        Caption = 'Add example text'
        TabOrder = 5
        OnClick = btnAddExampleTextClick
        ExplicitLeft = 705
        ExplicitTop = 2
      end
      object btnStopTalking: TButton
        AlignWithMargins = True
        Left = 409
        Top = 4
        Width = 90
        Height = 31
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'Stop talking'
        TabOrder = 6
        OnClick = btnStopTalkingClick
        ExplicitLeft = 744
      end
    end
    object gBoxTanscription: TGroupBox
      Left = 2
      Top = 41
      Width = 1068
      Height = 79
      Align = alClient
      Caption = ' Audio transcription  '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 1
      ExplicitHeight = 71
      object mmTanscription: TMemo
        Left = 3
        Top = 15
        Width = 1062
        Height = 61
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          '')
        TabOrder = 0
      end
    end
    object gBoxResponse: TGroupBox
      Left = 2
      Top = 155
      Width = 1068
      Height = 88
      Align = alBottom
      Caption = ' Response '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 2
      object mmResponse: TMemo
        Left = 3
        Top = 15
        Width = 1062
        Height = 70
        Align = alClient
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 82
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 120
      Width = 1068
      Height = 35
      Align = alBottom
      TabOrder = 3
      ExplicitTop = 112
      object btnExecute: TBitBtn
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 102
        Height = 27
        Align = alLeft
        Caption = 'Execute'
        TabOrder = 0
        OnClick = btnExecuteClick
        ExplicitLeft = 1
        ExplicitTop = 3
        ExplicitHeight = 26
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 113
        Top = 9
        Width = 200
        Height = 17
        Margins.Left = 4
        Margins.Top = 8
        Margins.Right = 4
        Margins.Bottom = 8
        Align = alLeft
        Smooth = True
        Style = pbstMarquee
        SmoothReverse = True
        State = pbsPaused
        TabOrder = 1
        ExplicitLeft = 410
        ExplicitHeight = 21
      end
    end
  end
  object TMSFNCDirections1: TTMSFNCDirections
    Left = 619
    Top = 56
    Width = 26
    Height = 26
    Visible = True
    DirectionsRequests = <>
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    Service = aiOpenAI
    Settings.GeminiModel = 'gemini-1.5-flash-latest'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.OpenAITranscribeModel = 'whisper-1'
    Settings.GrokModel = 'grok-beta'
    Settings.ClaudeModel = 'claude-3-5-sonnet-20241022'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'llama-3.1-sonar-small-128k-online'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.MistralModel = 'mistral-large-latest'
    Settings.MistralTranscribeModel = 'voxtral-mini-2507'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    OnSpeechAudio = TMSMCPCloudAI1SpeechAudio
    OnTranscribeAudio = TMSMCPCloudAI1TranscribeAudio
    Left = 496
    Top = 56
  end
end
