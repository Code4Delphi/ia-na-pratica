object OllamaMainView: TOllamaMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Ollama - IA Off-Line'
  ClientHeight = 636
  ClientWidth = 841
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
  object Splitter1: TSplitter
    Left = 0
    Top = 297
    Width = 841
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -8
    ExplicitTop = 481
    ExplicitWidth = 1383
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 841
    Height = 129
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 833
    object Label13: TLabel
      Left = 677
      Top = 7
      Width = 67
      Height = 15
      Caption = 'Temperature'
    end
    object Label1: TLabel
      Left = 163
      Top = 6
      Width = 34
      Height = 15
      Caption = 'Model'
    end
    object Label2: TLabel
      Left = 13
      Top = 67
      Width = 63
      Height = 15
      Caption = 'OllamaHost'
    end
    object Label3: TLabel
      Left = 345
      Top = 67
      Width = 62
      Height = 15
      Caption = 'OllamaPath'
    end
    object lbPort: TLabel
      Left = 677
      Top = 67
      Width = 60
      Height = 15
      Caption = 'OllamaPort'
    end
    object edtTemperature: TEdit
      Left = 677
      Top = 24
      Width = 149
      Height = 23
      MaxLength = 3
      TabOrder = 0
      Text = '0'
    end
    object btnShowModels: TButton
      Left = 13
      Top = 23
      Width = 146
      Height = 25
      Cursor = crHandPoint
      Caption = 'Get Models Dispon'#237'veis'
      TabOrder = 1
      OnClick = btnShowModelsClick
    end
    object cBoxModel: TComboBox
      Left = 163
      Top = 24
      Width = 511
      Height = 23
      TabOrder = 2
    end
    object edtHost: TEdit
      Left = 12
      Top = 83
      Width = 329
      Height = 23
      TabOrder = 3
    end
    object edtPath: TEdit
      Left = 344
      Top = 83
      Width = 329
      Height = 23
      TabOrder = 4
    end
    object edtPort: TEdit
      Left = 676
      Top = 83
      Width = 150
      Height = 23
      NumbersOnly = True
      TabOrder = 5
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 129
    Width = 841
    Height = 168
    Align = alTop
    Caption = 'pnBoth'
    TabOrder = 1
    ExplicitWidth = 833
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 839
      Height = 134
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      ExplicitWidth = 831
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 833
        Height = 114
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 19
        ExplicitWidth = 825
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 135
      Width = 839
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitWidth = 831
      object btnExecute: TBitBtn
        Left = 0
        Top = 2
        Width = 102
        Height = 28
        Align = alLeft
        Caption = 'Execute'
        TabOrder = 0
        OnClick = btnExecuteClick
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 108
        Top = 6
        Width = 200
        Height = 20
        Margins.Left = 6
        Margins.Top = 4
        Margins.Right = 6
        Margins.Bottom = 4
        Align = alLeft
        Smooth = True
        Style = pbstMarquee
        SmoothReverse = True
        State = pbsPaused
        TabOrder = 1
      end
    end
  end
  object gBoxResponse: TGroupBox
    Left = 0
    Top = 302
    Width = 841
    Height = 334
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    ExplicitTop = 303
    ExplicitWidth = 833
    ExplicitHeight = 320
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 835
      Height = 314
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 16
      ExplicitWidth = 827
      ExplicitHeight = 300
    end
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    Service = aiOpenAI
    Settings.GeminiModel = 'gemini-1.5-flash-latest'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.OpenAITranscribeModel = 'whisper-1'
    Settings.GrokModel = 'grok-3'
    Settings.ClaudeModel = 'claude-3-5-sonnet-20241022'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'sonar-pro'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.MistralModel = 'mistral-large-latest'
    Settings.MistralTranscribeModel = 'voxtral-mini-2507'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    OnGetModels = TMSMCPCloudAI1GetModels
    Left = 541
    Top = 140
  end
end
