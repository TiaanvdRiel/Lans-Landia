program frmLansLandia_p;

uses
  Forms,
  frmLansLandia_u in 'frmLansLandia_u.pas' {frmWelcome},
  frmLogIn_u in 'frmLogIn_u.pas' {frmLogIn},
  frmCreateNewAccount_u in 'frmCreateNewAccount_u.pas' {frmCreateNewAccount},
  frmUserHomePage_u in 'frmUserHomePage_u.pas' {frmUserHomePage},
  frmMatch_u in 'frmMatch_u.pas' {frmMatch},
  frmLeaderboards_u in 'frmLeaderboards_u.pas' {frmLeaderboards},
  dmAccounts_u in 'dmAccounts_u.pas' {dmAccounts: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Lans Landia';
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmCreateNewAccount, frmCreateNewAccount);
  Application.CreateForm(TfrmUserHomePage, frmUserHomePage);
  Application.CreateForm(TfrmMatch, frmMatch);
  Application.CreateForm(TfrmLeaderboards, frmLeaderboards);
  Application.CreateForm(TdmAccounts, dmAccounts);
  Application.Run;
end.
