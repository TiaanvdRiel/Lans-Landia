// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit frmLeaderboards_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Mask, DBCtrls, ComCtrls,
  pngimage;

type
  TfrmLeaderboards = class(TForm)
    pnlLeaderboardsHeading: TPanel;
    pnlLeaderboardsLeft: TPanel;
    pnlLeaderboardsRight: TPanel;
    lblYouAreCurrRanked: TLabel;
    lblDispTotalCompetators: TLabel;
    pnlDisplayRank: TPanel;
    btnLeaderboardsHelp: TButton;
    edtSearchUSername: TLabeledEdit;
    btnBack: TButton;
    dbnAccounts: TDBNavigator;
    lblIDInfo: TLabel;
    DBEdit1: TDBEdit;
    lblUsernameInfo: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    lblSurnameInfo: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    lblMatchesWInInfo: TLabel;
    DBEdit6: TDBEdit;
    lblMacthesLostInfo: TLabel;
    DBEdit7: TDBEdit;
    lblTotalRoundsInfo: TLabel;
    DBEdit8: TDBEdit;
    lblRoundsWonInfo: TLabel;
    DBEdit9: TDBEdit;
    lblRoundsLostInfo: TLabel;
    DBEdit10: TDBEdit;
    dbgAccounts: TDBGrid;
    lblUsername: TLabel;
    btnHighestWdivM: TButton;
    btnUserWdivM: TButton;
    lblUserMostRoundsWon: TLabel;
    Panel1: TPanel;
    redTop10: TRichEdit;
    Label11: TLabel;
    btnKD: TButton;
    lblKillsInfo: TLabel;
    DBEdit11: TDBEdit;
    lblDeathsInfo: TLabel;
    DBEdit12: TDBEdit;
    imgLeaderboardLogo: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLeaderboardsHelpClick(Sender: TObject);
    procedure edtSearchUSernameChange(Sender: TObject);
    procedure btnHighestWdivMClick(Sender: TObject);
    procedure btnUserWdivMClick(Sender: TObject);
    procedure btnKDClick(Sender: TObject);
    // procedure btnSortaLeaderboardClick(Sender: TObject);

  private
    { Private declarations }
    iTotalNumAccounts: integer;
    // Custom procedures
    procedure GetTotalNumAccounts;
    procedure GetMostRoundsWonPlayer;
    procedure DetermineUserRank;
    procedure ShowTop10;

  public
    { Public declarations }
  end;

var
  frmLeaderboards: TfrmLeaderboards;

implementation

Uses
  frmUserHomePage_u, dmAccounts_u;
{$R *.dfm}

/// ================================= Exit Button =============================
procedure TfrmLeaderboards.btnBackClick(Sender: TObject);
begin
  frmLeaderboards.Close;
end;

/// ===================== Highest ration W per M played =======================
procedure TfrmLeaderboards.btnHighestWdivMClick(Sender: TObject);
{ This procedure calculates the player with the highest ratio of matches won
  to matches played }
var
  iMatchesPlayed: integer;
  iMatchesWon: integer;
  rMaxWonDivPlayed: real;
  rCurrWonDivPlayed: real;
  sMaxUsername: string;

begin
  // enter data for first user - initialise
  dmAccounts.tblAccounts.First;
  dmAccounts.tblAccounts.DisableControls;
  iMatchesPlayed := dmAccounts.tblAccounts['Total Matches Played'];
  iMatchesWon := dmAccounts.tblAccounts['Matches Won'];
  rMaxWonDivPlayed := iMatchesWon / iMatchesPlayed;
  sMaxUsername := dmAccounts.tblAccounts['Username'];

  // search through the database
  while not dmAccounts.tblAccounts.Eof do
  Begin
    // Get data from current player
    iMatchesPlayed := dmAccounts.tblAccounts['Total Matches Played'];
    iMatchesWon := dmAccounts.tblAccounts['Matches Won'];

    // 0 divided by 0 will give back an error
    if (iMatchesPlayed = 0) AND (iMatchesWon = 0) then
    begin
      dmAccounts.tblAccounts.Next;
    end
    else
    Begin

      rCurrWonDivPlayed := iMatchesWon / iMatchesPlayed;
      /// If two players both have the highest ratio
      if rCurrWonDivPlayed = rMaxWonDivPlayed then
      Begin
        sMaxUsername := sMaxUsername + ' and ' + dmAccounts.tblAccounts
          ['Username'];
      End;

      if rCurrWonDivPlayed > rMaxWonDivPlayed then
      Begin
        rMaxWonDivPlayed := rCurrWonDivPlayed;
        sMaxUsername := dmAccounts.tblAccounts['Username'];
      End; // rCurrPlayedDivWon > rMaxPlayedDivWon

      dmAccounts.tblAccounts.Next;
    End;

  End; // while not dmAccounts.tblAccounts.Eof do
  dmAccounts.tblAccounts.EnableControls;
  dmAccounts.tblAccounts.First;
  // Output
  ShowMessage(sMaxUsername +
      ' has the highesr ratio of matches won to matches played at ' +
      FloatToStrF(rMaxWonDivPlayed, ffGeneral, 3, 3));

end;

/// ======================== Highest KD =======================================
procedure TfrmLeaderboards.btnKDClick(Sender: TObject);
{ This procedure calculates the player with the highest ratio of kills to
  deaths }
var
  iKills: integer;
  iDeaths: integer;
  rMaxKD: real;
  rCurrKD: real;
  sMaxUsername: string;

begin
  // enter data for first user - initialise
  dmAccounts.tblAccounts.First;
  dmAccounts.tblAccounts.DisableControls;
  iKills := dmAccounts.tblAccounts['Kills'];
  iDeaths := dmAccounts.tblAccounts['Deaths'];
  rMaxKD := iKills / iDeaths;
  sMaxUsername := dmAccounts.tblAccounts['Username'];

  // search through the database
  while not dmAccounts.tblAccounts.Eof do
  Begin
    // Get data from current player
    iKills := dmAccounts.tblAccounts['Kills'];
    iDeaths := dmAccounts.tblAccounts['Deaths'];

    // 0 divided by 0 will give back an error
    if (iKills = 0) AND (iDeaths = 0) then
    begin
      dmAccounts.tblAccounts.Next;
    end
    else
    Begin

      rCurrKD := iKills / iDeaths;
      /// If two players both have the highest ratio
      if rCurrKD = rMaxKD then
      Begin
        sMaxUsername := sMaxUsername + ' and ' + dmAccounts.tblAccounts
          ['Username'];
      End;

      if rCurrKD > rMaxKD then
      Begin
        rMaxKD := rCurrKD;
        sMaxUsername := dmAccounts.tblAccounts['Username'];
      End; // rCurrPlayedDivWon > rMaxPlayedDivWon

      dmAccounts.tblAccounts.Next;
    End;

  End; // while not dmAccounts.tblAccounts.Eof do
  dmAccounts.tblAccounts.EnableControls;
  dmAccounts.tblAccounts.First;
  // Output
  ShowMessage(sMaxUsername + ' has the highest K/D at ' + FloatToStrF
      (rMaxKD, ffGeneral, 3, 3));

end;

/// ================================= Help Button =============================
procedure TfrmLeaderboards.btnLeaderboardsHelpClick(Sender: TObject);
var
  tHelp: TextFile;
  sLine: string;
  sMessage: string;

begin
  sMessage := '========================================';
  AssignFile(tHelp, 'Help_Leaderboards.txt');

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

/// ==================== Calculate user Win to Match ratio ====================
procedure TfrmLeaderboards.btnUserWdivMClick(Sender: TObject);
{ This procedure calculates the user`s own ratio of matches won to matches
  played }
var
  rUserWdivM: real;
begin

  dmAccounts.tblAccounts.First;
  while not dmAccounts.tblAccounts.Eof do
  Begin
    if frmUserHomePage.sLoggedInUser = dmAccounts.tblAccounts['Username'] then
    Begin
      if dmAccounts.tblAccounts['Total Matches Played'] = 0 then
      // dividing by 0 gives an error
      Begin
        ShowMessage(frmUserHomePage.sLoggedInUser +
            ' your ratio of matches won to matches played is 0.00');
      End
      else
      Begin

        rUserWdivM := dmAccounts.tblAccounts['Matches Won']
          / dmAccounts.tblAccounts['Total Matches Played'];
        ShowMessage(frmUserHomePage.sLoggedInUser +
            ' your ratio of matches won to matches played is ' + FloatToStrF
            (rUserWdivM, ffGeneral, 3, 3));
        Exit;
      End;
    End;
    dmAccounts.tblAccounts.Next;
  End;
  dmAccounts.tblAccounts.First;
end;

/// =============================== Username Search ===========================
procedure TfrmLeaderboards.edtSearchUSernameChange(Sender: TObject);
{ This porcedure is used to search, and filter the table of accounts, to
  display the smilar usernames, as the user types a username into the edit field }
begin
  if (edtSearchUSername.Text <> '') then
  Begin
    dmAccounts.tblAccounts.Filter := 'Username LIKE ''' +
      (edtSearchUSername.Text) + '%''     ';
    dmAccounts.tblAccounts.Filtered := True;
  End
  else
  begin
    dmAccounts.tblAccounts.Filtered := False;
  end;
end;

/// ================================== Form Close =============================
procedure TfrmLeaderboards.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmUserHomePage.Show;
end;

/// ================================== Form Show ==============================
procedure TfrmLeaderboards.FormShow(Sender: TObject);
begin
  lblUsername.Caption := frmUserHomePage.sLoggedInUser;
  lblUsername.Width := 150;
  dmAccounts.tblAccounts.Sort := '[Matches Won] DESC';
  dmAccounts.tblAccounts.First;

  // Procedure to get the total number of accounts
  GetTotalNumAccounts;
  lblDispTotalCompetators.Caption := 'Out of ' + IntToStr(iTotalNumAccounts)
    + ' competators';

  // Procedure to get player who won most rounds
  GetMostRoundsWonPlayer;
  dmAccounts.tblAccounts.First;

  // Procedure to show user`s rank
  DetermineUserRank;

  // Procedure to show top 10 players
  ShowTop10;
  dmAccounts.tblAccounts.First;

  // dmAccounts.tblAccounts.EnableControls;
end;

/// =========================== Show user`s rank ==============================
procedure TfrmLeaderboards.DetermineUserRank;
{ This procedure calculates the user`s rank, based upon matches won, by
  calculating the number of users who have won more matches than him/her }
var
  iRank: integer;
begin

  dmAccounts.tblAccounts.First;
  iRank := 1;
  while not dmAccounts.tblAccounts.Eof do
  Begin
    if frmUserHomePage.sLoggedInUser = dmAccounts.tblAccounts['Username'] then
    Begin
      pnlDisplayRank.Caption := IntToStr(iRank);
      Exit;
    End;
    iRank := iRank + 1;
    dmAccounts.tblAccounts.Next;
  End;

end;

/// =========================== Procedure get total Accounts ==================
procedure TfrmLeaderboards.GetTotalNumAccounts;
begin

  dmAccounts.tblAccounts.First;
  iTotalNumAccounts := 0;
  while not dmAccounts.tblAccounts.Eof do
  Begin
    iTotalNumAccounts := iTotalNumAccounts + 1;
    dmAccounts.tblAccounts.Next;
  End;

  dmAccounts.tblAccounts.First;
end;

/// =============== Procedure to get player who won most rounds ===============
procedure TfrmLeaderboards.GetMostRoundsWonPlayer;
{ This procedure alternatively determines the player who has won the most rounds,
  since this is not nesseceraly the same as the user who has won the most matches }
var
  iMaxRoundsWon: integer;
  iCurrRoundsWon: integer;
  sMaxUsername: string;
begin
  // enter data for first user - initialise
  dmAccounts.tblAccounts.First;
  iMaxRoundsWon := dmAccounts.tblAccounts['Rounds Won'];
  sMaxUsername := dmAccounts.tblAccounts['Username'];

  while not dmAccounts.tblAccounts.Eof do
  Begin
    // Get data from current player
    iCurrRoundsWon := dmAccounts.tblAccounts['Rounds Won'];

    if iCurrRoundsWon = iMaxRoundsWon then
    Begin
      sMaxUsername := sMaxUsername + ' and ' + dmAccounts.tblAccounts
        ['Username'];
    End;

    if iCurrRoundsWon > iMaxRoundsWon then
    Begin
      iMaxRoundsWon := iCurrRoundsWon;
      sMaxUsername := dmAccounts.tblAccounts['Username'];
    End; // iCurrRoundsWon > iMaxRoundsWon

    dmAccounts.tblAccounts.Next;

  End; // while not dmAccounts.tblAccounts.Eof do

  lblUserMostRoundsWon.Caption := sMaxUsername +
    ' has won the most rounds with ' + IntToStr(iMaxRoundsWon) + ' rounds won.';
  lblUserMostRoundsWon.Width := 203;
end;

/// ========================== Procedure to show top 10 ======================
procedure TfrmLeaderboards.ShowTop10;
{ This procedure displayes the top 10 best contetstants, based uppon matches
  won, by reading the first 10 usernames from the table, after it has been sorted
  from the best to the worst player, and then outputs these names to a rich edit
  - If the logged in user`s name appears on the list it will be displayed in green }
var
  sUserToAdd: string;
  iIndex: integer;
begin
  redTop10.Lines.Clear;
  redTop10.Lines.Add('========================');
  redTop10.SelAttributes.Color := clBlue;
  redTop10.Lines.Add('Top 10 Users by Matches Played:');
  redTop10.Lines.Add('========================');

  dmAccounts.tblAccounts.First;
  while not dmAccounts.tblAccounts.Eof do
  Begin
    for iIndex := 1 to 10 do
    Begin
      sUserToAdd := dmAccounts.tblAccounts['Username'];
      /// If the user is on the list
      if sUserToAdd = frmUserHomePage.sLoggedInUser then
      begin
        redTop10.SelAttributes.Color := clGreen;
        redTop10.Lines.Add(IntToStr(iIndex) + '. ' + sUserToAdd + '   -  YOU');
        dmAccounts.tblAccounts.Next;
      end
      else
      Begin
        redTop10.Lines.Add(IntToStr(iIndex) + '. ' + sUserToAdd);
        dmAccounts.tblAccounts.Next;
      End;
    End;
    redTop10.Lines.Add('========================');
    Exit;
  End;

end;

end.
