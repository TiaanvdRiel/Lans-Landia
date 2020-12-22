// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit frmLogIn_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmLogIn = class(TForm)
    lblLogInHeading: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblUsername: TLabel;
    lblPassword: TLabel;
    btnLogIntoAccount: TButton;
    btnBack: TButton;
    btnHelp: TButton;
    procedure btnBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHelpClick(Sender: TObject);
    procedure btnLogIntoAccountClick(Sender: TObject);

  private
    { Private declarations }
    sEnteredUsername: string;
    sEnteredPassword: string;
    { }
    procedure GoToUserHomePage;
    { This procedure will execute when the user has succesfully logged in.
      It will set the variable sLoggedInUser to the user, which will
      be used by frmUserHomePage. It will also show the home page form. }

  public
    { public declarations }
  end;

var
  frmLogIn: TfrmLogIn;

implementation

Uses
  frmLansLandia_u, dmAccounts_u, frmUserHomePage_u;
{$R *.dfm}

/// ============================= Back Button ==============================
procedure TfrmLogIn.btnBackClick(Sender: TObject);
begin
  frmLogIn.Close;
  lblUsername.Font.Color := clWhite;
  lblPassword.Font.Color := clWhite;
  edtUsername.Text := '';
  edtPassword.Text := '';
  lblUsername.Caption := 'Username:';
  lblPassword.Caption := 'Password:';
end;

/// ============================= Help Button ==============================
procedure TfrmLogIn.btnHelpClick(Sender: TObject);
var
  tHelp: TextFile;
  sLine: string;
  sMessage: string;

begin
  sMessage := '========================================';
  AssignFile(tHelp, 'Help_LogIn.txt');

  try { Code that checks to see if the file about the sponsors can be opened
      - displays error if not }
    reset(tHelp);
  Except
    ShowMessage('ERROR: The help file could not be opened.');
    Exit;
  end;

  while NOT EOF(tHelp) do
  begin
    Readln(tHelp, sLine);
    sMessage := sMessage + #13 + sLine;

  end;
  sMessage := sMessage + #13 + '========================================';
  CloseFile(tHelp);
  ShowMessage(sMessage);
end;

/// ============================= Log Into Account =========================
procedure TfrmLogIn.btnLogIntoAccountClick(Sender: TObject);
var
  bUsernameFound: boolean;
begin
  sEnteredUsername := edtUsername.Text;
  sEnteredPassword := edtPassword.Text;

  if sEnteredUsername = '' then
  begin
    ShowMessage('Please enter your Username');
    lblUsername.Font.Color := clred;
    lblUsername.Caption := '***Username:';
    Exit;
  end;
  if sEnteredPassword = '' then
  begin
    ShowMessage('Please enter your Password');
    lblPassword.Font.Color := clred;
    lblPassword.Caption := '***Password:';
    Exit;
  end;

  bUsernameFound := false;
  dmAccounts.tblAccounts.First;
  while (NOT dmAccounts.tblAccounts.EOF) AND (bUsernameFound = false) do
  Begin
    if sEnteredUsername = dmAccounts.tblAccounts['Username'] then
    Begin
      bUsernameFound := true;
      // ShowMessage('Username Found');
    End
    else
    Begin
      dmAccounts.tblAccounts.Next;
    End;
  End; // End of searching for username (EOF)

  if bUsernameFound = false then // Username was not found
  Begin
    ShowMessage('Username or Password incorrect');
  End;

  { If the Username was found the code has to check that the password that the
    user entered matches the password for the account }
  if bUsernameFound = true then
  Begin
    if sEnteredPassword = dmAccounts.tblAccounts['Password'] then
    Begin
      ShowMessage('Log In Successful.');
      ShowMessage('Welcome to Lans-Landia ' + dmAccounts.tblAccounts['Name']
          + ' ' + dmAccounts.tblAccounts['Surname'] + '.');
      GoToUserHomePage; // procedure
    End // End of correct password
    Else
    Begin
      ShowMessage('Password or Username incorrect');
      Exit;
    End; // End of else
  End; // End of username Found

end;

/// =========================== Form Close =================================
procedure TfrmLogIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmWelcome.Show;
end;

/// ======================== Procedure GoToUserHomePage =====================
procedure TfrmLogIn.GoToUserHomePage;
begin
  ///
  { The function of this piece of code is to set the variable sLoggedInUser to
    the username of the user that has successfully logged in. The variable is one
    of the form frmUserHomePage }
  frmUserHomePage.sLoggedInUser := edtUsername.Text;
  ///
  lblUsername.Font.Color := clWhite;
  lblPassword.Font.Color := clWhite;
  edtUsername.Text := '';
  edtPassword.Text := '';
  lblUsername.Caption := 'Username:';
  lblPassword.Caption := 'Password:';
  frmLogIn.Hide;
  frmLogIn.Close;
  frmUserHomePage.ShowModal;

end;

end.
