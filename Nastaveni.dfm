object ExecutorNastaveni: TExecutorNastaveni
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object xmlparse: TipwXMLp
    Left = 32
    Top = 16
  end
  object xmlread: TipwXMLw
    EOL = #13#10
    Indent = #9
    Left = 104
    Top = 16
  end
  object FileSaveDialog1: TFileSaveDialog
    DefaultExtension = 'eqr'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Profil ExeQutor XML'
        FileMask = '*.eqr'
      end>
    Options = [fdoOverWritePrompt]
    Left = 80
    Top = 80
  end
end
