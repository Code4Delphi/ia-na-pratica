object ReportsHTMLMainView: TReportsHTMLMainView
  Left = 0
  Top = 0
  Caption = 'AI in practice: Charts and reports using data from the database.'
  ClientHeight = 677
  ClientWidth = 985
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
    Width = 985
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 257
    ExplicitWidth = 881
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 985
    Height = 65
    Align = alTop
    TabOrder = 0
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
    Width = 985
    Height = 107
    Align = alTop
    Caption = 'pnBoth'
    TabOrder = 1
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 983
      Height = 73
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      DesignSize = (
        983
        73)
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 977
        Height = 53
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 961
        Top = 9
        Width = 17
        Height = 20
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 1
        object imgPopupQuestions: TImage
          Tag = 33
          Left = 0
          Top = 0
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617036040000424D360400000000000036000000280000001000
            000010000000010020000000000000040000C40E0000C40E0000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000FF000000FF000000FF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000FF000000FF000000FF000000FFCACACAFF000000FF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000FF000000FF000000FF9D9D9DFF000000FF000000FF000000000000
            00000000000000000000B78183FFB78183FFB78183FFB78183FFB78183FFB781
            83FF000000FFFFFFFFFFE3E3E3FF040404FF000000FF000000FF000000000000
            00000000000000000000E1C0AEFFFFF7EBFFFBF3EBFFFBF3EBFFFBF3EBFFFBF3
            EBFF000000FFFFFFFFFFFFFFFFFFE3E3E3FF000000FF000000FF000000000000
            00000000000000000000E9C6B1FFFFFCF4FFEBCCB8FFEBCCB8FFEBCCB8FFEBCC
            B8FF000000FFFFFFFFFFFFFFFFFFE3E3E3FF000000FF000000FF000000000000
            00000000000000000000E9C6B1FFEBCCB8FFEBCCB8FFEBCCB8FFEBCCB8FFEBCC
            B8FF000000FFFFFFFFFFE3E3E3FF000000FF000000FF00000000000000000000
            00000000000000000000E9C6B1FFEBCCB8FFFBF3EBFFFBF3EBFFFBF3EBFFFBF3
            EBFF000000FFE3E3E3FF000000FFE3E3E3FF000000FF00000000000000000000
            00000000000000000000E9C6B1FFEBCCB8FFEBCCB8FFEBCCB8FFEBCCB8FFEBCC
            B8FF000000FF000000FFE3E3E3FFFFFFFFFF000000FF00000000000000000000
            00000000000000000000E9C6B1FFFFFFFFFFEBCCB8FFEBCCB8FFEBCCB8FFEBCC
            B8FFEBCCB8FFFBF3EBFFFBF3EBFFFBF3EBFFB78183FF00000000000000000000
            00000000000000000000E9C6B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFDF9
            F4FFFBF3EBFFFBF3EBFFFBF3EBFFFBF3EBFFB78183FF00000000000000000000
            00000000000000000000E9C6B1FFFFFFFFFF800000FF800000FF800000FF8000
            00FFFDF8F3FFFBF3EBFFFBF3EBFFFBF3EBFFB78183FF00000000000000000000
            00000000000000000000E9C6B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFEFCFFFFFEF9FFFBF3EBFFFBF3EBFFB78183FF00000000000000000000
            00000000000000000000E9C6B1FFFFFFFFFF800000FF800000FF800000FF8000
            00FF800000FFFFFFFFFFFBF3EBFFFBF3EBFFB78183FF00000000000000000000
            00000000000000000000E9C6B1FFFCF7F4FFFCF7F3FFFBF6F3FFFBF6F3FFFAF5
            F3FFF9F5F3FFF9F5F3FFFBF3EBFFFBF3EBFFB78183FF00000000000000000000
            00000000000000000000E9C6B1FFE9C6B1FFE9C6B1FFE9C6B1FFE9C6B1FFE9C6
            B1FFE9C6B1FFE9C6B1FFE9C6B1FFE9C7B2FFB78183FF00000000000000000000
            0000}
          PopupMenu = PopupMenu1
          Transparent = True
          OnClick = imgPopupQuestionsClick
        end
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 74
      Width = 983
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
    Width = 985
    Height = 93
    Align = alTop
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 979
      Height = 73
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 16
    end
  end
  object pnResponseDetails: TPanel
    Left = 0
    Top = 654
    Width = 985
    Height = 23
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
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
    Width = 985
    Height = 384
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 4
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    APIKeys.OpenAI = 
      'sk-proj-hFSIgcNgEVdv-luOBTIJz13qDigwFefFw0vIgyuExdO-nLoNQHpNfpvM' +
      'H75uKh4vc-h4rgKC7BT3BlbkFJCI87u1sLjzJg1-ewn2vp0vx2Sflqp3NpPmDAnG' +
      'ZM_YEvEf22CFuQ06-vOklE4qt6vKLTeMtCQA'
    Service = aiClaude
    Settings.GeminiModel = 'gemini-2.5-pro'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.OpenAITranscribeModel = 'whisper-1'
    Settings.GrokModel = 'grok-3'
    Settings.ClaudeModel = 'claude-sonnet-4-5-20250929'
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
    Left = 904
    Top = 88
    object Listartabelasdobanco1: TMenuItem
      Caption = 'Listar tabelas do banco'
      Hint = 'Listar tabelas do banco'
      OnClick = Listartabelasdobanco1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CrieumrelatriodeclientescompaginaoeopoparaDownload1: TMenuItem
      Caption = 
        'Crie um relat'#243'rio de clientes com pagina'#231#227'o e op'#231#227'o para Downloa' +
        'd'
      Hint = 
        'Crie um relat'#243'rio de clientes e exiba-o em HTML como uma tabela ' +
        'moderna que fa'#231'a a pagina'#231#227'o de 10 em 10 e com op'#231#227'o para downlo' +
        'ad em CSV, impress'#227'o, consulta e ordena'#231#227'o. Usando o estilo Dark' +
        ' do Bootstrap, e abra-o no navegador'
      OnClick = Listartabelasdobanco1Click
    end
    object Crieumrelatriocomas10ltimasvendas1: TMenuItem
      Caption = 'Crie um relat'#243'rio com as 10 '#250'ltimas vendas'
      Hint = 
        '- Crie um relat'#243'rio com as 10 '#250'ltimas vendas. Exiba-o em HTML co' +
        'mo uma tabela moderna e elegante, usando o estilo Dark do Bootst' +
        'rap, e abra-o no navegador'
      OnClick = Listartabelasdobanco1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Crieumgrficodepizzacomadataeototaldasvendasde01062025a300620251: TMenuItem
      Caption = 
        'Crie um gr'#225'fico de pizza com a data e o total das vendas de 01/0' +
        '6/2025 a 30/06/202'
      Hint = 
        'Crie um gr'#225'fico de pizza do Google com cores dark, com a data e ' +
        'o total das vendas de 01/06/2025 a 30/06/2025'
      OnClick = Listartabelasdobanco1Click
    end
  end
end
