object ReportsHTMLMainView: TReportsHTMLMainView
  Left = 0
  Top = 0
  Caption = 
    'AI in practice: Token Usage Tracking (Rastreamento de uso de tok' +
    'en)'
  ClientHeight = 669
  ClientWidth = 984
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
    Top = 265
    Width = 984
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 257
    ExplicitWidth = 881
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 881
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
    object edtMaxTokens: TEdit
      Left = 344
      Top = 24
      Width = 125
      Height = 23
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 3
      Text = '0'
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 65
    Width = 984
    Height = 107
    Align = alTop
    Caption = 'pnBoth'
    TabOrder = 1
    ExplicitWidth = 881
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 982
      Height = 73
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      ExplicitWidth = 879
      ExplicitHeight = 86
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 976
        Height = 53
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        PopupMenu = PopupMenu1
        TabOrder = 0
        ExplicitWidth = 873
        ExplicitHeight = 66
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 74
      Width = 982
      Height = 32
      Align = alBottom
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitTop = 87
      ExplicitWidth = 879
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
    Top = 172
    Width = 984
    Height = 93
    Align = alTop
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    ExplicitWidth = 881
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 978
      Height = 73
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitWidth = 875
      ExplicitHeight = 52
    end
  end
  object pnResponseDetails: TPanel
    Left = 0
    Top = 646
    Width = 984
    Height = 23
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 659
    ExplicitWidth = 881
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
  object TMSFNCWebBrowser1: TTMSFNCWebBrowser
    Left = 0
    Top = 270
    Width = 984
    Height = 376
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 4
    ExplicitTop = 257
    ExplicitWidth = 881
    ExplicitHeight = 402
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    APIKeys.OpenAI = 
      'sk-proj-hFSIgcNgEVdv-luOBTIJz13qDigwFefFw0vIgyuExdO-nLoNQHpNfpvM' +
      'H75uKh4vc-h4rgKC7BT3BlbkFJCI87u1sLjzJg1-ewn2vp0vx2Sflqp3NpPmDAnG' +
      'ZM_YEvEf22CFuQ06-vOklE4qt6vKLTeMtCQA'
    Service = aiClaude
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
    Left = 360
    Top = 96
  end
  object PopupMenu1: TPopupMenu
    Left = 632
    Top = 96
    object Listartabelasdobanco1: TMenuItem
      Caption = 'Listar tabelas do banco'
      Hint = 'Listar tabelas do banco'
      OnClick = Listartabelasdobanco1Click
    end
  end
end
