object SlozkaDlg: TSlozkaDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Editor slo'#382'ky'
  ClientHeight = 219
  ClientWidth = 533
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 517
    Height = 65
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Caption = #218'daje o slo'#382'ce'
    TabOrder = 0
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 507
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      ExplicitWidth = 358
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
        Width = 397
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Nazev'
        ExplicitWidth = 248
        ExplicitHeight = 21
      end
    end
    object Panel9: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 507
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 10
      ExplicitTop = 49
      ExplicitWidth = 358
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
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 186
    Width = 517
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
    ExplicitTop = 59
    ExplicitWidth = 368
    object OKBtn: TButton
      Left = 367
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 218
    end
    object CancelBtn: TButton
      Left = 442
      Top = 0
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Zru'#353'it'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 293
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
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 81
    Width = 517
    Height = 97
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Caption = 'P'#345'ihla'#353'ovac'#237' '#250'daje'
    TabOrder = 1
    ExplicitLeft = -155
    ExplicitTop = 133
    ExplicitWidth = 539
    ExplicitHeight = 96
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 507
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      ExplicitWidth = 529
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
        Width = 397
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Heslo'
        ExplicitWidth = 419
        ExplicitHeight = 21
      end
    end
    object Panel7: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 67
      Width = 507
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 2
      ExplicitWidth = 529
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
        Width = 397
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Role'
        ExplicitWidth = 419
        ExplicitHeight = 21
      end
    end
    object Panel8: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 507
      Height = 23
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      ExplicitWidth = 529
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
        Width = 397
        Height = 23
        Align = alClient
        TabOrder = 0
        Text = 'Login'
        ExplicitWidth = 419
        ExplicitHeight = 21
      end
    end
  end
end
