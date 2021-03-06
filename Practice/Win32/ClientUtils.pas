// Client utilities module

unit ClientUtils;

interface

uses
  Classes,
  bkdefs,
  clObj32,
  BanklinkOnlineServices;

procedure AddNewProspectRec(const ClientCode, ClientName, Address1,
  Address2, Address3, Phone, Fax, Mobile, Sal, Email, ContactName: string;
  const User: Integer);
procedure UpdateClientRecord(const ClientCode, ClientName, Address1,
  Address2, Address3, Phone, Fax, Mobile, Sal, Email, ContactName: string;
  const UserID: Integer);
function GenerateProspectCode(const Code, ClientName, CurrentCode: string): string;
function IsABadCode( S : String ): Boolean;
function IsCodeValid(Code: string; var Errors: string; CurrentCode: string): Boolean;
function CheckCodeExists(Code: string; Silent: Boolean = False): Boolean;
function GetLastPrintedDate(Code: string; BLRN: Integer): Integer;
procedure SetLastPrintedDate(Code: string; BLRN: Integer);
procedure SetTempPrintedDate(Code: string; BLRN, TempDate: Integer);
function CountEntriesToPurge(TestDate: Integer; TrnsfOnly: boolean; const BankAccountList: TStringList): integer;
function CountUPIs(TestDate: Integer; TrnsfOnly: boolean; const BankAccountList: TStringList): integer;
function OkToPurgeTransaction( pT : pTransaction_Rec; TestDate : integer; PurgeTrnsfOnly : boolean) : boolean;
function OkToPurgeUPI(pT: pTransaction_Rec; TestDate: integer): boolean;
procedure PurgeEntriesFromMyClient(const PurgeDate: integer;
                                   const DelTransferredOnly: boolean;
                                   var TotalDeleted, TotalUnpresented: integer;
                                   const BankAccountList: TStringList);
procedure AttachAccountsToClient(aClient           : TClientObj;
                                 aSelectedAccounts : TStringList;
                                 aClientVendors    : TBloArrayOfGuid;
                                 aVendorNames      : TStringList;
                                 aClientID         : TBloGuid;
                                 aDebugMe          : Boolean;
                                 aClientAccScreen  : Boolean);

const
  UnitName = 'ClientUtils';

implementation

uses
  SysUtils,
  ClientDetailCacheObj,
  Globals,
  SyDefs,
  SycfIO,
  BkConst,
  Admin32,
  ErrorMoreFrm,
  LogUtil,
  trxList32,
  bkdateutils,
  stdate,
  baObj32,
  Files,
  AuditMgr,
  EnterPwdDlg,
  MONEYDEF,
  SYamIO,
  GenUtils,
  InfoMoreFrm,
  bkBranding;

// Check to see if a given client code is valid
function IsABadCode( S : String ): Boolean;
Begin
   S := UpperCase( S );
   result := ( S='CON' ) or ( S='AUX' ) or ( S='COM1' ) or ( S='COM2' ) or
             ( S='PRN' ) or ( S='LPT1' ) or ( S='LPT2' ) or ( S='LPT3' ) or ( S='NUL' ) or
             ( pos( '.', S )>0 ) or
             ( pos( ':', S )>0 ) or
             ( pos( '\', S )>0 ) or
             ( pos( '/', S )>0 ) or
             ( pos( '*', S )>0 ) or
             ( pos( '"', S )>0 ) or
             ( pos( '<', S )>0 ) or
             ( pos( '>', S )>0 ) or
             ( pos( '|', S )>0 ) or
             ( pos( '~', S )>0 ) or
             ( pos( '?', S )>0 );
end;

// Validate a given client code and return errors
function IsCodeValid(Code: string; var Errors: string; CurrentCode: string): Boolean;
var
  cfRec : pClient_File_Rec;
begin
  Result := True;
  Errors := '';
  if Assigned(Adminsystem) then
    cfRec := AdminSystem.fdSystem_Client_File_List.FindCode(Code)
  else
    cfRec := nil;
  if Code = '' then
  begin
    Errors := 'Code must not be blank.';
    Result := False;
  end
  else if IsABadCode(Code) then
  begin
     Errors := 'The code contains invalid characters or is a reserved word.';
     Result := False;
  end
  else if (Code <> CurrentCode) and (cfRec <> nil) then
  begin
    if cfRec.cfClient_Type = ctProspect then
      Errors := 'A Prospect with this code already exists.'
    else
      Errors := 'A Client with this code already exists.';
    Result := False;
  end
  else if Length(Code) > 8 then
  begin
    Errors := 'The code must not be longer than 8 characters';
    Result := False;
  end;
end;

// Generate a new code for a prospective client based on the client name
// (We always must have a client code because BK indexes and searches using client code)
function GenerateProspectCode(const Code, ClientName, CurrentCode: string): string;
var
  i: Integer;
  NewCode, NewName: string;
begin
  NewCode := Trim(Code);
  if NewCode = '' then
  begin
    // Remove any invalid characters to reduce the chance of generating a bad code!
    NewName := UpperCase(ClientName);
    i := 1;
    while i < Length(NewName) do
    begin
      if (NewName[i] = ' ') or (NewName[i] = '.') or
         (NewName[i] = ':') or (NewName[i] = '\') or
         (NewName[i] = '/') or (NewName[i] = '~') or
         (NewName[i] = '*') or (NewName[i] = '"') or
         (NewName[i] = '<') or (NewName[i] = '>') or
         (NewName[i] = '?') then
        Delete(NewName, i, 1)
      else
        Inc(i);
    end;
    // If its now empty use a default
    if NewName = '' then
      Result := 'BK'
    else
      Result := Copy(NewName, 1, 8);
    i := 1;
    while (Result <> CurrentCode) and (AdminSystem.fdSystem_Client_File_List.FindCode(Result) <> nil) do
    begin
      Result := Copy(NewName, 1, 8 - Length(IntToStr(i))) + IntToStr(i);
      Inc(i);
    end;
  end
  else
    Result := Code;
  // Now make sure we never generate a bad code
  i := 1;
  while ((Result <> CurrentCode) and (AdminSystem.fdSystem_Client_File_List.FindCode(Result) <> nil)) or
        (IsABadCode(Result)) do
  begin
    Result := 'BK' + IntToStr(i);
    Inc(i);
  end;
  Result := Result;
end;

//Update an existing Client Record in the Admin System (Used when importing Clients)
procedure UpdateClientRecord(const ClientCode, ClientName, Address1,
  Address2, Address3, Phone, Fax, Mobile, Sal, Email, ContactName: string;
  const UserID: Integer);
const ThisMethodName = 'UpdateClientRecord';
var
  cfrec: pClient_File_Rec;
  Client: TClientObj;
begin
  RefreshAdmin;
  OpenAClient(ClientCode, Client, True);
  cfrec := AdminSystem.fdSystem_Client_File_List.FindCode(ClientCode);
  if Assigned(Client) then
  begin
    Client.clFields.clStaff_Member_LRN := UserID;
    Client.clFields.clAddress_L1 := Copy(Address1, 1, 60);
    Client.clFields.clName := Copy(ClientName, 1, 60);
    Client.clFields.clAddress_L2 := Copy(Address2, 1, 60);
    Client.clFields.clAddress_L3 := Copy(Address3, 1, 60);
    Client.clFields.clContact_Name := Copy(ContactName, 1, 60);
    Client.clFields.clPhone_No := Copy(Phone, 1, 60);
    Client.clFields.clMobile_No := Copy(Mobile, 1, 60);
    Client.clFields.clSalutation := Copy(Sal, 1, 10);
    Client.clFields.clFax_No := Copy(Fax, 1, 60);
    Client.clFields.clClient_Email_Address := Copy(Email, 1,40);
    Client.clFields.clContact_Details_Edit_Date := StDate.CurrentDate;
    Client.clFields.clContact_Details_Edit_Time := StDate.CurrentTime;
    CloseAClient(Client);
  end
  else
  begin
    ClientDetailsCache.Clear;
    ClientDetailsCache.Load(cfrec.cfLRN);

    ClientDetailsCache.Name := Copy(ClientName, 1, 60);
    ClientDetailsCache.Address_L1 := Copy(Address1, 1, 60);
    ClientDetailsCache.Address_L2 := Copy(Address2, 1, 60);
    ClientDetailsCache.Address_L3 := Copy(Address3, 1, 60);
    ClientDetailsCache.Contact_Name := Copy(ContactName, 1, 60);
    ClientDetailsCache.Phone_No := Copy(Phone, 1, 60);
    ClientDetailsCache.Mobile_No := Copy(Mobile, 1, 60);
    ClientDetailsCache.Salutation := Copy(Sal, 1, 10);
    ClientDetailsCache.Fax_No := Copy(Fax, 1, 60);
    ClientDetailsCache.Email_Address := Copy(Email, 1,40);

    ClientDetailsCache.Save(cfrec.cfLRN);
  end;

  if LoadAdminSystem(True, ThisMethodName) then
  begin
    cfrec := AdminSystem.fdSystem_Client_File_List.FindCode(ClientCode);
    cfrec^.cfUser_Responsible := UserID;
    cfrec^.cfFile_Name := ClientDetailsCache.Name;
    cfrec^.cfContact_Details_Edit_Date := StDate.CurrentDate;
    cfrec^.cfContact_Details_Edit_Time := StDate.CurrentTime;

    //*** Flag Audit ***
    SystemAuditMgr.FlagAudit(arSystemClientFiles);

    SaveAdminSystem;
  end
  else
    HelpfulErrorMsg('Unable to update Client at this time.  Admin system unavailable.',0);

  //RefreshLookup( ClientCode);
end;


// Insert a new prospective client record into the admin system
procedure AddNewProspectRec(const ClientCode, ClientName, Address1,
  Address2, Address3, Phone, Fax, Mobile, Sal, Email, ContactName: string;
  const User: Integer);
const
  ThisMethodName = 'AddNewProspectRec';
var
  cfrec: pClient_File_Rec;
begin
  if LoadAdminSystem(True, ThisMethodName) then
  begin
    cfrec := New_Client_File_Rec;
    cfrec^.cfFile_Code := ClientCode;
    cfrec^.cfClient_Type := ctProspect;
    cfrec^.cfUser_Responsible := User;
    Inc(AdminSystem.fdFields.fdClient_File_LRN_Counter);
    cfrec^.cfLRN := AdminSystem.fdFields.fdClient_File_LRN_Counter ;
    AdminSystem.fdSystem_Client_File_List.Insert(cfrec);
    with ClientDetailsCache do
    begin
      // auto-truncate to max lengths
      Code := Copy(ClientCode, 1, 8);
      Name := Copy(ClientName, 1, 60);
      Address_L1 := Copy(Address1, 1, 60);
      Address_L2 := Copy(Address2, 1, 60);
      Address_L3 := Copy(Address3, 1, 60);
      Contact_Name := Copy(ContactName, 1, 60);
      Phone_No := Copy(Phone, 1, 60);
      Mobile_No := Copy(Mobile, 1, 60);
      Salutation := Copy(Sal, 1, 10);
      Fax_No := Copy(Fax, 1, 60);
      Email_Address := Copy(Email, 1,40);
      Save(cfrec^.cfLRN);
    end;
    cfrec^.cfFile_Name := ClientDetailsCache.Name;

    //*** Flag Audit ***
    SystemAuditMgr.FlagAudit(arSystemClientFiles);
    
    SaveAdminSystem;
  end
  else
     HelpfulErrorMsg('Unable to add Prospect at this time.  Admin system unavailable.',0);
end;

function CheckCodeExists(Code: string; Silent: Boolean = False): Boolean;
const
  ThisMethodName = 'CheckCodeExists';
var
  Msg: string;
begin
  Result := True;
  RefreshAdmin;
  if (AdminSystem.fdSystem_Client_File_List.FindCode(Code) = nil) then
  begin
    Msg := Format('Code "%s" could not be found in the Admin System.', [Code]);
    if not Silent then
      HelpfulErrorMsg(Msg, 0);
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' : ' + Msg );
    Result := False;
  end;
end;

// Given a client code and bank account number, find the last Sched Rep printed date in the client-account map
function GetLastPrintedDate(Code: string; BLRN: Integer): Integer;
var
  pM: pClient_Account_Map_Rec;
  pF: pClient_File_Rec;
begin
  Result := 0;
  pF := AdminSystem.fdSystem_Client_File_List.FindCode(Code);
  if Assigned(pF) then
  begin
    pM := AdminSystem.fdSystem_Client_Account_Map.FindLRN(BLRN, pF.cfLRN);
    if Assigned(pM) then
      Result := pM.amLast_Date_Printed;
  end;
end;

procedure SetLastPrintedDate(Code: string; BLRN: Integer);
var
  pM: pClient_Account_Map_Rec;
  pF: pClient_File_Rec;
begin
  pF := AdminSystem.fdSystem_Client_File_List.FindCode(Code);
  if Assigned(pF) then
  begin
    pM := AdminSystem.fdSystem_Client_Account_Map.FindLRN(BLRN, pF.cfLRN);
    if Assigned(pM) and (pM.amTemp_Last_Date_Printed <> 0) and (pM.amTemp_Last_Date_Printed > pM.amLast_Date_Printed) then
    begin
      pM.amLast_Date_Printed := pM.amTemp_Last_Date_Printed;
      pM.amTemp_Last_Date_Printed := 0;
    end;
  end;
end;

procedure SetTempPrintedDate(Code: string; BLRN, TempDate: Integer);
var
  pM: pClient_Account_Map_Rec;
  pF: pClient_File_Rec;
begin
  pF := AdminSystem.fdSystem_Client_File_List.FindCode(Code);
  if Assigned(pF) then
  begin
    pM := AdminSystem.fdSystem_Client_Account_Map.FindLRN(BLRN, pF.cfLRN);
    if Assigned(pM) and (TempDate > pM.amLast_Date_Printed) then
      pM.amTemp_Last_Date_Printed := TempDate;
  end;
end;

function OkToPurgeUPI( pT : pTransaction_Rec; TestDate : integer) : boolean;
var
  IsUPC, IsUPD, IsUPW: boolean;
begin
  //Note: The following matches the selection criteria for UPI's in the
  //Bank Rec Report (except for UPC's with amount = 0). These items should
  //not be purged because they may alter the report totals.

  //Unpresented cheques that shouldn't be pruged
  IsUPC := (pT^.txUPI_State in [upUPC, upMatchedUPC, upBalanceOfUPC,
                                upReversedUPC, upReversalOfUPC]) and
           (pT^.txDate_Effective < TestDate) and
           ((pT^.txDate_Presented = 0) or
            (pT^.txDate_Presented >= TestDate));
  //Unpresented deposits that shouldn't be pruged
  IsUPD := (pT^.txUPI_State in [upUPD, upMatchedUPD, upBalanceOfUPD,
                                upReversedUPD,upReversalOfUPD]) and
           (pT^.txDate_Effective < TestDate) and
           ((pT^.txDate_Presented = 0) or
            (pT^.txDate_Presented >= TestDate));
  //Unpresented withdraws that shouldn't be pruged
  IsUPW := (pT^.txUPI_State in [upUPW, upMatchedUPW, upBalanceOfUPW,
                                upReversedUPW, upReversalOfUPW]) and
           (pT^.txDate_Effective < TestDate) and
           ((pT^.txDate_Presented = 0) or
            (pT^.txDate_Presented >= TestDate));

  Result := not (IsUPC or IsUPD or IsUPW);
end;

function CountEntriesToPurge( TestDate : tStDate; TrnsfOnly : boolean; const BankAccountList: TStringList) : integer;
Var
   Count  : integer;
   p      : pTransaction_Rec;
   i,j    : Integer;
begin
   Count := 0;
   with myClient.clBank_Account_List do for i := 0 to Pred(ItemCount) do
      with Bank_Account_At(i), baTransaction_List do
      begin
         if (BankAccountList = nil) or
            (BankAccountList.IndexOf(baFields.baBank_Account_Number) > -1) then
         begin
           for j := 0 to Pred(baTransaction_List.ItemCount) do begin
            p := Transaction_At(j);
            if OkToPurgeTransaction(p, TestDate, TrnsfOnly) then
               Inc(Count)
            else
               //See if effective date is greater than test date. If so there
               //will be no more entries as entries are sorted in eff date order
               if p^.txDate_Effective >= TestDate then
                  Break;

               ;//Break;  //leave transaction loop
            end;
         end ;
      end;
   Result := Count;
End;

function CountUPIs(TestDate: Integer; TrnsfOnly: boolean; const
  BankAccountList: TStringList): integer;
var
  p: pTransaction_Rec;
  i,j: Integer;
  ClientBankAccount: TBank_Account;
  BankAccountNo: string;
begin
  Result := 0;
  for i := 0 to Pred(myClient.clBank_Account_List.ItemCount) do begin
    ClientBankAccount := myClient.clBank_Account_List.Bank_Account_At(i);
    BankAccountNo := ClientBankAccount.baFields.baBank_Account_Number;
    if (BankAccountList = nil) or
       (BankAccountList.IndexOf(BankAccountNo) > -1) then begin
      for j := 0 to Pred(ClientBankAccount.baTransaction_List.ItemCount) do begin
        p := ClientBankAccount.baTransaction_List.Transaction_At(j);
        if p^.txDate_Effective >= TestDate then
          Break;
        if not OkToPurgeUPI(p, testDate) then
          Inc(Result);
      end;
    end;
  end;
end;

function OkToPurgeTransaction( pT : pTransaction_Rec; TestDate : integer; PurgeTrnsfOnly : boolean) : boolean;
begin
  Result := (pT^.txDate_Effective < TestDate) and
            ((not PurgeTrnsfOnly) or
             (PurgeTrnsfOnly and (pT^.txDate_Transferred <> 0)));
  Result := Result and (OkToPurgeUPI(pT, TestDate));
end;

procedure PurgeEntriesFromMyClient(const PurgeDate: integer;
  const DelTransferredOnly: boolean; var TotalDeleted,
  TotalUnpresented: integer; const BankAccountList: TStringList);
var
   i                  : integer;
   b                  : integer;
   BankAccount        : TBank_Account;
   NewTransactionList : TTransaction_List;
   pT                 : pTransaction_Rec;
   NoDeleted          : integer;
   sMsg               : string;
begin
  TotalDeleted := 0;
  //Get the total for unpresented items that will not be purged
  TotalUnpresented := CountUPIs(PurgeDate, DelTransferredOnly, BankAccountList);
  //cycle thru each bank account (including journals)
  with MyClient do
  begin
    for b := 0 to Pred( clBank_Account_List.ItemCount) do
    Begin
      BankAccount := clBank_Account_List.Bank_Account_At( b );
      with BankAccount do
      begin
        //Create a new transaction list
        if (BankAccountList = nil) or
           (BankAccountList.IndexOf(baFields.baBank_Account_Number) > -1) then
        begin
          NewTransactionList := TTransaction_List.Create( MyClient, BankAccount, MyClient.FClientAuditMgr );
          NoDeleted := 0;
              //look thru each transaction
          for i := 0 to Pred( baTransaction_List.ItemCount) do
          begin
            pT := baTransaction_List.Transaction_At(i);
            //delete transaction and set the pointer to nil if before purge date
            //also check to see if has been transfered
            if OkToPurgeTransaction( pT, PurgeDate, DelTransferredOnly) then begin
               Dispose_Transaction_Rec( pT );
               pT := nil;
               Inc( NoDeleted );
               Inc( TotalDeleted );
            end
            else
            begin
              //transaction should be kept so add to New Transaction List
              NewTransactionList.Insert_Transaction_Rec( pT, False);
            end;
          end;
          //Check to see if anything changed
          if NoDeleted > 0 then
          begin
            //clear the existing trans list and point to the new list
            baTransaction_List.DeleteAll;
            baTransaction_List.Free;
            baTransaction_List := NewTransactionList;
            sMsg := Format('%d Entries with a presentation date prior to ' +
                           '%s were purged from account %s',
                           [ NoDeleted,
                             BkDate2Str(PurgeDate),
                             baFields.baBank_Account_Number]);
            LogUtil.LogMsg(lmInfo, UnitName, sMsg);

            //*** Flag Audit ***
            MyClient.ClientAuditMgr.FlagAudit(arClientBankAccounts,
                                              baFields.baAudit_Record_ID,
                                              aaNone,
                                              sMsg);
          end
          else
          begin
            //Nothing deleted so don't need to use new list, empty pointers and free
            NewTransactionList.DeleteAll;
            NewTransactionList.Free;
          end;
        end; // if
      end; //with BankAccount
    end; /// b
  end; //with myClient
end;

procedure AttachAccountsToClient(aClient           : TClientObj;
                                 aSelectedAccounts : TStringList;
                                 aClientVendors    : TBloArrayOfGuid;
                                 aVendorNames      : TStringList;
                                 aClientID         : TBloGuid;
                                 aDebugMe          : Boolean;
                                 aClientAccScreen  : Boolean);
const
  ThisMethodName = 'ClientUtils.AttachAccountsToClient';
var
  AdminBankAccount : pSystem_Bank_Account_Rec;
  NewBankAccount : tBank_Account;
  AccIndex : integer;
  AccountOK : boolean;
  ChangedAdmin : boolean;
  Msg : String;
  pM: pClient_Account_Map_Rec;
  pF: pClient_File_Rec;
  AccountsMsg : TStringList;
  AlreadyAttachedList, NoBLOSecureCodeList, BLOCodeDoesNotMatchList,
  AttachedSuccessfullyList, DirectDeliveryNotEnabled, NonOnlineSecureAccounts: TStringList;

  i: integer;
begin
  ChangedAdmin := false;

  try
    //first check for passwords needed or if already added
    for AccIndex := 0 to aSelectedAccounts.Count-1 do
    begin
      AccountOK := true;

      AdminBankAccount := AdminSystem.fdSystem_Bank_Account_List.FindCode(aSelectedAccounts.Strings[AccIndex]);
      if Assigned(AdminBankAccount) then
      begin
        //check to see if a password is required
        if AdminBankAccount^.sbAccount_Password <> '' then
        begin
          if not EnterPassword('Attach Account '+AdminBankAccount^.sbAccount_Number,
            AdminBankAccount^.sbAccount_Password,0,false,true) then
          begin
            HelpfulErrorMsg('Invalid Password.  Permission to attach this account is denied.',0);
            AccountOK := false;
          end;
        end
        else if ( aClient.clBank_Account_List.FindCode( AdminBankAccount^.sbAccount_Number ) <> nil ) then
        begin
          {
          Msg := Format( 'BankAccount %s is already attached to this Client',
                         [ AdminBankAccount^.sbAccount_Number ] );
          HelpfulErrorMsg( Msg, 0 );
          }
          if not Assigned(AlreadyAttachedList) then
            AlreadyAttachedList := TStringList.Create;
          AlreadyAttachedList.Add(AdminBankAccount^.sbAccount_Number);
          AccountOK := false;
        end
        else if (AdminBankAccount^.sbAccount_Type = sbtOnlineSecure) and not (aClient.clExtra.ceDeliverDataDirectToBLO) then
        begin
          if not Assigned(DirectDeliveryNotEnabled) then
          begin
            DirectDeliveryNotEnabled := TStringList.Create;
          end;

          DirectDeliveryNotEnabled.Add(AdminBankAccount^.sbAccount_Number);

          AccountOk := False;
        end
        else if (AdminBankAccount^.sbAccount_Type = sbtOnlineSecure) and
                (aClient.clExtra.ceBLOSecureCode = '') then
        begin
          {
          Msg := 'You cannot attach this bank account to the selected client file ' +
                 'because the client file does not have a BankLink Online Secure Code.';

          if not aClientAccScreen then
             Msg := Msg + ' Click OK to return and select a different account or client file.';

          HelpfulErrorMsg( Msg, 0 );
          }
          if not Assigned(NoBLOSecureCodeList) then
            NoBLOSecureCodeList := TStringList.Create;
          NoBLOSecureCodeList.Add(AdminBankAccount^.sbAccount_Number);
          AccountOK := false;
        end
        else if (AdminBankAccount^.sbAccount_Type = sbtOnlineSecure) and
                (uppercase(aClient.clExtra.ceBLOSecureCode) <> uppercase(AdminBankAccount.sbSecure_Online_Code)) then
        begin
          {
          Msg := 'You cannot attach the selected bank account(s) to the client file ' +
                 'because the BankLink Online Secure Codes do not match.';

          if not aClientAccScreen then
             Msg := Msg + ' Click OK to return and select a different account or client file.';
          HelpfulErrorMsg( Msg, 0 );
          }
          if not Assigned(BLOCodeDoesNotMatchList) then
            BLOCodeDoesNotMatchList := TStringList.Create;
          BLOCodeDoesNotMatchList.Add(AdminBankAccount^.sbAccount_Number);
          AccountOK := false;
        end
        else if (aClient.clExtra.ceDeliverDataDirectToBLO) and (trim(aClient.clExtra.ceBLOSecureCode) = '') then
        begin
          if not Assigned(NoBLOSecureCodeList) then
          begin
            NoBLOSecureCodeList := TStringList.Create;
          end;

          NoBLOSecureCodeList.Add(AdminBankAccount^.sbAccount_Number);

          AccountOK := false;        
        end
        else if aClient.clExtra.ceDeliverDataDirectToBLO and (AdminBankAccount^.sbAccount_Type <> sbtOnlineSecure) then
        begin
          if not Assigned(NonOnlineSecureAccounts) then
          begin
            NonOnlineSecureAccounts := TStringList.Create;
          end;
          
          NonOnlineSecureAccounts.Add(AdminBankAccount^.sbAccount_Number);

          AccountOK := false;          
        end
        else if (aClient.clExtra.ceDeliverDataDirectToBLO) and (uppercase(aClient.clExtra.ceBLOSecureCode) <> uppercase(AdminBankAccount.sbSecure_Online_Code)) then
        begin
          if not Assigned(BLOCodeDoesNotMatchList) then
          begin
            BLOCodeDoesNotMatchList := TStringList.Create;
          end;
          
          BLOCodeDoesNotMatchList.Add(AdminBankAccount^.sbAccount_Number);

          AccountOK := false;
        end
      end
      else
        AccountOK := false; //could not be found

      if not AccountOK then
        aSelectedAccounts.Strings[AccIndex] := '';
    end;

    Msg := '';
    if Assigned(AlreadyAttachedList) then
    begin
      Msg := 'The following bank account(s) are already attached to the client:' + #10;
      for i := 0 to AlreadyAttachedList.Count - 1 do
        Msg := Msg + AlreadyAttachedList.Strings[i] + #10;
      Msg := Msg + #10;
    end;

    if Assigned(DirectDeliveryNotEnabled) then
    begin
      Msg := Msg + 'The following bank account(s) cannot be attached to the selected ' +
             'client file because the client file is not enabled for delivering data directly to '+ bkBranding.ProductOnlineName + ':' + #10;
      for i := 0 to DirectDeliveryNotEnabled.Count - 1 do
        Msg := Msg + DirectDeliveryNotEnabled.Strings[i] + #10;
      Msg := Msg + #10;
    end;
    
    if Assigned(NoBLOSecureCodeList) then
    begin
      Msg := Msg + 'The following bank account(s) cannot be attached to the selected ' +
             'client file because the client file does not have a ' + bkBranding.ProductOnlineName +
             'Secure Code:' + #10;
      for i := 0 to NoBLOSecureCodeList.Count - 1 do
        Msg := Msg + NoBLOSecureCodeList.Strings[i] + #10;
      Msg := Msg + #10;
    end;

    if Assigned(BLOCodeDoesNotMatchList) then
    begin
      Msg := Msg + 'The following bank account(s) cannot be attached to the selected ' +
             'client file because the ' + bkBranding.ProductOnlineName + ' Secure Codes do not match: ' + #10;
      for i := 0 to BLOCodeDoesNotMatchList.Count - 1 do
        Msg := Msg + BLOCodeDoesNotMatchList.Strings[i] + #10;
      Msg := Msg + #10;
    end;

    if Assigned(NonOnlineSecureAccounts) then
    begin
      Msg := Msg + 'The following bank account(s) cannot be attached to the selected ' +
             'client file because they are not ' + bkBranding.ProductOnlineName + ' Secure account(s): ' + #10;
      for i := 0 to NonOnlineSecureAccounts.Count - 1 do
        Msg := Msg + NonOnlineSecureAccounts.Strings[i] + #10;
      Msg := Msg + #10;
    end;
    
    if Assigned(AttachedSuccessfullyList) then
    begin
      Msg := Msg + 'The following bank account(s) were successfully attached:' + #10;
      for i := 0 to AttachedSuccessfullyList.Count - 1 do
        Msg := Msg + AttachedSuccessfullyList.Strings[i] + #10;
      Msg := Msg + #10;
    end;

    Msg := Trim(Msg);

    if Msg <> '' then
    begin
      HelpfulErrorMsg( Msg, 0 );
    end;
  finally
    if Assigned(AlreadyAttachedList) then    
      FreeAndNil(AlreadyAttachedList);
    if Assigned(NoBLOSecureCodeList) then
      FreeAndNil(NoBLOSecureCodeList);
    if Assigned(BLOCodeDoesNotMatchList) then
      FreeAndNil(BLOCodeDoesNotMatchList);
    if Assigned(AttachedSuccessfullyList) then
      FreeAndNil(AttachedSuccessfullyList);
    if Assigned(DirectDeliveryNotEnabled) then
      FreeAndNil(DirectDeliveryNotEnabled);
    if Assigned(NonOnlineSecureAccounts) then
      FreeAndNil(NonOnlineSecureAccounts);
  end;

  //accounts verified, now attach them
  AccountsMsg := TStringList.Create;
  Try
    if LoadAdminSystem(true, ThisMethodName ) then
    begin
      for AccIndex := 0 to aSelectedAccounts.Count-1 do
      begin
        if aSelectedAccounts.Strings[AccIndex] <> '' then
        begin
          AdminBankAccount := AdminSystem.fdSystem_Bank_Account_List.FindCode(aSelectedAccounts.Strings[AccIndex]);
          if Assigned(AdminBankAccount) then
          begin
            if aDebugMe then
              LogUtil.LogMsg(lmDebug, UnitName, 'Attach Bank Account ' +
                                                AdminBankAccount.sbAccount_Number +
                                                ' to Client ' +
                                                aClient.clFields.clCode);

            //update admin and attach bank account
            AdminBankAccount.sbAttach_Required := false;
            ChangedAdmin := true;

            with aClient.clBank_Account_List do
            begin
              if ( FindCode(AdminBankAccount.sbAccount_Number) = nil ) then
              begin
                {update bankaccount in client file}
                NewBankAccount := TBank_Account.Create(MyClient);

                with NewBankAccount do
                begin
                  baFields.baBank_Account_Number     := AdminBankAccount.sbAccount_Number;
                  baFields.baBank_Account_Name       := AdminBankAccount.sbAccount_Name;
                  baFields.baBank_Account_Password   := AdminBankAccount.sbAccount_Password;
                  baFields.baCurrent_Balance         := Unknown;  //dont assign bal until have all trx
                  baFields.baBank_Account_Password   := AdminBankAccount.sbAccount_Password;
                  baFields.baApply_Master_Memorised_Entries := true;
                  baFields.baDesktop_Super_Ledger_ID := -1;
                  baFields.baCurrency_Code           := AdminBankAccount.sbCurrency_Code;
                  //Provisional bank account
                  if AdminBankAccount.sbAccount_Type = sbtProvisional then
                  begin
                    baFields.baIs_A_Provisional_Account := True;
                      //Needed to force client file save so transactions can't be
                      //altered before audit.
                    aClient.ClientAuditMgr.ProvisionalAccountAttached := True;
                  end;
                  baFields.baCore_Account_ID         := AdminBankAccount.sbCore_Account_ID;
                  baFields.baSecure_Online_Code      := AdminBankAccount.sbSecure_Online_Code;
                end;

                if (Assigned(aClientVendors)) and
                   (aClientID <> '') and
                   (ProductConfigService.IsExportDataEnabledFoAccount(NewBankAccount)) then
                begin
                  if ProductConfigService.SaveAccountVendorExports(aClientID,
                                                                   NewBankAccount.baFields.baCore_Account_ID,
                                                                   NewBankAccount.baFields.baBank_Account_Name,
                                                                   NewBankAccount.baFields.baBank_Account_Number,
                                                                   aClientVendors,
                                                                   True,
                                                                   True,
                                                                   False) then
                  begin
                    AccountsMsg.Add(NewBankAccount.baFields.baBank_Account_Number);
                  end;
                end;

                Insert(NewBankAccount);

                // Add to client-account map
                pF := AdminSystem.fdSystem_Client_File_List.FindCode(aClient.clFields.clCode);
                if Assigned(pF) and (not Assigned(AdminSystem.fdSystem_Client_Account_Map.FindLRN(AdminBankAccount.sbLRN, pF.cfLRN))) then
                begin
                  pM := New_Client_Account_Map_Rec;
                  if Assigned(pM) then
                  begin
                    pM.amClient_LRN := pF.cfLRN;
                    pM.amAccount_LRN := AdminBankAccount.sbLRN;
                    pM.amLast_Date_Printed := 0;
                    AdminSystem.fdSystem_Client_Account_Map.Insert(pM);
                  end;
                end;
              end;
            end;
          end
          else
            //couldn't find it, might as well continue on
            LogUtil.LogMsg(lmInfo,UnitName,'Bank Account ' +
                                           aSelectedAccounts.Strings[AccIndex] +
                                           ' no longer found in Admin System.  Account will be skipped.');
        end; {if selected}
      end; {Cycle through Accounts}

      if ChangedAdmin then
      begin
        //*** Flag Audit ***
        SystemAuditMgr.FlagAudit(arAttachBankAccounts);

        SaveAdminSystem;
      end
      else
        UnlockAdmin;  //no changes made
    end
    else
      HelpfulErrorMsg('Unable to Attach Accounts.  Admin System cannot be loaded',0);

    if (AccountsMsg.Count > 0) and
       (Assigned(aVendorNames)) then
    begin
      Msg := 'You have attached the following bank account(s) to client file ' +
             aClient.clFields.clName + ' ' + aClient.clFields.clCode + ' : ' +
             GetCommaSepStrFromList(AccountsMsg) + '. This will enable the export ' +
             'of data to ' + bkBranding.ProductOnlineName + ' for ' + GetCommaSepStrFromList(aVendorNames) +
             '. ' + #10#10 + 'If you do not want to send transactions to ' + bkBranding.ProductOnlineName + ' for these ' +
             'accounts you can deselect them via Other Functions | Bank Accounts.';

      HelpfulInfoMsg(Msg,0);
    end;

  Finally
    FreeAndNil(AccountsMsg);
  End;
end;

end.
