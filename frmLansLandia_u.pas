// ##################################
// ######     IT PAT 2017     #######
// ######       PHASE 3       #######
// ######  Tiaan van der Riel #######
// ##################################

unit frmLansLandia_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, MPlayer;

type
  TfrmWelcome = class(TForm)
    imgWelcomeBackgound: TImage;
    btnEnterTheKingdom: TButton;
    btnSponsors: TButton;
    btnBack: TButton;
    btnLogIn: TButton;
    btnCreateNewAccount: TButton;
    mpBackgroundMusic: TMediaPlayer;
    procedure btnSponsorsClick(Sender: TObject);
    procedure btnEnterTheKingdomClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnLogInClick(Sender: TObject);
    procedure btnCreateNewAccountClick(Sender: TObject);

  private
    { Private declarations }
    imgDynamicBackground: TImage;
    pnlWelcome: Tpanel;
  public
    { Public declarations }
  end;

var
  frmWelcome: TfrmWelcome;

implementation

uses
  frmLogIn_u, frmCreateNewAccount_u;
{$R *.dfm}

/// ==================== Back To Original Welcome Screen ==================
procedure TfrmWelcome.btnBackClick(Sender: TObject);
begin
  { The code below destroys the two dynamically created objects when the user
    clicks the button btnBack. It also hides and shows the appropriate obejcts
    by changing their .visable proparties(boolean) to True and False
    respectively. }
  imgDynamicBackground.Free;
  pnlWelcome.Free;

  btnEnterTheKingdom.Visible := True;
  btnSponsors.Visible := True;
  imgWelcomeBackgound.Visible := True;
  btnBack.Visible := False;
  btnLogIn.Visible := False;
  btnCreateNewAccount.Visible := False;
end;

/// ====================== Create A New Account =====================
procedure TfrmWelcome.btnCreateNewAccountClick(Sender: TObject);
begin
  /// Hide the Welcome screen and show the Create A New Account screen
  mpBackgroundMusic.stop;
  mpBackgroundMusic.Close;
  frmWelcome.Hide;
  frmCreateNewAccount.ShowModal;

  /// Set the Welcome screen back to the way it initially was
  imgDynamicBackground.Free;  // Destroys Dynamic Backround Image
  pnlWelcome.Free;            // Destroys Dynamic Panel
  btnEnterTheKingdom.Visible := True;
  btnSponsors.Visible := True;
  imgWelcomeBackgound.Visible := True;
  btnBack.Visible := False;
  btnLogIn.Visible := False;
  btnCreateNewAccount.Visible := False;

end;

/// ====================== Enter the Kingdom button =====================
procedure TfrmWelcome.btnEnterTheKingdomClick(Sender: TObject);
begin
  { The purpose of the code below is to, when the button btnEnterTheKingdom
    is clicked, hide all of the nescesasry objects, dynamically create the
    appropriate objects ( the background image and the panel ), and the show
    the accounpanying objects by making them visable. }
  btnEnterTheKingdom.Visible := False;
  btnSponsors.Visible := False;
  imgWelcomeBackgound.Visible := False;
  btnBack.Visible := True;
  btnLogIn.Visible := True;
  btnCreateNewAccount.Visible := True;

  /// Create Backround Image
  imgDynamicBackground := TImage.Create(frmWelcome);
  imgDynamicBackground.Parent := frmWelcome;
  With imgDynamicBackground do
  begin
    imgDynamicBackground.Picture.LoadFromFile('Image_DynamicBackground.jpeg');
    Anchors := [akTop, akBottom, akRight, akLeft];
    Stretch := True;
    Align := alClient;

    /// Create Welcome Panel
    pnlWelcome := Tpanel.Create(frmWelcome);
    pnlWelcome.Parent := frmWelcome;
    With pnlWelcome do
    Begin
      Caption := 'Welcome to the kingdom of gamers';
      Color := clHotLight;
      ParentColor := False;
      ParentBackground := False;
      Font.Size := 20;
      Font.Style := [fsBold];
      Height := 60;
      Align := alTop;
    End;
  end;

end;

/// ===================== Log in Button =================================
procedure TfrmWelcome.btnLogInClick(Sender: TObject);
begin
  /// Hide the Welcome screen and show the log in screen
  mpBackgroundMusic.stop;
  mpBackgroundMusic.Close;
  frmWelcome.Hide;
  frmLogIn.ShowModal;

  /// Set the Welcome screen back to the way it initially was
  imgDynamicBackground.Free;
  pnlWelcome.Free;
  btnEnterTheKingdom.Visible := True;
  btnSponsors.Visible := True;
  imgWelcomeBackgound.Visible := True;
  btnBack.Visible := False;
  btnLogIn.Visible := False;
  btnCreateNewAccount.Visible := False;

end;

/// ================ Information about sponsors ==========================
procedure TfrmWelcome.btnSponsorsClick(Sender: TObject);
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

/// ==================== Welcomne Form Gets activated ===================
procedure TfrmWelcome.FormActivate(Sender: TObject);
begin
  { When the Welcome form gets activated it makes only the appropriate objects
    visable and hides all of the ones that appear with the dynamically created
    ones. }
  btnEnterTheKingdom.Visible := True;
  btnSponsors.Visible := True;
  imgWelcomeBackgound.Visible := True;
  btnBack.Visible := False;
  btnLogIn.Visible := False;
  btnCreateNewAccount.Visible := False;
  /// Play background music
  mpBackgroundMusic.FileName := 'Medieval Folk Music.wav';
  mpBackgroundMusic.open;
  mpBackgroundMusic.play;
end;

end.
