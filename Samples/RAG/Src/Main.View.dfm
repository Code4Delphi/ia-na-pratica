object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: RAG - Retrieval-Augmented Generation'
  ClientHeight = 665
  ClientWidth = 931
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
    Top = 321
    Width = 931
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 1
    ExplicitTop = 320
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 931
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
      Top = 25
      Width = 201
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 65
    Width = 931
    Height = 256
    Align = alTop
    TabOrder = 1
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 929
      Height = 222
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 923
        Height = 151
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        TabOrder = 0
        ExplicitHeight = 101
      end
      object gBoxDefaultsPrompts: TGroupBox
        Left = 3
        Top = 168
        Width = 923
        Height = 51
        Align = alBottom
        Caption = ' Defaults  Prompts '
        TabOrder = 1
        object pnDefaultsPrompts01: TPanel
          Left = 2
          Top = 17
          Width = 919
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Padding.Bottom = 3
          TabOrder = 0
          object btnDadosCliente: TButton
            Left = 182
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Dados cliente'
            TabOrder = 0
            OnClick = btnDadosClienteClick
          end
          object btnEmailCliente: TButton
            Left = 364
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Email cliente'
            TabOrder = 1
            OnClick = btnEmailClienteClick
          end
          object btnDadosProduto: TButton
            Left = 0
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Dados produto'
            TabOrder = 2
            OnClick = btnDadosProdutoClick
          end
        end
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 223
      Width = 929
      Height = 32
      Align = alBottom
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      object btnExecute: TBitBtn
        Left = 1
        Top = 3
        Width = 102
        Height = 26
        Cursor = crHandPoint
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
    Top = 326
    Width = 931
    Height = 339
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 925
      Height = 296
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitHeight = 319
    end
    object pnResponseDetails: TPanel
      Left = 3
      Top = 313
      Width = 925
      Height = 23
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 264
      ExplicitWidth = 1019
      object Label9: TLabel
        Left = 174
        Top = 0
        Width = 92
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
        Left = 266
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
        Left = 515
        Top = 0
        Width = 90
        Height = 21
        Align = alLeft
        Caption = 'Model response: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbServiceModel: TLabel
        Left = 605
        Top = 0
        Width = 5
        Height = 21
        Align = alLeft
        Caption = '-'
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object Label12: TLabel
        Left = 356
        Top = 0
        Width = 69
        Height = 21
        Align = alLeft
        Caption = 'Total tokens: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lbTotalTokens: TLabel
        Left = 425
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
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    Service = aiOpenAI
    Settings.GeminiModel = 'gemini-1.5-flash-latest'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.GrokModel = 'grok-3'
    Settings.ClaudeModel = 'claude-3-5-sonnet-20241022'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'llama-3.1-sonar-small-128k-online'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.MistralModel = 'mistral-large-latest'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    Left = 481
    Top = 82
  end
end
