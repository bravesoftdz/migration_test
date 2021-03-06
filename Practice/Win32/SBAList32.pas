unit SBAList32;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//System Bank Accounts List
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
interface
uses
  ECollect,Classes, syDefs, ioStream, sysUtils, AuditMgr;

Type
   tSystem_Bank_Account_List = class(TExtdSortedCollection)
      constructor Create; override;
      function    Compare( Item1, Item2 : pointer ) : integer; override;
   protected
      procedure   FreeItem( Item : Pointer ); override;
      function    FindRecordID( ARecordID : integer ):  pSystem_Bank_Account_Rec;
   public
      function    System_Bank_Account_At( Index : LongInt ): pSystem_Bank_Account_Rec;
      function    FindCode( ACode : String ): pSystem_Bank_Account_Rec;
      function    FindLRN(LRN: LongInt): pSystem_Bank_Account_Rec;
      function    NewAccountsCount: Integer;
      function    UnAttachedAccounts: Integer;
      function    InactiveAccounts: Integer;
      function    ChargingAccountsCount: Integer;
      procedure   SaveToFile(var S : TIOStream );
      procedure   LoadFromFile(var S : TIOStream );

      procedure   DoAudit(AAuditType: TAuditType; ASysBankAccountTableCopy: tSystem_Bank_Account_List; var AAuditTable: TAuditTable);
      procedure   SetAuditInfo(P1, P2: pSystem_Bank_Account_Rec; var AAuditInfo: TAuditInfo);
      procedure   Insert(Item: Pointer); override;
   end;

//******************************************************************************
implementation
uses
   SYSBIO, TOKENS, LogUtil, MALLOC, StStrS, bkdbExcept, SYAUDIT,
   bk5except;

CONST
   DebugMe : Boolean = FALSE;
   UnitName = 'SBALIST32';

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
{ tSystem_Bank_Account_List }

function tSystem_Bank_Account_List.ChargingAccountsCount: Integer;
var i: Integer;
    pBankAccount: pSystem_Bank_Account_Rec;
begin
  result := 0;
  for i:= 0 to self.ItemCount-1 do begin
    pBankAccount := pSystem_Bank_Account_Rec(At(i));
    if NOT(pBankAccount.sbNo_Charge_Account) then
      result := result+1;
  end;
end;

function tSystem_Bank_Account_List.Compare(Item1, Item2: pointer): integer;
begin
   Compare := STStrS.CompStringS(pSystem_Bank_Account_Rec(Item1).sbAccount_Number, pSystem_Bank_Account_Rec(Item2).sbAccount_Number);
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
constructor tSystem_Bank_Account_List.Create;
const
  ThisMethodName = 'TSystem_Bank_Account_List.Create';
begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   inherited Create;
   Duplicates := false;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure tSystem_Bank_Account_List.DoAudit(AAuditType: TAuditType;
  ASysBankAccountTableCopy: tSystem_Bank_Account_List;
  var AAuditTable: TAuditTable);
var
  i: integer;
  P1, P2: pSystem_Bank_Account_Rec;
  AuditInfo: TAuditInfo;
begin
  AuditInfo.AuditType := arSystemBankAccounts;
  AuditInfo.AuditUser := SystemAuditMgr.CurrentUserCode;
  AuditInfo.AuditRecordType := tkBegin_System_Bank_Account;
  //Adds, changes
  for I := 0 to Pred( itemCount ) do begin
    P1 := Items[i];
    P2 := ASysBankAccountTableCopy.FindRecordID(P1.sbAudit_Record_ID);
    AuditInfo.AuditRecord := New_System_Bank_Account_Rec;
    try
      SetAuditInfo(P1, P2, AuditInfo);
      if AuditInfo.AuditAction in [aaAdd, aaChange] then
        AAuditTable.AddAuditRec(AuditInfo);
      finally
        Dispose(AuditInfo.AuditRecord);
      end;
  end;
  //Deletes
  for i := 0 to ASysBankAccountTableCopy.ItemCount - 1 do begin
    P2 := ASysBankAccountTableCopy.Items[i];
    P1 := FindRecordID(P2.sbAudit_Record_ID);
    AuditInfo.AuditRecord := New_System_Bank_Account_Rec;
    try
      SetAuditInfo(P1, P2, AuditInfo);
      if (AuditInfo.AuditAction = aaDelete) then
        AAuditTable.AddAuditRec(AuditInfo);
    finally
      Dispose(AuditInfo.AuditRecord);
    end;
  end;
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function tSystem_Bank_Account_List.FindCode(ACode: String): pSystem_Bank_Account_Rec;
const
  ThisMethodName = 'TSystem_Bank_Account_List.FindCode';
var
  L, H, I, C: Integer;
  pBa       : pSystem_Bank_Account_Rec;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Called' );
  result := nil;
  L := 0;
  H := ItemCount - 1;
  if L>H then begin
    if DebugMe then LogUtil.LogMsg(lmDebug,UnitName,Format('%s : No Items',[ThisMethodName]));
    exit;      {no items in list}
  end;

  repeat
    I := (L + H) shr 1;
    pBa := pSystem_Bank_Account_Rec(At(i));
    C := STStrS.CompStringS(ACode, pba^.sbAccount_Number);
    if C > 0 then L := I + 1 else H := I - 1;
  until (c=0) or (L>H);

  if c=0 then result := pBa;
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function tSystem_Bank_Account_List.FindLRN(LRN: LongInt): pSystem_Bank_Account_Rec;
const
  ThisMethodName = 'TSystem_Bank_Account_List.FindLRN';
var
  I: Integer;
  pBa: pSystem_Bank_Account_Rec;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Called' );
  result := nil;
  for i := 0 to Pred(ItemCount) do
  begin
    pBa := pSystem_Bank_Account_Rec(At(i));
    if pBA^.sbLRN = LRN then
    begin
      result := pBA;
      Break;
    end;
  end;
end;

function tSystem_Bank_Account_List.FindRecordID(
  ARecordID: integer): pSystem_Bank_Account_Rec;
const
  ThisMethodName = 'TSystem_Bank_Account_List.FindRecordID';
var
  i : LongInt;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug,UnitName,Format('%s : Called with %d',[ThisMethodName, ARecordID]));
  Result := NIL;
  if (itemCount = 0 ) then Exit;

  for I := 0 to Pred( itemCount ) do
    with System_Bank_Account_At( I )^ do
      if sbAudit_Record_ID = ARecordID then begin
        Result := System_Bank_Account_At( I );
        if DebugMe then LogUtil.LogMsg(lmDebug,UnitName,Format('%s : Found',[ThisMethodName]));
          Exit;
      end;

   if DebugMe then LogUtil.LogMsg(lmDebug,UnitName,Format('%s : Not Found',[ThisMethodName]));
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure tSystem_Bank_Account_List.FreeItem(Item: Pointer);
const
  ThisMethodName = 'TSystem_Bank_Account_List.FreeItem';
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

  SYSBIO.Free_System_Bank_Account_Rec_Dynamic_Fields( pSystem_Bank_Account_Rec( Item)^);
  SafeFreeMem( Item, System_Bank_Account_Rec_Size );

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure tSystem_Bank_Account_List.LoadFromFile(var S: TIOStream);
const
  ThisMethodName = 'TSystem_Bank_Account_List.LoadFromFile';
Var
   Token       : Byte;
   SB          : pSystem_Bank_Account_Rec;
   Msg         : string;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   Token := S.ReadToken;
   While ( Token <> tkEndSection ) do
   Begin
      Case Token of
         tkBegin_System_Bank_Account :
            Begin
               MALLOC.SafeGetMem( SB, System_Bank_Account_Rec_Size );
               If not Assigned( SB ) then
               Begin
                  Msg := Format( '%s : Unable to Allocate SB',[ThisMethodName]);
                  LogUtil.LogMsg(lmError, UnitName, Msg );
                  raise EInsufficientMemory.CreateFmt( '%s - %s', [ UnitName, Msg ] );
               end;
               Read_System_Bank_Account_Rec ( SB^, S );
               inherited Insert( SB );
            end;
         else
         begin { Should never happen }
            Msg := Format( '%s : Unknown Token %d', [ ThisMethodName, Token ] );
            LogUtil.LogMsg(lmError, UnitName, Msg );
            raise ETokenException.CreateFmt( '%s - %s', [ UnitName, Msg ] );
         end;
      end; { of Case }
      Token := S.ReadToken;
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;


function tSystem_Bank_Account_List.NewAccountsCount: Integer;
var i: Integer;
    pBankAccount: pSystem_Bank_Account_Rec;
begin
  result := 0;
  for i:= 0 to self.ItemCount-1 do begin
    pBankAccount := pSystem_Bank_Account_Rec(At(i));
    if pBankAccount.sbNew_This_Month
    and pBankAccount.sbAttach_Required
    and not(pBankAccount.sbMark_As_Deleted) then
      result := result+1;
  end;
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure tSystem_Bank_Account_List.SaveToFile(var S: TIOStream);
const
  ThisMethodName = 'TSystem_Bank_Account_List.SaveToFile';
Var
   i        : LongInt;
   SB       : pSystem_Bank_Account_Rec;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   S.WriteToken( tkBeginSystem_Bank_Account_List );

   For i := 0 to Pred( itemCount ) do
   Begin
      SB := pSystem_Bank_Account_Rec( At( i ) );
      SYSBIO.Write_System_Bank_Account_Rec ( SB^, S );
   end;

   S.WriteToken( tkEndSection );

   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
   if DebugMe then LogUtil.LogMsg(lmDebug,UnitName,Format('%s : %d account records saved',[ThisMethodName,ItemCount]));
end;

procedure tSystem_Bank_Account_List.SetAuditInfo(P1,
  P2: pSystem_Bank_Account_Rec; var AAuditInfo: TAuditInfo);
begin
  AAuditInfo.AuditAction := aaNone;
  if not Assigned(P1) then begin
    //Delete
    AAuditInfo.AuditAction := aaDelete;
    AAuditInfo.AuditRecordID := P2.sbAudit_Record_ID;
  end else if Assigned(P2) then begin
    //Change
    AAuditInfo.AuditRecordID := P1.sbAudit_Record_ID;
    AAuditInfo.AuditParentID := SystemAuditMgr.GetParentRecordID(AAuditInfo.AuditRecordType,
                                                                 AAuditInfo.AuditRecordID);
    if System_Bank_Account_Rec_Delta(P1, P2, AAuditInfo.AuditRecord, AAuditInfo.AuditChangedFields) then
      AAuditInfo.AuditAction := aaChange;
  end else begin
    //Add
    AAuditInfo.AuditAction := aaAdd;
    AAuditInfo.AuditRecordID := P1.sbAudit_Record_ID;
    AAuditInfo.AuditParentID := SystemAuditMgr.GetParentRecordID(AAuditInfo.AuditRecordType,
                                                                 AAuditInfo.AuditRecordID);
    P1.sbAudit_Record_ID := AAuditInfo.AuditRecordID;
    SYSBIO.SetAllFieldsChanged(AAuditInfo.AuditChangedFields);
    Copy_System_Bank_Account_Rec(P1, AAuditInfo.AuditRecord);
  end;
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function tSystem_Bank_Account_List.System_Bank_Account_At(Index: Integer): pSystem_Bank_Account_Rec;
const
  ThisMethodName = 'TSystem_Bank_Account_List.System_Bank_Account_At';
Var
   P : Pointer;
Begin
   System_Bank_Account_At := nil;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   P := At( Index );
   If SYSBIO.IsASystem_Bank_Account_Rec(p) then
      result := P;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function tSystem_Bank_Account_List.UnAttachedAccounts: Integer;
var i: Integer;
    pBankAccount: pSystem_Bank_Account_Rec;
begin
  Result := 0;
  for i:= 0 to self.Last do begin
    pBankAccount := pSystem_Bank_Account_Rec(At(i));
    if pBankAccount.sbAttach_Required
    and not(pBankAccount.sbMark_As_Deleted) then
      Inc(Result)
  end;
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function tSystem_Bank_Account_List.InactiveAccounts: Integer;
var i: Integer;
    pBankAccount: pSystem_Bank_Account_Rec;
begin
  Result := 0;
  for i:= 0 to self.Last do begin
    pBankAccount := pSystem_Bank_Account_Rec(At(i));
    if pBankAccount.sbInActive
    and not(pBankAccount.sbMark_As_Deleted) then
      Inc(Result)
  end;
end;

procedure tSystem_Bank_Account_List.Insert(Item: Pointer); 
begin
  pSystem_Bank_Account_Rec(Item).sbAudit_Record_ID := SystemAuditMgr.NextAuditRecordID;
  inherited Insert(Item);
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
initialization
  DebugMe := DebugUnit(UnitName);

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
end.
