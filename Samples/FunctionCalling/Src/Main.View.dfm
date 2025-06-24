object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Function Calling (chamada de fun'#231#227'o)'
  ClientHeight = 552
  ClientWidth = 742
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
    Top = 233
    Width = 742
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -284
    ExplicitWidth = 1025
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -365
    ExplicitWidth = 1025
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
      OnChange = cBoxIAServiceChange
    end
    object TMSFNCCloudAI1: TTMSFNCCloudAI
      Left = 480
      Top = 24
      Width = 26
      Height = 26
      Visible = True
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
      Tools = <
        item
          Name = 'GetEstoqueProduto'
          Description = 'Retorne o estoque do produto informado'
          Parameters = <
            item
              ArrayProperties = <>
              Name = 'IdProduto'
              Type = ptNumber
              Description = 'Id do produto'
              Properties = <>
            end>
          OnExecute = TMSFNCCloudAI1Tools0Execute
        end
        item
          Name = 'GetEndereco'
          Description = 'Qual o endere'#231'o do CEP informado'
          Parameters = <
            item
              ArrayProperties = <>
              Name = 'CEP'
              Type = ptString
              Description = 'CEP a ser consultado'
              Properties = <>
            end>
          OnExecute = TMSFNCCloudAI1Tools1Execute
        end>
      OnExecuted = TMSFNCCloudAI1Executed
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 65
    Width = 742
    Height = 168
    Align = alTop
    Caption = 'pnBoth'
    TabOrder = 1
    ExplicitLeft = -284
    ExplicitWidth = 1025
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 740
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
        Width = 734
        Height = 114
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Qual '#233' o endere'#231'o do CEP: 13098-615')
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 16
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 135
      Width = 740
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
    Top = 238
    Width = 742
    Height = 314
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    ExplicitLeft = -284
    ExplicitWidth = 1025
    ExplicitHeight = 290
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 736
      Height = 294
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 16
    end
  end
end
