object Data: TData
  OldCreateOrder = False
  Left = 375
  Top = 118
  Height = 422
  Width = 581
  object conCmco: TUniConnection
    DataTypeMap = <
      item
        DBType = 202
        FieldType = ftInteger
      end
      item
        DBType = 203
        FieldType = ftInteger
      end>
    ProviderName = 'MySQL'
    Database = 's11'
    SpecificOptions.Strings = (
      'MySQL.UseUnicode=True')
    Username = 'dbuser'
    Server = 'MySqlServer'
    LoginPrompt = False
    Left = 48
    Top = 16
    EncryptedPassword = '9BFF9DFF8FFF9EFF8CFF8CFF88FF90FF8DFF9BFF'
  end
  object MySql: TMySQLUniProvider
    Left = 128
    Top = 16
  end
end
