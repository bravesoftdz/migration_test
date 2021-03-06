 Unit EditUserDlg;
//------------------------------------------------------------------------------
{
   Title:       Edit User Dialog

   Description: Allows editing and set up for system users

   Author:      Matthew Hopkins

   Remarks:

}
//------------------------------------------------------------------------------
Interface

Uses
  Windows,
  Messages,
  SysUtils,          
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  SYDEFS,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
  CheckLst,
  AuditMgr,
  OsFont,
  BankLinkOnlineServices;

Type
  TUserValues = record
    FullName : String;
    Email : String;
    DirectDial : String;
    Password : String;
    CanCreateEditMasterMems : Boolean;
    ShowPrinter : Boolean;
    SuppressHeaderFooter : Boolean;
    ShowPracticeLogo : Boolean;
    CanAccessBankLinkOnline : Boolean;
    UsePracPassInOnline : Boolean;
    UserType : Integer;
  end;

  TUI_Modes = (uimBasic, uimOnline, uimOnlineUnlinked, uimOnlineShowUser);

  TdlgEditUser = Class(TForm)
    btnOK        : TButton;
    btnCancel    : TButton;
    pcMain: TPageControl;
    tsDetails: TTabSheet;
    tsFiles: TTabSheet;
    Label6: TLabel;
    rbAllFiles: TRadioButton;
    rbSelectedFiles: TRadioButton;
    pnlSelected: TPanel;
    lvFiles: TListView;
    btnAdd: TButton;
    btnRemove: TButton;
    btnRemoveAll: TButton;
    pnlMain: TPanel;
    chkShowPracticeLogo: TCheckBox;
    CBSuppressHeaderFooter: TCheckBox;
    CBPrintDialogOption: TCheckBox;
    chkMaster: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    cmbUserType: TComboBox;
    lblUserType: TLabel;
    Label9: TLabel;
    eDirectDial: TEdit;
    eMail: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    eFullName: TEdit;
    eUserCode: TEdit;
    Label1: TLabel;
    stUserName: TLabel;
    pnlUserIsLoggedOn: TPanel;
    pnlSpecial: TPanel;
    chkLoggedIn: TCheckBox;
    pnlOnline: TPanel;
    pnlOnlineLeft: TPanel;
    pnlOnlineRight: TPanel;
    pnlOnlineMid: TPanel;
    pnlAllowAccess: TPanel;
    chkCanAccessBankLinkOnline: TCheckBox;
    pnlUnlinked: TPanel;
    radCreateNewOnlineUser: TRadioButton;
    radLinkExistingOnlineUser: TRadioButton;
    cmbLinkExistingOnlineUser: TComboBox;
    pnlOnlineUser: TPanel;
    Label10: TLabel;
    eOnlineUser: TEdit;
    lblPrimaryContact: TLabel;
    pnlEnterPassword: TPanel;
    Label4: TLabel;
    ePass: TEdit;
    Label5: TLabel;
    eConfirmPass: TEdit;
    LblPasswordValidation: TLabel;
    pnlResetPassword: TPanel;
    btnResetPassword: TButton;
    Label11: TLabel;
    pnlGeneratedPassword: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    tsMYOB: TTabSheet;
    Label14: TLabel;
    edtEmailId: TEdit;

    Procedure btnCancelClick(Sender: TObject);
    Procedure btnOKClick(Sender: TObject);
    Procedure chkLoggedInClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    procedure SetUpHelp;
    Procedure FormShow(Sender: TObject);
    procedure btnRemoveAllClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure rbAllFilesClick(Sender: TObject);
    procedure rbSelectedFilesClick(Sender: TObject);
    procedure cmbUserTypeSelect(Sender: TObject);
    procedure chkCanAccessBankLinkOnlineClick(Sender: TObject);
    procedure radCreateNewOnlineUserClick(Sender: TObject);
    procedure radLinkExistingOnlineUserClick(Sender: TObject);
    procedure btnResetPasswordClick(Sender: TObject);
    procedure eFullNameChange(Sender: TObject);
    procedure eMailChange(Sender: TObject);
    procedure eDirectDialChange(Sender: TObject);
    procedure chkMasterClick(Sender: TObject);
    procedure CBPrintDialogOptionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnlMainClick(Sender: TObject);
  Private
    fOldValues : TUserValues;

    fUserGuid     : TBloGuid;
    fIsCreateUser : boolean;
    fIsPrimaryUser : Boolean;
    fokPressed  : boolean;
    fformLoaded : boolean;
    fEditChk    : boolean;
    fUIMode     : TUI_Modes;

    FIsLoggedIn: Boolean;
    FUsingMixedCasePassword: Boolean;

    FUnlinkedUsers: TBloArrayOfUserRead;

    // Cache this in SetOnlineUIMode, so it can be used during OKToPost without
    // retrieving Practice again.
    fDefaultAdminUserId : TBloGuid;

    FUsingSecureAuthentication: Boolean;

    FCurrentUserTypeIndex: Integer;

    procedure RefreshUnlinkedUserList;

    function AllowResetPassword: Boolean;
    
    function UserIsBanklinkOnlineAdmin: Boolean;

    function UserLoggedInChanged: Boolean;

    procedure StoreOldValues;
    function HasUserValueChanged : Boolean;
    function GetCurrentCode : string;
    procedure OnlineControlSetup(aUIMode : TUI_Modes);
    Function OKtoPost : boolean;
    Function PosttoBankLinkOnline : Boolean;
    Procedure UpdateAdminFileAccessList( UserLRN : integer);
    Function IsBankLinkOnlineUser : Boolean;
    procedure SetOnlineUIMode(var aUIMode : TUI_Modes; aPractice: TBloPracticeRead);

    procedure ShowGeneratedPassword;
    procedure ShowResetPassword;
    procedure ShowEnterPassword;
    procedure DoRebranding();

    property okPressed  : boolean read fokPressed  write fokPressed;
    property formLoaded : boolean read fformLoaded write fformLoaded;
    property EditChk    : boolean read fEditChk    write fEditChk;
  Public
    Function Execute(User: pUser_Rec) : boolean;

    property UserGuid     : TBloGuid    read fUserGuid     write fUserGuid;
    property IsCreateUser : boolean read fIsCreateUser write fIsCreateUser;
  End;

Function EditUser(w_PopupParent: TForm; User_Code: String) : boolean;
Function AddUser(w_PopupParent: TForm) : boolean;

//------------------------------------------------------------------------------
implementation
{$R *.DFM}

uses
  Admin32,
  bkconst,
  BKHelp,
  bkXPThemes,
  ClientLookUpExFrm,
  ErrorMoreFrm,
  InfoMoreFrm,
  Globals,
  ImagesFrm,
  LogUtil,
  SyUSIO,
  WarningMoreFrm,
  YesNoDlg,
  RegExprUtils,
  PickNewPrimaryUser,
  progress,
  INISettings,
  AuthenticationFailedFrm,
  bkBranding, bkProduct,
  IniFiles,
  PracticeLedgerObj;

Const
  UNITNAME = 'EDITUSERDLG';
  COMP_VERT_DIFF = 60;

//------------------------------------------------------------------------------
procedure TdlgEditUser.FormCreate(Sender: TObject);
var
  UserTypeIndex : Integer;
begin
  bkXPThemes.ThemeForm( Self);

  formLoaded := false;
  SetUpHelp;
  pcMain.ActivePage := tsDetails;

  SetpasswordFont(ePass);
  SetpasswordFont(eConfirmPass);

  cmbUserType.Clear;
  for UserTypeIndex := ustmin to ustMax do
    cmbUserType.Items.Add(ustNames[UserTypeIndex]);

  ShowEnterPassword;

  DoRebranding();
End;

procedure TdlgEditUser.FormDestroy(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.SetOnlineUIMode(var aUIMode : TUI_Modes; aPractice: TBloPracticeRead);
var
  BloUserRead : TBloUserRead;

  //----------------------------
  procedure CheckForUnlinked;
  begin
    FUnlinkedUsers := ProductConfigService.GetUnLinkedOnlineUsers(aPractice);
    
    // Are there unlinked online users to link to?
    if (assigned(FUnlinkedUsers)) and (high(FUnlinkedUsers) >= 0) then
    begin
      aUIMode := uimOnlineUnlinked;
    end
    else
    begin
      aUIMode := uimOnline;
    end;
  end;

  procedure SetOnlineShowUser;
  begin
    // Is online user linked to practice user?
    BloUserRead := ProductConfigService.GetOnlineUserLinkedToCode(GetCurrentCode, aPractice);

    if Assigned(BloUserRead) then
    begin
      // Linked
      if Trim(Uppercase(BloUserRead.EMail)) = Trim(Uppercase(eMail.text)) then
        aUIMode := uimOnline
      else
      begin
        // Differant user name to email
        aUIMode := uimOnlineShowUser;
        eOnlineUser.text := BloUserRead.EMail;
      end;
    end
    else
      CheckForUnlinked;
  end;

begin
  // Store this for use in OKToPost
  if Assigned(aPractice) then
    fDefaultAdminUserId := aPractice.DefaultAdminUserId
  else
    fDefaultAdminUserId := '';

  // is the user marked as online?
  if chkCanAccessBankLinkOnline.Checked then
  begin
    If fOldValues.CanAccessBankLinkOnline and UseBankLinkOnline then
    begin
      SetOnlineShowUser;
    end
    else
    begin
      if fOldValues.CanAccessBankLinkOnline then
        SetOnlineShowUser
      else
        CheckForUnlinked;
    end;
  end
  else
    fUIMode := uimOnline;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.SetUpHelp;
begin
  Self.ShowHint    := INI_ShowFormHints;
  Self.HelpContext := 0;
  //Components
  eUserCode.Hint      :=
                     'Enter a User Code for logging in to '+SHORTAPPNAME+'|' +
                     'Enter a User Code for logging in to '+SHORTAPPNAME;
  eFullName.Hint      :=
                     'Enter the user''s full name|' +
                     'Enter the user''s full name';
  eMail.Hint          :=
                     'Enter the user''s Email address|' +
                     'Enter the user''s Email address';
  ePass.Hint          :=
                     'Enter a login password|' +
                     'Enter a password that this User must use when logging in. (Required if user has Administrator rights)';
  eConfirmPass.Hint   :=
                     'Confirm the password entered above|' +
                     'Re-enter the password above to confirm it is correct';
  chkMaster.Hint      :=
                     'Check to allow user to memorise transactions at master level|' +
                     'Check to allow user to memorise transactions at master level';
  //chkSystem.Hint      :=
  //                    'Check to give the user Administrator rights|' +
  //                    'Check to give the user Administrator rights';

  cmbUserType.Hint    :=
                     'Select users access rights|' +
                     'Select users access rights';

  chkLoggedIn.hint    :=
                     'Check to alter the user''s login status|' +
                     'Uncheck to reset the user''s status if the user has crashed out of the program';

  CBPrintDialogOption.Hint :=
                      'Always show printer options before printing|' +
                      'Always show printer options before printing';

  CBSuppressHeaderFooter.Hint := 'Check to Hide Headers and Footers on Reports for this User';

  chkShowPracticeLogo.Hint := 'Display the practice logo when this user is logged in';

  chkCanAccessBankLinkOnline.Hint := 'Allows a ' + TProduct.BrandName + ' User to Access ' + bkBranding.ProductOnlineName;
end;

procedure TdlgEditUser.ShowEnterPassword;
begin
  pnlEnterPassword.BringToFront;
  pnlEnterPassword.Visible := True;

  pnlGeneratedPassword.Visible := False;
  pnlResetPassword.Visible := False;
end;

procedure TdlgEditUser.ShowGeneratedPassword;
begin
  pnlGeneratedPassword.BringToFront;
  pnlGeneratedPassword.Visible := True;

  pnlEnterPassword.Visible := False;
  pnlResetPassword.Visible := False;
end;

procedure TdlgEditUser.ShowResetPassword;
begin
  pnlResetPassword.BringToFront;
  pnlResetPassword.Visible := True;

  pnlEnterPassword.Visible := False;
  pnlGeneratedPassword.Visible := False;
end;

//------------------------------------------------------------------------------
Procedure TdlgEditUser.FormShow(Sender: TObject);
begin
  FCurrentUserTypeIndex := cmbUserType.ItemIndex;
  
  formLoaded := true;

  if eUserCode.CanFocus then
    eUserCode.SetFocus;
End;

//------------------------------------------------------------------------------
function TdlgEditUser.IsBankLinkOnlineUser: Boolean;
begin
  Result := (UseBankLinkOnline and chkCanAccessBankLinkOnline.Checked);
end;

//------------------------------------------------------------------------------
Procedure TdlgEditUser.btnCancelClick(Sender: TObject);
begin { TdlgEditUser.btnCancelClick }
  okPressed := false;
  Close;
End; { TdlgEditUser.btnCancelClick }

//------------------------------------------------------------------------------
Procedure TdlgEditUser.btnOKClick(Sender: TObject);
begin { TdlgEditUser.btnOKClick }
  If OKtoPost Then
  begin

    if (HasUserValueChanged) and
       ((fOldValues.CanAccessBankLinkOnline = true) or
       (chkCanAccessBankLinkOnline.Checked = true)) then
    begin
      If AskYesNo('User Details Changed', 'The details for this user have changed ' +
                  'and will be updated to ' + bkBranding.ProductOnlineName + '.' + #13#10 + #13#10 +
                  'Are you sure you want to continue?', DLG_NO, 0) <> DLG_YES Then
        Exit;
    end;

    if HasUserValueChanged then
    begin
      if chkCanAccessBankLinkOnline.Checked and not FOldValues.CanAccessBankLinkOnline then
      begin
        if (UserIsBanklinkOnlineAdmin or (CurrUser.Code = GetCurrentCode)) then
        begin
          if not PosttoBankLinkOnline then
          begin
            Exit;
          end;
        end
        else
        begin
          HelpfulWarningMsg('Creating a ' + bkBranding.ProductOnlineName + ' enabled user requires you to be an administrator on ' + bkBranding.ProductOnlineName + '.', 0);

          Exit;
        end;
      end
      else
      begin
       if not PosttoBankLinkOnline then
         Exit;
      end;
    end;
    
    okPressed := true;
    Close;
  End { OKtoPost };
End; { TdlgEditUser.btnOKClick }

//------------------------------------------------------------------------------
procedure TdlgEditUser.StoreOldValues;
begin
  fOldValues.FullName                := eFullName.text;
  fOldValues.Email                   := eMail.text;
  fOldValues.DirectDial              := eDirectDial.Text;
  fOldValues.Password                := ePass.text;
  fOldValues.ShowPrinter             := cbPrintDialogOption.Checked;
  fOldValues.SuppressHeaderFooter    := CBSuppressHeaderFooter.Checked;
  fOldValues.ShowPracticeLogo        := chkShowPracticeLogo.Checked;
  fOldValues.CanAccessBankLinkOnline := chkCanAccessBankLinkOnline.Checked;
  fOldValues.UserType                := cmbUserType.ItemIndex;
  FOldValues.CanCreateEditMasterMems := chkMaster.Checked;
end;

//------------------------------------------------------------------------------
function TdlgEditUser.HasUserValueChanged: Boolean;
begin
  Result := not((fOldValues.FullName                = eFullName.text) and
                (fOldValues.Email                   = eMail.text) and
                (fOldValues.DirectDial              = eDirectDial.Text) and
                (fOldValues.Password                = ePass.text) and
                (fOldValues.CanCreateEditMasterMems = chkMaster.Checked) and
                (fOldValues.ShowPrinter             = cbPrintDialogOption.Checked) and
                (fOldValues.SuppressHeaderFooter    = CBSuppressHeaderFooter.Checked) and
                (fOldValues.ShowPracticeLogo        = chkShowPracticeLogo.Checked) and
                (fOldValues.CanAccessBankLinkOnline = chkCanAccessBankLinkOnline.Checked) and
                (fOldValues.UserType                = cmbUserType.ItemIndex));
end;

//------------------------------------------------------------------------------
function TdlgEditUser.GetCurrentCode: string;
begin
  if IsCreateUser then
    Result := eUserCode.text
  else
    Result := stUserName.Caption;
end;

//------------------------------------------------------------------------------
Procedure TdlgEditUser.OnlineControlSetup(aUIMode : TUI_Modes);
begin
  case aUIMode of
    uimBasic :
    Begin
      pnlOnline.Visible := False;
      // Show Practice Logo should always be there (for restricted user)
      Self.Height := 458 + 31;
    End;
    uimOnline :
    Begin
      pnlOnlineMid.BevelInner := bvNone;
      pnlOnlineMid.BevelOuter := bvNone;
      pnlOnline.Visible := True;
      pnlUnlinked.Visible := False;
      pnlOnlineUser.Visible := False;
      Self.Height := 524;
      chkCanAccessBankLinkOnline.Left := 13;
      chkCanAccessBankLinkOnline.Top  := 10;
    End;
    uimOnlineUnlinked :
    Begin
      pnlOnlineMid.BevelInner := bvLowered;
      pnlOnlineMid.BevelOuter := bvRaised;
      pnlOnline.Visible := True;
      pnlUnlinked.Visible := True;
      pnlOnlineUser.Visible := False;
      Self.Height := 600;
      chkCanAccessBankLinkOnline.Left := 11;
      chkCanAccessBankLinkOnline.Top  := 8;
    End;
    uimOnlineShowUser :
    Begin
      pnlOnlineMid.BevelInner := bvLowered;
      pnlOnlineMid.BevelOuter := bvRaised;
      pnlOnline.Visible := True;
      pnlUnlinked.Visible := False;
      pnlOnlineUser.Visible := True;
      Self.Height := 552;
      chkCanAccessBankLinkOnline.Left := 11;
      chkCanAccessBankLinkOnline.Top  := 8;
    End;
  end;

  if (aUIMode = uimBasic) or (chkCanAccessBankLinkOnline.Checked = false) then
  begin
    lblPasswordValidation.Caption  := '(Maximum 12 characters)'
  end
  else
  begin
    lblPasswordValidation.Caption  := '(8-12 characters, including at least 1 digit)';

    lblPrimaryContact.Visible      := fIsPrimaryUser;
  end;
end;

procedure TdlgEditUser.pnlMainClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
Function TdlgEditUser.OKtoPost : boolean;

type
  TCharSet = set of Char;
  
  function StringContainsOnlyChars(Value: String; Chars: TCharSet; out InvalidCharsFound: String): Boolean;
  var
    CharValue: Char;
  begin
    InvalidCharsFound := '';
    
    for CharValue in Value do
    begin
      if not (CharValue in Chars) then
      begin
        InvalidCharsFound := InvalidCharsFound + CharValue;
      end;
    end;

    Result := InvalidCharsFound = '';
  end;

Var
  URec : pUser_Rec;
  LinkedUser : TBloUserRead;
  InvalidChars: String;
begin { TdlgEditUser.OKtoPost }
  Result := false;

  if eUserCode.visible Then
  begin
    if (Trim(eUserCode.text) = '') Then
    begin
      HelpfulWarningMsg('You must enter a user code.', 0);
      pcMain.ActivePage := tsDetails;
      eUserCode.SetFocus;
      exit;
    End; { (Trim(eUserCode.text) = '') };

    {check for duplicate login name}
    URec := AdminSystem.fdSystem_User_List.FindCode(eUserCode.text);
    If Assigned(URec) or (eUserCode.text = SUPERUSER) Then
    begin
      HelpfulWarningMsg( Format( 'The user code "%s" already exists.  Please use a different code.', [ eUserCode.Text ] ), 0 );
      pcMain.ActivePage := tsDetails;
      eUserCode.SetFocus;
      exit;
    End; { Assigned(URec) or (eUserCode.text = SUPERUSER) };

    if not StringContainsOnlyChars(eUserCode.Text, ['a'..'z', 'A'..'Z', '0'..'9', '-', '_', '.'], InvalidChars) then
    begin
      HelpfulWarningMsg(Format('The user code "%s" contains invalid character(s): "%s"', [eUserCode.Text, InvalidChars]), 0);
      pcMain.ActivePage := tsDetails;
      eUserCode.SetFocus;
      Exit;
    end;
  end; { eUserCode.visible };

  if ((Trim(edtEmailId.Text) <> '') and  (not RegExIsEmailValid(edtEmailId.Text))) Then
  begin
    HelpfulWarningMsg('Please enter a valid email address.', 0 );
    pcMain.ActivePage := tsMYOB;
    edtEmailId.SetFocus;
    Exit;
  end; { ValidEmail(eMail.text) }

  if IsBankLinkOnlineUser then
  begin
    if (Trim(eFullName.text) = '') Then
    begin
      HelpfulWarningMsg(bkBranding.ProductOnlineName + ' users must have a User Name.', 0);
      pcMain.ActivePage := tsDetails;
      eFullName.SetFocus;
      exit;
    end; { (Trim(eUserName.text) = '') };

    If not RegExIsEmailValid(eMail.text) Then
    begin
      HelpfulWarningMsg(bkBranding.ProductOnlineName + ' users must have a valid Email Address.', 0 );
      pcMain.ActivePage := tsDetails;
      eMail.SetFocus;
      exit;
    end; { ValidEmail(eMail.text) }

    if (radLinkExistingOnlineUser.Checked) and
       (cmbLinkExistingOnlineUser.ItemIndex = -1) and
       (fUIMode = uimOnlineUnlinked) then
    begin
      HelpfulWarningMsg('An existing user on ' + bkBranding.ProductOnlineName + ' must be selected.', 0 );
      pcMain.ActivePage := tsDetails;
      cmbLinkExistingOnlineUser.SetFocus;
      exit;
    end;

    // Only System users can link to a BLO Primary Contact (Default Admin)
    if radLinkExistingOnlineUser.Checked and
      (cmbLinkExistingOnlineUser.ItemIndex <> -1) and
      (cmbUserType.ItemIndex <> ustSystem) then
    begin
      with cmbLinkExistingOnlineUser do
        LinkedUser := (Items.Objects[ItemIndex] as TBloUserRead);

      // Linked against a primary contact (or default admin user)?
      if (LinkedUser.Id = fDefaultAdminUserId) then
      begin
        HelpfulWarningMsg('Only System users can link to a ' + bkBranding.ProductOnlineName + ' default Administrator (Primary Contact).', 0);
        pcMain.ActivePage := tsDetails;
        cmbLinkExistingOnlineUser.SetFocus;
        exit;
      end;
    end;
  end  { IsBankLinkOnlineUser }
  else
  begin
    if AdminSystem.fdFields.fdCountry = whUK then
    begin
    //All UK users must have a password TFS 19605
      if (ePass.Text = '') then
      begin
        HelpfulWarningMsg('Users must have a password.', 0);
        pcMain.ActivePage := tsDetails;
        ePass.SetFocus;
        exit;
      end;
    end;

    if not (ePass.text = eConfirmPass.text) Then
    begin
      HelpfulWarningMsg('The passwords you have entered do not match. Please re-enter them.', 0);
      pcMain.ActivePage := tsDetails;
      ePass.SetFocus;
      exit;
    end; { not (ePass.text = eConfirmPass.text) };
  end;

  case cmbUserType.ItemIndex of
    ustRestricted :
      begin
        if (rbSelectedFiles.Checked) and (lvFiles.Items.Count = 0) then
        begin
          HelpfulWarningMsg('Users with Restricted Access MUST be allowed to access at least one file.', 0);
          pcMain.ActivePage := tsFiles;
          btnAdd.SetFocus;
          Exit;
        end;
      end;
    ustNormal :
      begin
        if (rbSelectedFiles.Checked) and (lvFiles.Items.Count = 0) then
        begin
          HelpfulWarningMsg('Users with Normal Access MUST be allowed to access at least one file.', 0);
          pcMain.ActivePage := tsFiles;
          btnAdd.SetFocus;
          Exit;
        end;
      end;
    ustSystem :
      begin
        if not chkCanAccessBankLinkOnline.Checked then
        begin
          if (ePass.Text = '') then
          begin
            HelpfulWarningMsg('Users with System Menu Access MUST have a password.', 0);
            pcMain.ActivePage := tsDetails;
            ePass.SetFocus;
            exit;
          end;
        end;
      end;
  end;

  Result := true;
End; { TdlgEditUser.OKtoPost }

//------------------------------------------------------------------------------
Function TdlgEditUser.PosttoBankLinkOnline : Boolean;
var
  MsgCreateorUpdate : string;
  UserCode          : string;
  UserEmail         : String;
  BloUserRead       : TBloUserRead;
  UserGuid: TBloGuid;
begin
  Result := True;

  UserCode := GetCurrentCode;
  UserGuid := FUserGuid;
  
  // if User was on Banklink Online and now is removed delete user on Banklink online
  Try
    if  (fOldValues.CanAccessBankLinkOnline = True)
    and (chkCanAccessBankLinkOnline.Checked = False) then
    begin
      if UserGuid = '' then
        Result := ProductConfigService.DeletePracUser(UserCode, '')
      else
      begin
        // if user is the primary user and been deleted pick a new primary user
        if fIsPrimaryUser then
        begin
          Result := PickPrimaryUser(puaDelete, UserCode);
          if not Result then
            Exit;
        end;

        Result := ProductConfigService.DeletePracUser(UserCode, UserGuid);
      end;

      if Result then
        HelpfulInfoMsg(Format('%s has been successfully deleted from ' + bkBranding.ProductOnlineName + '.', [eFullName.Text]), 0 )
      else
        HelpfulInfoMsg(bkBranding.PracticeProductName + ' was unable to remove this user from ' + bkBranding.ProductOnlineName, 0);
    end;

    if  (chkCanAccessBankLinkOnline.Checked) and (chkCanAccessBankLinkOnline.Visible) then
    begin
      // if user is the primary user and been set to a non supervisor then pick a new primary user
      if (fIsPrimaryUser) and
         (cmbUserType.ItemIndex in [ustRestricted, ustNormal]) then
      begin
        Result := PickPrimaryUser(puaRoleChange, UserCode);
        if not Result then
          Exit;
      end;

      // Check if the the user is unlinked and a user from the list is being picked
      if (fUIMode = uimOnlineUnlinked) and
         (radLinkExistingOnlineUser.Checked) and
         (cmbLinkExistingOnlineUser.ItemIndex > -1) then
      begin
        BloUserRead := TBloUserRead(cmbLinkExistingOnlineUser.Items.Objects[cmbLinkExistingOnlineUser.ItemIndex]);

        if assigned(BloUserRead) then
        begin
          UserEmail := BloUserRead.EMail;
          UserGuid := BloUserRead.Id;
        end;
      end
      else
      begin
        if fUIMode = uimOnlineShowUser then
          UserEmail := eOnlineUser.Text
        else
          UserEmail := eMail.Text;
      end;

      Result := ProductConfigService.AddEditPracUser(UserGuid,
                                                     UserEmail,
                                                     eFullName.Text,
                                                     GetCurrentCode,
                                                     cmbUserType.ItemIndex,
                                                     fIsCreateUser,
                                                     not (fIsCreateUser or (fUIMode = uimOnlineUnlinked)) ,
                                                     FOldValues.Password,
                                                     ePass.Text);
      
      if Result then
      begin
        FUserGuid := UserGuid;

        if IsCreateUser then
          MsgCreateorUpdate := 'created on'
        else
          MsgCreateorUpdate := 'updated to';

        HelpfulInfoMsg(Format('%s has been successfully %s ' + bkBranding.ProductOnlineName + '.', [eFullName.Text, MsgCreateorUpdate]), 0 );
      end
      else
      begin
        if fIsCreateUser then
          HelpfulInfoMsg(Format(bkBranding.PracticeProductName + ' was unable to create %s on ' + bkBranding.ProductOnlineName, [eFullName.Text]), 0)
        else
          HelpfulInfoMsg(Format(bkBranding.PracticeProductName + ' was unable to update %s on ' + bkBranding.ProductOnlineName, [eFullName.Text]), 0);
      end;
    end;
  Except
    on E : Exception do
    begin
      HelpfulErrorMsg(E.Message, 0);
      Result := False;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.chkCanAccessBankLinkOnlineClick(Sender: TObject);
var
  MsgCreateorUpdate : String;
  MsgAddorUpdate    : String;
  Practice          : TBloPracticeRead;
begin
  If formLoaded Then
  begin
    If (not chkCanAccessBankLinkOnline.Checked) and (fOldValues.CanAccessBankLinkOnline) then
    begin
      If AskYesNo('Deleted ' + TProduct.BrandName + ' User', 'This user will be Deleted on ' + bkBranding.ProductOnlineName + '.' + #13
                + 'Are you sure you want to continue?', DLG_NO, 0) <>
        DLG_YES Then
      begin
        chkCanAccessBankLinkOnline.Checked := Not chkCanAccessBankLinkOnline.Checked;
      end
      else
      begin
        ShowEnterPassword;
      end;
    end
    else If (chkCanAccessBankLinkOnline.Checked) and not (fOldValues.CanAccessBankLinkOnline) then
    begin
      if IsCreateUser then
      begin
        MsgCreateorUpdate := 'created on';
        MsgAddorUpdate := 'Add'
      end
      else
      begin
        MsgCreateorUpdate := 'updated to';
        MsgAddorUpdate := 'Update'
      end;

      If AskYesNo(MsgAddorUpdate + ' ' + TProduct.BrandName + ' User', 'This user will be ' + MsgCreateorUpdate + ' ' + bkBranding.ProductOnlineName + '.' + #13
                + 'Are you sure you want to do this?', DLG_NO, 0) <>
        DLG_YES Then
      begin
        chkCanAccessBankLinkOnline.Checked := Not chkCanAccessBankLinkOnline.Checked;
      end
      else
      begin
        ShowGeneratedPassword;
      end;
    end
    else If (chkCanAccessBankLinkOnline.Checked) and (fOldValues.CanAccessBankLinkOnline) then
    begin
      ShowResetPassword;
    end
    else if (not chkCanAccessBankLinkOnline.Checked) and not fOldValues.CanAccessBankLinkOnline then
    begin
      ShowEnterPassword;
    end;

    Practice := ProductConfigService.GetPractice;
    SetOnlineUIMode(fUIMode, Practice);
    OnlineControlSetup(fUIMode);

    If fOldValues.CanAccessBankLinkOnline then
    begin
      btnResetPassword.Enabled := AllowResetPassword;
    end;
  End; { formLoaded };
end;

//------------------------------------------------------------------------------
Procedure TdlgEditUser.chkLoggedInClick(Sender: TObject);
begin { TdlgEditUser.chkLoggedInClick }
  If formLoaded Then
  begin
    If EditChk Then
    begin
      exit;
    End; {already editing}

    If AskYesNo('Reset User Status', 'This will reset the User''s login status and reset the Client File '
       + 'open status for any files the user had open.  You should only do this '
       + 'if the user has been unexpectedly disconnected from ' + SHORTAPPNAME+'.'
       + #13 + #13 + 'Please confirm you want to do this.', DLG_NO, 0) <>
       DLG_YES Then
    begin
      EditChk := true;
      chkLoggedIn.Checked := not chkLoggedIn.Checked;
      EditChk := false;
    End
       { AskYesNo('Reset User Status', 'This will reset the Users login status and reset the Client File '  };
  End { formLoaded };
End;

procedure TdlgEditUser.chkMasterClick(Sender: TObject);
begin

end;

{ TdlgEditUser.chkLoggedInClick }

//------------------------------------------------------------------------------
Procedure TdlgEditUser.UpdateAdminFileAccessList( UserLRN : integer);
var
  CLRN : integer;
  i    : integer;
begin
  //Clear out the existing information, this will allow access to all files
  AdminSystem.fdSystem_File_Access_List.Delete_User( UserLRN );

  //set access if selected files checked
  if rbSelectedFiles.Checked then
  begin
    if lvFiles.Items.Count = 0 then
    begin
      //create a dummy client LRN so that file access will be denied
      AdminSystem.fdSystem_File_Access_List.Insert_Access_Rec( UserLRN, 0 )
    end
    else
    begin
      for i := 0 to Pred( lvFiles.Items.Count ) do
      begin
        CLRN := Integer( lvFiles.Items[ i].SubItems.Objects[ 0]);
        AdminSystem.fdSystem_File_Access_List.Insert_Access_Rec( UserLRN, CLRN );
      end;
    end;
  end;
end;

function TdlgEditUser.UserIsBanklinkOnlineAdmin: Boolean;
var
  User: TBloUserRead;
begin
  Result := False;

  if Assigned(ProductConfigService.Practice) then
  begin  
    User := ProductConfigService.Practice.FindUserByCode(CurrUser.Code);

    if User <> nil then
    begin
      Result := User.IsPracticeAdministrator;    
    end;
  end;
end;

function TdlgEditUser.UserLoggedInChanged: Boolean;
begin
  if FIsLoggedIn then
  begin
    Result := FIsLoggedIn <> chkLoggedIn.Checked;
  end
  else
  begin
    Result := False;
  end;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.btnRemoveAllClick(Sender: TObject);
begin
  lvFiles.Items.Clear;
end;

//------------------------------------------------------------------------------
function TdlgEditUser.AllowResetPassword: Boolean;
begin
  Result := (UserIsBanklinkOnlineAdmin or (CurrUser.Code = GetCurrentCode)) and not Self.HasUserValueChanged;
end;

procedure TdlgEditUser.btnAddClick(Sender: TObject);
Var
  Codes  : TStringList;
  pCF    : pClient_File_Rec;
  Found  : Boolean;
  i, j   : Integer;
  NewLVItem : TListItem;
begin
  Codes := TStringList.Create;
  try
    Codes.Delimiter := ClientCodeDelimiter;
    Codes.StrictDelimiter := True;
    //ask the user for a list of codes, will reload admin system
    Codes.DelimitedText :=
      LookupClientCodes( 'Select Files',
                         '',
                         [ coHideStatusColumn, coHideViewButtons, coAllowMultiSelected, coShowAssignedToColumn],
                         'Add');

    for i := 0 to Codes.Count - 1 do
    begin
      pCF := AdminSystem.fdSystem_Client_File_List.FindCode( Codes[i] );
      if Assigned( pCF ) then
      begin
        Found := False;
        //check that is not already in the list
        for j := 0 to Pred( lvFiles.Items.Count ) do
          If Integer( lvFiles.Items[ j].SubItems.Objects[ 0]) = pCF.cfLRN then
            Found := True;

        if not Found then
        begin
           NewLVItem := lvFiles.Items.Add;
           NewLVItem.caption := pCF^.cfFile_Code;
           NewLVItem.SubItems.AddObject( pCF^.cfFile_Name, Pointer( pCF^.cfLRN ));
           NewLVItem.ImageIndex := 0;
        end;
      end;
    end;
  finally
    Codes.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.btnRemoveClick(Sender: TObject);
Var
  i : Integer;
begin
  If lvFiles.SelCount > 0 then
  begin
    For i := Pred( lvFiles.Items.Count ) downto 0 do
    begin
      If lvFiles.Items[ i].Selected then
         lvFiles.Items[ i].Delete;
    end;
  end;
end;

procedure TdlgEditUser.btnResetPasswordClick(Sender: TObject);
begin
  if (not fIsCreateUser) and (FUserGuid <> '') then
  begin
    if AskYesNo('Reset User Password', Format('This will reset the password for %s. An email will be sent to their email address %s with a temporary password. ' + #10#13#10#13 + 'Are you sure you want to do this?', [FOldValues.FullName, FOldValues.Email]), DLG_YES, 0) = DLG_YES then
    begin
      ProductConfigService.ResetPracticeUserPassword(FOldValues.Email, FUserGuid);
    end;
  end;
end;

procedure TdlgEditUser.CBPrintDialogOptionClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.radCreateNewOnlineUserClick(Sender: TObject);
begin
  cmbLinkExistingOnlineUser.enabled := false;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.radLinkExistingOnlineUserClick(Sender: TObject);
begin                                       
  RefreshUnlinkedUserList;
  
  cmbLinkExistingOnlineUser.enabled := true;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.rbAllFilesClick(Sender: TObject);
begin
  pnlSelected.Visible := rbSelectedFiles.Checked;
end;

//------------------------------------------------------------------------------
procedure TdlgEditUser.rbSelectedFilesClick(Sender: TObject);
begin
  pnlSelected.Visible := rbSelectedFiles.Checked;
end;

procedure TdlgEditUser.RefreshUnlinkedUserList;
var
  Index: Integer;
  PracUserRole: String;
begin
  if ProductConfigService.OnLine then
  begin
    cmbLinkExistingOnlineUser.Clear;

    if Assigned(ProductConfigService.CachedPractice) then
    begin
      PracUserRole := ProductConfigService.CachedPractice.GetUserRoleNameFromPracUserType(cmbUserType.ItemIndex);

      if PracUserRole <> '' then
      begin
        for index := 0 to high(FUnlinkedUsers) do
        begin
          if ProductConfigService.CachedPractice.CheckUserRolesEqual(cmbUserType.ItemIndex, FUnlinkedUsers[index]) then
          begin
            cmbLinkExistingOnlineUser.AddItem(FUnlinkedUsers[index].EMail, FUnlinkedUsers[index]);
          end;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
// cmbUserTypeSelect
//
// Triggered when the User Type combobox is changed. The caption next to the
// combobox is updated and the various controls on the form are set.
//
procedure TdlgEditUser.cmbUserTypeSelect(Sender: TObject);
var
  User: TBloUserRead;
begin
  case TComboBox(Sender).ItemIndex of
    ustRestricted :
      begin
        if chkCanAccessbanklinkOnline.Checked then
        begin
          HelpfulWarningMsg(bkBranding.ProductOnlineName + ' cannot change the user type to Restricted for a user that has access to ' + bkBranding.ProductOnlineName + '.', 0);

          TComboBox(Sender).ItemIndex := FCurrentUserTypeIndex;

          Exit;
        end;
  
        lblUserType.Caption := 'Limited functionality : Access to selected files only';
        chkMaster.Checked := False;
        chkMaster.Enabled := False;
        rbAllFiles.Checked := False;
        rbAllFiles.Enabled := False;
        rbSelectedFiles.Checked := True;
        rbSelectedFiles.Enabled := True;
        chkShowPracticeLogo.Enabled := True;
        chkCanAccessBankLinkOnline.Enabled := False;
      end;
    ustNormal :
      begin
        if chkCanAccessbanklinkOnline.Checked and Assigned(ProductConfigService.CachedPractice) then
        begin
          if radLinkExistingOnlineUser.Checked and (cmbLinkExistingOnlineUser.ItemIndex > -1) then
          begin
            User := TBloUserRead(cmbLinkExistingOnlineUser.Items.Objects[cmbLinkExistingOnlineUser.ItemIndex]);

            if User.HasRoles([ProductConfigService.CachedPractice.GetUserRoleNameFromPracUserType(ustSystem)]) then
            begin
              HelpfulWarningMsg(bkBranding.PracticeProductName + ' cannot link a user with a user type of Normal to an Administrator user on ' + bkBranding.ProductOnlineName + '.', 0);

              TComboBox(Sender).ItemIndex := FCurrentUserTypeIndex;

              Exit;
            end;
          end;
        end;
    
        lblUserType.Caption := 'Standard functionality : Access to all or selected files';
        chkMaster.Enabled := True;
        rbAllFiles.Checked := True;
        rbAllFiles.Enabled := True;
        rbSelectedFiles.Checked := False;
        rbSelectedFiles.Enabled := True;
        chkShowPracticeLogo.Enabled := False;
        chkShowPracticeLogo.Checked := False;
        chkCanAccessBankLinkOnline.Enabled := True;

        RefreshUnlinkedUserList;
      end;
    ustSystem :
      begin
        if chkCanAccessbanklinkOnline.Checked and Assigned(ProductConfigService.CachedPractice) then
        begin
          if radLinkExistingOnlineUser.Checked and (cmbLinkExistingOnlineUser.ItemIndex > -1) then
          begin
            User := TBloUserRead(cmbLinkExistingOnlineUser.Items.Objects[cmbLinkExistingOnlineUser.ItemIndex]);
            
            if not User.HasRoles([ProductConfigService.CachedPractice.GetUserRoleNameFromPracUserType(ustSystem)]) then
            begin
              HelpfulWarningMsg(bkBranding.PracticeProductName + ' cannot link a user with a user type of System to a Normal user on ' + bkBranding.ProductOnlineName + '.', 0);

              TComboBox(Sender).ItemIndex := FCurrentUserTypeIndex;

              Exit;
            end;
          end;
        end;
        
        lblUserType.Caption := 'Administrator rights : Access to all files';
        chkMaster.Enabled := True;
        rbAllFiles.Checked := True;
        rbAllFiles.Enabled := True;
        rbSelectedFiles.Checked := False;
        rbSelectedFiles.Enabled := False;
        chkShowPracticeLogo.Enabled := False;
        chkShowPracticeLogo.Checked := False;
        chkCanAccessBankLinkOnline.Enabled := True;

        RefreshUnlinkedUserList;
      end;
  else
    lblUserType.Caption := '';
  end;
  
  if FOldValues.CanAccessBankLinkOnline then
  begin
    btnResetPassword.Enabled := AllowResetPassword;
  end;

  FCurrentUserTypeIndex := cmbUserType.ItemIndex;
end;

procedure TdlgEditUser.DoRebranding;
begin
  Label13.Caption := BRAND_ONLINE + ' will automatically generate this user''s password.';
  chkCanAccessBankLinkOnline.Caption := 'Allow access to &' + BRAND_ONLINE;
  radCreateNewOnlineUser.Caption := 'C&reate new user on ' + BRAND_ONLINE;
  radLinkExistingOnlineUser.Caption := 'Lin&k to existing user on ' + BRAND_ONLINE;
end;

procedure TdlgEditUser.eDirectDialChange(Sender: TObject);
begin
  if FOldValues.CanAccessBankLinkOnline then
  begin
    btnResetPassword.Enabled := AllowResetPassword;
  end;
end;

procedure TdlgEditUser.eFullNameChange(Sender: TObject);
begin
  if FOldValues.CanAccessBankLinkOnline then
  begin
    btnResetPassword.Enabled := AllowResetPassword;
  end;
end;

procedure TdlgEditUser.eMailChange(Sender: TObject);
begin
  if FOldValues.CanAccessBankLinkOnline then
  begin
    btnResetPassword.Enabled := AllowResetPassword;
  end;
end;

//------------------------------------------------------------------------------
Function TdlgEditUser.Execute( User: pUser_Rec ) : boolean;
Const
  ACCESS_ONLINE_CHK_HEIGHT = 30;
Var
  i : Integer;
  NewLVItem : TListItem;
  Practice : TBloPracticeRead;
  pCF : pClient_File_Rec;
begin { TdlgEditUser.Execute }
  FIsLoggedIn := False;
  
  lvFiles.Items.Clear;

//  if (UseBankLinkOnline or
//     (Assigned(User) and User.usAllow_Banklink_Online)) then
  Practice := nil;
  if UseBankLinkOnline then
    Practice := ProductConfigService.GetPractice(true);

  if Assigned(User) then
  begin
    FIsLoggedIn := User.usLogged_In;
    FUsingMixedCasePassword := User.usUsing_Mixed_Case_Password;
    FUsingSecureAuthentication := User.usUsing_Secure_Authentication;

    //user type
    if (User.usSystem_Access) then
      cmbUserType.ItemIndex := ustSystem
    else if (User.usIs_Remote_User) then
      cmbUserType.ItemIndex := ustRestricted
    else
      cmbUserType.ItemIndex := ustNormal;

    cmbUserTypeSelect(cmbUserType);

    //see if user is restricted
    if AdminSystem.fdSystem_File_Access_List.Restricted_User( User^.usLRN) then
    begin
      rbSelectedFiles.Checked := true;

      //load selected files into list view
      lvFiles.Items.BeginUpdate;
      try
        For i := 0 to AdminSystem.fdSystem_Client_File_List.ItemCount-1 do
        begin
          pCF := AdminSystem.fdSystem_Client_File_List.Client_File_At( i );

          If AdminSystem.fdSystem_File_Access_List.Allow_Access( User^.usLRN, pCF^.cfLRN ) then
          begin
            NewLVItem := lvFiles.Items.Add;
            NewLVItem.caption := pCF^.cfFile_Code;
            NewLVItem.SubItems.AddObject( pCF^.cfFile_Name, Pointer( pCF^.cfLRN ));
            NewLVItem.ImageIndex := 0;
          end;
        end;
      finally
        lvFiles.Items.EndUpdate;
      end;
    end
    else
      rbAllFiles.Checked := true;

    eUserCode.Visible  := false;
    stUserName.Caption := User.usCode;
    eFullName.Text     := User.usName;
    eMail.Text         := User.usEMail_Address;
    eDirectDial.Text   := User.usDirect_Dial;
    ePass.Text         := User.usPassword;
    eConfirmPass.Text  := User.usPassword;
    chkLoggedIn.Checked := User.usLogged_In;
    cbPrintDialogOption.Checked := User.usShow_Printer_Choice;
    cbSuppressHeaderFooter.Checked := (User.usSuppress_HF = shfChecked);
    chkShowPracticeLogo.Checked := User.usShow_Practice_Logo;
    chkCanAccessBankLinkOnline.Checked := User.usAllow_Banklink_Online;
    edtEmailId.Text := User.usMYOBEMail;

    if UseBankLinkOnline and User.usAllow_Banklink_Online then
    begin
      Screen.Cursor := crHourGlass;
      Progress.StatusSilent := False;
      Progress.UpdateAppStatus(bkBranding.ProductOnlineName, 'Connecting', 10);

      try
        if ProductConfigService.Online then
        begin
          Assert(Assigned(Practice));

          Progress.UpdateAppStatus(bkBranding.ProductOnlineName, 'Sending Data to ' + bkBranding.ProductOnlineName, 50);
          UserGuid := ProductConfigService.GetPracUserGuid(User.usCode, Practice);
          fIsPrimaryUser := ProductConfigService.IsPrimPracUser(User.usCode, Practice);
          Progress.UpdateAppStatus(bkBranding.ProductOnlineName, 'Finnished', 100);
        end
        else
        begin
          UserGuid := '';
          fIsPrimaryUser := False;
        end;
      finally
        Progress.StatusSilent := True;
        Progress.ClearStatus;
        Screen.Cursor := crDefault;
      end;
    end
    else
    begin
      UserGuid := '';
      fIsPrimaryUser := False;
    end;

    if User.usWorkstation_Logged_In_At <> '' then
      chkLoggedIn.Caption := 'User is &Logged In  (on ' + User.usWorkstation_Logged_In_At +')';

    chkMaster.Checked     := User.usMASTER_Access;
  end { Assigned(User) }
  else
  begin
    {new user}
    stUserName.visible := false;
    eUserCode.text := '';
    eFullName.text := '';
    eMail.text := '';
    ePass.text := '';
    eDirectDial.Text := '';
    eConfirmPass.text := '';
    cmbUserType.ItemIndex := ustNormal;
    cmbUserTypeSelect(cmbUserType);
    chkLoggedIn.Checked := false;
    chkLoggedIn.Enabled := false;
    chkMaster.Checked := false;
    cbPrintDialogOption.Checked := false;
    cbSuppressHeaderFooter.Checked := false;
    rbAllFiles.Checked := true;
    chkCanAccessBankLinkOnline.Checked := false;
    UserGuid := '';
    edtEmailId.Text := '';
  end { not (Assigned(User)) };

  StoreOldValues;

  // Checks what User View to show
  // is the view online?
  if (UseBankLinkOnline or chkCanAccessBankLinkOnline.Checked) then
  // if UseBankLinkOnline then
    SetOnlineUIMode(fUIMode, Practice)
  else
    fUIMode := uimBasic;

  OnlineControlSetup(fUIMode);

  pnlSelected.Visible := rbSelectedFiles.Checked;
  rbAllFiles.Enabled := (cmbUserType.ItemIndex <> ustRestricted);

  EditChk := false;

  if chkCanAccessBankLinkOnline.Checked then
  begin
    ShowResetPassword;

    btnResetPassword.Enabled := AllowResetPassword;
  end;

  ShowModal;

  Result := okPressed;
End; { TdlgEditUser.Execute }

//------------------------------------------------------------------------------
Function EditUser(w_PopupParent: TForm; User_Code: String) : boolean;
const
  ThisMethodName = 'EditUser';
Var
  MyDlg       : TdlgEditUser;
  eUser       : pUser_Rec;
  StoredLRN   : Integer;
  StoredName  : string;
  YN          : string;
  pu          : pUser_Rec;
  WasLoggedIn : boolean;
  i           : integer;
  Password    : String;
begin { EditUser }
  Result := false;

  eUser := AdminSystem.fdSystem_User_List.FindCode(User_Code);

  If not (Assigned(AdminSystem) and Assigned(eUser)) Then
    exit;

  MyDlg := TdlgEditUser.Create(Application);
  Try
    MyDlg.PopupParent := w_PopupParent;
    MyDlg.PopupMode := pmExplicit;
    
    MyDlg.IsCreateUser := False;

    BKHelpSetUp(MyDlg, BKH_Adding_and_maintaining_users);
    if Assigned(CurrUser) Then
    begin
      if (CurrUser.LRN = eUser.usLRN) or (not eUser.usLogged_In) then
      begin
        MyDlg.chkLoggedIn.Enabled   := false;
        MyDlg.cmbUserType.ItemIndex := ustNormal;
      end; { CurrUser.LRN = eUser.usLRN }
    end;
    WasLoggedIn := eUser^.usLogged_In;

    Password := eUser.usPassword;

    If MyDlg.Execute(eUser) Then
    begin
      //get the user_rec again as the admin system may have changed in the mean time.
      eUser := AdminSystem.fdSystem_User_List.FindCode(User_Code);
      With MyDlg Do
      begin
        StoredLRN := eUser.usLRN; {user pointer about to be destroyed}
        StoredName := eUser.usCode;

        If LoadAdminSystem(true, ThisMethodName ) Then
        begin
          pu := AdminSystem.fdSystem_User_List.FindLRN(StoredLRN);
          If not Assigned(pu) Then
          begin
            UnlockAdmin;
            HelpfulErrorMsg('The User ' + StoredName + ' can no longer be found in the Admin System.', 0);
            exit;
          End;

          pu.usName           := eFullName.text;

          if chkCanAccessBankLinkOnline.Checked then
          begin
            if Trim(ePass.Text) <> '' then
            begin
              UpdateUserDataBlock(pu, ePass.Text);

              pu.usPassword := '';
            end;
          end
          else
          begin
            pu.usPassword:= ePass.text;

            pu.usUsing_Secure_Authentication := False;
          end;

          pu.usEMail_Address  := Trim( eMail.text);
          pu.usDirect_Dial    := eDirectDial.Text;
          pu.usShow_Printer_Choice := cbPrintDialogOption.Checked;

          //Reset user tokens
          if ((Trim(edtEmailId.Text) = '') or
              (pu.usMYOBEMail <> Trim(edtEmailId.Text))) then
          begin
            ResetMYOBTokensInUsersINI(pu.usCode);
            if Assigned(PracticeLedger) then
            begin
              PracticeLedger.Firms.Clear;
              PracticeLedger.Businesses.Clear;
            end;
          end;

          pu.usMYOBEMail := Trim(edtEmailId.Text);

          if Password <> pu.usPassword then
          begin
            pu.usUsing_Mixed_Case_Password := True;
          end;

          if CBSuppressHeaderFooter.Checked then
            pu.usSuppress_HF := shfChecked
          else
            pu.usSuppress_HF := shfUnChecked;

          pu.usShow_Practice_Logo := chkShowPracticeLogo.Checked;
          pu.usAllow_Banklink_Online := chkCanAccessBankLinkOnline.Checked;

          case cmbUserType.ItemIndex of
            ustRestricted :
              begin
                pu.usSystem_Access  := False;
                pu.usIs_Remote_User := True;
              end;
            ustSystem :
              begin
                pu.usSystem_Access  := True;
                pu.usIs_Remote_User := False;
              end;
            ustNormal :
              begin
                pu.usSystem_Access  := False;
                pu.usIs_Remote_User := False;
              end;
            else
              begin
                pu.usSystem_Access  := False;
                pu.usIs_Remote_User := False;
              end;
          end;

          pu.usMASTER_Access  := chkMaster.Checked;
//          pu.usBankLink_Online_Guid := UserGuid;

          If pu.usLogged_In <> chkLoggedIn.Checked Then
          begin
            If chkLoggedIn.Checked Then
              YN := 'YES'
            Else
              YN := 'NO';

            LogUtil.LogMsg(lmInfo, UNITNAME,
                          'User ' + StoredName + ' Logged In reset to ' + YN);
            pu.usLogged_In := chkLoggedIn.Checked;

            //have changed to not logged in ( logged out). ie reset user status, so now reset any open files
            If (not (chkLoggedIn.Checked) and WasLoggedIn) Then
            begin
              //clear the workstation identifier
              pu.usWorkstation_Logged_In_At := '';
              With AdminSystem.fdSystem_Client_File_List Do
              begin
                For i := 0 to Pred(ItemCount) Do
                begin
                  With Client_File_At(i)^ Do
                  begin
                    If (cfFile_Status = fsOpen) and (cfCurrent_User = pu^.usLRN) Then
                    begin
                      //reset the file status for files that this user may have open
                      cfFile_Status := fsNormal;
                      cfCurrent_User := 0;
                    End;
                  End;
                End;
              End;
            End;
          End;

          UpdateAdminFileAccessList( pu^.usLRN);

          //*** Flag Audit ***
          SystemAuditMgr.FlagAudit(arUsers);

          SaveAdminSystem;
          Result := true;

          LogUtil.LogMsg(lmInfo, UNITNAME,
                         Format('User %s was edited by %s.', [pu^.usName, CurrUser.FullName]));

          If Assigned(CurrUser) Then
          begin
            If CurrUser.LRN = pu.usLRN Then
            begin
              CurrUser.CanMemoriseToMaster := pu.usMASTER_Access;
              CurrUser.FullName := pu.usName;
              CurrUser.ShowPrinterDialog := pu.usShow_Printer_Choice;
              CurrUser.AllowBanklinkOnline := pu.usAllow_Banklink_Online;
              CurrUser.CanAccessAdmin := pu.usSystem_Access;
              CurrUser.MYOBEmailAddress := pu.usMYOBEMail;
            End; { CurrUser.LRN = pu.usLRN }
          End;
        End { LoadAdminSystem(true) }
        Else
        begin
          HelpfulErrorMsg('Could not update User Details at this time. Admin System unavailable.', 0)
        End;
      End; { with MyDlg }
    End;
  Finally
    MyDlg.Free;
  End; { try };
End; { EditUser }

//------------------------------------------------------------------------------
Function AddUser(w_PopupParent: TForm) : boolean;
const
  ThisMethodName = 'AddUser';
Var
  MyDlg : TdlgEditUser;
  pu    : pUser_Rec;
begin { AddUser }
  Result := false;
  If not Assigned(AdminSystem) Then
    exit;

  MyDlg := TdlgEditUser.Create(Application);
  Try
    MyDlg.PopupParent := w_PopupParent;
    MyDlg.PopupMode := pmExplicit;
    
    MyDlg.IsCreateUser := True;
    BKHelpSetUp(MyDlg, BKH_Adding_and_maintaining_users);
    If MyDlg.Execute(Nil) Then
    begin
      With MyDlg Do
      begin
        If LoadAdminSystem(true, ThisMethodName ) Then
        begin
          pu := New_User_Rec;

          if not Assigned(pu) Then
          begin
            UnlockAdmin;
            HelpfulErrorMsg('New User cannot be created', 0);
            exit;
          end { not Assigned(pu) };

          Inc(AdminSystem.fdFields.fdUser_LRN_Counter);
          pu.usCode           := eUserCode.text;
          pu.usName           := eFullName.text;


          if not chkCanAccessBankLinkOnline.Checked then
          begin
            pu.usPassword := ePass.text;
            
            pu.usUsing_Mixed_Case_Password := True;
          end;

          pu.usEMail_Address  := Trim( eMail.text);
          pu.usDirect_Dial    := eDirectDial.Text;
          pu.usShow_Printer_Choice := cbPrintDialogOption.Checked;

          if CBSuppressHeaderFooter.Checked then
            pu.usSuppress_HF := shfChecked
          else
            pu.usSuppress_HF := shfUnChecked;

          pu.usShow_Practice_Logo := chkShowPracticeLogo.Checked;
          pu.usAllow_Banklink_Online := chkCanAccessBankLinkOnline.Checked;

          case cmbUserType.ItemIndex of
           ustRestricted :
             begin
               pu.usSystem_Access  := False;
               pu.usIs_Remote_User := True;
             end;
           ustSystem :
             begin
               pu.usSystem_Access  := True;
               pu.usIs_Remote_User := False;
             end;
           ustNormal :
             begin
               pu.usSystem_Access  := False;
               pu.usIs_Remote_User := False;
             end;
           else
             begin
               pu.usSystem_Access  := False;
               pu.usIs_Remote_User := False;
             end;
          end;

          pu.usMASTER_Access  := chkMaster.Checked;
          pu.usLogged_In      := false;
          pu.usLRN            := AdminSystem.fdFields.fdUser_LRN_Counter;
          //               pu.usBankLink_Online_Guid := UserGuid;

          AdminSystem.fdSystem_User_List.Insert( pu );

          UpdateAdminFileAccessList( pu^.usLRN);

          //*** Flag Audit ***
          SystemAuditMgr.FlagAudit(arUsers);

          SaveAdminSystem;
          Result := true;

          LogUtil.LogMsg(lmInfo, UNITNAME,
                        Format('User %s was added by %s.', [pu^.usName, CurrUser.FullName]));
        End { LoadAdminSystem(true) }
        Else
        begin
           HelpfulErrorMsg('Could not update User Details at this time. Admin System unavailable.', 0)
        End;
      End; { with MyDlg }
    End;
  Finally
    MyDlg.Free;
  End; { try };
End; { AddUser }

End.
