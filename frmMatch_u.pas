// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit frmMatch_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, math;

const
  MAXNUM = 8;

type
  TfrmMatch = class(TForm)
    pnlMatchHeading: TPanel;
    imgMatchBackground: TImage;
    lblChampion: TLabel;
    lblRound1: TLabel;
    lblRound2: TLabel;
    lblRound3: TLabel;
    lblRound4: TLabel;
    lblRound5: TLabel;
    lblRound6: TLabel;
    lblRound7: TLabel;
    lblROund9: TLabel;
    lblRound10: TLabel;
    lblRound12: TLabel;
    lblRound13: TLabel;
    lblRound14: TLabel;
    lblRound8: TLabel;
    lblRound11: TLabel;
    btnExitMatch: TButton;
    btnMatchHelp: TButton;
    btnStartMatch: TButton;
    lblCurrentRound: TLabel;
    pnlCurrentRound: TPanel;
    btnNextRound: TButton;
    lblUsername: TLabel;
    imgMatchLogo: TImage;
    rb1_1: TRadioButton;
    rb2_1: TRadioButton;
    rb2_2: TRadioButton;
    rb3_1: TRadioButton;
    rb3_2: TRadioButton;
    rb4_1: TRadioButton;
    rb4_2: TRadioButton;
    rb1_2: TRadioButton;
    rb10_2: TRadioButton;
    rb6_2: TRadioButton;
    rb6_1: TRadioButton;
    rb5_2: TRadioButton;
    rb5_1: TRadioButton;
    rb8_2: TRadioButton;
    rb8_1: TRadioButton;
    rb7_2: TRadioButton;
    rb7_1: TRadioButton;
    rb10_1: TRadioButton;
    rb9_2: TRadioButton;
    rb9_1: TRadioButton;
    rb12_2: TRadioButton;
    rb12_1: TRadioButton;
    rb11_2: TRadioButton;
    rb11_1: TRadioButton;
    rb14_1: TRadioButton;
    rb14_2: TRadioButton;
    rb13_2: TRadioButton;
    rb13_1: TRadioButton;
    lblUserRoundsLost: TLabel;
    lblUserRoundsPlayed: TLabel;
    lblUserRoundsWon: TLabel;
    lblUserKills: TLabel;
    lblUserDeaths: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitMatchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMatchHelpClick(Sender: TObject);
    procedure btnStartMatchClick(Sender: TObject);
    procedure btnNextRoundClick(Sender: TObject);

  private
    { Private declarations }
    arrContestants: array [1 .. MAXNUM] of string;
    iCurrRound: integer;
    //
    iUserNumRoundsPlayed: integer;
    iUserNumRoundsWon: integer;
    iUserNumRoundsLost: integer;
    iUserNumKills: integer;
    iUserNumDeaths: integer;
    //
    sRoundWinner: string;
    sRoundLoser: string;
    // Custom procedures
    procedure MovePlayersToNextMatch; // Moves the two players from the curent match to the appropriate next match
    procedure UpdateUserMatchHistory; // Procedure that adds the results of the match to the user`s personal match history
    procedure UpdateLansLandiaWebsite; // Procedure that adds the results of every match to the event`s website
    procedure UpdateAccountRecords; // Procedure that adds the results of the match to the user`s account in the database
    procedure PopulateContestantsArray; // Randomly chooses 7 other contestants to compete against
  public
    { Public declarations }
  end;

var
  frmMatch: TfrmMatch;

implementation

uses
  frmUserHomePage_u, dmAccounts_u;
{$R *.dfm}

/// =================== Procedure to populate contestants array ==============
procedure TfrmMatch.PopulateContestantsArray;
Var
  i: integer;
  iTotalNumAccounts: integer;
  iRandomPlayerID: integer;
  sRandomAccountUsername: string;
  iArr: integer;
  bAlreadyExistInArray: boolean;
  bRandomUserNameFound: boolean;
begin
  arrContestants[1] := '';
  arrContestants[2] := '';
  arrContestants[3] := '';
  arrContestants[4] := '';
  arrContestants[5] := '';
  arrContestants[6] := '';
  arrContestants[7] := '';
  arrContestants[8] := '';

  /// Get total num accounts
  dmAccounts.tblAccounts.First;
  iTotalNumAccounts := 0;
  while not dmAccounts.tblAccounts.Eof do
  Begin
    iTotalNumAccounts := iTotalNumAccounts + 1;
    dmAccounts.tblAccounts.Next;
  End;
  dmAccounts.tblAccounts.First;
  ///
  /// Enter the user into the array of contetstants
  arrContestants[1] := frmUserHomePage.sLoggedInUser;

  Randomize;
  i := 2;
  While i <= MAXNUM do
  Begin
    // get a random username
    iRandomPlayerID := RandomRange(1, iTotalNumAccounts + 1);
    dmAccounts.tblAccounts.First;
    dmAccounts.tblAccounts.DisableControls;
    bRandomUserNameFound := False;
    while (not dmAccounts.tblAccounts.Eof) AND (bRandomUserNameFound = False) do
    Begin
      if iRandomPlayerID = dmAccounts.tblAccounts['Player ID'] then
      Begin
        sRandomAccountUsername := dmAccounts.tblAccounts['Username'];
        bRandomUserNameFound := True;
      End
      else
      begin
        dmAccounts.tblAccounts.Next;
      end;
    End; // while not dmAccounts.tblAccounts.Eof  AND bRandomUserNameFound = False

    // check if already exists
    bAlreadyExistInArray := False;
    iArr := 1;
    while (bAlreadyExistInArray = False) AND (iArr <= 8) do
    Begin
      if arrContestants[iArr] = sRandomAccountUsername then
      Begin
        bAlreadyExistInArray := True;
      End
      else
      begin
        iArr := iArr + 1;
      end;
    end;

    // If the user is a new user add him/her to the array
    if bAlreadyExistInArray = False then
    Begin
      arrContestants[i] := sRandomAccountUsername;
      i := i + 1;
    End;

  End; // while

  rb1_1.Caption := arrContestants[1];
  rb1_2.Caption := arrContestants[2];
  rb2_1.Caption := arrContestants[3];
  rb2_2.Caption := arrContestants[4];
  rb3_1.Caption := arrContestants[5];
  rb3_2.Caption := arrContestants[6];
  rb4_1.Caption := arrContestants[7];
  rb4_2.Caption := arrContestants[8];
end;

/// =========================== Button start match ===========================
procedure TfrmMatch.btnStartMatchClick(Sender: TObject);
begin
  PopulateContestantsArray;
  btnStartMatch.Enabled := False;
  iCurrRound := 1;
  pnlCurrentRound.Enabled := True;
  pnlCurrentRound.Caption := IntToStr(iCurrRound);

  rb1_1.Enabled := True;
  rb1_2.Enabled := True;
  btnNextRound.Enabled := True;
  lblUserRoundsPlayed.Enabled := True;
  lblUserRoundsLost.Enabled := True;
  lblUserRoundsWon.Enabled := True;
  lblUserKills.Enabled := True;
  lblUserDeaths.Enabled := True;
  iUserNumRoundsPlayed := 0;
  iUserNumRoundsWon := 0;
  iUserNumRoundsLost := 0;
  iUserNumKills := 0;
  iUserNumDeaths := 0;
end;

/// ============================== Next Match Button ==========================
procedure TfrmMatch.btnNextRoundClick(Sender: TObject);
var
  // variables used to store the component names of the two users that are competing in the current round
  rbCompetator1: TRadioButton;
  rbCompetator2: TRadioButton;

  iTempKillsAdded: integer;
  iTempDeathsAdded: integer;

begin
  { The function of the code bellow is to find the two competators who are
    competing in the current match. The Radio Buttons are named in a way wich
    makes it possible to locate the users by using a variable (iCurrMacth). The
    names are constructed as follows: 'rb' + the round at whis their names are +
    either a '_1' fisrt posistion in round, or a '_2', second posistion in round. }
  rbCompetator1 := FindComponent('rb' + IntToStr(iCurrRound) + '_1')
    as TRadioButton;
  rbCompetator2 := FindComponent('rb' + IntToStr(iCurrRound) + '_2')
    as TRadioButton;
  { }

  // Checks that a winner is select
  if (rbCompetator1.Checked = False) AND (rbCompetator2.Checked = False) then
  begin
    ShowMessage('Please select a winner for the current round.');
    Exit;
  end;

  // Gets the winner and loser for the round
  if rbCompetator1.Checked = True then
  begin
    sRoundWinner := rbCompetator1.Caption;
    sRoundLoser := rbCompetator2.Caption;
  end;
  if rbCompetator2.Checked = True then
  begin
    sRoundWinner := rbCompetator2.Caption;
    sRoundLoser := rbCompetator1.Caption;
  end;

  // Checks to see if the user won or lost the current round ( if he won or lost
  // he must have also competed )
  if sRoundWinner = frmUserHomePage.sLoggedInUser then
  Begin
    iUserNumRoundsWon := iUserNumRoundsWon + 1;
    iUserNumRoundsPlayed := iUserNumRoundsPlayed + 1;
    iTempKillsAdded := 10; // you need 10 kills to win
    iUserNumKills := iUserNumKills + iTempKillsAdded;
    iTempDeathsAdded := RandomRange(1, 9); // gives the user a random amount of deaths, but not enough so that his component won
    iUserNumDeaths := iUserNumDeaths + iTempDeathsAdded;
    ShowMessage('YOU WON agianst ' + sRoundLoser + ' in round ' + IntToStr
        (iCurrRound) + '.' + #13 + 'Kills: +' + IntToStr(iTempKillsAdded)
        + #13 + 'Deaths: +' + IntToStr(iTempDeathsAdded));
  End
  else if sRoundLoser = frmUserHomePage.sLoggedInUser then
  begin
    iUserNumRoundsLost := iUserNumRoundsLost + 1;
    iUserNumRoundsPlayed := iUserNumRoundsPlayed + 1;
    iTempDeathsAdded := 10; // for his opponent to have won he must have gotten 10 kills
    iUserNumDeaths := iUserNumDeaths + iTempDeathsAdded;
    iTempKillsAdded := RandomRange(1, 9); // gives the user some kills, but not enough to have won the round
    iUserNumKills := iUserNumKills + iTempKillsAdded;
    ShowMessage('YOU LOST agianst ' + sRoundWinner + ' in round ' + IntToStr
        (iCurrRound) + '.' + #13 + 'Kills: +' + IntToStr(iTempKillsAdded)
        + #13 + 'Deaths: +' + IntToStr(iTempDeathsAdded));
  end
  else
  begin
    ShowMessage(sRoundWinner + ' won and ' + sRoundLoser + ' lost round ' +
        IntToStr(iCurrRound) + '.');
  end;

  // Updates the labels that diplays the users information about the match
  lblUserRoundsPlayed.Caption := 'Rounds You Have Played: ' + IntToStr
    (iUserNumRoundsPlayed);
  lblUserRoundsWon.Caption := 'Rounds You Have Won: ' + IntToStr
    (iUserNumRoundsWon);
  lblUserRoundsLost.Caption := 'Rounds You Have Lost: ' + IntToStr
    (iUserNumRoundsLost);
  lblUserKills.Caption := 'Kills You Have Made: ' + IntToStr(iUserNumKills);
  lblUserDeaths.Caption := 'Deaths You Have Had: ' + IntToStr(iUserNumDeaths);

  // If it is the last round
  if iCurrRound = 14 then
  begin
    lblChampion.Caption := sRoundWinner;
    if lblChampion.Caption = frmUserHomePage.sLoggedInUser then
    Begin
      ShowMessage('YOU WON THE MATCH !!!'); // If the user wins show him/her a nice victory
    End
    else
    Begin
      ShowMessage(lblChampion.Caption + ' won the match.');
      // else just show match winner
    End;
    rbCompetator1.Enabled := False;
    rbCompetator2.Enabled := False;
    pnlCurrentRound.Enabled := False;
    //
    UpdateUserMatchHistory; // Put results of the match into the user`s personal match history
    //
    UpdateLansLandiaWebsite; // Procedure that adds the results of every match to the event`s website
    //
    UpdateAccountRecords; // Procedure that adds the results of the match to the user`s account in the database
    //
    btnNextRound.Enabled := False;
    ShowMessage(
      'Match Complete. You can veiw te results of the match, and all other matches on our Website: www.Lans-Landia.com');
  end
  else
  begin

    // If there are still more rounds to go
    MovePlayersToNextMatch;
    // Disables the radio buttons for the current round
    rbCompetator1.Enabled := False;
    rbCompetator2.Enabled := False;
    // Finds the radio buttons for the next round
    rbCompetator1 := FindComponent('rb' + IntToStr(iCurrRound + 1) + '_1')
      as TRadioButton;
    rbCompetator2 := FindComponent('rb' + IntToStr(iCurrRound + 1) + '_2')
      as TRadioButton;
    // Enables the radio buttons for the next round
    rbCompetator1.Enabled := True;
    rbCompetator2.Enabled := True;
  end;

  if NOT(iCurrRound = 14) then
    iCurrRound := iCurrRound + 1;

  pnlCurrentRound.Caption := IntToStr(iCurrRound);

end;

/// ================ Moves the two players from the curent match to the
// appropriate next match =================================================
procedure TfrmMatch.MovePlayersToNextMatch;
{ The function of the code bellow is to move the winner and loser of each round
  to his/her appropriate posistion for the next round. This is possible thanks
  to the fact that the component names of the radio buttons are labled in such a
  way that it is possible to determine where it is situated - please check procedure
  above for information }
begin
  case iCurrRound of
    1: // Round  1
      Begin
        rb7_1.Caption := sRoundWinner;
        rb5_1.Caption := sRoundLoser;
      End;
    2:
      Begin
        rb7_2.Caption := sRoundWinner;
        rb5_2.Caption := sRoundLoser;
      End;
    3:
      Begin
        rb8_1.Caption := sRoundWinner;
        rb6_1.Caption := sRoundLoser;
      End;
    4:
      Begin
        rb8_2.Caption := sRoundWinner;
        rb6_2.Caption := sRoundLoser;
      End;
    5:
      Begin
        rb9_2.Caption := sRoundWinner; // elimination round
      End;
    6:
      Begin
        rb10_2.Caption := sRoundWinner; // elimination round
      End;
    7:
      Begin
        rb11_1.Caption := sRoundWinner;
        rb9_1.Caption := sRoundLoser;
      End;
    8:
      Begin
        rb11_2.Caption := sRoundWinner;
        rb10_1.Caption := sRoundLoser;
      End;
    9:
      Begin
        rb12_1.Caption := sRoundWinner; // elimination round
      End;
    10:
      Begin
        rb12_2.Caption := sRoundWinner; // elimination round
      End;
    11:
      Begin
        rb14_1.Caption := sRoundWinner;
        rb13_1.Caption := sRoundLoser;
      End;
    12:
      Begin
        rb13_2.Caption := sRoundWinner; // elimination round
      End;
    13:
      Begin
        rb14_2.Caption := sRoundWinner; // elimination round
      End;
  end;

end;

/// ==================== Procedure that adds the results of the match to the
/// user`s account in the database ============================================
procedure TfrmMatch.UpdateAccountRecords;
var
  bUsernameFound: boolean;
begin
  // Search for the username
  bUsernameFound := False;
  dmAccounts.tblAccounts.First;
  dmAccounts.tblAccounts.DisableControls;
  while (NOT(dmAccounts.tblAccounts.Eof)) AND (bUsernameFound = False) do
  Begin
    if dmAccounts.tblAccounts['Username'] = frmUserHomePage.sLoggedInUser then
    Begin // The username is found
      bUsernameFound := True;
    End
    else // The username is not found
    begin
      dmAccounts.tblAccounts.Next;
    end;
  End; // While

  // Add the records
  with dmAccounts do
  begin
    tblAccounts.Edit;
    // Update the number of rounds the user has played
    tblAccounts['Total Rounds Played'] := tblAccounts['Total Rounds Played']
      + iUserNumRoundsPlayed;
    tblAccounts['Rounds Won'] := tblAccounts['Rounds Won'] + iUserNumRoundsWon;
    tblAccounts['Rounds Lost'] := tblAccounts['Rounds Lost']
      + iUserNumRoundsLost;
    // Increses matches played by +1
    tblAccounts['Total Matches Played'] := tblAccounts['Total Matches Played']
      + 1;
    // Update the user`s number of kills and deaths
    tblAccounts['Kills'] := tblAccounts['Kills'] + iUserNumKills;
    tblAccounts['Deaths'] := tblAccounts['Deaths'] + iUserNumDeaths;
    // if the user won ad +1 to matches won, else +1 to matches lost
    if lblChampion.Caption = frmUserHomePage.sLoggedInUser then
    begin
      tblAccounts['Matches Won'] := tblAccounts['Matches Won'] + 1;
    end
    else
    begin
      tblAccounts['Matches Lost'] := tblAccounts['Matches Lost'] + 1;
    end;
    tblAccounts.Post;
  end; // end of  with dmAccounts do

  dmAccounts.tblAccounts.EnableControls;
end;

/// ============= Procedure that adds the results of every match to the
/// event`s website ===========================================================
procedure TfrmMatch.UpdateLansLandiaWebsite;
var
  tLansLandiaWebsite: TextFile;
  iInArray: integer;
  sLineToWrite: string;
begin

  AssignFile(tLansLandiaWebsite, 'LansLandiaWebsite.txt');

  try
    Append(tLansLandiaWebsite);
  except
    ShowMessage(
      'ERROR: The file containing the information regarding the event`s website could not be located');
    Exit;
  end;
  // Write the new information to the file
  Writeln(tLansLandiaWebsite, '<html>');
  // Write date
  Writeln(tLansLandiaWebsite,
    '<p align="center"><font color= #2874A6 face="verdana">');
  Writeln(tLansLandiaWebsite, 'Date: ' + DateToStr(Date));
  Writeln(tLansLandiaWebsite, '<br>');
  Writeln(tLansLandiaWebsite, '<br>');
  // Write Contestants
  for iInArray := 1 to 8 do
  begin
    sLineToWrite := IntToStr(iInArray) + '.) ' + arrContestants[iInArray];
    Writeln(tLansLandiaWebsite, sLineToWrite);
    Writeln(tLansLandiaWebsite, '<br>');
  end;
  Writeln(tLansLandiaWebsite, '	</font> </p>');
  // End of all the contestants who competed
  // The winner of the competition
  Writeln(tLansLandiaWebsite,
    '<p align="center"><font color = " red " face = " verdana ">');
  sLineToWrite := 'The winner was: ' + lblChampion.Caption;
  Writeln(tLansLandiaWebsite, sLineToWrite);
  Writeln(tLansLandiaWebsite, '</font></p>');
  Writeln(tLansLandiaWebsite, '<hr color= #2874A6>');
  Writeln(tLansLandiaWebsite, '</html>');
  CloseFile(tLansLandiaWebsite);
end;

/// ====================== Procedure that adds the results of the match to
/// the user`s personal match history ========================================
procedure TfrmMatch.UpdateUserMatchHistory;
var
  sFileName: string;
  tUserMatchHistory: TextFile;
  sLineToWrite: string;
  iInArray: integer;

begin
  sFileName := 'UserMatchHistory_' + frmUserHomePage.sLoggedInUser + '.txt';
  AssignFile(tUserMatchHistory, sFileName);

  try
    Append(tUserMatchHistory); // Try and add to the user`s match history
  except
    begin // If the user does not yet have one, create one
      ShowMessage(
        'You do not yet have a user match history. One has been created for you.');
      Rewrite(tUserMatchHistory);
      Writeln(tUserMatchHistory, 'Account Created: ' + DateToStr(Date));
      Writeln(tUserMatchHistory,
        '=========================================================');
    end;
  end;
  Writeln(tUserMatchHistory,
    '=========================================================');
  Writeln(tUserMatchHistory, 'Last Match You Played:');
  Writeln(tUserMatchHistory, 'Date:    ' + DateToStr(Date));
  Writeln(tUserMatchHistory, 'Time:    ' + TimeToStr(Time));
  Writeln(tUserMatchHistory, '');
  Writeln(tUserMatchHistory, 'Competators:');
  for iInArray := 1 to 8 do
  Begin
    sLineToWrite := IntToStr(iInArray) + '.) ' + arrContestants[iInArray];
    Writeln(tUserMatchHistory, sLineToWrite);
  End;
  Writeln(tUserMatchHistory, '');
  sLineToWrite := 'The winner was: ' + lblChampion.Caption;
  Writeln(tUserMatchHistory, sLineToWrite);
  Writeln(tUserMatchHistory, ' ');
  Writeln(tUserMatchHistory,
    '=========================================================');

  CloseFile(tUserMatchHistory);

end;

/// =========================== Exit Match Button ============================
procedure TfrmMatch.btnExitMatchClick(Sender: TObject);
begin
  if lblChampion.Caption <> 'Champion' then // the user closes the form after a winner has been determined
  begin
    frmMatch.close;
  end
  else
  begin
    if MessageDlg(
      'Are you sure you want to leave the match while it is ongoing? PLEASE NOTE: The match will be called off and you will be given a penalty match lost.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      frmMatch.close;
    end
    else
    begin
      Exit;
    end;
  end;
end;

/// ================================== Help Button ===========================
procedure TfrmMatch.btnMatchHelpClick(Sender: TObject);
var
  tHelp: TextFile;
  sLine: string;
  sMessage: string;

begin
  sMessage := '========================================';
  AssignFile(tHelp, 'Help_Match.txt');

  try { Code that checks to see if the file about the sponsors can be opened
      - displays error if not }
    Reset(tHelp);
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

/// ================================ Form Close ==============================
procedure TfrmMatch.FormClose(Sender: TObject; var Action: TCloseAction);
{ This code closes the form, after checking if it is closed before, during,
  or after a match. If the form is closed during the match it will count as
  an aoutomatic forfeit to the user, the match will be called off, and the user
  will be given a penatly match lost }
var
  bUsernameFound: boolean;
begin
  if lblChampion.Caption = 'Champion' then
  // the match is not yet over
  Begin
    ShowMessage(
      'You have forfeighted the match. You have been given a penalty match lost.');
    // Search for the username
    dmAccounts.tblAccounts.First;
    bUsernameFound := False;
    while (NOT dmAccounts.tblAccounts.Eof) AND (bUsernameFound = False) do
    Begin
      if dmAccounts.tblAccounts['Username'] = frmUserHomePage.sLoggedInUser then
      Begin
        bUsernameFound := True;
      End
      else
      begin
        dmAccounts.tblAccounts.Next;
      end;
    End;
    // end of searching for username
    with dmAccounts do
    begin
      tblAccounts.Edit;
      tblAccounts['Matches Lost'] := tblAccounts['Matches Lost'] + 1;
      tblAccounts.Post;
    end;
  End;

  frmUserHomePage.Show;
end;

/// ================================= Form Show ===============================
procedure TfrmMatch.FormShow(Sender: TObject);
begin
  lblUsername.Caption := frmUserHomePage.sLoggedInUser;
  lblUsername.Width := 250;
  btnStartMatch.Enabled := True;
  btnNextRound.Enabled := False;
  lblUserRoundsPlayed.Enabled := False;
  lblUserRoundsLost.Enabled := False;
  lblUserRoundsWon.Enabled := False;
  lblUserKills.Enabled := False;
  lblUserDeaths.Enabled := False;

end;

end.
