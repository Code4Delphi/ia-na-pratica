object TranslateMainView: TTranslateMainView
  Left = 0
  Top = 0
  Caption = 'AI in practice: TTS e STT - Demo Translate'
  ClientHeight = 698
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 314
    Width = 845
    Height = 8
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ExplicitTop = 161
    ExplicitWidth = 780
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 845
    Height = 273
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object pnButtonsTop: TPanel
      Left = 2
      Top = 2
      Width = 841
      Height = 39
      Align = alTop
      TabOrder = 0
      DesignSize = (
        841
        39)
      object btnStartRecording: TButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 90
        Height = 31
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'Start recording'
        TabOrder = 0
        OnClick = btnStartRecordingClick
      end
      object btnStopRecording: TButton
        AlignWithMargins = True
        Left = 100
        Top = 4
        Width = 90
        Height = 31
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'Stop recording'
        TabOrder = 1
        OnClick = btnStopRecordingClick
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 197
        Top = 9
        Width = 129
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
      object ckSpeakAudioRecording: TCheckBox
        Left = 690
        Top = 1
        Width = 150
        Height = 17
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'Speak audio recording'
        TabOrder = 3
      end
      object ckSpeakResponse: TCheckBox
        Left = 690
        Top = 18
        Width = 150
        Height = 17
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'Speak response'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object btnStopTalking: TButton
        AlignWithMargins = True
        Left = 429
        Top = 4
        Width = 90
        Height = 31
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'Stop talking'
        TabOrder = 5
        OnClick = btnStopTalkingClick
      end
      object btnLoadAudio: TButton
        AlignWithMargins = True
        Left = 333
        Top = 4
        Width = 90
        Height = 31
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'Load audio'
        TabOrder = 6
        OnClick = btnLoadAudioClick
      end
    end
    object gBoxTanscription: TGroupBox
      Left = 2
      Top = 41
      Width = 841
      Height = 230
      Align = alClient
      Caption = ' Audio transcription  '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 1
      object mmTanscription: TMemo
        Left = 3
        Top = 17
        Width = 835
        Height = 210
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          '')
        TabOrder = 0
      end
    end
  end
  object gBoxResponse: TGroupBox
    Left = 0
    Top = 322
    Width = 845
    Height = 376
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 1
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 839
      Height = 333
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object pnResponseDetails: TPanel
      Left = 3
      Top = 350
      Width = 839
      Height = 23
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      object Label9: TLabel
        Left = 174
        Top = 0
        Width = 93
        Height = 21
        Hint = 'N'#186' de tokens que a resposta cont'#233'm: '
        Align = alLeft
        Caption = 'Tokens response: '
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbNumTokensResponse: TLabel
        Left = 267
        Top = 0
        Width = 90
        Height = 21
        Align = alLeft
        AutoSize = False
        Caption = '0'
        Layout = tlCenter
        ExplicitLeft = 370
      end
      object Label10: TLabel
        Left = 0
        Top = 0
        Width = 84
        Height = 21
        Align = alLeft
        Caption = 'Prompt tokens: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbPromptTokens: TLabel
        Left = 84
        Top = 0
        Width = 90
        Height = 21
        Align = alLeft
        AutoSize = False
        Caption = '0'
        Layout = tlCenter
        ExplicitLeft = 83
      end
      object Label11: TLabel
        Left = 517
        Top = 0
        Width = 90
        Height = 21
        Align = alLeft
        Caption = 'Model response: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbServiceModel: TLabel
        Left = 607
        Top = 0
        Width = 5
        Height = 21
        Align = alLeft
        Caption = '-'
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object Label12: TLabel
        Left = 357
        Top = 0
        Width = 70
        Height = 21
        Align = alLeft
        Caption = 'Total tokens: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbTotalTokens: TLabel
        Left = 427
        Top = 0
        Width = 90
        Height = 21
        Align = alLeft
        AutoSize = False
        Caption = '0'
        Layout = tlCenter
        ExplicitLeft = 675
      end
    end
  end
  object pnOpcoesTranslate: TPanel
    Left = 0
    Top = 273
    Width = 845
    Height = 41
    Align = alTop
    Padding.Top = 6
    Padding.Bottom = 6
    TabOrder = 2
    object Label1: TLabel
      Left = 1
      Top = 7
      Width = 125
      Height = 27
      Align = alLeft
      Caption = ' Speak in the language: '
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object cBoxLanguage: TComboBox
      AlignWithMargins = True
      Left = 129
      Top = 10
      Width = 117
      Height = 23
      Margins.Bottom = 0
      Align = alLeft
      DropDownCount = 15
      ItemIndex = 0
      TabOrder = 0
      Text = 'Ingl'#234's - EN'
      Items.Strings = (
        'Ingl'#234's - EN'
        'Portugu'#234's - PT'
        'Espanhol - ES'
        'Franc'#234's - FR'
        'Italiano - IT'
        'Japon'#234's - JA'
        #193'rabe - AR')
    end
    object btnTranslate: TButton
      AlignWithMargins = True
      Left = 252
      Top = 7
      Width = 145
      Height = 27
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Translate'
      TabOrder = 1
      OnClick = btnTranslateClick
    end
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
    Left = 624
    Top = 136
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'mp3'
    Filter = 'Arquivos MP3 (*.mp3)|*.mp3|Todos os arquivos (*.*)|*.*'
    Left = 624
    Top = 72
  end
end
