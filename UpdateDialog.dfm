object UpdateDlg: TUpdateDlg
  Left = 227
  Top = 108
  Caption = 'Prob'#237'h'#225' update datab'#225'z'#237
  ClientHeight = 750
  ClientWidth = 671
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    AlignWithMargins = True
    Left = 8
    Top = 717
    Width = 655
    Height = 25
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    Cancel = True
    Caption = 'Zav'#345#237't'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 655
    Height = 701
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Color = clBtnFace
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object DB: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\kandrik\Documents\Embarcadero\Studio\Projects\' +
        'starmon-ep\LOCALBASE-CTR.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 88
    Top = 16
  end
  object FDTransaction1: TFDTransaction
    Options.Params.Strings = (
      'read_commited'
      'record_version'
      'nowait')
    Connection = DB
    Left = 176
    Top = 16
  end
  object Script: TFDScript
    SQLScripts = <>
    Connection = DB
    ScriptOptions.SQLDialect = 3
    Params = <>
    Macros = <>
    OnConsolePut = ScriptConsolePut
    OnError = ScriptError
    Left = 248
    Top = 16
  end
  object InitTimer: TTimer
    Enabled = False
    Interval = 300
    OnTimer = InitTimerTimer
    Left = 304
    Top = 64
  end
end
