object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Code4D\Projetos\IA-na-pratica\Samples\BD\dados.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 128
    Top = 88
  end
  object TBVendas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select'
      'vendas.Id,'
      'vendas.id_cliente,'
      'cliente.nome as ClienteNome,'
      'vendas.data,'
      'vendas.total'
      'from vendas'
      'left join cliente on cliente.id = vendas.id_cliente'
      '')
    Left = 128
    Top = 152
    object TBVendasId: TFDAutoIncField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object TBVendasid_cliente: TIntegerField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
      Required = True
    end
    object TBVendasClienteNome: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'ClienteNome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object TBVendasdata: TWideStringField
      FieldName = 'data'
      Origin = 'data'
      Size = 10
    end
    object TBVendastotal: TFloatField
      FieldName = 'total'
      Origin = 'total'
    end
  end
end
