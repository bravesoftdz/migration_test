unit PickNewPrimaryUser;
//------------------------------------------------------------------------------
{
   Title:       Pick New Primary User Dialog

   Description: Picks a new Primary BankLink Online User

   Author:      Ralph Austen

   Remarks:

}
//------------------------------------------------------------------------------
interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  BankLinkOnlineServices,
  OsFont;

type
  TPickNewPrimUserAction = (puaDelete, puaRoleChange);

  TPickNewPrimaryUser = class(TForm)
    Image1  : TImage;
    btnYes  : TButton;
    btnNo   : TButton;
    lblMainMessage: TLabel;
    Label1  : TLabel;
    Label2  : TLabel;
    cmbPrimaryContact: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    FHelpContext : integer;
  public
  end;

  function PickPrimaryUser(aUserAction : TPickNewPrimUserAction;
                           aUserCode   : string = '';
                           aPractice   : TBloPracticeRead = Nil) : Boolean;

//------------------------------------------------------------------------------
implementation
{$R *.dfm}

uses
  LOGUTIL,
  imagesfrm,
  bkXPThemes,
  WarningMoreFrm,
  BkConst,
  Globals, bkBranding;

const
  UNIT_NAME = 'PickNewPrimaryUser';
  MAIN_MESSAGE = 'This user is the current primary contact for this practice. ' +
                 'Another user will need to be set as the primary contact before %s. ';
  MAIN_DELETE_MSG = 'this user can be deleted';
  MAIN_ROLE_CHANGE_MSG = 'this user''s type can be changed';
  WARNING_MESSAGE = 'BankLink Practice is unable to %s as it is the primary contact user ' +
                    'for this practice. (%s)';
  WARNING_DELETE_MSG = 'delete the online user';
  WARNING_ROLE_CHANGE_MSG = 'change the online user''s type';

//------------------------------------------------------------------------------
function PickPrimaryUser(aUserAction : TPickNewPrimUserAction;
                         aUserCode   : string = '';
                         aPractice   : TBloPracticeRead = Nil) : Boolean;
var
  MyDlg         : TPickNewPrimaryUser;
  UserIndex     : integer;
  AdminRollName : Widestring;
  RoleIndex     : integer;
  UserCode      : string;
  UserActionMsg : string;
  PracticeCode  : String;
begin
  Result := False;

  if not assigned(AdminSystem) then
    Exit;
  
  PracticeCode := AdminSystem.fdFields.fdBankLink_Code;

  try
    if not Assigned(aPractice) then
      aPractice := ProductConfigService.GetPractice;

    AdminRollName := aPractice.GetRoleFromPracUserType(ustSystem, aPractice).RoleName;

    MyDlg := TPickNewPrimaryUser.Create(Application);
    Try
      MyDlg.cmbPrimaryContact.Clear;

      case aUserAction of
        puaDelete     : UserActionMsg := MAIN_DELETE_MSG;
        puaRoleChange : UserActionMsg := MAIN_ROLE_CHANGE_MSG;
      end;
      MyDlg.lblMainMessage.Caption := format(MAIN_MESSAGE, [UserActionMsg]);

      // Go through users adding to Combo if not current user
      for UserIndex := 0 to high(aPractice.Users) do
      begin
        if not (aPractice.Users[UserIndex].Id = ProductConfigService.GetPracUserGuid(aUserCode, aPractice)) then
        begin
          for RoleIndex := Low(aPractice.Users[UserIndex].RoleNames) to
                          High(aPractice.Users[UserIndex].RoleNames) do
          begin
            // Add only Admin User Types
            if aPractice.Users[UserIndex].RoleNames[RoleIndex] = AdminRollName then
            begin
              MyDlg.cmbPrimaryContact.AddItem(aPractice.Users[UserIndex].FullName,
                                          aPractice.Users[UserIndex]);
              break;
            end;
          end;
        end;
      end;

      // show error if no users
      if MyDlg.cmbPrimaryContact.Items.Count = 0 then
      begin
        case aUserAction of
          puaDelete     : UserActionMsg := WARNING_DELETE_MSG;
          puaRoleChange : UserActionMsg := WARNING_ROLE_CHANGE_MSG;
        end;

        HelpfulWarningMsg(format(bkBranding.PracticeProductName + ' is unable to %s as it is the primary contact user ' +
                    'for this practice. (%s)', [UserActionMsg, PracticeCode]), 0 );
        Exit;
      end;

      MyDlg.cmbPrimaryContact.ItemIndex := 0;

      if MyDlg.ShowModal = mrYes then
      begin
        // Save Default Admin User
        aPractice.DefaultAdminUserId := TBloUserRead(MyDlg.cmbPrimaryContact.Items.Objects[MyDlg.cmbPrimaryContact.ItemIndex]).Id;
        Result := ProductConfigService.SavePractice(false);

        UserCode := TBloUserRead(MyDlg.cmbPrimaryContact.Items.Objects[MyDlg.cmbPrimaryContact.ItemIndex]).UserCode;
        LogUtil.LogMsg(lmInfo, UNIT_NAME, UserCode + ' has been successfully set to the Default Admin on BankLink Online.');
      end;

    Finally
      FreeAndNil(MyDlg);
    End;
  except
    on E : Exception do
    begin
      raise Exception.Create(bkBranding.PracticeProductName + ' was unable to connect to ' + bkBranding.ProductOnlineName + '. ' + #13#13 + E.Message );
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TPickNewPrimaryUser.FormCreate(Sender: TObject);
begin
  bkXPThemes.ThemeForm( Self);

  FHelpContext := 0;
  Image1.Picture := AppImages.QuestionBmp.Picture;
  {$IFDEF SmartBooks}
  self.Color := clBtnFace;
  {$ENDIF}

  Self.Position := poMainFormCenter;
end;

end.

