object SkriptEditDlg: TSkriptEditDlg
  Left = 227
  Top = 108
  Caption = 'Editor skriptu'
  ClientHeight = 860
  ClientWidth = 746
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 827
    Width = 730
    Height = 25
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    ExplicitTop = 540
    ExplicitWidth = 582
    object OKBtn: TButton
      Left = 580
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = OKBtnClick
      ExplicitLeft = 432
    end
    object CancelBtn: TButton
      Left = 655
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Zru'#353'it'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 507
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 3
    Width = 730
    Height = 198
    Margins.Left = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Caption = #218'daje o skriptu'
    TabOrder = 0
    ExplicitWidth = 582
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 720
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      ExplicitWidth = 572
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'N'#225'zev'
        Layout = tlCenter
      end
      object Nazev: TEdit
        Left = 110
        Top = 0
        Width = 610
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Nazev'
        ExplicitWidth = 462
        ExplicitHeight = 21
      end
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 67
      Width = 720
      Height = 126
      Margins.Top = 0
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel5'
      TabOrder = 2
      ExplicitWidth = 572
      object Výjimky: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 126
        Align = alLeft
        AutoSize = False
        Caption = 'V'#253'jimky'
        Layout = tlCenter
        ExplicitHeight = 131
      end
      object Vyjimky: TCheckListBox
        Left = 110
        Top = 0
        Width = 610
        Height = 126
        Align = alClient
        ItemHeight = 13
        Items.Strings = (
          'aef=Test')
        TabOrder = 0
        ExplicitWidth = 462
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 720
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      ExplicitWidth = 572
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'AutoCommit'
        Layout = tlCenter
      end
      object AutocommitAno: TRadioButton
        Left = 110
        Top = 0
        Width = 43
        Height = 23
        Align = alLeft
        Caption = 'Ano'
        TabOrder = 0
      end
      object AutocommitNe: TRadioButton
        Left = 153
        Top = 0
        Width = 113
        Height = 23
        Align = alLeft
        Caption = 'Ne'
        TabOrder = 1
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 209
    Width = 730
    Height = 610
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Caption = 'T'#283'lo skriptu'
    TabOrder = 1
    ExplicitWidth = 582
    ExplicitHeight = 323
    object Memo1: TSynMemo
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 720
      Height = 587
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      TabOrder = 0
      CodeFolding.CollapsedLineColor = clGrayText
      CodeFolding.FolderBarLinesColor = clGrayText
      CodeFolding.ShowCollapsedLine = True
      CodeFolding.IndentGuidesColor = clGray
      CodeFolding.IndentGuides = True
      UseCodeFolding = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.ShowLineNumbers = True
      Highlighter = SynSQLSyn1
      Lines.Strings = (
        'Memo1')
      FontSmoothing = fsmNone
      ExplicitLeft = 248
      ExplicitTop = 128
      ExplicitWidth = 200
      ExplicitHeight = 150
    end
  end
  object SynSQLSyn1: TSynSQLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 344
    Top = 504
  end
end
