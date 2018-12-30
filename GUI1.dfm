object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ExeQutor'
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
      object DatabazeSmazat: TButton
        Left = 614
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Sma'#382'e vybranou datab'#225'zi nebo slo'#382'ku'
        Align = alRight
        Caption = 'Smazat'
        TabOrder = 0
        OnClick = DatabazeSmazatClick
      end
      object DatabazuPridat: TButton
        Left = 419
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Vytvo'#345#237' novou datab'#225'zi'
        Align = alRight
        Caption = 'P'#345'idat'
        TabOrder = 1
        OnClick = DatabazuPridatClick
      end
      object DatabazuUpravit: TButton
        Left = 549
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Uprav'#237' '#250'daje o vybran'#233' datab'#225'ze nebo slo'#382'cce'
        Align = alRight
        Caption = 'Upravit'
        TabOrder = 2
        OnClick = DatabazuUpravitClick
      end
      object DatabazeNahoru: TButton
        Left = 679
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Posune datab'#225'z'#237' nebo slo'#382'ku nahoru'
        Align = alRight
        Caption = 'Nahoru'
        TabOrder = 3
        OnClick = DatabazeNahoruClick
      end
      object DatabazeDolu: TButton
        Left = 744
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Posune datab'#225'zi nebo slo'#382'ku dol'#367
        Align = alRight
        Caption = 'Dol'#367
        TabOrder = 4
        OnClick = DatabazeDoluClick
      end
      object DatabazeKopirovat: TButton
        Left = 484
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Vytvo'#345#237' novou datab'#225'zi dle ji'#382' ulo'#382'en'#233
        Align = alRight
        Caption = 'Zkop'#237'rovat'
        TabOrder = 5
        OnClick = DatabazeKopirovatClick
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
      DoubleBuffered = True
      HideSelection = False
      Indent = 19
      ParentDoubleBuffered = False
      RowSelect = True
      SelectionPen.Color = clBtnShadow
      StateImages = Databaze.CheckImages
      TabOrder = 1
      OnChange = DatabazeChange
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
        Left = 419
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Vytvo'#345#237' nov'#253' skript'
        Align = alRight
        Caption = 'P'#345'idat'
        TabOrder = 0
        OnClick = SkriptPridatClick
      end
      object SkriptDolu: TButton
        Left = 744
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Posune vybran'#253' skript dol'#367
        Align = alRight
        Caption = 'Dol'#367
        TabOrder = 1
        OnClick = SkriptDoluClick
      end
      object SkriptNahoru: TButton
        Left = 679
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Posune vybran'#253' skript nahoru'
        Align = alRight
        Caption = 'Nahoru'
        TabOrder = 2
        OnClick = SkriptNahoruClick
      end
      object SkriptSmazat: TButton
        Left = 614
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Sma'#382'e vybran'#253' skript'
        Align = alRight
        Caption = 'Smazat'
        TabOrder = 3
        OnClick = SkriptSmazatClick
      end
      object SkriptUpravit: TButton
        Left = 549
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Uprav'#237' '#250'daje o vybran'#233'm skriptu'
        Align = alRight
        Caption = 'Upravit'
        TabOrder = 4
        OnClick = SkriptUpravitClick
      end
      object SkriptZkopirovat: TButton
        Left = 484
        Top = 0
        Width = 65
        Height = 25
        Hint = 'Vytvo'#345#237' nov'#253' skript'
        Align = alRight
        Caption = 'Zkop'#237'rovat'
        TabOrder = 5
        OnClick = SkriptPridatClick
      end
    end
  end
  object Button1: TButton
    AlignWithMargins = True
    Left = 8
    Top = 678
    Width = 819
    Height = 25
    Hint = 'Za'#269'ne prov'#225'd'#283't zm'#283'ny v datab'#225'z'#237'ch'
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
    object Ostatn1: TMenuItem
      Caption = 'Ostatn'#237
      object Monosti1: TMenuItem
        Caption = 'Mo'#382'nosti'
        OnClick = Monosti1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Oprogramu1: TMenuItem
        Caption = 'O programu'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'xml'
    Filter = 'Profil ExeQutor XML (*.eqr)|*.eqr'
    Options = [ofCreatePrompt, ofEnableSizing]
    Left = 192
    Top = 152
  end
end
