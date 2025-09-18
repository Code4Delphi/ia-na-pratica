object ToolsetsPOOMainView: TToolsetsPOOMainView
  Left = 0
  Top = 0
  Caption = 'IA na pr'#225'tica: Toolsets Customizada POO'
  ClientHeight = 609
  ClientWidth = 1001
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
    Top = 321
    Width = 1001
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -108
    ExplicitWidth = 931
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1001
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 11
      Width = 50
      Height = 15
      Caption = 'IA service'
    end
    object cBoxIAService: TComboBox
      Left = 18
      Top = 28
      Width = 201
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object pnBoth: TPanel
    Left = 0
    Top = 65
    Width = 1001
    Height = 256
    Align = alTop
    TabOrder = 1
    object gBoxQuestion: TGroupBox
      Left = 1
      Top = 1
      Width = 999
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
        Width = 993
        Height = 202
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          'Ol'#225' quem '#233' voc'#234' e quem '#233' o seu fabricante?')
        TabOrder = 0
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 223
      Width = 999
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
    Width = 1001
    Height = 283
    Align = alClient
    Caption = ' Response '
    Padding.Left = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 2
    object mmResponse: TMemo
      Left = 3
      Top = 17
      Width = 995
      Height = 263
      Align = alClient
      BorderStyle = bsNone
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
