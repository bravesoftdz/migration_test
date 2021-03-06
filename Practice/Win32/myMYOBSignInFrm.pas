unit myMYOBSignInFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PracticeLedgerObj, CashbookMigrationRestData,
  OSFont, contnrs;

type
  TFormShowType = (fsSignIn, fsSelectFirm, fsSelectClient, fsFirmForceSignIn);

  TmyMYOBSignInForm = class(TForm)
    pnlLogin: TPanel;
    lblEmail: TLabel;
    lblPassword: TLabel;
    lblForgotPassword: TLabel;
    edtEmail: TEdit;
    edtPassword: TEdit;
    pnlClientSelection: TPanel;
    ShapeBorder: TShape;
    Label1: TLabel;
    cmbSelectClient: TComboBox;
    pnlControls: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Shape2: TShape;
    pnlFirmSelection: TPanel;
    Label6: TLabel;
    Shape1: TShape;
    cmbSelectFirm: TComboBox;
    btnSignIn: TButton;

    procedure btnSignInClick(Sender: TObject);
    procedure lblForgotPasswordClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmbSelectFirmChange(Sender: TObject);
    procedure cmbSelectFirmEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFormShowType : TFormShowType;
    FShowFirmSelection : Boolean;
    FProcessingLogin : Boolean;
    FSelectedName: string;
    FSelectedID: string;
    FOldFirmID : string;
    FForcedSignInSucceed : Boolean;
    FIsSignIn : Boolean;
    FValidateClientAgainstFirm : Boolean;
    function LoadFirms:Boolean;
    procedure LoadBusinesses;
    procedure SaveUser;
    procedure UpdateControls;
    procedure SaveMyMYOBUserDetails;
    function ChangeFirm():Boolean;
    procedure ForceModelCancel;
  public
    { Public declarations }
    property FormShowType : TFormShowType read FFormShowType write FFormShowType;
    property ShowFirmSelection : Boolean read FShowFirmSelection write FShowFirmSelection;
    property ValidateClientAgainstFirm : Boolean read FValidateClientAgainstFirm write FValidateClientAgainstFirm;

    property SelectedID: string read FSelectedID write FSelectedID;
    property SelectedName : string read FSelectedName write FSelectedName;
  end;

var
  myMYOBSignInForm: TmyMYOBSignInForm;

const
  UNITNAME = 'myMYOBSignInFrm';

implementation

uses ShellApi, Globals, CashbookMigration, WarningMoreFrm, bkContactInformation,
  ErrorMoreFrm, SYDEFS, Admin32, LogUtil, AuditMgr, IniSettings,
  SelectBusinessFrm, YesNoDlg, bkConst,
  AppMessages;

{$R *.dfm}

procedure TmyMYOBSignInForm.btnCancelClick(Sender: TObject);
begin
  if not FProcessingLogin then  
    ModalResult := mrCancel;
end;

procedure TmyMYOBSignInForm.btnOKClick(Sender: TObject);
var
  Firm : TFirm;
begin
  if (FormShowType = fsSelectFirm) then
  begin
    if ((Trim(cmbSelectFirm.Items.Text) <> '') and (cmbSelectFirm.ItemIndex >= 0)) then
    begin
      Firm := TFirm(cmbSelectFirm.Items.Objects[cmbSelectFirm.ItemIndex]);
      if Assigned(Firm) then
      begin
        FSelectedID := Firm.ID;
        FSelectedName := Firm.Name;
      end;
    end;
  end;
  ModalResult := mrOk;
end;

procedure TmyMYOBSignInForm.btnSignInClick(Sender: TObject);
var
  liErrorCode : integer;
  lsErrorDescription: string;
  OldCursor: TCursor;
  InvalidPass: boolean;
begin
  if Not FIsSignIn then
  begin
    FIsSignIn := not FIsSignIn;
    UpdateControls;
    Exit;
  end;

  UpdateControls;
  Application.ProcessMessages;
  FProcessingLogin := True;
  FForcedSignInSucceed := False;
  OldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if CurrUser.MYOBEmailAddress <> Trim(edtEmail.Text) then
    begin
      SaveUser;

      PracticeLedger.Firms.Clear;
      PracticeLedger.Businesses.Clear;
    end;

    if not FileExists(GLOBALS.PublicKeysDir + PUBLIC_KEY_FILE_CASHBOOK_TOKEN) then
    begin
      HelpfulWarningMsg('File ' + GLOBALS.PublicKeysDir + PUBLIC_KEY_FILE_CASHBOOK_TOKEN + ' is missing in the folder', 0);
      Exit;
    end;

    PracticeLedger.RandomKey := UserINI_myMYOB_Random_Key;
    PracticeLedger.EncryptToken(UserINI_myMYOB_Access_Token);

    //my.MYOB login
    if not PracticeLedger.Login(edtEmail.Text, edtPassword.Text, liErrorCode,
             lsErrorDescription, InvalidPass) then
    begin
      Screen.Cursor := OldCursor;
      if InvalidPass then
        HelpfulWarningMsg(lsErrorDescription, 0)
      else
        HelpfulErrorMsg( PracticeLedger.ReturnGenericErrorMessage( liErrorCode ), 0 );

      if FormShowType in [fsFirmForceSignIn] then
      begin
        edtEmail.Enabled := False;
        edtPassword.Enabled := True;
        edtPassword.SetFocus;
      end
      else
        edtEmail.SetFocus;
    end
    else
    begin
      lblForgotPassword.Visible := True;
      FIsSignIn := not FIsSignIn;
      UpdateControls;
      SaveMyMYOBUserDetails;
      btnSignIn.Default := False;

      if (FormShowType in [fsSignIn, fsFirmForceSignIn, fsSelectFirm]) and (ShowFirmSelection) then
      begin
        // Get Firms
        if ((PracticeLedger.Firms.Count = 0) and
             (not PracticeLedger.GetFirms(PracticeLedger.Firms, liErrorCode,
                    lsErrorDescription))) then
        begin
          Screen.Cursor := OldCursor;
          HelpfulErrorMsg( PracticeLedger.ReturnGenericErrorMessage( liErrorCode ), 0 );
          ForceModelCancel;
          Exit;
        end;
        if (FormShowType = fsFirmForceSignIn) then
        begin
          ModalResult := mrOk;
          Exit;
        end;

        if PracticeLedger.CountEligibleFirms <= 0 then begin
          SelectedID   := '';
          SelectedName := '';

          HelpfulErrorMsg( errMYOBCredential, 0 );

          FIsSignIn := not FIsSignIn;
          UpdateControls;
          btnSignIn.Default := False;
          PracticeLedger.ResetMyMYOBUserDetails;
          if edtEmail.Enabled then
            edtEmail.Setfocus;
          Exit;
        end;

        FormShowType := fsSelectFirm;
        pnlFirmSelection.Visible := True;
        Self.Height := 250;
        btnOK.Visible := True;
        if not LoadFirms then
        begin
          ForceModelCancel;
          Exit;
        end;
      end;

      if ValidateClientAgainstFirm then
      begin
        {if not admin user and no firm is selected yet, show an error message and exit,
        only admin can choose a firm}

        if Trim(AdminSystem.fdFields.fdmyMYOBFirmID) = '' then
        begin
          if not CurrUser.IsAdminUser then
          begin
            begin
              Screen.Cursor := OldCursor;
              HelpfulWarningMsg( errNoMYOBFirmSelection, 0 );
              ForceModelCancel;
              Exit;
            end;
          end;
        end
        else if not PracticeLedger.MYOBUserHasAccesToFirm
              (AdminSystem.fdFields.fdmyMYOBFirmID, True)then
        begin
          Screen.Cursor := OldCursor;
          HelpfulWarningMsg( errMYOBCredential, 0 );
          PracticeLedger.ResetMyMYOBUserDetails;
          ForceModelCancel;
          Exit;
        end;
      end;

      if (FormShowType = fsSignIn) then
        btnOKClick(Self);
    end;
  finally
    Screen.Cursor := OldCursor;
    FProcessingLogin := False;
  end;
end;

function TmyMYOBSignInForm.ChangeFirm: Boolean;
var
  Firm : TFirm;
  iLoop : Integer;
begin
  Result := True;
  if cmbSelectFirm.Items.Count <= 0 then
    Exit;

  Firm := TFirm(cmbSelectFirm.Items.Objects[cmbSelectFirm.ItemIndex]);

  if not Assigned(Firm) then
    Exit;

  if FOldFirmID = Firm.ID then
    Exit;

  if FForcedSignInSucceed then
    Exit;

  if ((Trim(FSelectedID) <> '') and
      (Trim(FSelectedID) <> Firm.ID))
  then
  begin
    if not (AskYesNo('Change Firm',
                 'This change will affect the MYOB client setup done for all clients.'#13#13 +
                 'You need a MYOB sign in before changing the Firm.'#13#13+
                 'Do you want to continue?',DLG_YES, 0) = DLG_YES) then
    begin
      Result := False;
      for iLoop := 0 to cmbSelectFirm.Items.Count - 1 do
      begin
        Firm := TFirm(cmbSelectFirm.Items.Objects[iLoop]);
        if Assigned(Firm) and (FOldFirmID = Firm.ID) then
        begin
          cmbSelectFirm.ItemIndex := iLoop;
          Break;
        end;
      end;
      Exit;
    end;

    SelectedID := Firm.ID;
    SelectedName := Firm.Name;
    cmbSelectFirm.Enabled := False;
    FormShowType := fsFirmForceSignIn;
    FOldFirmID := SelectedID;

    FormShow(Self);
  end;
end;

procedure TmyMYOBSignInForm.cmbSelectFirmChange(Sender: TObject);
begin
  ChangeFirm;
end;

procedure TmyMYOBSignInForm.cmbSelectFirmEnter(Sender: TObject);
var
  Firm : TFirm;
begin
  if ( cmbSelectFirm.ItemIndex >= 0 ) then begin
    Firm := TFirm(cmbSelectFirm.Items.Objects[ cmbSelectFirm.ItemIndex ]);
    if not Assigned(Firm) then
      Exit;

    FOldFirmID := Firm.ID;
  end;
end;

procedure TmyMYOBSignInForm.ForceModelCancel;
begin
  PostMessage(Self.Handle,wm_close,0,0);
end;

procedure TmyMYOBSignInForm.FormCreate(Sender: TObject);
begin
  ShowFirmSelection := False;
  fValidateClientAgainstFirm := False;
end;

procedure TmyMYOBSignInForm.FormShow(Sender: TObject);
var
  liErrorCode: integer;
  lsErrorDescription: string;
  OldCursor: TCursor;
begin
  FIsSignIn := True;
  UpdateControls;
  FProcessingLogin := False;
  edtPassword.Text := '';
  edtEmail.Text := CurrUser.MYOBEmailAddress;
  if Trim(edtEmail.Text)= '' then
    edtEmail.Text := CurrUser.EmailAddress;

  pnlClientSelection.Visible := False;
  pnlFirmSelection.Visible := False;
  pnlLogin.Visible := False;
  btnOK.Visible := True;
  lblForgotPassword.Visible := True;

  case FormShowType of
    fsSignIn :
    begin
      pnlLogin.Visible := True;
      Self.Height := 185;
      btnOK.Visible := False;
      //lblForgotPassword.Visible := False;
    end;
    fsFirmForceSignIn :
    begin
      pnlLogin.Visible := True;
      pnlFirmSelection.Visible := True;
      Self.Height := 250;
      btnOK.Visible := False;
      edtEmail.Enabled := False;

      edtPassword.Enabled := True;
      edtPassword.SetFocus;
    end;
    fsSelectFirm :
    begin
      pnlFirmSelection.Visible := True;
      Self.Height := 150;
      OldCursor := Screen.Cursor;
      Screen.Cursor := crHourglass;
      try
        PracticeLedger.UnEncryptedToken := UserINI_myMYOB_Access_Token;
        PracticeLedger.RandomKey := UserINI_myMYOB_Random_Key;
        PracticeLedger.RefreshToken := UserINI_myMYOB_Refresh_Token;
        Application.ProcessMessages;
        // Get Firms
        if ((PracticeLedger.Firms.Count = 0) and
             (not PracticeLedger.GetFirms(PracticeLedger.Firms, liErrorCode,
                    lsErrorDescription))) then
        begin
          HelpfulErrorMsg( PracticeLedger.ReturnGenericErrorMessage( liErrorCode ), 0 );
          ForceModelCancel;
        end;

        if PracticeLedger.CountEligibleFirms <= 0 then begin
          HelpfulWarningMsg( errMYOBCredential, 0 );
          PracticeLedger.ResetMyMYOBUserDetails;
          ForceModelCancel;
          Exit;
        end;

        if not LoadFirms then
        begin
          ForceModelCancel;
          Exit;
        end;

      finally
        Screen.Cursor := OldCursor;
      end;
    end;
    fsSelectClient :
    begin
      pnlClientSelection.Visible := True;
      Self.Height := 150;
      OldCursor := Screen.Cursor;
      Screen.Cursor := crHourglass;
      try
        PracticeLedger.UnEncryptedToken := UserINI_myMYOB_Access_Token;
        PracticeLedger.RandomKey := UserINI_myMYOB_Random_Key;
        PracticeLedger.RefreshToken := UserINI_myMYOB_Refresh_Token;
        Application.ProcessMessages;
        // Get Businesses
        if ((PracticeLedger.Businesses.Count = 0) and
           (not PracticeLedger.GetBusinesses(AdminSystem.fdFields.fdmyMYOBFirmID,
                  ltPracticeLedger,PracticeLedger.Businesses, liErrorCode,
                  lsErrorDescription))) then
        begin
          Screen.Cursor := OldCursor;
          HelpfulErrorMsg( PracticeLedger.ReturnGenericErrorMessage( liErrorCode ), 0 );
          ForceModelCancel;
        end;
        LoadBusinesses;
      finally
        Screen.Cursor := OldCursor;
      end;
    end;
  end;
end;

procedure TmyMYOBSignInForm.lblForgotPasswordClick(Sender: TObject);
var
  link : string;
  OldCursor: TCursor;
begin
  OldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;

  try
    link := PRACINI_DefaultCashbookForgotPasswordURL;

    if length(link) = 0 then
      exit;

    ShellExecute(0, 'open', PChar(link), nil, nil, SW_NORMAL);
  finally
    Screen.Cursor := OldCursor;
  end;
end;

procedure TmyMYOBSignInForm.LoadBusinesses;
var
  i, Index: Integer;
  Business : TBusinessData;
begin
  cmbSelectClient.Items.Clear;
  Index := 0;

  if not Assigned(PracticeLedger.Businesses) then
    Exit;

  if PracticeLedger.Businesses.Count = 0 then
    ModalResult := mrCancel;

  for i := 0 to PracticeLedger.Businesses.Count - 1 do
  begin
    Business := PracticeLedger.Businesses.GetItem(i);
    if Assigned(Business) then
    begin
      if Business.ID = MyClient.clExtra.cemyMYOBClientIDSelected then
        Index := i;
      cmbSelectClient.Items.AddObject(Business.Name, TObject(Business));
    end;
  end;
  cmbSelectClient.ItemIndex := Index;
  cmbSelectClient.SetFocus;
end;

function TmyMYOBSignInForm.LoadFirms:Boolean;
var
  i, Index, Row: Integer;
  Firm : TFirm;
begin
  Result := False;
  cmbSelectFirm.Items.Clear;
  Index := 0;
  if not Assigned(PracticeLedger.Firms) then
    Exit;

  if PracticeLedger.Firms.Count = 0 then
    Exit;

  Row := 0;
  for i := 0 to PracticeLedger.Firms.Count - 1 do
  begin
    Firm := PracticeLedger.Firms.GetItem(i);
    if Assigned(Firm) then
    begin
      // Check for Practice Ledger
      if Pos('PL',Firm.EligibleLicense) > 0 then
      begin
        if (whShortNames[ AdminSystem.fdFields.fdCountry ] = Firm.Region ) then
        begin
          if (Firm.ID = FSelectedID) then
          begin
            Index := Row;
          end;

          cmbSelectFirm.Items.AddObject(Firm.Name, TObject(Firm));
          Inc(Row);
        end;
      end;
    end;
  end;
  cmbSelectFirm.ItemIndex := Index;
  FOldFirmID := FSelectedID;

  Result := ChangeFirm;  
end;

procedure TmyMYOBSignInForm.SaveMyMYOBUserDetails;
begin
  UserINI_myMYOB_Access_Token := PracticeLedger.UnEncryptedToken;
  UserINI_myMYOB_Random_Key := PracticeLedger.RandomKey;
  UserINI_myMYOB_Refresh_Token := PracticeLedger.RefreshToken;
  UserINI_myMYOB_Expires_TokenAt := PracticeLedger.TokenExpiresAt;
  WriteUsersINI(CurrUser.Code);
end;

procedure TmyMYOBSignInForm.SaveUser;
const
  ThisMethodName = 'SaveMYOBEmail';
var
  eUser: pUser_Rec;
  StoredLRN   : Integer;
  StoredName  : string;
  pu          : pUser_Rec;
begin
  //get the user_rec again as the admin system may have changed in the mean time.
  if Assigned(CurrUser) then
  begin
    eUser := AdminSystem.fdSystem_User_List.FindCode(CurrUser.Code);
    if Assigned(eUser) then
    begin
      StoredLRN := eUser.usLRN; {user pointer about to be destroyed}
      StoredName := eUser.usCode;

      if LoadAdminSystem(true, ThisMethodName ) Then
      begin
        pu := AdminSystem.fdSystem_User_List.FindLRN(StoredLRN);

        if not Assigned(pu) Then
        begin
          UnlockAdmin;
          HelpfulErrorMsg('The User ' + StoredName + ' can no longer be found in the Admin System.', 0);
          Exit;
        end;
        pu^.usMYOBEMail := Trim(edtEmail.Text);
        CurrUser.MYOBEmailAddress := Trim(edtEmail.Text);
        SaveAdminSystem;
      end;
    end;
  end;
end;

procedure TmyMYOBSignInForm.UpdateControls;
begin
  if FIsSignIn then
  begin
    edtEmail.Enabled := True;
    btnSignIn.Caption := 'Login';
    btnSignIn.Default := True;
  end
  else
  begin
    edtEmail.Enabled := False;
    btnSignIn.Caption := 'Logout';
  end;

  edtPassword.Enabled := edtEmail.Enabled;
  lblEmail.Enabled := edtEmail.Enabled;
  lblPassword.Enabled := edtEmail.Enabled;
  //lblForgotPassword.Visible := (not FIsSignIn);
end;

end.
