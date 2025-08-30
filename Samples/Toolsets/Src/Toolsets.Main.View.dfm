object ToolsetsMainView: TToolsetsMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Toolsets'
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
    object tabAPIKeys: TTabSheet
      Caption = 'API Keys'
      object pnAPIKeysBack: TPanel
        Left = 0
        Top = 0
        Width = 1025
        Height = 528
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 16
          Top = 19
          Width = 37
          Height = 15
          Caption = 'Claude'
        end
        object Label3: TLabel
          Left = 16
          Top = 59
          Width = 51
          Height = 15
          Caption = 'DeepSeek'
        end
        object Label4: TLabel
          Left = 16
          Top = 99
          Width = 38
          Height = 15
          Caption = 'Gemini'
        end
        object Label5: TLabel
          Left = 16
          Top = 139
          Width = 25
          Height = 15
          Caption = 'Grok'
        end
        object Label6: TLabel
          Left = 16
          Top = 179
          Width = 36
          Height = 15
          Caption = 'Mistral'
        end
        object Label7: TLabel
          Left = 16
          Top = 219
          Width = 40
          Height = 15
          Caption = 'OpenAI'
        end
        object Label8: TLabel
          Left = 16
          Top = 259
          Width = 51
          Height = 15
          Caption = 'Perplexity'
        end
        object edtKeyClaude: TEdit
          Left = 80
          Top = 16
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 0
        end
        object edtKeyDeepSeek: TEdit
          Left = 80
          Top = 56
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 1
        end
        object edtKeyGemini: TEdit
          Left = 80
          Top = 96
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 2
        end
        object edtKeyGrok: TEdit
          Left = 80
          Top = 136
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 3
        end
        object edtKeyMistral: TEdit
          Left = 80
          Top = 176
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 4
        end
        object edtKeyOpenAI: TEdit
          Left = 80
          Top = 216
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 5
        end
        object edtKeyPerplexity: TEdit
          Left = 80
          Top = 256
          Width = 697
          Height = 23
          PasswordChar = '*'
          TabOrder = 6
        end
        object btnLoadKeys: TButton
          Left = 621
          Top = 297
          Width = 75
          Height = 25
          Caption = 'Load'
          TabOrder = 7
          OnClick = btnLoadKeysClick
        end
        object btnSaveKeys: TButton
          Left = 702
          Top = 297
          Width = 75
          Height = 25
          Caption = 'Save'
          TabOrder = 8
          OnClick = btnSaveKeysClick
        end
      end
    end
    object tabModels: TTabSheet
      Caption = 'Models'
      ImageIndex = 2
      object pnModelsBack: TPanel
        Left = 0
        Top = 0
        Width = 1025
        Height = 528
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Label15: TLabel
          Left = 16
          Top = 19
          Width = 37
          Height = 15
          Caption = 'Claude'
        end
        object Label16: TLabel
          Left = 16
          Top = 59
          Width = 51
          Height = 15
          Caption = 'DeepSeek'
        end
        object Label17: TLabel
          Left = 16
          Top = 99
          Width = 38
          Height = 15
          Caption = 'Gemini'
        end
        object Label18: TLabel
          Left = 16
          Top = 139
          Width = 25
          Height = 15
          Caption = 'Grok'
        end
        object Label19: TLabel
          Left = 16
          Top = 179
          Width = 36
          Height = 15
          Caption = 'Mistral'
        end
        object Label20: TLabel
          Left = 16
          Top = 219
          Width = 40
          Height = 15
          Caption = 'OpenAI'
        end
        object Label21: TLabel
          Left = 16
          Top = 259
          Width = 51
          Height = 15
          Caption = 'Perplexity'
        end
        object edtModelClaude: TEdit
          Left = 80
          Top = 16
          Width = 697
          Height = 23
          TabOrder = 0
        end
        object edtModelDeepSeek: TEdit
          Left = 80
          Top = 56
          Width = 697
          Height = 23
          TabOrder = 1
        end
        object edtModelGemini: TEdit
          Left = 80
          Top = 96
          Width = 697
          Height = 23
          TabOrder = 2
        end
        object edtModelGrok: TEdit
          Left = 80
          Top = 136
          Width = 697
          Height = 23
          TabOrder = 3
        end
        object edtModelMistral: TEdit
          Left = 80
          Top = 176
          Width = 697
          Height = 23
          TabOrder = 4
        end
        object edtModelOpenAI: TEdit
          Left = 80
          Top = 216
          Width = 697
          Height = 23
          TabOrder = 5
        end
        object edtModelPerplexity: TEdit
          Left = 80
          Top = 256
          Width = 697
          Height = 23
          TabOrder = 6
        end
      end
    end
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
          OnChange = cBoxIAServiceChange
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
        object ckWebSearch: TCheckBox
          Left = 554
          Top = 27
          Width = 87
          Height = 17
          Caption = 'Web Search'
          TabOrder = 3
        end
        object edtMaxTokens: TEdit
          Left = 344
          Top = 24
          Width = 125
          Height = 23
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 4
          Text = '0'
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
        end
      end
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 592
    Top = 304
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select '
      'vendas.id,'
      'vendas.data,'
      'vendas.id_cliente,'
      'clientes.nome as ClienteNome,'
      'vendas.total '
      'from vendas'
      'inner join clientes on vendas.id_cliente = clientes.Id'
      'order by vendas.id desc'
      'limit 10')
    Left = 669
    Top = 304
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 738
    Top = 304
  end
  object TMSMCPCloudAIDataSet1: TTMSMCPCloudAIDataSet
    AI = TMSMCPCloudAI1
    Tools = <
      item
        Name = 'GetFields'
        Description = 'retrieve the fields of the dataset'
        Parameters = <>
      end
      item
        Name = 'GetTableName'
        Description = 'retrieve the name of the table for the dataset'
        Parameters = <>
      end
      item
        Name = 'GetRecords'
        Description = 
          'retrieve all fields or a selected number of fields from all reco' +
          'rds from the dataset'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Fields'
            Type = ptString
            Required = False
            Properties = <>
          end>
      end
      item
        Name = 'GetRecord'
        Description = 
          'retrieve all fields or a selected number of fields from the curr' +
          'ent record from the dataset'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Fields'
            Type = ptString
            Required = False
            Properties = <>
          end>
      end
      item
        Name = 'First'
        Description = 'set the first record as active record on the dataset'
        Parameters = <>
      end
      item
        Name = 'Last'
        Description = 'set the last record as active record on the dataset'
        Parameters = <>
      end
      item
        Name = 'Next'
        Description = 'set the next record as active record on the dataset'
        Parameters = <>
      end
      item
        Name = 'Previous'
        Description = 'set the previous record as active record on the dataset'
        Parameters = <>
      end
      item
        Name = 'Move'
        Description = 'move the active record on the dataset for a number of rows'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Number'
            Type = ptNumber
            Description = 
              'sets the number of rows to move the active record forward or bac' +
              'kward'
            Properties = <>
          end>
      end
      item
        Name = 'AddRecord'
        Description = 'add a new record with specified field values to the dataset'
        Parameters = <
          item
            ArrayType = ptObject
            ArrayProperties = <
              item
                ArrayProperties = <>
                Name = 'Name'
                Type = ptString
                Description = 'the name of the field'
                Properties = <>
              end
              item
                ArrayProperties = <>
                Name = 'Value'
                Type = ptString
                Description = 'the value to set to the field'
                Properties = <>
              end>
            Name = 'FieldValues'
            Type = ptArray
            Description = 'The list of fieldnames and values to set to the record'
            Properties = <>
          end>
      end
      item
        Name = 'ModifyRecord'
        Description = 
          'modify the current record with specified field values in the dat' +
          'aset'
        Parameters = <
          item
            ArrayType = ptObject
            ArrayProperties = <
              item
                ArrayProperties = <>
                Name = 'Name'
                Type = ptString
                Description = 'the name of the field'
                Properties = <>
              end
              item
                ArrayProperties = <>
                Name = 'Value'
                Type = ptString
                Description = 'the value to set to the field'
                Properties = <>
              end>
            Name = 'FieldValues'
            Type = ptArray
            Description = 'The list of fieldnames and values to set to the record'
            Properties = <>
          end>
      end
      item
        Name = 'LocateRecord'
        Description = 'locate the record with specified field values in the dataset'
        Parameters = <
          item
            ArrayType = ptObject
            ArrayProperties = <
              item
                ArrayProperties = <>
                Name = 'Name'
                Type = ptString
                Description = 'the name of the field'
                Properties = <>
              end
              item
                ArrayProperties = <>
                Name = 'Value'
                Type = ptString
                Description = 'the value to set to the field'
                Properties = <>
              end>
            Name = 'FieldValues'
            Type = ptArray
            Description = 'The list of fieldnames and values to find the record'
            Properties = <>
          end>
      end>
    DataSource = DataSource1
    Left = 852
    Top = 304
  end
  object TMSMCPCloudAIFileSystem1: TTMSMCPCloudAIFileSystem
    AI = TMSMCPCloudAI1
    Tools = <
      item
        Name = 'GetFiles'
        Description = 'show files in a specific folder'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Folder'
            Type = ptString
            Description = 'the folder in which to list all files'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Mask'
            Type = ptString
            Required = False
            Description = 'optional file mask to use to search files'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Details'
            Type = ptBoolean
            Required = False
            Description = 'when true, the file size and file modified date is returned'
            Properties = <>
          end>
      end
      item
        Name = 'GetFolders'
        Description = 'show folders in a specific folder'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Folder'
            Type = ptString
            Description = 'the folder in which to list all folders'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Mask'
            Type = ptString
            Required = False
            Description = 'optional file mask to use to search folders'
            Properties = <>
          end>
      end
      item
        Name = 'ReadTextFile'
        Description = 'get the content of a text file'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Filename'
            Type = ptString
            Description = 'the full path to the text file to get the content from'
            Properties = <>
          end>
      end
      item
        Name = 'WriteTextFile'
        Description = 'write content to a text file'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Filename'
            Type = ptString
            Description = 'the full path to the file to write to'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Content'
            Type = ptString
            Description = 'the content to write as text to the file'
            Properties = <>
          end>
      end
      item
        Name = 'AppendTextFile'
        Description = 'append content to an existing text file'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Filename'
            Type = ptString
            Description = 'the full path to the file to write to'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Content'
            Type = ptString
            Description = 'the content to append as text to the file'
            Properties = <>
          end>
      end
      item
        Name = 'CreateFolder'
        Description = 'create a new subfolder'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Folder'
            Type = ptString
            Description = 'the name of the folder where to create the subfolder'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Foldername'
            Type = ptString
            Description = 'the name of the subfolder to create'
            Properties = <>
          end>
      end
      item
        Name = 'CopyFile'
        Description = 'copy a file to another'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Source'
            Type = ptString
            Description = 'the full path of the file to copy'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Target'
            Type = ptString
            Description = 'the full path where to copy the file'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Overwrite'
            Type = ptBoolean
            Required = False
            Description = 
              'when this target file exists, overwrite the file when this param' +
              'eter is true'
            Properties = <>
          end>
      end
      item
        Name = 'MoveFile'
        Description = 'move a file to another'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Source'
            Type = ptString
            Description = 'the full path of the file to move'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Target'
            Type = ptString
            Description = 'the full path where to move the file'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'Overwrite'
            Type = ptBoolean
            Required = False
            Description = 
              'when this target file exists, overwrite the file when this param' +
              'eter is true'
            Properties = <>
          end>
      end>
    Left = 789
    Top = 116
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
    Left = 789
    Top = 44
  end
  object TMSMCPCloudAIEmail1: TTMSMCPCloudAIEmail
    AI = TMSMCPCloudAI1
    Tools = <
      item
        Name = 'SendEmail'
        Description = 'send an email to an email address with subject and body'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'EmailTo'
            Type = ptString
            Description = 'the email address of the recipient where to send it to'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'EmailSubject'
            Type = ptString
            Description = 'the email subject text'
            Properties = <>
          end
          item
            ArrayProperties = <>
            Name = 'EmailBody'
            Type = ptString
            Description = 'the email body text'
            Properties = <>
          end>
      end
      item
        Name = 'GetCountEmail'
        Description = 'Get the number of emails'
        Parameters = <>
      end
      item
        Name = 'RetrieveEmail'
        Description = 'Retrieve the email at index'
        Parameters = <
          item
            ArrayProperties = <>
            Name = 'Index'
            Type = ptNumber
            Description = 'the index of the email to retrieve'
            Properties = <>
          end>
      end>
    SMPTPort = 0
    PopPort = 0
    PopUseSSL = False
    Left = 604
    Top = 424
  end
end
