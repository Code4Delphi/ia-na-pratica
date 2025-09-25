object OllamaMainView: TOllamaMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Ollama - IA Off-Line'
  ClientHeight = 558
  ClientWidth = 1033
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1033
    Height = 558
    ActivePage = tabChat
    Align = alClient
    TabOrder = 0
    object tabChat: TTabSheet
      Caption = 'Chat'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 233
        Width = 1025
        Height = 5
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 526
        ExplicitWidth = 815
      end
      object pnTop: TPanel
        Left = 0
        Top = 0
        Width = 1025
        Height = 65
        Align = alTop
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = -5
        object Label13: TLabel
          Left = 373
          Top = 5
          Width = 67
          Height = 15
          Caption = 'Temperature'
        end
        object Label14: TLabel
          Left = 496
          Top = 5
          Width = 110
          Height = 15
          Caption = 'Max tokens response'
        end
        object Label1: TLabel
          Left = 18
          Top = 4
          Width = 34
          Height = 15
          Caption = 'Model'
        end
        object ckGerarLogs: TCheckBox
          Left = 625
          Top = 25
          Width = 76
          Height = 17
          Caption = 'Gerar Log'
          TabOrder = 0
        end
        object edtTemperature: TEdit
          Left = 373
          Top = 22
          Width = 121
          Height = 23
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 1
          Text = '0'
        end
        object ckWebSearch: TCheckBox
          Left = 706
          Top = 25
          Width = 87
          Height = 17
          Caption = 'Web Search'
          TabOrder = 2
        end
        object edtMaxTokens: TEdit
          Left = 496
          Top = 22
          Width = 125
          Height = 23
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 3
          Text = '0'
        end
        object btnShowModels: TButton
          Left = 247
          Top = 21
          Width = 95
          Height = 25
          Cursor = crHandPoint
          Caption = 'Show Models'
          TabOrder = 4
          OnClick = btnShowModelsClick
        end
        object cBoxModel: TComboBox
          Left = 18
          Top = 22
          Width = 223
          Height = 23
          Style = csDropDownList
          TabOrder = 5
        end
      end
      object pnBoth: TPanel
        Left = 0
        Top = 65
        Width = 1025
        Height = 168
        Align = alTop
        Caption = 'pnBoth'
        TabOrder = 1
        object gBoxQuestion: TGroupBox
          Left = 1
          Top = 1
          Width = 1023
          Height = 134
          Align = alClient
          Caption = ' Prompt / question '
          Padding.Left = 1
          Padding.Right = 1
          Padding.Bottom = 1
          TabOrder = 0
          object mmQuestion: TMemo
            Left = 3
            Top = 17
            Width = 1017
            Height = 114
            Align = alClient
            BorderStyle = bsNone
            Lines.Strings = (
              'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
            TabOrder = 0
          end
        end
        object Panel1: TPanel
          Left = 1
          Top = 135
          Width = 1023
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
            Align = alLeft
            Caption = 'Execute'
            TabOrder = 0
            OnClick = btnExecuteClick
            ExplicitLeft = -2
            ExplicitTop = 1
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
        Top = 238
        Width = 1025
        Height = 290
        Align = alClient
        Caption = ' Response '
        Padding.Left = 1
        Padding.Right = 1
        Padding.Bottom = 1
        TabOrder = 2
        object pnResponseDetails: TPanel
          Left = 3
          Top = 264
          Width = 1019
          Height = 23
          Align = alBottom
          BevelEdges = [beTop]
          BevelKind = bkTile
          BevelOuter = bvNone
          TabOrder = 0
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
        object mmResponse: TMemo
          Left = 3
          Top = 17
          Width = 1019
          Height = 247
          Align = alClient
          BorderStyle = bsNone
          ScrollBars = ssVertical
          TabOrder = 1
          ExplicitLeft = 2
          ExplicitTop = 13
        end
      end
    end
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    Service = aiOpenAI
    Settings.GeminiModel = 'gemini-1.5-flash-latest'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.GrokModel = 'grok-3'
    Settings.ClaudeModel = 'claude-3-5-sonnet-20241022'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'sonar-pro'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.MistralModel = 'mistral-large-latest'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    OnGetModels = TMSMCPCloudAI1GetModels
    Left = 637
    Top = 132
  end
end
