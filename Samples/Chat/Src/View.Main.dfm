object ViewMain: TViewMain
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Chat'
  ClientHeight = 558
  ClientWidth = 823
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
    Top = 265
    Width = 823
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 246
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 97
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 1
    ExplicitTop = -5
    object Label1: TLabel
      Left = 18
      Top = 23
      Width = 34
      Height = 15
      Caption = 'Model'
    end
    object cBoxModel: TComboBox
      Left = 18
      Top = 40
      Width = 201
      Height = 23
      Style = csDropDownList
      TabOrder = 0
      OnChange = cBoxModelChange
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 86
      Width = 821
      Height = 10
      Align = alBottom
      Smooth = True
      Style = pbstMarquee
      SmoothReverse = True
      State = pbsPaused
      TabOrder = 1
      ExplicitTop = 87
    end
    object TMSFNCCloudAI1: TTMSFNCCloudAI
      Left = 568
      Top = 24
      Width = 26
      Height = 26
      Visible = True
      Service = aiOpenAI
      Settings.GeminiModel = 'gemini-1.5-flash-latest'
      Settings.OpenAIModel = 'gpt-4o'
      Settings.GrokModel = 'grok-beta'
      Settings.ClaudeModel = 'claude-3-5-sonnet-20241022'
      Settings.OllamaModel = 'llama3.2:latest'
      Settings.DeepSeekModel = 'deepseek-chat'
      Settings.PerplexityModel = 'llama-3.1-sonar-small-128k-online'
      Settings.OllamaHost = 'localhost'
      Settings.OllamaPath = '/api/chat'
      Settings.MistralModel = 'mistral-large-latest'
      Tools = <>
      OnExecuted = TMSFNCCloudAI1Executed
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 97
    Width = 823
    Height = 168
    Align = alTop
    Caption = 'pnBoth'
    TabOrder = 1
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 821
      Height = 134
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      ExplicitTop = -2
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 815
        Height = 114
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234)
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 16
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 135
      Width = 821
      Height = 32
      Align = alBottom
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 209
      ExplicitWidth = 823
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
    end
  end
  object gBoxResponse: TGroupBox
    Left = 0
    Top = 270
    Width = 823
    Height = 288
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 3
    ExplicitLeft = 208
    ExplicitTop = 328
    ExplicitWidth = 185
    ExplicitHeight = 105
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 817
      Height = 268
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 3
    end
  end
end
