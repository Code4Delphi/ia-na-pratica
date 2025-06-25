object MainView: TMainView
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
    object TMSFNCCloudAI1: TTMSFNCCloudAI
      Left = 536
      Top = 14
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
        end
        item
          Name = 'PeriodoVenda'
          Description = 'Retorne os dados das vendas do periodo informado'
          Parameters = <
            item
              ArrayProperties = <>
              Name = 'DataIni'
              Type = ptString
              Description = 'Data inicial do periodo de filtro da venda'
              Properties = <>
            end
            item
              ArrayProperties = <>
              Name = 'DataFim'
              Type = ptString
              Description = 'Data final do periodo de filtro da venda'
              Properties = <>
            end>
        end>
      OnGetModels = TMSFNCCloudAI1GetModels
    end
    object btnShowModels: TButton
      Left = 225
      Top = 25
      Width = 95
      Height = 25
      Cursor = crHandPoint
      Caption = 'Show Models'
      TabOrder = 2
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
      TabOrder = 3
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
    TabOrder = 2
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 618
      Height = 535
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 13
    end
    object pnBottom: TPanel
      Left = 3
      Top = 552
      Width = 618
      Height = 29
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 361
      ExplicitWidth = 801
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
end
