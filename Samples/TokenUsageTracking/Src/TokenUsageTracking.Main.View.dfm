object TokenUsageTrackingMainView: TTokenUsageTrackingMainView
  Left = 0
  Top = 0
  Caption = 
    'AI in practice: Token Usage Tracking (Rastreamento de uso de tok' +
    'en)'
  ClientHeight = 499
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
  TextHeight = 15
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 845
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -180
    ExplicitWidth = 1025
    object Label1: TLabel
      Left = 18
      Top = 7
      Width = 50
      Height = 15
      Caption = 'IA service'
    end
    object Label13: TLabel
      Left = 221
      Top = 7
      Width = 67
      Height = 15
      Caption = 'Temperature'
    end
    object Label14: TLabel
      Left = 344
      Top = 7
      Width = 110
      Height = 15
      Caption = 'Max tokens response'
    end
    object cBoxIAService: TComboBox
      Left = 18
      Top = 24
      Width = 201
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
    object ckGerarLogs: TCheckBox
      Left = 473
      Top = 27
      Width = 76
      Height = 17
      Caption = 'Gerar Log'
      TabOrder = 1
    end
    object edtTemperature: TEdit
      Left = 221
      Top = 24
      Width = 121
      Height = 23
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 2
      Text = '0'
    end
    object ckWebSearch: TCheckBox
      Left = 554
      Top = 27
      Width = 87
      Height = 17
      Caption = 'Web Search'
      TabOrder = 3
    end
    object edtMaxTokens: TEdit
      Left = 344
      Top = 24
      Width = 125
      Height = 23
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 4
      Text = '0'
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 65
    Width = 845
    Height = 168
    Align = alTop
    Caption = 'pnBoth'
    TabOrder = 1
    ExplicitLeft = -180
    ExplicitWidth = 1025
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 843
      Height = 134
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      ExplicitWidth = 1023
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 837
        Height = 114
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        TabOrder = 0
        ExplicitWidth = 1017
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 135
      Width = 843
      Height = 32
      Align = alBottom
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitWidth = 1023
      object btnExecute: TBitBtn
        Left = 1
        Top = 3
        Width = 102
        Height = 26
        Align = alLeft
        Caption = 'Execute'
        TabOrder = 0
        OnClick = btnExecuteClick
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 109
        Top = 7
        Width = 200
        Height = 18
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
    Top = 233
    Width = 845
    Height = 164
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    ExplicitLeft = 1
    ExplicitTop = 232
    ExplicitHeight = 266
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 839
      Height = 144
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 16
    end
  end
  object gBoxTokensConsumedCurrentRequest: TGroupBox
    Left = 0
    Top = 397
    Width = 845
    Height = 51
    Align = alBottom
    Caption = ' Tokens consumed in the current request '
    Padding.Left = 5
    TabOrder = 3
    ExplicitLeft = 1
    ExplicitTop = 400
    object Label9: TLabel
      Left = 181
      Top = 17
      Width = 93
      Height = 32
      Hint = 'N'#186' de tokens que a resposta cont'#233'm: '
      Align = alLeft
      Caption = 'Tokens response: '
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      ExplicitLeft = 176
      ExplicitHeight = 15
    end
    object lbNumTokensResponse: TLabel
      Left = 274
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      AutoSize = False
      Caption = '0'
      Layout = tlCenter
      ExplicitLeft = 370
      ExplicitTop = 0
      ExplicitHeight = 21
    end
    object Label10: TLabel
      Left = 7
      Top = 17
      Width = 84
      Height = 32
      Align = alLeft
      Caption = 'Prompt tokens: '
      Layout = tlCenter
      ExplicitLeft = 2
      ExplicitHeight = 15
    end
    object lbPromptTokens: TLabel
      Left = 91
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      AutoSize = False
      Caption = '0'
      Layout = tlCenter
      ExplicitLeft = 83
      ExplicitTop = 0
      ExplicitHeight = 21
    end
    object Label11: TLabel
      Left = 524
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      Caption = 'Model response: '
      Layout = tlCenter
      ExplicitLeft = 519
      ExplicitHeight = 15
    end
    object lbServiceModel: TLabel
      Left = 614
      Top = 17
      Width = 5
      Height = 32
      Align = alLeft
      Caption = '-'
      Layout = tlCenter
      ExplicitLeft = 609
      ExplicitHeight = 15
    end
    object Label12: TLabel
      Left = 364
      Top = 17
      Width = 70
      Height = 32
      Align = alLeft
      Caption = 'Total tokens: '
      Layout = tlCenter
      ExplicitLeft = 359
      ExplicitHeight = 15
    end
    object lbTotalTokens: TLabel
      Left = 434
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      AutoSize = False
      Caption = '0'
      Layout = tlCenter
      ExplicitLeft = 675
      ExplicitTop = 0
      ExplicitHeight = 21
    end
  end
  object gBoxTokensUsedSession: TGroupBox
    Left = 0
    Top = 448
    Width = 845
    Height = 51
    Align = alBottom
    Caption = ' Total number of tokens used during a session '
    Padding.Left = 5
    TabOrder = 4
    ExplicitLeft = 1
    ExplicitTop = 451
    object Label2: TLabel
      Left = 181
      Top = 17
      Width = 93
      Height = 32
      Hint = 'N'#186' de tokens que a resposta cont'#233'm: '
      Align = alLeft
      Caption = 'Tokens response: '
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object lbNumTokensResponseUsedSession: TLabel
      Left = 274
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      AutoSize = False
      Caption = '0'
      Layout = tlCenter
      ExplicitLeft = 280
    end
    object Label4: TLabel
      Left = 7
      Top = 17
      Width = 84
      Height = 32
      Align = alLeft
      Caption = 'Prompt tokens: '
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object lbPromptTokensUsedSession: TLabel
      Left = 91
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      AutoSize = False
      Caption = '0'
      Layout = tlCenter
      ExplicitLeft = 83
      ExplicitTop = 0
      ExplicitHeight = 21
    end
    object Label8: TLabel
      Left = 364
      Top = 17
      Width = 70
      Height = 32
      Align = alLeft
      Caption = 'Total tokens: '
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object lbTotalTokensUsedSession: TLabel
      Left = 434
      Top = 17
      Width = 90
      Height = 32
      Align = alLeft
      AutoSize = False
      Caption = '0'
      Layout = tlCenter
      ExplicitLeft = 675
      ExplicitTop = 0
      ExplicitHeight = 21
    end
    object btnUsageReset: TButton
      Left = 768
      Top = 17
      Width = 75
      Height = 32
      Align = alRight
      Caption = 'Usage Reset'
      TabOrder = 0
      OnClick = btnUsageResetClick
      ExplicitLeft = 769
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
    Left = 624
    Top = 136
  end
end
