object DBEditDlg: TDBEditDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Editor datab'#225'ze'
  ClientHeight = 298
  ClientWidth = 555
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 265
    Width = 539
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
      Left = 389
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
      Left = 464
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Zru'#353'it'
      ModalResult = 2
      TabOrder = 1
    end
    object HesloSkryt: TCheckBox
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 73
      Height = 19
      Margins.Left = 0
      Align = alLeft
      Caption = 'Skr'#253't heslo'
      TabOrder = 2
      OnClick = HesloSkrytClick
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 539
    Height = 145
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Caption = #218'daje o datab'#225'ze'
    TabOrder = 1
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 39
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'N'#225'zev'
        Layout = tlCenter
        ExplicitLeft = -6
      end
      object Nazev: TEdit
        Left = 110
        Top = 0
        Width = 419
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
      Top = 91
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'Cesta k DB'
        Layout = tlCenter
      end
      object Cesta: TEdit
        Left = 110
        Top = 0
        Width = 419
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Cesta'
        ExplicitHeight = 21
      end
    end
    object Panel6: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 65
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 2
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'Server'
        Layout = tlCenter
      end
      object Server: TEdit
        Left = 110
        Top = 0
        Width = 419
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Server'
        ExplicitHeight = 21
      end
    end
    object Panel9: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 117
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 3
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'P'#345'ihl'#225#353'en'#237
        Layout = tlCenter
      end
      object LoginCentral: TRadioButton
        Left = 110
        Top = 0
        Width = 211
        Height = 23
        Align = alLeft
        Caption = 'Centr'#225'ln'#283' ulo'#382'en'#233' p'#345'ihla'#353'ovac'#237' '#250'daje'
        TabOrder = 0
        OnClick = LoginCentralClick
      end
      object LoginLocal: TRadioButton
        Left = 321
        Top = 0
        Width = 192
        Height = 23
        Align = alLeft
        Caption = 'M'#237'stn'#283' ulo'#382'en'#233' p'#345'ihla'#353'ovac'#237' '#250'daje'
        TabOrder = 1
        OnClick = LoginCentralClick
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 529
      Height = 21
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 4
      object Label8: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 21
        Align = alLeft
        AutoSize = False
        Caption = 'Slo'#382'ka'
        Layout = tlCenter
        ExplicitLeft = -6
        ExplicitHeight = 23
      end
      object Slozka: TComboBox
        Left = 110
        Top = 0
        Width = 320
        Height = 21
        Align = alClient
        Style = csDropDownList
        TabOrder = 0
        OnChange = SlozkaChange
      end
      object SlozkyUprav: TButton
        AlignWithMargins = True
        Left = 433
        Top = 0
        Width = 96
        Height = 21
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Upravit slo'#382'ky'
        TabOrder = 1
        OnClick = SlozkyUpravClick
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 161
    Width = 539
    Height = 96
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Caption = 'P'#345'ihla'#353'ovac'#237' '#250'daje'
    TabOrder = 2
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'Heslo'
        Layout = tlCenter
      end
      object Heslo: TEdit
        Left = 110
        Top = 0
        Width = 419
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Heslo'
        ExplicitHeight = 21
      end
    end
    object Panel7: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 67
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'Ozna'#269'en'#237' role'
        Layout = tlCenter
      end
      object Role: TEdit
        Left = 110
        Top = 0
        Width = 419
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Role'
        ExplicitHeight = 21
      end
    end
    object Panel8: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 529
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 2
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        AutoSize = False
        Caption = 'U'#382'ivatelsk'#233' jm'#233'no'
        Layout = tlCenter
      end
      object Login: TEdit
        Left = 110
        Top = 0
        Width = 419
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Login'
        ExplicitHeight = 21
      end
    end
  end
end
