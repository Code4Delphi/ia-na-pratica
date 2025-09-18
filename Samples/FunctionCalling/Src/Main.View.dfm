object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Function Calling/Tool Calling (chamada de fun'#231#227'o)'
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
    object TMSFNCCloudAI1: TTMSFNCCloudAI
      Left = 480
      Top = 8
      Width = 26
      Height = 26
      Visible = True
      Service = aiOpenAI
      Settings.GeminiModel = 'gemini-1.5-flash-latest'
      Settings.OpenAIModel = 'gpt-4o'
      Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
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
          Name = 'IdCliente'
          Description = 'Retorne os dados do cliente pelo ID informado'
          Parameters = <
            item
              ArrayProperties = <>
              Name = 'IdCliente'
              Type = ptNumber
              Description = 'Id do cliente'
              Properties = <>
            end>
          OnExecute = TMSFNCCloudAI1Tools1Execute
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
          OnExecute = TMSFNCCloudAI1Tools2Execute
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
          OnExecute = TMSFNCCloudAI1Tools3Execute
        end>
      OnExecuted = TMSFNCCloudAI1Executed
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
        Height = 101
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        TabOrder = 0
      end
      object gBoxDefaultsPrompts: TGroupBox
        Left = 3
        Top = 118
        Width = 923
        Height = 101
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
        object pnDefaultsPrompts02: TPanel
          Left = 2
          Top = 44
          Width = 919
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Padding.Bottom = 3
          TabOrder = 1
          object btnVendasPeriodo: TButton
            Left = 0
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Vendas per'#237'odo'
            TabOrder = 0
            OnClick = btnVendasPeriodoClick
          end
          object btnVendasPeriodoDetalhando: TButton
            Left = 182
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Vendas per'#237'odo (detalhando)'
            TabOrder = 1
            OnClick = btnVendasPeriodoDetalhandoClick
          end
          object btnVendasPeriodoClienteMaisVendas: TButton
            Left = 364
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Clientes com mais vendas'
            TabOrder = 2
            OnClick = btnVendasPeriodoClienteMaisVendasClick
          end
          object btnVendasPeriodoEmailMaisVendas: TButton
            Left = 546
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Email clientes mais vendas'
            TabOrder = 3
            OnClick = btnVendasPeriodoEmailMaisVendasClick
          end
          object btnVendasDoDiaX: TButton
            Left = 728
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'Vendas do dia X'
            TabOrder = 4
            OnClick = btnVendasDoDiaXClick
          end
        end
        object pnDefaultsPrompts03: TPanel
          Left = 2
          Top = 71
          Width = 919
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Padding.Bottom = 3
          TabOrder = 2
          object btnAPIViaCep: TButton
            Left = 0
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'API ViaCep'
            TabOrder = 0
            OnClick = btnAPIViaCepClick
          end
          object btnAPIViaCepMaisInternet: TButton
            Left = 182
            Top = 0
            Width = 182
            Height = 24
            Align = alLeft
            Caption = 'API ViaCep + Internet'
            TabOrder = 1
            OnClick = btnAPIViaCepMaisInternetClick
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
      ExplicitLeft = 2
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
      Height = 319
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
