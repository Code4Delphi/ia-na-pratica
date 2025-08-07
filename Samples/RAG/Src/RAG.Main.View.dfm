object RAGMainView: TRAGMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: RAG - Retrieval-Augmented Generation'
  ClientHeight = 685
  ClientWidth = 994
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
    Top = 409
    Width = 994
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 1
    ExplicitTop = 320
    ExplicitWidth = 931
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 994
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = -5
    ExplicitWidth = 931
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
      Cursor = crHandPoint
      Style = csDropDownList
      TabOrder = 0
      OnChange = cBoxIAServiceChange
    end
    object btnGetFiles: TButton
      Left = 226
      Top = 24
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'GetFiles'
      TabOrder = 1
      OnClick = btnGetFilesClick
    end
    object btnUploadFile: TButton
      Left = 307
      Top = 24
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'UploadFile'
      TabOrder = 2
      OnClick = btnUploadFileClick
    end
    object btnDelete: TButton
      Left = 388
      Top = 24
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'Delete'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 249
    Width = 994
    Height = 160
    Align = alTop
    TabOrder = 1
    ExplicitTop = 185
    ExplicitWidth = 931
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 992
      Height = 126
      Align = alClient
      Caption = ' Prompt / question '
      Padding.Left = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      ExplicitWidth = 929
      ExplicitHeight = 222
      object mmQuestion: TMemo
        Left = 3
        Top = 17
        Width = 986
        Height = 106
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          '- Quando a DelphiDevs foi fundada?')
        TabOrder = 0
        ExplicitLeft = 2
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 127
      Width = 992
      Height = 32
      Align = alBottom
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 1
      ExplicitTop = 223
      ExplicitWidth = 929
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
    Top = 414
    Width = 994
    Height = 271
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    ExplicitTop = 326
    ExplicitWidth = 931
    ExplicitHeight = 339
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 988
      Height = 228
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 13
      ExplicitWidth = 925
      ExplicitHeight = 296
    end
    object pnResponseDetails: TPanel
      Left = 3
      Top = 245
      Width = 988
      Height = 23
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 313
      ExplicitWidth = 925
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 65
    Width = 994
    Height = 184
    Align = alTop
    Caption = ' Arquivos carregados '
    TabOrder = 3
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 990
      Height = 165
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Index'
          Title.Alignment = taCenter
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID'
          Width = 213
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FileName'
          Width = 195
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FileSize'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MimeType'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'URL'
          Width = 319
          Visible = True
        end>
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
    OnGetFiles = TMSMCPCloudAI1GetFiles
    OnFileDeleted = TMSMCPCloudAI1FileDeleted
    OnFileUpload = TMSMCPCloudAI1FileUpload
    Left = 529
    Top = 10
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'PDF files (*.pdf)|*.pdf|Text files (*.txt)|*.txt|CSV files (*.cs' +
      'v)|*.csv|All files (*.*)|*.*'
    FilterIndex = 4
    Left = 632
    Top = 8
  end
  object ClientDataSet1: TClientDataSet
    PersistDataPacket.Data = {
      A20000009619E0BD010000001800000006000000000003000000A20005496E64
      6578040001000000000002494401004900000001000557494454480200020064
      000846696C654E616D65010049000000010005574944544802000200FA000846
      696C6553697A6508000100000000000355524C01004900000001000557494454
      4802000200FA00084D696D655479706501004900000001000557494454480200
      02003C000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Index'
        DataType = ftInteger
      end
      item
        Name = 'ID'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'FileName'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'FileSize'
        DataType = ftLargeint
      end
      item
        Name = 'URL'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'MimeType'
        DataType = ftString
        Size = 60
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 528
    Top = 120
    object ClientDataSet1Index: TIntegerField
      FieldName = 'Index'
    end
    object ClientDataSet1ID: TStringField
      FieldName = 'ID'
      Size = 100
    end
    object ClientDataSet1FileName: TStringField
      FieldName = 'FileName'
      Size = 250
    end
    object ClientDataSet1FileSize: TLargeintField
      FieldName = 'FileSize'
    end
    object ClientDataSet1URL: TStringField
      FieldName = 'URL'
      Size = 250
    end
    object ClientDataSet1MimeType: TStringField
      FieldName = 'MimeType'
      Size = 60
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 632
    Top = 120
  end
end
