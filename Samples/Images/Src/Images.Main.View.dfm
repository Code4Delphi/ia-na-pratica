object ImagesMainView: TImagesMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Multimodal - Imagens'
  ClientHeight = 737
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
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 395
    Width = 984
    Height = 10
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    Color = clMedGray
    ParentColor = False
    ExplicitTop = 363
  end
  object pnBoth: TPanel
    Left = 0
    Top = 405
    Width = 984
    Height = 332
    Align = alBottom
    TabOrder = 0
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 982
      Height = 96
      Align = alTop
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 709
        Height = 76
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Descreva a imagem')
        TabOrder = 0
      end
      object gBoxDefaultsPrompts: TGroupBox
        Left = 712
        Top = 17
        Width = 267
        Height = 76
        Align = alRight
        Caption = ' Defaults  Prompts '
        TabOrder = 1
        object pnDefaultsPrompts01: TPanel
          Left = 2
          Top = 17
          Width = 263
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Padding.Bottom = 3
          TabOrder = 0
          object btnCompareAsImagens: TButton
            AlignWithMargins = True
            Left = 132
            Top = 0
            Width = 129
            Height = 24
            Margins.Left = 0
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alLeft
            Caption = 'Compare as imagens'
            TabOrder = 0
            OnClick = btnCompareAsImagensClick
          end
          object btnDescrevaImagem1: TButton
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 129
            Height = 24
            Margins.Left = 0
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alLeft
            Caption = 'Descreva a imagem 1'
            TabOrder = 1
            OnClick = btnDescrevaImagem1Click
          end
        end
        object pnDefaultsPrompts02: TPanel
          Left = 2
          Top = 44
          Width = 263
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Padding.Bottom = 3
          TabOrder = 1
          object btnVendasPeriodo: TButton
            Left = 0
            Top = 0
            Width = 129
            Height = 24
            Hint = 'Extrair o texto da imagem 1'
            Align = alLeft
            Caption = 'Oceriza'#231#227'o - OCR'
            TabOrder = 0
            OnClick = btnVendasPeriodoClick
          end
          object btnQtdCamisas: TButton
            Left = 129
            Top = 0
            Width = 129
            Height = 24
            Hint = 'Extrair o texto da imagem 1'
            Align = alLeft
            Caption = 'Quantidade camisas'
            TabOrder = 1
            OnClick = btnQtdCamisasClick
          end
        end
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 97
      Width = 982
      Height = 31
      Align = alTop
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      object Label1: TLabel
        Left = 221
        Top = 3
        Width = 56
        Height = 25
        Align = alLeft
        Caption = 'IA service: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object btnExecute: TBitBtn
        AlignWithMargins = True
        Left = 488
        Top = 3
        Width = 102
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Execute'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnExecuteClick
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 596
        Top = 7
        Width = 200
        Height = 17
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
      object ckAddImagem1: TCheckBox
        Left = 1
        Top = 3
        Width = 110
        Height = 25
        Align = alLeft
        Caption = 'Add imagem 1'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object ckAddImagem2: TCheckBox
        Left = 111
        Top = 3
        Width = 110
        Height = 25
        Align = alLeft
        Caption = 'Add imagem 2'
        TabOrder = 3
      end
      object cBoxIAService: TComboBox
        Left = 277
        Top = 3
        Width = 201
        Height = 23
        Align = alLeft
        Style = csDropDownList
        TabOrder = 4
      end
    end
    object gBoxResponse: TGroupBox
      Left = 1
      Top = 128
      Width = 982
      Height = 203
      Align = alClient
      Caption = ' Response '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 2
      object mmResponse: TMemo
        Left = 3
        Top = 17
        Width = 976
        Height = 183
        Align = alClient
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 16
      end
    end
  end
  object pnImagesBack: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 488
      Top = 0
      Width = 10
      Height = 395
      Beveled = True
      ExplicitHeight = 298
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 488
      Height = 395
      Align = alLeft
      TabOrder = 0
      object Image1: TImage
        Left = 1
        Top = 33
        Width = 486
        Height = 361
        Align = alClient
        Center = True
        Proportional = True
        ExplicitLeft = 6
        ExplicitTop = 35
      end
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 486
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
    object Panel4: TPanel
      Left = 498
      Top = 0
      Width = 486
      Height = 395
      Align = alClient
      TabOrder = 1
      object Image2: TImage
        Left = 1
        Top = 33
        Width = 484
        Height = 361
        Align = alClient
        Center = True
        Proportional = True
        Stretch = True
        ExplicitLeft = 0
        ExplicitWidth = 488
        ExplicitHeight = 264
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 484
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
  object TMSFNCCloudAI1: TTMSFNCCloudAI
    Left = 696
    Top = 48
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
  object OpenDialog1: TOpenDialog
    Filter = 
      'JPEG files|*.jpg|PNG files|*.png|WebP files|*.webp|All image fil' +
      'es|*.*'
    Left = 800
    Top = 48
  end
end
