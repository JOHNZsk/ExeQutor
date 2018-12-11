object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Hromadn'#225' '#250'prava datab'#225'ze'
  ClientHeight = 711
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 342
    Width = 835
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 164
    ExplicitWidth = 750
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 819
    Height = 332
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Datab'#225'ze'
    TabOrder = 0
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 302
      Width = 809
      Height = 25
      Margins.Top = 0
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      object Button5: TButton
        Left = 614
        Top = 0
        Width = 65
        Height = 25
        Align = alRight
        Caption = 'Smazat'
        TabOrder = 0
        ExplicitLeft = 629
      end
      object DatabazuPridat: TButton
        Left = 419
        Top = 0
        Width = 65
        Height = 25
        Align = alRight
        Caption = 'P'#345'idat'
        TabOrder = 1
        OnClick = DatabazuPridatClick
        ExplicitLeft = 449
      end
      object DatabazuUpravit: TButton
        Left = 549
        Top = 0
        Width = 65
        Height = 25
        Align = alRight
        Caption = 'Upravit'
        TabOrder = 2
        OnClick = DatabazuUpravitClick
        ExplicitLeft = 569
      end
      object DatabazeNahoru: TButton
        Left = 679
        Top = 0
        Width = 65
        Height = 25
        Align = alRight
        Caption = 'Nahoru'
        TabOrder = 3
        OnClick = DatabazuPridatClick
        ExplicitLeft = 689
      end
      object DattabazeDolu: TButton
        Left = 744
        Top = 0
        Width = 65
        Height = 25
        Align = alRight
        Caption = 'Dol'#367
        TabOrder = 4
        OnClick = DatabazuPridatClick
        ExplicitLeft = 749
      end
      object DatabazeKopirovat: TButton
        Left = 484
        Top = 0
        Width = 65
        Height = 25
        Align = alRight
        Caption = 'Zkop'#237'rovat'
        TabOrder = 5
        OnClick = DatabazeKopirovatClick
        ExplicitLeft = 478
        ExplicitTop = 1
      end
    end
    object Databaze: TRzCheckTree
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 809
      Height = 281
      OnStateChange = DatabazeStateChange
      Align = alClient
      Indent = 19
      RowSelect = True
      SelectionPen.Color = clBtnShadow
      StateImages = Databaze.CheckImages
      TabOrder = 1
      OnDblClick = DatabazeDblClick
      Items.NodeData = {
        030100000026000000000000000000000001000000FFFFFFFF00000000000000
        0001000000010454006500730074002A000000000000000000000001000000FF
        FFFFFF0000000000000000000000000106540065007300740020003200}
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 348
    Width = 819
    Height = 322
    Margins.Left = 8
    Margins.Top = 2
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    Caption = 'Skripty'
    TabOrder = 1
    object Skripty: TListView
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 809
      Height = 271
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          Caption = '#'
        end
        item
          Caption = 'N'#225'zev'
          Width = 300
        end
        item
          Caption = 'V'#253'jimky'
          Width = 340
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = SkriptyDblClick
      OnItemChecked = SkriptyItemChecked
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 292
      Width = 809
      Height = 25
      Margins.Top = 0
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      object SkriptPridat: TButton
        Left = 330
        Top = 0
        Width = 75
        Height = 25
        Align = alRight
        Caption = 'P'#345'idat skript'
        TabOrder = 0
        OnClick = SkriptPridatClick
      end
      object SkriptDolu: TButton
        Left = 709
        Top = 0
        Width = 100
        Height = 25
        Align = alRight
        Caption = 'Posunout dol'#367
        TabOrder = 1
        OnClick = SkriptDoluClick
      end
      object SkriptNahoru: TButton
        Left = 604
        Top = 0
        Width = 105
        Height = 25
        Align = alRight
        Caption = 'Posunout nahoru'
        TabOrder = 2
        OnClick = SkriptNahoruClick
      end
      object SkriptSmazat: TButton
        Left = 499
        Top = 0
        Width = 105
        Height = 25
        Align = alRight
        Caption = 'Smazat skript'
        TabOrder = 3
        OnClick = SkriptSmazatClick
      end
      object SkriptUpravit: TButton
        Left = 405
        Top = 0
        Width = 94
        Height = 25
        Align = alRight
        Caption = 'Upravit skript'
        TabOrder = 4
        OnClick = SkriptUpravitClick
      end
    end
  end
  object Button1: TButton
    AlignWithMargins = True
    Left = 8
    Top = 678
    Width = 819
    Height = 25
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    Caption = 'Spustit'
    TabOrder = 2
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 488
    Top = 48
    object Soubor1: TMenuItem
      Caption = 'Soubor'
      object Nastnastaven1: TMenuItem
        Caption = 'Na'#269#237'st nastaven'#237
        OnClick = Nastnastaven1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Sprvasloek1: TMenuItem
        Caption = 'Spr'#225'va slo'#382'ek'
        OnClick = Sprvasloek1Click
      end
      object Pidatdatabzi1: TMenuItem
        Caption = 'P'#345'idat datab'#225'zi'
      end
      object Skripty1: TMenuItem
        Caption = 'P'#345'idat skript'
        OnClick = Skripty1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Konec1: TMenuItem
        Caption = 'Konec'
        OnClick = Konec1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'xml'
    Options = [ofCreatePrompt, ofEnableSizing]
    Left = 192
    Top = 152
  end
end
