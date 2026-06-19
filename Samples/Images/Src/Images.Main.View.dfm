object ImagesMainView: TImagesMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Multimodal - Imagens'
  ClientHeight = 716
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 15
  object pnBoth: TPanel
    Left = 0
    Top = 279
    Width = 595
    Height = 437
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 363
    ExplicitTop = 0
    ExplicitWidth = 910
    ExplicitHeight = 705
    object gBoxQuestion: TGroupBox
      Left = 0
      Top = 0
      Width = 595
      Height = 145
      Align = alTop
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 437
        Height = 125
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Descreva a imagem')
        TabOrder = 0
        ExplicitWidth = 350
      end
      object gBoxDefaultsPrompts: TGroupBox
        Left = 440
        Top = 17
        Width = 152
        Height = 125
        Align = alRight
        Caption = ' Defaults  Prompts '
        TabOrder = 1
        object btnDescrevaImagem1: TButton
          AlignWithMargins = True
          Left = 5
          Top = 17
          Width = 142
          Height = 24
          Margins.Top = 0
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Descreva a imagem 1'
          TabOrder = 0
          OnClick = btnDescrevaImagem1Click
          ExplicitWidth = 257
        end
        object btnCompareAsImagens: TButton
          AlignWithMargins = True
          Left = 5
          Top = 43
          Width = 142
          Height = 24
          Margins.Top = 0
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Compare as imagens'
          TabOrder = 1
          OnClick = btnCompareAsImagensClick
          ExplicitWidth = 257
        end
        object btnVendasPeriodo: TButton
          AlignWithMargins = True
          Left = 5
          Top = 69
          Width = 142
          Height = 24
          Hint = 'Extrair o texto da imagem 1'
          Margins.Top = 0
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Oceriza'#231#227'o - OCR'
          TabOrder = 2
          OnClick = btnVendasPeriodoClick
          ExplicitWidth = 257
        end
        object btnQtdCamisas: TButton
          AlignWithMargins = True
          Left = 5
          Top = 95
          Width = 142
          Height = 24
          Hint = 'Extrair o texto da imagem 1'
          Margins.Top = 0
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Quantidade camisas'
          TabOrder = 3
          ExplicitWidth = 257
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 145
      Width = 595
      Height = 53
      Align = alTop
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitTop = 96
      ExplicitWidth = 585
      object Panel3: TPanel
        Left = 1
        Top = 3
        Width = 591
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Padding.Left = 10
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = 1
        ExplicitWidth = 581
        object ckAddImagem1: TCheckBox
          Left = 10
          Top = 0
          Width = 110
          Height = 22
          Align = alLeft
          Caption = 'Add imagem 1'
          Checked = True
          State = cbChecked
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 3
          ExplicitHeight = 25
        end
        object ckAddImagem2: TCheckBox
          Left = 120
          Top = 0
          Width = 110
          Height = 22
          Align = alLeft
          Caption = 'Add imagem 2'
          TabOrder = 1
          ExplicitLeft = 111
          ExplicitTop = 3
          ExplicitHeight = 25
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 25
        Width = 591
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        Padding.Left = 10
        TabOrder = 1
        ExplicitLeft = 6
        ExplicitTop = 21
        ExplicitWidth = 581
        object Label1: TLabel
          Left = 10
          Top = 0
          Width = 56
          Height = 26
          Align = alLeft
          Caption = 'IA service: '
          Layout = tlCenter
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitHeight = 15
        end
        object cBoxIAService: TComboBox
          Left = 66
          Top = 0
          Width = 201
          Height = 23
          Align = alLeft
          Style = csDropDownList
          DropDownCount = 15
          TabOrder = 0
          ExplicitLeft = 63
          ExplicitTop = 6
        end
        object btnExecute: TBitBtn
          AlignWithMargins = True
          Left = 277
          Top = 0
          Width = 102
          Height = 23
          Cursor = crHandPoint
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 0
          Align = alLeft
          Caption = 'Execute'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnExecuteClick
          ExplicitLeft = 547
          ExplicitTop = 3
          ExplicitHeight = 24
        end
        object ProgressBar1: TProgressBar
          AlignWithMargins = True
          Left = 385
          Top = 4
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
          TabOrder = 2
          ExplicitLeft = 487
          ExplicitTop = -3
          ExplicitHeight = 16
        end
      end
    end
    object gBoxResponse: TGroupBox
      Left = 0
      Top = 198
      Width = 595
      Height = 239
      Align = alClient
      Caption = ' Response '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 2
      ExplicitTop = 127
      ExplicitWidth = 910
      ExplicitHeight = 578
      object mmResponse: TMemo
        Left = 3
        Top = 17
        Width = 589
        Height = 219
        Align = alClient
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitHeight = 243
      end
    end
  end
  object pnImagesBack: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 279
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 0
      Top = 198
      Width = 595
      Height = 10
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
      Color = clMedGray
      ParentColor = False
      ExplicitTop = 488
      ExplicitWidth = 239
    end
    object pnImagem01: TPanel
      Left = 0
      Top = 0
      Width = 595
      Height = 198
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 219
      object Image1: TImage
        Left = 0
        Top = 32
        Width = 595
        Height = 166
        Align = alClient
        Center = True
        Proportional = True
        ExplicitHeight = 154
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 595
        Height = 32
        Align = alTop
        BevelEdges = [beBottom]
        BevelKind = bkTile
        BevelOuter = bvNone
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        TabOrder = 0
        ExplicitWidth = 353
        object btnLoadImage1: TButton
          Left = 2
          Top = 2
          Width = 127
          Height = 26
          Align = alLeft
          Caption = 'Load image 1'
          TabOrder = 0
          OnClick = btnLoadImage1Click
        end
      end
    end
    object pnImagem02: TPanel
      Left = 0
      Top = 208
      Width = 595
      Height = 71
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Image2: TImage
        Left = 0
        Top = 32
        Width = 595
        Height = 39
        Align = alClient
        Center = True
        Proportional = True
        Stretch = True
        ExplicitTop = 34
        ExplicitWidth = 1273
        ExplicitHeight = 181
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 595
        Height = 32
        Align = alTop
        BevelEdges = [beBottom]
        BevelKind = bkTile
        BevelOuter = bvNone
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        TabOrder = 0
        ExplicitWidth = 353
        object btnLoadImage2: TButton
          Left = 2
          Top = 2
          Width = 127
          Height = 26
          Align = alLeft
          Caption = 'Load image 2'
          TabOrder = 0
          OnClick = btnLoadImage2Click
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'JPEG files|*.jpg|PNG files|*.png|WebP files|*.webp|All image fil' +
      'es|*.*'
    Left = 648
    Top = 80
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
    Settings.LlamaCppHost = 'localhost'
    Settings.LlamaCppPath = '/v1/chat/completions'
    Settings.MistralModel = 'mistral-large-latest'
    Settings.MistralTranscribeModel = 'voxtral-mini-2507'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    Left = 107
    Top = 503
  end
end
