// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit frmCreateNewAccount_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, math;

type
  TfrmCreateNewAccount = class(TForm)
    lblCreateNewAccountHeading: TLabel;
    lblDateOfBirth: TLabel;
    lblGender: TLabel;
    lblGenderM: TLabel;
    lblGenderF: TLabel;
    spnedtDayOfBirth: TSpinEdit;
    lbledtName: TLabeledEdit;
    lbledtID: TLabeledEdit;
    lbledtEmailAdress: TLabeledEdit;
    lbledtCellphoneNumber: TLabeledEdit;
    lbledtPassword: TLabeledEdit;
    lbledtPasswordRetype: TLabeledEdit;
    lbledtSurname: TLabeledEdit;
    lbledtUsername: TLabeledEdit;
    rbFemale: TRadioButton;
    rbMale: TRadioButton;
    btnSignUp: TButton;
    btnBack: TButton;
    btnCreateNewAccountHelp: TButton;
    spnedtYearOfBirth: TSpinEdit;
    cbxMonth: TComboBox;
    procedure btnCreateNewAccountHelpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBackClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);

  private
    { Private declarations }
    sName: string;
    sSurname: string;
    sUsername: string;
    iIDNumber: integer;
    sGender: string;
    sEmailAdress: string;
    sCellphoneNumber: string;
    sPassword: string;
    sPleaseRetypePassword: string;
    iEnteredBirthDay: integer;
    iEnteredBirthMonth: integer;
    iEnteredBirthYear: integer;
    ///============= Custom Procedures =========//
    procedure ShowHelpAfterIncorrectAttempt;
    procedure ResetAll; // Resets form to the way it initially looked
    procedure ShowHelp; // Shows the user a help file
    //========= Custom Functions ===============//
    Function IsAllFieldsPresent: boolean; // Determines if all fields are entered
    Function IsNameValid: boolean; // Determines if name is valid
    Function IsSurnameValid: boolean; // Determine if surname is valid
    Function IsUsernameExists: boolean; // Determines if the user entered a new username
    Function IsCellphoneNumberValid: boolean; // Determines if cellphone number is 10 DIGITS long
    Function IsPasswordValid: boolean; // Checks that password is at least 8 characters long, and contains at least
    // one uppercase letter, one lowercase letter and at least one number.
    Function IsIDNumberValidNumbers: boolean; // Function that checks that the ID Number contains only numbers and is 13 digits long
    Function IsIDNumberValidBirthDate: boolean; // Checks that the user`s enterd bithdates match ID
    Function IsIDNumberValidGender: boolean; // Checks that the user`s gender matches his ID`s
    Function IsIDNumberValidCheckDigit: boolean; // Checks that the check digit validates according to Luhn`s equation
    /// ////////////////////
    Function GetPlayersID: integer; // gets the pleyers unique player ID to add as a primary key in the database
    Function DeterminePlayerAge: integer; // Determines the user`s age
    Procedure CreateNewUserMatchHistory; // Creates the text file that saves the user`s match history;

  public
    { Public declarations }
  end;

var
  frmCreateNewAccount: TfrmCreateNewAccount;

implementation

Uses
  frmLansLandia_u, dmAccounts_u, frmUserHomePage_u;
{$R *.dfm}

/// ============ Function to detirmine if all fields are entered ==============
Function TfrmCreateNewAccount.IsAllFieldsPresent: boolean;
{ The purpose of this procedure is to determine if all of the fields are
entered}
begin

  IsAllFieldsPresent := True;

  // Name
  sName := lbledtName.Text;
  if sName = '' then
  Begin
    ShowMessage('Please enter a name.');
    lbledtName.EditLabel.Font.Color := clRed;
    lbledtName.EditLabel.Caption := '*** Name:';
    IsAllFieldsPresent := False;
  End;
  // Surname
  sSurname := lbledtSurname.Text;
  if sSurname = '' then
  Begin
    ShowMessage('Please enter a surname.');
    lbledtSurname.EditLabel.Font.Color := clRed;
    lbledtSurname.EditLabel.Caption := '*** Surname:';
    IsAllFieldsPresent := False;
  End;
  // Username
  sUsername := lbledtUsername.Text;
  if sUsername = '' then
  Begin
    ShowMessage('Please enter a username.');
    lbledtUsername.EditLabel.Font.Color := clRed;
    lbledtUsername.EditLabel.Caption := '*** Username:';
    IsAllFieldsPresent := False;
  End;
  // ID Number
  if lbledtID.Text = '' then
  Begin
    ShowMessage('Please enter a ID');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID:';
    IsAllFieldsPresent := False;
  End;
  // Gender
  if (rbMale.Checked = False) AND (rbFemale.Checked = False) then
  Begin
    ShowMessage('Please select a gender. ');
    lblGender.Font.Color := clRed;
    lblGender.Caption := '*** Gender:';
    IsAllFieldsPresent := False;
  End;
  // Email
  sEmailAdress := lbledtEmailAdress.Text;
  if sEmailAdress = '' then
  Begin
    ShowMessage('Please enter a Email Adress.');
    lbledtEmailAdress.EditLabel.Font.Color := clRed;
    lbledtEmailAdress.EditLabel.Caption := '*** Email Aress:';
    IsAllFieldsPresent := False;
  End;
  // Cellphone Number
  sCellphoneNumber := lbledtCellphoneNumber.Text;
  if sCellphoneNumber = '' then
  Begin
    ShowMessage('Please enter a Cellphone Number.');
    lbledtCellphoneNumber.EditLabel.Font.Color := clRed;
    lbledtCellphoneNumber.EditLabel.Caption := '*** Cellphone Number:';
    IsAllFieldsPresent := False;
  End;
  // Password
  sPassword := lbledtPassword.Text;
  if sPassword = '' then
  Begin
    ShowMessage('Please enter a password.');
    lbledtPassword.EditLabel.Font.Color := clRed;
    lbledtPassword.EditLabel.Caption := '*** Password:';
    IsAllFieldsPresent := False;
  End;
  // Please Retype Password
  sPleaseRetypePassword := lbledtPasswordRetype.Text;
  if sPleaseRetypePassword = '' then
  Begin
    ShowMessage('Please retype your password.');
    lbledtPasswordRetype.EditLabel.Font.Color := clRed;
    lbledtPasswordRetype.EditLabel.Caption :=
      '*** Please Retype Your Password:';
    IsAllFieldsPresent := False;
  End;

end;

/// ==================== Function to detirmine is name is valid ===============
function TfrmCreateNewAccount.IsNameValid: boolean;
{ This function checks that the name contains only letters and spaces}
var
  i: integer;
begin
  IsNameValid := True;

  sName := lbledtName.Text;
  for i := 1 to Length(sName) do
  Begin
    sName[i] := Upcase(sName[i]);
    if not(sName[i] in ['A' .. 'Z']) AND (sName[i] <> ' ') then
    begin
      ShowMessage('Your name can only contain letters and spaces.');
      lbledtName.EditLabel.Font.Color := clRed;
      lbledtName.EditLabel.Caption := '*** Name:';
      IsNameValid := False;
    end;
  End;

end;

/// ================= Function to determine if surname is valid ===============
function TfrmCreateNewAccount.IsSurnameValid: boolean;
{ This function checks that the surname contains only letters and spaces}
var
  i: integer;
begin
  IsSurnameValid := True;

  sName := lbledtSurname.Text;
  for i := 1 to Length(sSurname) do
  Begin
    sSurname[i] := Upcase(sSurname[i]);
    if not(sSurname[i] in ['A' .. 'Z']) AND (sSurname[i] <> ' ') then
    begin
      ShowMessage('Your surname can only contain letters and spaces.');
      lbledtSurname.EditLabel.Font.Color := clRed;
      lbledtSurname.EditLabel.Caption := '*** Surname:';
      IsSurnameValid := False;
    end;
  End;

end;

/// ====== Function to determine if the user entered a new username ==========
Function TfrmCreateNewAccount.IsUsernameExists: boolean;
 { This function takes the username the user chose and determines wheter
 or not that username already existst in the database by searching for it}
begin
  sUsername := lbledtUsername.Text;
  dmAccounts.tblAccounts.First;
  while not dmAccounts.tblAccounts.Eof do
  Begin
    if sUsername = dmAccounts.tblAccounts['username'] then
    Begin
      ShowMessage(
        'This username has already been taken. Please enter a new one.');
      lbledtUsername.EditLabel.Font.Color := clRed;
      lbledtUsername.EditLabel.Caption := '*** Username:';
      IsUsernameExists := True;
    End;
    dmAccounts.tblAccounts.Next;
  End;
end;

/// ===== Function that determines if cellphone number is 10 DIGITS long =======
Function TfrmCreateNewAccount.IsCellphoneNumberValid;
{ This function checks that the cellphone number is 10 digits long, and contains
only numbers}
var
  i: integer;
begin
  IsCellphoneNumberValid := True;
  sCellphoneNumber := lbledtCellphoneNumber.Text;

  if Length(sCellphoneNumber) <> 10 then
  Begin
    ShowMessage('Your cellphone number is not the correct lenght.');
    lbledtCellphoneNumber.EditLabel.Font.Color := clRed;
    lbledtCellphoneNumber.EditLabel.Caption := '*** Cellphone Number:';
    IsCellphoneNumberValid := False;
  End;

  for i := 1 to Length(sCellphoneNumber) do
  Begin
    if NOT(sCellphoneNumber[i] In ['0' .. '9']) then
    Begin
      ShowMessage('Your cellphone number can only contain numbers.');
      lbledtCellphoneNumber.EditLabel.Font.Color := clRed;
      lbledtCellphoneNumber.EditLabel.Caption := '*** Cellphone Number:';
      IsCellphoneNumberValid := False;
    end;

  end;

end;

/// ===================== Function that validates password ====================
Function TfrmCreateNewAccount.IsPasswordValid: boolean;
{ Checks that password is at least 8 characters long, and contaains at least
  one uppercase letter, one lowercase letter and at least one number. }
var
  i: integer;
  bContainsUppercase: boolean;
  bContainsLowercase: boolean;
  bContainsNumber: boolean;
begin
  IsPasswordValid := True;
  sPassword := lbledtPassword.Text;

  if Length(sPassword) < 8 then
  Begin
    ShowMessage('Your password needs to be at least 8 characters long.');
    lbledtPassword.EditLabel.Font.Color := clRed;
    lbledtPassword.EditLabel.Caption := '*** Password:';
    IsPasswordValid := False;
  End;

  bContainsUppercase := False;
  bContainsLowercase := False;
  bContainsNumber := False;
  for i := 1 to Length(sPassword) do
  Begin
    if sPassword[i] IN ['a' .. 'z'] then
    Begin
      bContainsLowercase := True;
    End;
    if sPassword[i] IN ['A' .. 'Z'] then
    Begin
      bContainsUppercase := True;
    End;
    if sPassword[i] IN ['0' .. '9'] then
    Begin
      bContainsNumber := True;
    End;
  end;

  if bContainsUppercase = False then
    ShowMessage('Your password does not contain an uppercase letter.');
  if bContainsLowercase = False then
    ShowMessage('Your password does not contain a lowercase letter.');
  if bContainsNumber = False then
    ShowMessage('Your password does not contain a number letter.');

  if (bContainsUppercase = False) OR (bContainsLowercase = False) OR
    (bContainsNumber = False) then
  Begin
    ShowMessage(
      'Your password needs to contain at least one uppercase letter, lowercase letter and number.');
    lbledtPassword.EditLabel.Font.Color := clRed;
    lbledtPassword.EditLabel.Caption := '*** Password:';
    IsPasswordValid := False;
  End;

end;

/// ====== Function that checks that the ID Number contains only numbers and is
// 13 digits long ============================================================
Function TfrmCreateNewAccount.IsIDNumberValidNumbers: boolean;
var
  sEnteredID: string;
  i: integer;
begin
  IsIDNumberValidNumbers := True;
  // Checks that ID Number only contains numbers
  sEnteredID := lbledtID.Text;
  i := 0;
  for i := 1 to Length(sEnteredID) do
  Begin
    if NOT(sEnteredID[i] In ['0' .. '9']) then
    Begin
      ShowMessage('Your ID number can only contain numbers.');
      lbledtID.EditLabel.Font.Color := clRed;
      lbledtID.EditLabel.Caption := '*** ID Number:';
      IsIDNumberValidNumbers := False;
    end;
  End;

  if Length(sEnteredID) <> 13 then
  Begin
    ShowMessage('Your ID number must be 13 digits long.');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID Number:';
    IsIDNumberValidNumbers := False;
  End;

end;

// ============== Checks that the user`s enterd bithdates match ID  =========
Function TfrmCreateNewAccount.IsIDNumberValidBirthDate: boolean;
{ This function determines what the user`s bith date is suppose to be according
to his ID, and then checks to see that the match}
var
  iIDday: integer;
  iIDmonth: integer;
  sIDyear: string;
  iIDYear: integer;
  sIDNumber: string;

begin
  IsIDNumberValidBirthDate := True;
  // Gets User entered birth information
  iEnteredBirthDay := StrToInt(spnedtDayOfBirth.Text);
  iEnteredBirthMonth := cbxMonth.ItemIndex + 1;
  iEnteredBirthYear := StrToInt(spnedtYearOfBirth.Text);
  // Gets birth dates from ID Number
  sIDNumber := lbledtID.Text;
  iIDday := StrToInt(Copy(sIDNumber, 5, 2));
  iIDmonth := StrToInt(Copy(sIDNumber, 3, 2));
  sIDyear := Copy(sIDNumber, 1, 2);
  if StrToInt(sIDyear) IN [0 .. 17] then
    iIDYear := 2000 + StrToInt(sIDyear)
  else
    iIDYear := 1900 + StrToInt(sIDyear);
  // Compares the two
  // Day
  if iEnteredBirthDay <> iIDday then
  Begin
    ShowMessage('Your ID number`s day of birth does not match your birth day.');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID Number:';
    IsIDNumberValidBirthDate := False;
  End;
  // Month
  if iEnteredBirthMonth <> iIDmonth then
  Begin
    ShowMessage(
      'Your ID number`s month of birth does not match your birth month.');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID Number:';
    IsIDNumberValidBirthDate := False;
  End;
  // Year
  if iEnteredBirthYear <> iIDYear then
  Begin
    ShowMessage
      ('Your ID number`s year of birth does not match your birth year.');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID Number:';
    IsIDNumberValidBirthDate := False;
  End;
end;

// =============== Checks that the user`s gender matches his ID`s =============
function TfrmCreateNewAccount.IsIDNumberValidGender: boolean;
{ This function determines what the user`s gender is suppose to be according
to his ID, and then checks to see that the match}
var
  sEnteredID: string;

begin
  IsIDNumberValidGender := True;
  sEnteredID := lbledtID.Text;

  if NOT(((StrToInt(sEnteredID[7]) > 4) AND (rbMale.Checked = True)) OR
      ((StrToInt(sEnteredID[7]) < 4) AND (rbFemale.Checked = True))) then
  begin
    ShowMessage('Your ID number does not match your gender.');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID Number:';
    IsIDNumberValidGender := False;
  end;
end;

// =========== Function that validates that the check digit matches
// what it should be according to Luhn`s equation ==================
Function TfrmCreateNewAccount.IsIDNumberValidCheckDigit: boolean;
{ This function calculates the what the user`s check digit is suppose to be
according to Luhn`s formula, and then checks to see wheter or not it matches the
user`s enered ID check digit}
var
  i: integer;
  iSumOdds: integer;
  iSumEvens: integer;
  iTotal: integer;
  iCheck: integer;
  sEvens: string;
  sNumFromEvens: string;
  sEnteredID: string;

begin
  IsIDNumberValidCheckDigit := True;
  sEnteredID := lbledtID.Text;

  // Calculate the sum of all the odd digits in the Id number - excluding the last one
  i := 1;
  iSumOdds := 0;
  while i <= 11 do
  begin
    iSumOdds := iSumOdds + StrToInt(sEnteredID[i]);
    Inc(i, 2);
  end;

  // Create a new number: Using the even positions and multiplying the number by 2
  sEvens := '';
  i := 2;
  while i <= 12 do
  begin
    sEvens := sEvens + sEnteredID[i];
    Inc(i, 2);
  end;
  sNumFromEvens := IntToStr(StrToInt(sEvens) * 2);

  // Add up all the digits in this new number
  iSumEvens := 0;
  for i := 1 to Length(sNumFromEvens) do
  begin
    iSumEvens := iSumEvens + StrToInt(sNumFromEvens[i]);
  end;

  // Add the two numbers
  iTotal := iSumOdds + iSumEvens;

  // Subtract the second digit form 10
  iCheck := (iTotal MOD 10);
  if iCheck = 0 then
  begin
    iCheck := 10;
  end;
  iCheck := 10 - iCheck;

  // Check if the calculated check digit matches the last digit in the ID Number
  if Not(iCheck = StrToInt(sEnteredID[13])) then
  Begin
    ShowMessage
      ('Your ID Number is incorrect. Please re-enter it and try again.');
    lbledtID.EditLabel.Font.Color := clRed;
    lbledtID.EditLabel.Caption := '*** ID Number:';
    IsIDNumberValidCheckDigit := False;
  End;
end;

/// ========= Function that calculates the players new player ID
/// - primary key in database ===========================================
Function TfrmCreateNewAccount.GetPlayersID: integer;
var
  iLarge: integer;
begin
  with dmAccounts do
  begin
    tblAccounts.DisableControls;
    tblAccounts.First;
    iLarge := -1;
    while NOT tblAccounts.Eof do
    begin
      if tblAccounts['Player ID'] > iLarge then
      begin
        iLarge := tblAccounts['Player ID'];
      end;
      tblAccounts.Next;
    end; // while
    tblAccounts.EnableControls;
  end; // with
  Result := iLarge + 1;
end;

// ================== Function that determines the user`s age =================
Function TfrmCreateNewAccount.DeterminePlayerAge: integer;
var
  iDay: integer;
  iMonth: integer;
  iYear: integer;
  sToday: string;
  iThisDay, iThisMonth, iThisYear: integer;
  iAge: integer;
begin
  // Gets User entered birth information
  iDay := StrToInt(spnedtDayOfBirth.Text);
  iMonth := cbxMonth.ItemIndex + 1;
  iYear := StrToInt(spnedtYearOfBirth.Text);
  // Determine Today`s date
  sToday := DateToStr(Date);
  iThisDay := StrToInt(Copy(sToday, 1, 2));
  iThisMonth := StrToInt(Copy(sToday, 4, 2));
  iThisYear := StrToInt(Copy(sToday, 7, 4));
  // Calculate the age the person will become this year
  iAge := iThisYear - iYear;
  // Determine if the person has already had his/her birthday
  if iMonth > iThisMonth then // birthday will be later this year
    Dec(iAge)
  else if iMonth = iThisMonth then // test if birthday is later in the month or has already happened
    if iDay > iThisDay then // bithday will be later in the MonthDays
      Dec(iAge);
  Result := iAge;
end;

/// ======================== Create A New Account Button ======================
procedure TfrmCreateNewAccount.btnSignUpClick(Sender: TObject);
{ The function of this code is to initialise the checking of all of the criteria
and then, if all criteria are met, initialise the creation of a new account, or,
if one is not met, initialise the showing of an error message and a help file}
var
  bAllFieldsEntered: boolean;
  bNamevalid: boolean;
  bSurnamevalid: boolean;
  bUsernameExists: boolean;
  bCellphoneNumberValid: boolean;
  bPasswordValid: boolean;
  // Boolaens calling functions for ID Validation
  bIDNumberValidNumbers: boolean;
  bIDNumberValidBirthDate: boolean;
  bIDNumberValidGender: boolean;
  bIDNumberValidCheckDigit: boolean;
  // Gets calculated when user`s account gets created
  iPlayersID: integer;
  sPlayerGender: string;
  // Determine from function
  iPlayersAge: integer;
begin

  // Presence check
  bAllFieldsEntered := IsAllFieldsPresent; // Calls function
  if bAllFieldsEntered = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Name Valid
  bNamevalid := IsNameValid; // Calls function
  if bNamevalid = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Surname Valid
  bSurnamevalid := IsSurnameValid; // Calls function
  if bSurnamevalid = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Username New
  bUsernameExists := IsUsernameExists; // Calls function
  if bUsernameExists = True then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Cellphone Number Valid
  bCellphoneNumberValid := IsCellphoneNumberValid;
  if bCellphoneNumberValid = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Password Valid
  bPasswordValid := IsPasswordValid;
  if bPasswordValid = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Password Retype
  sPleaseRetypePassword := lbledtPasswordRetype.Text;
  if NOT(sPleaseRetypePassword = sPassword) then
  begin
    ShowMessage(
      'One of your passwords was entered incorectly and they don`t match.');
    if MessageDlg(
      'You entered your information incorrectly. Would you like to veiw help as to how to enter your information ?', mtInformation, [mbYes, mbNo], 0) = mrYes then
    Begin
      ShowHelp;
    End
    Else
    Begin
      Exit;
    End;
  end;
  // ==========================================================================
  // Is ID Numeber valid - Only Numbers
  bIDNumberValidNumbers := IsIDNumberValidNumbers;
  if bIDNumberValidNumbers = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Checks that the user`s enterd bithdates match ID
  bIDNumberValidBirthDate := IsIDNumberValidBirthDate;
  if bIDNumberValidBirthDate = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Checks that the user`s gender matches his ID
  bIDNumberValidGender := IsIDNumberValidGender;
  if bIDNumberValidGender = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================
  // Checks that the check digit matches what it should be according to Luhn`s equation
  bIDNumberValidCheckDigit := IsIDNumberValidCheckDigit;
  if bIDNumberValidCheckDigit = False then
  begin
    ShowHelpAfterIncorrectAttempt;
    Exit;
  end;
  // ==========================================================================

  // Get Gender
  if rbFemale.Checked = True then
    sPlayerGender := 'F';
  if rbMale.Checked = True then
    sPlayerGender := 'M';
  // Generate a new player ID for the user
  iPlayersID := GetPlayersID;
  // Determine the user`s age and check that he/she is at least 16 years old
  iPlayersAge := DeterminePlayerAge;
  if iPlayersAge < 16 then
  Begin
    ShowMessage('Sorry, you are currently ' + IntToStr(iPlayersAge) +
        ' of age. You need to be at least 16 years old to partake in the event.'
      );
    Exit;
  End;

  // Enter the data into the database
  with dmAccounts do
  begin
    dmAccounts.tblAccounts.Last;
    tblAccounts.Insert;
    tblAccounts['Player ID'] := iPlayersID;
    tblAccounts['Username'] := lbledtUsername.Text;
    tblAccounts['Name'] := lbledtName.Text;
    tblAccounts['Surname'] := lbledtSurname.Text;
    tblAccounts['Total Matches Played'] := 0;
    tblAccounts['Matches Won'] := 0;
    tblAccounts['Matches Lost'] := 0;
    tblAccounts['Total Rounds Played'] := 0;
    tblAccounts['Rounds Won'] := 0;
    tblAccounts['Rounds Lost'] := 0;
    tblAccounts['Kills'] := 0;
    tblAccounts['Deaths'] := 0;
    tblAccounts['Age'] := iPlayersAge;
    tblAccounts['Gender'] := sPlayerGender;
    tblAccounts['Email Adress'] := lbledtEmailAdress.Text;
    tblAccounts['Cellphone Number'] := lbledtCellphoneNumber.Text;
    tblAccounts['ID Number'] := lbledtID.Text;
    tblAccounts['Password'] := lbledtPassword.Text;
    tblAccounts.Post;
  end;

  CreateNewUserMatchHistory; // Creates the text file that saves the user`s match history;

  ShowMessage('Your account has been created.');
  ShowMessage('Sighn Up Seccessfull. Welcome to The Kingdom Of Gamers ' +
      lbledtName.Text + ' ' + lbledtSurname.Text + '.');

  { The function of the next code is to initialize the user`s homepage, since he
    has successfully created a new account. The variable sLoggedInUser must be set
    to the user`s username, so that the next forms know which user`s data to use. }
  frmUserHomePage.sLoggedInUser := lbledtUsername.Text;
  ResetAll;
  frmCreateNewAccount.Hide;
  frmCreateNewAccount.Close;
  frmUserHomePage.ShowModal;

end;

/// ======= Create a new match history file in the user`s name ================
procedure TfrmCreateNewAccount.CreateNewUserMatchHistory;
var
  UserMatchHistorty: TextFile;
  sFileName: string;
  sUsername: string;
  sDate: string;
begin
  sDate := DateToStr(Date);
  sUsername := lbledtUsername.Text;
  sFileName := 'UserMatchHistory_' + sUsername + '.txt';
  AssignFile(UserMatchHistorty, sFileName);
  Rewrite(UserMatchHistorty);
  Writeln(UserMatchHistorty, 'Account Created: ' + sDate);
  Writeln(UserMatchHistorty,
    '=========================================================');
  CloseFile(UserMatchHistorty);

end;

/// ======================= Back Button =======================================
procedure TfrmCreateNewAccount.btnBackClick(Sender: TObject);
begin
  frmCreateNewAccount.Close;
end;

/// =============== Show user help after incorrect attempt ===================
procedure TfrmCreateNewAccount.ShowHelpAfterIncorrectAttempt;
begin
  if MessageDlg(
    'You entered your information incorrectly. Would you like to veiw help as to how to enter your information ?', mtInformation, [mbYes, mbNo], 0) = mrYes then
  Begin
    ShowHelp;
  End
  Else
  Begin
    Exit;
  End;
end;

/// ======================== Procedure Show Help =============================
procedure TfrmCreateNewAccount.ShowHelp;
{ This procedure gets called whenever the porgram detects that a user entered
some piece of information incorrectly. It asks the user if he/she wants help
in entereing their information, by displaying a list of the criteeria that
have to be met}
var
  tHelp: TextFile;
  sLine: string;
  sMessage: string;

begin
  sMessage := '========================================';
  AssignFile(tHelp, 'Help_CreateNewAccount.txt');

  try { Code that checks to see if the file about the sponsors can be opened
      - displays error if not }
    reset(tHelp);
  Except
    ShowMessage('ERROR: The help file could not be opened.');
    Exit;
  end;

  while NOT Eof(tHelp) do
  begin
    Readln(tHelp, sLine);
    sMessage := sMessage + #13 + sLine;

  end;
  sMessage := sMessage + #13 + '========================================';
  CloseFile(tHelp);
  ShowMessage(sMessage);
end;

/// ======================= Close Form ========================================
procedure TfrmCreateNewAccount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ResetAll;
  frmWelcome.Show;
end;

/// ======================= Help Button =======================================
procedure TfrmCreateNewAccount.btnCreateNewAccountHelpClick(Sender: TObject);
begin
  ShowHelp;
end;

/// ========================= Procedure ResetAll ==============================
procedure TfrmCreateNewAccount.ResetAll;

begin
  // Name
  lbledtName.EditLabel.Font.Color := clWhite;
  lbledtName.EditLabel.Caption := 'Name:';
  lbledtName.Text := '';
  // Surname
  lbledtSurname.EditLabel.Font.Color := clWhite;
  lbledtSurname.EditLabel.Caption := 'Surname:';
  lbledtSurname.Text := '';
  // Username
  lbledtUsername.EditLabel.Font.Color := clWhite;
  lbledtUsername.EditLabel.Caption := 'Username:';
  lbledtUsername.Text := '';
  // ID
  lbledtID.EditLabel.Font.Color := clWhite;
  lbledtID.EditLabel.Caption := 'ID Number:';
  lbledtID.Text := '';
  // Gender
  lblGender.Font.Color := clWhite;
  lblGender.Caption := 'Gender: ';
  rbFemale.Checked := False;
  rbMale.Checked := False;
  // Email
  lbledtEmailAdress.EditLabel.Font.Color := clWhite;
  lbledtEmailAdress.EditLabel.Caption := 'Email Adress:';
  lbledtEmailAdress.Text := '';
  // Cellphone Number
  lbledtCellphoneNumber.EditLabel.Font.Color := clWhite;
  lbledtCellphoneNumber.EditLabel.Caption := 'Cellphone Number:';
  lbledtCellphoneNumber.Text := '';
  // Password
  lbledtPassword.EditLabel.Font.Color := clWhite;
  lbledtPassword.EditLabel.Caption := 'Password:';
  lbledtPassword.Text := '';
  // Please Retype Your Password
  lbledtPasswordRetype.EditLabel.Font.Color := clWhite;
  lbledtPasswordRetype.EditLabel.Caption := 'Please Retype Your Password:';
  lbledtPasswordRetype.Text := '';
end;

end.
