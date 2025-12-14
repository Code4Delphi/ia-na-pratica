object DatabaseDm: TDatabaseDm
  OnCreate = DataModuleCreate
  Height = 258
  Width = 434
  object FDConnection1: TFDConnection
    Left = 136
    Top = 72
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 256
    Top = 72
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 128
    Top = 160
  end
end
