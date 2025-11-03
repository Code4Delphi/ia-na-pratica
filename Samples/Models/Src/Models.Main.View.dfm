object ModelsMainView: TModelsMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Models'
  ClientHeight = 649
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 8
      Width = 50
      Height = 15
      Caption = 'IA service'
    end
    object cBoxIAService: TComboBox
      Left = 18
      Top = 26
      Width = 201
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
    object btnShowModels: TButton
      Left = 225
      Top = 25
      Width = 95
      Height = 25
      Cursor = crHandPoint
      Caption = 'Show Models'
      TabOrder = 1
      OnClick = btnShowModelsClick
    end
    object ProgressBar1: TProgressBar
      Left = 326
      Top = 30
      Width = 150
      Height = 17
      Smooth = True
      Style = pbstMarquee
      SmoothReverse = True
      State = pbsPaused
      TabOrder = 2
    end
  end
  object gBoxResponse: TGroupBox
    Left = 0
    Top = 65
    Width = 624
    Height = 584
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 1
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 618
      Height = 535
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object pnBottom: TPanel
      Left = 3
      Top = 552
      Width = 618
      Height = 29
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 1
      object Label2: TLabel
        Left = 2
        Top = 2
        Width = 32
        Height = 25
        Align = alLeft
        Caption = 'Total: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbTotalModels: TLabel
        Left = 34
        Top = 2
        Width = 6
        Height = 25
        Align = alLeft
        Caption = '0'
        Layout = tlCenter
        ExplicitHeight = 15
      end
    end
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    Service = aiOpenAI
    Settings.GeminiModel = 'gemini-1.5-flash-latest'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.OpenAITranscribeModel = 'whisper-1'
    Settings.GrokModel = 'grok-3'
    Settings.ClaudeModel = 'claude-sonnet-4-20250514'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'sonar-pro'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.MistralModel = 'mistral-large-latest'
    Settings.MistralTranscribeModel = 'voxtral-mini-2507'
    Tools = <>
    OnGetModels = TMSMCPCloudAI1GetModels
    Left = 512
    Top = 25
  end
end
