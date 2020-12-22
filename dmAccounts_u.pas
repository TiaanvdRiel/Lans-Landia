// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit dmAccounts_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmAccounts = class(TDataModule)
    conAccounts: TADOConnection;
    tblAccounts: TADOTable;
    dsrAccounts: TDataSource;
    tblAccountsPlayerID: TIntegerField;
    tblAccountsUsername: TWideStringField;
    tblAccountsName: TWideStringField;
    tblAccountsSurname: TWideStringField;
    tblAccountsTotalMatchesPlayed: TSmallintField;
    tblAccountsMatchesWon: TSmallintField;
    tblAccountsMatchesLost: TSmallintField;
    tblAccountsTotalRoundsPlayed: TSmallintField;
    tblAccountsRoundsWon: TSmallintField;
    tblAccountsRoundsLost: TSmallintField;
    tblAccountsKills: TSmallintField;
    tblAccountsDeaths: TSmallintField;
    tblAccountsAge: TSmallintField;
    tblAccountsGender: TWideStringField;
    tblAccountsEmailAdress: TWideStringField;
    tblAccountsCellphoneNumber: TWideStringField;
    tblAccountsIDNumber: TWideStringField;
    tblAccountsPassword: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmAccounts: TdmAccounts;

implementation

{$R *.dfm}

procedure TdmAccounts.DataModuleCreate(Sender: TObject);
{ The purpose of this code is to construct the file path for the connectio string
  of the database, this ensures that the user doesn`t have to worry about the database
  not being able to be located just because the file path changed }
var
  sFilePath: string;
begin
  conAccounts.Close;
  sFilePath := ExtractFilePath('frmLansLandia_p.exe') + 'dbAccounts.mdb';
  conAccounts.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;' + 'Data Source=' + sFilePath;
  tblAccounts.Open;

end;

end.
