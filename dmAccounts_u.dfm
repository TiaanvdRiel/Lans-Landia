object dmAccounts: TdmAccounts
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 450
  Width = 745
  object conAccounts: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=D:\La' +
      'ns Landia\Lans Landia 42\dbAccounts.mdb;Mode=ReadWrite;Persist S' +
      'ecurity Info=False;Jet OLEDB:System database="";Jet OLEDB:Regist' +
      'ry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=' +
      '5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bul' +
      'k Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Datab' +
      'ase Password="";Jet OLEDB:Create System Database=False;Jet OLEDB' +
      ':Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=F' +
      'alse;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SF' +
      'P=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 232
    Top = 200
  end
  object tblAccounts: TADOTable
    Active = True
    Connection = conAccounts
    CursorType = ctStatic
    TableName = 'Accounts'
    Left = 336
    Top = 192
    object tblAccountsPlayerID: TIntegerField
      Alignment = taCenter
      FieldName = 'Player ID'
    end
    object tblAccountsUsername: TWideStringField
      FieldName = 'Username'
      Size = 40
    end
    object tblAccountsName: TWideStringField
      FieldName = 'Name'
      Size = 30
    end
    object tblAccountsSurname: TWideStringField
      FieldName = 'Surname'
      Size = 40
    end
    object tblAccountsTotalMatchesPlayed: TSmallintField
      FieldName = 'Total Matches Played'
    end
    object tblAccountsMatchesWon: TSmallintField
      FieldName = 'Matches Won'
    end
    object tblAccountsMatchesLost: TSmallintField
      FieldName = 'Matches Lost'
    end
    object tblAccountsTotalRoundsPlayed: TSmallintField
      FieldName = 'Total Rounds Played'
    end
    object tblAccountsRoundsWon: TSmallintField
      FieldName = 'Rounds Won'
    end
    object tblAccountsRoundsLost: TSmallintField
      FieldName = 'Rounds Lost'
    end
    object tblAccountsKills: TSmallintField
      FieldName = 'Kills'
    end
    object tblAccountsDeaths: TSmallintField
      FieldName = 'Deaths'
    end
    object tblAccountsAge: TSmallintField
      FieldName = 'Age'
      Visible = False
    end
    object tblAccountsGender: TWideStringField
      FieldName = 'Gender'
      Visible = False
      Size = 1
    end
    object tblAccountsEmailAdress: TWideStringField
      FieldName = 'Email Adress'
      Visible = False
      Size = 40
    end
    object tblAccountsCellphoneNumber: TWideStringField
      FieldName = 'Cellphone Number'
      Visible = False
      Size = 10
    end
    object tblAccountsIDNumber: TWideStringField
      FieldName = 'ID Number'
      Visible = False
      Size = 13
    end
    object tblAccountsPassword: TWideStringField
      FieldName = 'Password'
      Visible = False
      Size = 30
    end
  end
  object dsrAccounts: TDataSource
    DataSet = tblAccounts
    Left = 440
    Top = 192
  end
end
