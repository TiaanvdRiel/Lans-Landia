// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit frmUserHomePage_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, pngimage;

type
  TfrmUserHomePage = class(TForm)
    redLastMatch: TRichEdit;
    btnLogOut: TButton;
    btnHomePageHelp: TButton;
    lblHomPageUsername: TLabel;
    btnEnterMatch: TButton;
    btnVeiwLeaderboards: TButton;
    lblMatchHistory: TLabel;
    pnlMatchesPlayed: TPanel;
    pnlMatchesWon: TPanel;
    pnlMatchesLost: TPanel;
    pnlRoundsPlayed: TPanel;
    pnlRoundsWon: TPanel;
    pnlRoundsLost: TPanel;
    lblRoundsLost: TLabel;
    lblMatchesLost: TLabel;
    lblRoundsPlayed: TLabel;
    lblMatchesWon: TLabel;
    lblMatchesPlayed: TLabel;
    lblRoundsWon: TLabel;
    imgHomePageShield: TImage;
    imgHomePageSponsors: TImage;
    btnSponsors: TButton;
    lblDeaths: TLabel;
    lblKills: TLabel;
    pnlKills: TPanel;
    pnlDeaths: TPanel;
    pnlKD: TPanel;
    lblKD: TLabel;
    btnDeleteAccount: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnLogOutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSponsorsClick(Sender: TObject);
    procedure btnHomePageHelpClick(Sender: TObject);
    procedure btnEnterMatchClick(Sender: TObject);
    procedure btnVeiwLeaderboardsClick(Sender: TObject);
    procedure imgHomePageShieldClick(Sender: TObject);
    procedure btnDeleteAccountClick(Sender: TObject);
  private
    // Custom procedures
    procedure GetPanelsInfo;
    procedure ShowLastMatchPlayed;
    { Private declarations }
  public
    sLoggedInUser: string;
    { Public declarations }
  end;

var
  frmUserHomePage: TfrmUserHomePage;

implementation

uses
  frmLogIn_u, frmCreateNewAccount_u, frmLansLandia_u, frmMatch_u,
  frmLeaderboards_u, dmAccounts_u;
{$R *.dfm}
/// ========================== Enter A Match =================================

procedure TfrmUserHomePage.btnEnterMatchClick(Sender: TObject);
begin
  frmUserHomePage.Hide;
  frmMatch.ShowModal;

end;

/// =========================== Help Button ==================================
procedure TfrmUserHomePage.btnHomePageHelpClick(Sender: TObject);
var
  tHelp: TextFile;
  sLine: string;
  sMessage: string;

begin
  sMessage := '========================================';
  AssignFile(tHelp, 'Help_UserHomePage.txt');

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

/// =========================== Log Out Button ==============================
procedure TfrmUserHomePage.btnLogOutClick(Sender: TObject);
{ The function of this code is to bring up a message dialog when the user clicks
  the 'Log Out' button. this is to make sure that the user really wants to log out,
  if the user selects yes the program will go on to log him/her out }
begin
  if MessageDlg(
    'Are you sure you want to leave your home page ? You will be logged out.',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  Begin
    frmUserHomePage.Close;
  End
  Else
  Begin
    Exit;
  End;

end;

/// =============================== Sponsors Button ==========================
procedure TfrmUserHomePage.btnSponsorsClick(Sender: TObject);
var
  tSponsors: TextFile;
  sLine: string;
  sMessage: string;

begin
  sMessage := '========================================';
  AssignFile(tSponsors, 'Sponsors.txt');

  try { Code that checks to see if the file about the sponsors can be opened
      - displays error if not }
    reset(tSponsors);
  Except
    ShowMessage('ERROR: The file regarding the sponsors could not be opened.');
    Exit;
  end;

  while NOT EOF(tSponsors) do
  begin
    Readln(tSponsors, sLine);
    sMessage := sMessage + #13 + sLine;

  end;
  sMessage := sMessage + #13 + '========================================';
  CloseFile(tSponsors);
  ShowMessage(sMessage);

end;

/// =============================== Veiw Leaderboards =========================
procedure TfrmUserHomePage.btnVeiwLeaderboardsClick(Sender: TObject);
begin
  frmUserHomePage.Hide;
  frmLeaderboards.ShowModal;
end;

/// ================================== Form Close =============================
procedure TfrmUserHomePage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowMessage('You have been sighned out of your account.');
  sLoggedInUser := '';
  { The function of this code is to 'sighn the user out', by changing the variable
    sLoggedInUser back to nothing (blank). This efectively sighns the user out,
    since the program no longer recodnizes the user as the one who sihned in, and
    the one who`s data it should use. }
  frmWelcome.Show;

end;

/// ================================= Form Show ===============================
procedure TfrmUserHomePage.FormShow(Sender: TObject);
begin
  // Change the Heading
  lblHomPageUsername.Caption := sLoggedInUser;

  // Procedure to show last Match
  ShowLastMatchPlayed;

  // Procedure for panels
  GetPanelsInfo;
end;

/// ============================ Procedure For Panels =========================
procedure TfrmUserHomePage.GetPanelsInfo;
var
  bUserDataFound: boolean;
begin

  dmAccounts.tblAccounts.First;
  bUserDataFound := false;
  while (NOT dmAccounts.tblAccounts.EOF) AND (bUserDataFound = false) do
  Begin
    // ------ User data Found ----------
    if sLoggedInUser = dmAccounts.tblAccounts['Username'] then
    Begin // pointer is now at correct place
      bUserDataFound := true;
      // Matches panels
      pnlMatchesPlayed.Caption := dmAccounts.tblAccounts
        ['Total Matches Played'];
      pnlMatchesWon.Caption := dmAccounts.tblAccounts['Matches Won'];
      pnlMatchesLost.Caption := dmAccounts.tblAccounts['Matches Lost'];
      // Rounds panels
      pnlRoundsPlayed.Caption := dmAccounts.tblAccounts['Total Rounds Played'];
      pnlRoundsWon.Caption := dmAccounts.tblAccounts['Rounds Won'];
      pnlRoundsLost.Caption := dmAccounts.tblAccounts['Rounds Lost'];
      // Kills + Deaths Panel
      pnlKills.Caption := dmAccounts.tblAccounts['Kills'];
      pnlDeaths.Caption := dmAccounts.tblAccounts['Deaths'];
      if StrToInt(pnlDeaths.Caption) = 0 then // dividing by 0 is impossible
      begin
        pnlKD.Caption := '0';
      end
      else
      Begin

        pnlKD.Caption := FloatToStrF(StrToInt(pnlKills.Caption) / StrToInt
            (pnlDeaths.Caption), ffFixed, 5, 2);
      End;
    End
    else // --------- User data not found, NEXT ------
    Begin
      dmAccounts.tblAccounts.Next;
    End;
  End; // End of searching for data

  if bUserDataFound = false then // Username was not found
  Begin
    ShowMessage('Your data could not be located');
  End;
end;

/// ============== Proceduere to show the user`s match history ================
procedure TfrmUserHomePage.ShowLastMatchPlayed;
{ The function of tis piece of code is to locate the user`s spesific match
  history file and display it to him/her. Each user has his/her own match history
  file that is created upon signhing up. This file keep the results of each match
  the user has partaken in, including the players, time, date, and the winner }
var
  tUserMatchHistory: TextFile;
  sLine: string;
  sFileName: string;

begin
  redLastMatch.Lines.Clear;
  sFileName := 'UserMatchHistory_' + sLoggedInUser + '.txt';
  AssignFile(tUserMatchHistory, sFileName);

  Try
    reset(tUserMatchHistory);
  except
    ShowMessage('ERROR: Your match history records could not be located.');
  End;

  while not EOF(tUserMatchHistory) do
  Begin
    Readln(tUserMatchHistory, sLine);

    // If the user won, diplay the line in green
    if sLine = 'The winner was: ' + sLoggedInUser then
    begin
      redLastMatch.SelAttributes.Color := clGreen;
      redLastMatch.Lines.Add(sLine + '  -  YOU WON');
    end
    else
    Begin // If the line contains 'Account Created' is the first record in the file
      // and should be diplayed in red to indicate this to the user
      if Copy(sLine, 1, 16) = 'Account Created:' then
      Begin
        redLastMatch.SelAttributes.Color := clRed;
        redLastMatch.Lines.Add(sLine);
      End
      else
      Begin
        redLastMatch.Lines.Add(sLine);
      End;
    End;

  End; // while not EOF(tLastMatchFile)

  CloseFile(tUserMatchHistory);

end;

// ======================== Delete Account ==================================
procedure TfrmUserHomePage.btnDeleteAccountClick(Sender: TObject);
var
  sFileName: string;
  tUserMatchHistory: TextFile;
begin

  Begin
    if MessageDlg('Are you sure you want to permanently delete your account?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Begin
      dmAccounts.tblAccounts.DisableControls;
      dmAccounts.tblAccounts.First;
      while not dmAccounts.tblAccounts.EOF do
      Begin
        // username found
        if frmUserHomePage.sLoggedInUser = dmAccounts.tblAccounts['Username']
          then
        Begin
          // Close off the user`s match history
          sFileName := 'UserMatchHistory_' + frmUserHomePage.sLoggedInUser +
            '.txt';
          AssignFile(tUserMatchHistory, sFileName);
          try
            Append(tUserMatchHistory); // Try and add to the user`s match history
          except
            ShowMessage('ERROR: Your match history file could not be located');
          end;
          // Shows that these records are to a user who does no longer exist
          Writeln(tUserMatchHistory,
            '=========================================================');
          Writeln(tUserMatchHistory, '##### ACCOUNT DELETED #####');
          // Adds the date and time of deletion
          Writeln(tUserMatchHistory, 'Date:    ' + DateToStr(Date));
          Writeln(tUserMatchHistory, 'Time:    ' + TimeToStr(Time));
          Writeln(tUserMatchHistory,
            '=========================================================');
          CloseFile(tUserMatchHistory);
          //
          dmAccounts.tblAccounts.Delete; // Delete the user from the database
          ShowMessage('Your account has been deleted.');
          frmUserHomePage.Close;
        End
        Else
          // username not yet found
          dmAccounts.tblAccounts.Next;
      End; // while not dmAccounts.tblAccounts.EOF do
    End
    Else
    begin
      Exit; // User chose not to delte his/her account
    end;
  End;

end;

// ====================== Super Secret Bonus Easter Egg =======================
procedure TfrmUserHomePage.imgHomePageShieldClick(Sender: TObject);
begin
  ShowMessage
    ('Congrats, you found the hidden easter egg. Bonus points for you.');
  Windows.beep(440, 500);
  Windows.beep(440, 500);
  Windows.beep(440, 500);
  Windows.beep(349, 350);
  Windows.beep(523, 150);
  Windows.beep(440, 500);
  Windows.beep(349, 350);
  Windows.beep(523, 150);
  Windows.beep(440, 1000);
  Windows.beep(659, 500);
  Windows.beep(659, 500);
  Windows.beep(659, 500);
  Windows.beep(698, 350);
  Windows.beep(523, 150);
  Windows.beep(415, 500);
  Windows.beep(349, 350);
  Windows.beep(523, 150);
  Windows.beep(440, 1000);
  ShowMessage('Not really.');
end;

end.
