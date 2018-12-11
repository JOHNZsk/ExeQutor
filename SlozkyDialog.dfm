object SlozkyDlg: TSlozkyDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Spr'#225'va slo'#382'ek'
  ClientHeight = 295
  ClientWidth = 556
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 262
    Width = 540
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
    object CancelBtn: TButton
      Left = 465
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Zav'#345#237't'
      ModalResult = 2
      TabOrder = 0
      OnClick = CancelBtnClick
    end
    object SlozkaPridat: TButton
      Left = 0
      Top = 0
      Width = 65
      Height = 25
      Align = alLeft
      Caption = 'P'#345'idat'
      TabOrder = 1
      OnClick = SlozkaPridatClick
    end
    object SlozkaDolu: TButton
      Left = 325
      Top = 0
      Width = 65
      Height = 25
      Align = alLeft
      Caption = 'Dol'#367
      TabOrder = 2
      OnClick = SlozkaDoluClick
    end
    object SlozkaUpravit: TButton
      Left = 130
      Top = 0
      Width = 65
      Height = 25
      Align = alLeft
      Caption = 'Upravit'
      TabOrder = 3
      OnClick = SlozkaUpravitClick
    end
    object SlozkaNahoru: TButton
      Left = 260
      Top = 0
      Width = 65
      Height = 25
      Align = alLeft
      Caption = 'Nahoru'
      TabOrder = 4
      OnClick = SlozkaNahoruClick
    end
    object SlozkaSmazat: TButton
      Left = 195
      Top = 0
      Width = 65
      Height = 25
      Align = alLeft
      Caption = 'Smazat'
      TabOrder = 5
      OnClick = SlozkaSmazatClick
    end
    object SlozkaZkopirovat: TButton
      Left = 65
      Top = 0
      Width = 65
      Height = 25
      Align = alLeft
      Caption = 'Zkop'#237'rovat'
      TabOrder = 6
      OnClick = SlozkaZkopirovatClick
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 540
    Height = 246
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Caption = 'Seznam slo'#382'ek'
    TabOrder = 1
    object ListView1: TListView
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 530
      Height = 226
      Margins.Top = 0
      Align = alClient
      Columns = <
        item
          Caption = 'N'#225'zev'
          Width = 420
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
