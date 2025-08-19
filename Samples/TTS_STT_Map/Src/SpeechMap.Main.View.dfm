object SpeechMapMainView: TSpeechMapMainView
  Left = 0
  Top = 0
  Caption = 
    'AI TTS and STT demo integrated with LLM function calling and dir' +
    'ections'
  ClientHeight = 669
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
    Top = 249
    Width = 1072
    Height = 420
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
    ExplicitHeight = 494
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1072
    Height = 249
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
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 410
        Top = 9
        Width = 200
        Height = 21
        Margins.Left = 4
        Margins.Top = 8
        Margins.Right = 4
        Margins.Bottom = 8
        Align = alLeft
        Smooth = True
        Style = pbstMarquee
        SmoothReverse = True
        State = pbsPaused
        TabOrder = 2
      end
      object cBoxLanguage: TComboBox
        AlignWithMargins = True
        Left = 4
        Top = 9
        Width = 145
        Height = 21
        Margins.Top = 8
        Align = alLeft
        DropDownCount = 15
        TabOrder = 3
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
        TabOrder = 4
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
        TabOrder = 5
      end
      object btnAddExampleText: TButton
        AlignWithMargins = True
        Left = 617
        Top = 4
        Width = 121
        Height = 31
        Align = alLeft
        Caption = 'Add example text'
        TabOrder = 6
        OnClick = btnAddExampleTextClick
        ExplicitLeft = 727
        ExplicitTop = 8
        ExplicitHeight = 25
      end
      object btnStopTalking: TButton
        AlignWithMargins = True
        Left = 744
        Top = 4
        Width = 90
        Height = 31
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'Stop talking'
        TabOrder = 7
        OnClick = btnStopTalkingClick
        ExplicitLeft = 809
        ExplicitTop = 2
      end
    end
    object gBoxTanscription: TGroupBox
      Left = 2
      Top = 41
      Width = 1068
      Height = 106
      Align = alClient
      Caption = ' Audio transcription  '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 1
      object mmTanscription: TMemo
        Left = 3
        Top = 15
        Width = 1062
        Height = 82
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          '')
        TabOrder = 0
        ExplicitHeight = 74
      end
    end
    object gBoxResponse: TGroupBox
      Left = 2
      Top = 147
      Width = 1068
      Height = 100
      Align = alBottom
      Caption = ' Response '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 2
      ExplicitTop = 133
      object mmResponse: TMemo
        Left = 3
        Top = 15
        Width = 1062
        Height = 82
        Align = alClient
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 14
        ExplicitHeight = 96
      end
    end
  end
  object TMSFNCDirections1: TTMSFNCDirections
    Left = 616
    Top = 247
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
    Settings.GrokModel = 'grok-beta'
    Settings.ClaudeModel = 'claude-3-5-sonnet-20241022'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'llama-3.1-sonar-small-128k-online'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.MistralModel = 'mistral-large-latest'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    OnSpeechAudio = TMSMCPCloudAI1SpeechAudio
    OnTranscribeAudio = TMSMCPCloudAI1TranscribeAudio
    Left = 504
    Top = 248
  end
end
