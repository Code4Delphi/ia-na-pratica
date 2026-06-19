object ImagesMainView: TImagesMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Multimodal - Imagens'
  ClientHeight = 713
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
    Top = 448
    Width = 595
    Height = 265
    Margins.Top = 20
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 10
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 10
      Width = 595
      Height = 30
      Align = alTop
      Padding.Left = 10
      Padding.Top = 2
      Padding.Right = 10
      Padding.Bottom = 2
      TabOrder = 0
      object Label1: TLabel
        Left = 11
        Top = 3
        Width = 56
        Height = 24
        Align = alLeft
        Caption = 'IA service: '
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object cBoxIAService: TComboBox
        Left = 67
        Top = 3
        Width = 201
        Height = 23
        Align = alLeft
        Style = csDropDownList
        DropDownCount = 15
        TabOrder = 0
      end
      object btnExecute: TBitBtn
        AlignWithMargins = True
        Left = 278
        Top = 3
        Width = 102
        Height = 21
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
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 386
        Top = 7
        Width = 200
        Height = 16
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
      end
    end
    object gBoxResponse: TGroupBox
      Left = 0
      Top = 40
      Width = 595
      Height = 225
      Align = alClient
      Caption = ' Response '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 1
      object mmResponse: TMemo
        Left = 3
        Top = 17
        Width = 589
        Height = 205
        Align = alClient
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object pnImagesBack: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 383
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnImagem01: TPanel
      Left = 0
      Top = 0
      Width = 595
      Height = 383
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Image1: TImage
        Left = 0
        Top = 32
        Width = 595
        Height = 351
        Align = alClient
        Center = True
        Proportional = True
        ExplicitTop = 34
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
        object btnLoadImage1: TButton
          Left = 2
          Top = 2
          Width = 127
          Height = 26
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'Load image 1'
          TabOrder = 0
          OnClick = btnLoadImage1Click
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 383
    Width = 595
    Height = 65
    Align = alBottom
    Caption = 'Panel3'
    TabOrder = 2
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 593
      Height = 63
      Align = alClient
      Caption = '  Prompt / question '
      TabOrder = 0
      object mmQuestion: TMemo
        Left = 2
        Top = 17
        Width = 589
        Height = 44
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Qual a Quantidade e Cores das camisas?')
        TabOrder = 0
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
    Settings.GeminiModel = 'gemini-2.0-flash-exp'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.OpenAITranscribeModel = 'whisper-1'
    Settings.GrokModel = 'grok-2-vision-latest'
    Settings.ClaudeModel = 'claude-sonnet-4-20250514'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'sonar-pro'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.LlamaCppHost = 'localhost'
    Settings.LlamaCppPath = '/v1/chat/completions'
    Settings.MistralModel = 'mistral-small-2503'
    Settings.MistralTranscribeModel = 'voxtral-mini-2507'
    Tools = <>
    OnExecuted = TMSMCPCloudAI1Executed
    Left = 259
    Top = 231
  end
end
