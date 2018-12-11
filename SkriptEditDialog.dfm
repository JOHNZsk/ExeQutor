object SkriptEditDlg: TSkriptEditDlg
  Left = 227
  Top = 108
  Caption = 'Editor skriptu'
  ClientHeight = 573
  ClientWidth = 598
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
    Top = 540
    Width = 582
    Height = 25
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object OKBtn: TButton
      Left = 432
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = OKBtnClick
    end
    object CancelBtn: TButton
      Left = 507
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Zru'#353'it'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 3
    Width = 582
    Height = 198
    Margins.Left = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Caption = #218'daje o skriptu'
    TabOrder = 1
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 572
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 0
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
        Width = 462
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Nazev'
        ExplicitHeight = 21
      end
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 572
      Height = 152
      Margins.Top = 0
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel5'
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 72
      ExplicitWidth = 578
      ExplicitHeight = 182
      object Výjimky: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 152
        Align = alLeft
        AutoSize = False
        Caption = 'V'#253'jimky'
        Layout = tlCenter
        ExplicitHeight = 131
      end
      object Vyjimky: TCheckListBox
        Left = 110
        Top = 0
        Width = 462
        Height = 152
        Align = alClient
        ItemHeight = 13
        Items.Strings = (
          'aef=Test')
        TabOrder = 0
        ExplicitHeight = 182
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 209
    Width = 582
    Height = 323
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Caption = 'T'#283'lo skriptu'
    TabOrder = 2
    ExplicitLeft = 400
    ExplicitTop = 296
    ExplicitWidth = 185
    ExplicitHeight = 105
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 572
      Height = 303
      Margins.Top = 0
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      ExplicitTop = 203
      ExplicitHeight = 46
    end
  end
end
