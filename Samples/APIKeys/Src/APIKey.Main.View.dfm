object APIKeyMainView: TAPIKeyMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: API Keys'
  ClientHeight = 422
  ClientWidth = 801
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
  object pnAPIKeysBack: TPanel
    Left = 0
    Top = 0
    Width = 801
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -1
    DesignSize = (
      801
      393)
    object Label2: TLabel
      Left = 18
      Top = 32
      Width = 37
      Height = 15
      Caption = 'Claude'
    end
    object Label3: TLabel
      Left = 18
      Top = 72
      Width = 51
      Height = 15
      Caption = 'DeepSeek'
    end
    object Label4: TLabel
      Left = 18
      Top = 112
      Width = 38
      Height = 15
      Caption = 'Gemini'
    end
    object Label5: TLabel
      Left = 18
      Top = 152
      Width = 25
      Height = 15
      Caption = 'Grok'
    end
    object Label6: TLabel
      Left = 18
      Top = 192
      Width = 36
      Height = 15
      Caption = 'Mistral'
    end
    object Label7: TLabel
      Left = 18
      Top = 232
      Width = 40
      Height = 15
      Caption = 'OpenAI'
    end
    object Label8: TLabel
      Left = 18
      Top = 272
      Width = 51
      Height = 15
      Caption = 'Perplexity'
    end
    object Label22: TLabel
      Left = 2
      Top = 310
      Width = 67
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'OpenRouter'
    end
    object edtKeyClaude: TEdit
      Left = 82
      Top = 29
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 0
    end
    object edtKeyDeepSeek: TEdit
      Left = 82
      Top = 69
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 1
    end
    object edtKeyGemini: TEdit
      Left = 82
      Top = 109
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 2
    end
    object edtKeyGrok: TEdit
      Left = 82
      Top = 149
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 3
    end
    object edtKeyMistral: TEdit
      Left = 82
      Top = 189
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 4
    end
    object edtKeyOpenAI: TEdit
      Left = 82
      Top = 229
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 5
    end
    object edtKeyPerplexity: TEdit
      Left = 82
      Top = 269
      Width = 697
      Height = 23
      PasswordChar = '*'
      TabOrder = 6
    end
    object btnLoadKeys: TButton
      Left = 623
      Top = 342
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 7
      OnClick = btnLoadKeysClick
    end
    object btnSaveKeys: TButton
      Left = 704
      Top = 342
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 8
      OnClick = btnSaveKeysClick
    end
    object edtKeyOpenRouter: TEdit
      Left = 82
      Top = 307
      Width = 697
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      PasswordChar = '*'
      TabOrder = 9
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 393
    Width = 801
    Height = 29
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    ExplicitTop = 361
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 33
      Height = 25
      Align = alLeft
      Caption = ' Path: '
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object lbPathFile: TLabel
      Left = 35
      Top = 2
      Width = 9
      Height = 25
      Align = alLeft
      Caption = '...'
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object btnOpenFolder: TButton
      AlignWithMargins = True
      Left = 47
      Top = 5
      Width = 85
      Height = 19
      Align = alLeft
      Caption = 'Open folder'
      TabOrder = 0
      OnClick = btnOpenFolderClick
    end
  end
  object TMSMCPCloudAI1: TTMSMCPCloudAI
    APIKeys.OpenRouter = 
      'sk-or-v1-775421e70a70972f9187ad4b94887bed77c8824bc358f45c2e78af7' +
      'e5447c0e4'
    Service = aiOpenAI
    Settings.GeminiModel = 'gemini-2.5-flash'
    Settings.OpenAIModel = 'gpt-4o'
    Settings.OpenAISoundModel = 'gpt-4o-mini-tts'
    Settings.OpenAITranscribeModel = 'whisper-1'
    Settings.GrokModel = 'grok-3'
    Settings.ClaudeModel = 'claude-sonnet-5'
    Settings.OllamaModel = 'llama3.2:latest'
    Settings.DeepSeekModel = 'deepseek-chat'
    Settings.PerplexityModel = 'sonar-pro'
    Settings.OllamaHost = 'localhost'
    Settings.OllamaPath = '/api/chat'
    Settings.LlamaCppHost = 'localhost'
    Settings.LlamaCppPath = '/v1/chat/completions'
    Settings.MistralModel = 'mistral-large-latest'
    Settings.MistralTranscribeModel = 'voxtral-mini-2507'
    Settings.OpenRouterModel = 'z-ai/glm-5.3-flash'
    Tools = <>
    Left = 317
    Top = 186
  end
end
