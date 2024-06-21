object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 410
  Width = 372
  object con: TMyConnection
    Database = 'pdv_delphi'
    Port = 41890
    Username = 'sistema_pdv'
    Server = 'mysql669.umbler.com'
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
    EncryptedPassword = '8FFF9BFF89FFA0FF8CFF96FF8CFF8BFF9AFF92FF9EFF'
  end
  object query_usuarios: TMyQuery
    Connection = con
    Left = 32
    Top = 72
  end
  object query_tot_vendas: TMyQuery
    Connection = con
    Left = 120
    Top = 72
  end
  object query_produtos: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from produtos')
    Options.FieldOrigins = foNone
    Left = 208
    Top = 72
    object query_produtosnome: TStringField
      FieldName = 'nome'
      Size = 25
    end
    object query_produtosdescricao: TStringField
      FieldName = 'descricao'
      Size = 35
    end
    object query_produtosestoque: TIntegerField
      FieldName = 'estoque'
    end
    object query_produtosimagem: TBlobField
      FieldName = 'imagem'
    end
  end
  object query_vendas: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from vendas')
    Options.FieldOrigins = foNone
    Left = 296
    Top = 72
    object query_vendasvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      currency = True
    end
    object query_vendasfuncionario: TStringField
      DisplayLabel = 'Operador'
      FieldName = 'funcionario'
      Size = 25
    end
  end
  object query_mov: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from movimentacoes')
    Options.FieldOrigins = foNone
    Left = 24
    Top = 144
    object query_movtipo: TStringField
      FieldName = 'tipo'
      Size = 10
    end
    object query_movmovimento: TStringField
      FieldName = 'movimento'
    end
    object query_movvalor: TFloatField
      FieldName = 'valor'
    end
    object query_movfuncionario: TStringField
      FieldName = 'funcionario'
    end
  end
  object query_tot_mov: TMyQuery
    Connection = con
    Left = 96
    Top = 144
  end
  object query_gastos: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from gastos')
    Options.FieldOrigins = foNone
    Left = 176
    Top = 144
    object query_gastosid: TIntegerField
      FieldName = 'id'
    end
    object query_gastosmotivo: TStringField
      FieldName = 'motivo'
      Size = 25
    end
    object query_gastosvalor: TFloatField
      FieldName = 'valor'
    end
    object query_gastosfuncionario: TStringField
      FieldName = 'funcionario'
    end
    object query_gastosdata: TDateField
      FieldName = 'data'
    end
  end
  object query_mov_inserir: TMyQuery
    Connection = con
    Left = 264
    Top = 144
  end
end
