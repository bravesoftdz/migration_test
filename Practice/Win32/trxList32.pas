unit trxList32;
//------------------------------------------------------------------------------
// Transaction List Object
//------------------------------------------------------------------------------

interface

uses
  classes,
  bkdefs,
  ecollect,
  iostream,
  AuditMgr;

type
  //----------------------------------------------------------------------------
  pTran_Suggested_Index_Rec = ^TTran_Suggested_Index_Rec;
  TTran_Suggested_Index_Rec = Packed Record
    tiType                : Byte;
    tiCoded_By            : Byte;
    tiSuggested_Mem_State : Byte;
    tiDate_Effective      : integer;
    tiTran_Seq_No         : integer;
    tiAccount             : String[ 20 ];
    tiStatement_Details   : AnsiString;
  end;

  pTran_Transaction_Code_Index_Rec = ^TTran_Transaction_Code_Index_Rec;
  TTran_Transaction_Code_Index_Rec = Record
    tiCoreTransactionID     : Int64;
  end;

const
  Tran_Suggested_Index_Rec_Size = Sizeof(TTran_Suggested_Index_Rec);
  Tran_Transaction_Code_Index_Rec_Size = Sizeof(TTran_Transaction_Code_Index_Rec);

type
  //----------------------------------------------------------------------------
  TTran_Suggested_Index = class(TExtdSortedCollection)
  private
    fSortForSave : boolean;
  protected
    function NewItem() : Pointer;
    procedure FreeItem(Item: Pointer); override;
  public
    constructor Create; override;
    function  Compare(Item1, Item2: Pointer) : integer; override;

    procedure FreeTheItem(Item: Pointer);

    property SortForSave : boolean read fSortForSave write fSortForSave;
  end;

  //----------------------------------------------------------------------------
  TTran_Transaction_Code_Index = class(TExtdSortedCollection)
  private
  protected
    function NewItem() : Pointer;
    procedure FreeItem(Item: Pointer); override;
  public
    constructor Create; override;
    function  Compare(Item1, Item2: Pointer) : integer; override;

    procedure FreeTheItem(Item: Pointer);
  end;

  //----------------------------------------------------------------------------
  TTransaction_List = class(TExtdSortedCollection)
  private
    FLastSeq      : integer;
    FClient       : TObject;
    FBank_Account : TObject;
    FAuditMgr     : TClientAuditManager;
    FLoading      : boolean;

    fTran_Suggested_Index : TTran_Suggested_Index;
    fTran_Transaction_Code_Index : TTran_Transaction_Code_Index;

    function FindRecordID(ARecordID: integer):  pTransaction_Rec;
    function FindDissectionRecordID(ATransaction: pTransaction_Rec;
                                    ARecordID: integer): pDissection_Rec;
    procedure SetClient(const Value: TObject);
    procedure SetBank_Account(const Value: TObject);
    procedure SetAuditMgr(const Value: TClientAuditManager);
  protected
    procedure FreeItem(Item : Pointer); override;
  public
    constructor Create( AClient, ABank_Account: TObject; AAuditMgr: TClientAuditManager ); reintroduce; overload; virtual;
    destructor Destroy; override;
    function Compare(Item1,Item2 : Pointer): Integer; override;
    procedure Insert(Item:Pointer); override;
    procedure Insert_Transaction_Rec(var p: pTransaction_Rec; NewAuditID: Boolean = True);

    procedure LoadFromFile(var S : TIOStream);
    procedure SaveToFile(var S: TIOStream);
    function Transaction_At(Index : longint) : pTransaction_Rec;
    function GetTransCoreID_At(Index : longint) : int64;
    function FindTransactionFromECodingUID( UID : integer) : pTransaction_Rec;
    function FindTransactionFromMatchId(UID: integer): pTransaction_Rec;
    function SearchUsingDateandTranSeqNo(aDate_Effective, aTranSeqNo : integer; var aIndex: integer): Boolean;
    function SearchUsingTypeDateandTranSeqNo(aType : Byte; aDate_Effective, aTranSeqNo : integer; var aIndex: integer): Boolean;
    function SearchByTransactionCoreID(aCore_Transaction_ID, aCore_Transaction_ID_High: integer; var aIndex: integer): Boolean;
    function TransactionCoreIDExists(aCore_Transaction_ID, aCore_Transaction_ID_High: integer): Boolean;

    function Setup_New_Transaction: pTransaction_Rec;

    // Effective date
    // Note: returns 0 zero or first/last date of Effective Date
    function FirstEffectiveDate : LongInt;
    function LastEffectiveDate : LongInt;

    // Presented date
    function FirstPresDate : LongInt;
    function LastPresDate : LongInt;

    procedure UpdateCRC(var CRC : Longword);
    procedure DoAudit(ATransactionListCopy: TTransaction_List; AParentID: integer;
                      AAccountType: byte; var AAuditTable: TAuditTable);
    procedure DoDissectionAudit(ATransaction, ATransactionCopy: pTransaction_Rec;
                                AAccountType: byte;
                                var AAuditTable: TAuditTable);
    procedure SetAuditInfo(P1, P2: pTransaction_Rec; AParentID: integer;
                           var AAuditInfo: TAuditInfo);
    procedure SetDissectionAuditInfo(P1, P2: pDissection_Rec; AParentID: integer;
                                     var AAuditInfo: TAuditInfo);
    function GetIndexPRec(aIndex: integer): pTran_Suggested_Index_Rec;

    property LastSeq : integer read FLastSeq;
    property TxnClient: TObject read FClient write SetClient;
    property TxnBankAccount: TObject read FBank_Account write SetBank_Account;
    property AuditMgr: TClientAuditManager read FAuditMgr write SetAuditMgr;

    property Tran_Suggested_Index : TTran_Suggested_Index read fTran_Suggested_Index;
  end;

  procedure Dispose_Transaction_Rec(p: pTransaction_Rec);
  procedure Dispose_Dissection_Rec(p : PDissection_Rec);
  procedure Dump_Dissections(var p : pTransaction_Rec; AAuditIDList: TList = nil);
  procedure Copy_Dissection(var aSource , aDest : pDissection_Rec);
  procedure Copy_Dissections_Temporarily(P: pTransaction_Rec; DissectionList :TList);
  procedure ReAssign_Dissections(P: pTransaction_Rec; DissectionList :TList);
  procedure AppendDissection( T : pTransaction_Rec; D : pDissection_Rec;
                             AClientAuditManager: TClientAuditManager = nil );

  procedure Safe_Read_Transaction_Rec( var aTransaction_Rec : TTransaction_Rec; var aIOStream : TIOStream );
  procedure Safe_Read_Dissection_Rec ( var aDissection_Rec : TDissection_Rec; var aIOStream : TIOStream );
  function Create_New_Transaction : pTransaction_Rec;
  function Create_New_Transaction_Extension: pTransaction_Extension_Rec;

  function Create_New_Dissection : pDissection_Rec;
  function Create_New_Dissection_Extension: pDissection_Extension_Rec;

  //DN BGL360 Extended fields
  procedure AppendDissectionExtension( D : pDissection_Rec; DE : pDissection_Extension_Rec );

//------------------------------------------------------------------------------
implementation

uses
  Math,
  TransactionUtils,
  bktxio,
  bkdsio,
  tokens,
  LogUtil,
  malloc,
  SysUtils,
  bkdbExcept,
  bk5Except,
  bkcrc,
  bkconst,
  BKAudit,
  GenUtils,
  bkDateUtils,
  baObj32,
  SuggestedMems,
  BKUTIL32,
  bkteio,
  bkdeio;

const
  DebugMe : boolean = false;
  UnitName = 'TRXLIST32';
//  SInsufficientMemory = UnitName + ' Error: Out of memory in TTran_Suggested_Index.NewItem';
  SInsufficientMemory = UnitName + ' Error: Out of memory in %s.NewItem';

{ TTran_Suggested_Index }
//------------------------------------------------------------------------------
function TTran_Suggested_Index.NewItem: Pointer;
var
  P : pTran_Suggested_Index_Rec;
Begin
  SafeGetMem( P, Tran_Suggested_Index_Rec_Size );

  If Assigned( P ) then
    FillChar( P^, Tran_Suggested_Index_Rec_Size, 0 )
  else
    Raise EInsufficientMemory.CreateFmt( SInsufficientMemory, [ 'TTran_Suggested_Index' ] );

  Result := P;
end;

//------------------------------------------------------------------------------
procedure TTran_Suggested_Index.FreeItem(Item: Pointer);
begin
  pTran_Suggested_Index_Rec(Item)^.tiStatement_Details := '';

  SafeFreeMem(Item, Tran_Suggested_Index_Rec_Size);
end;

//------------------------------------------------------------------------------
procedure TTran_Suggested_Index.FreeTheItem(Item: Pointer);
begin
  DelFreeItem(Item);
end;

//------------------------------------------------------------------------------
constructor TTran_Suggested_Index.Create;
begin
  inherited;

  SortForSave := false;
  Duplicates := false;
end;

//------------------------------------------------------------------------------
function TTran_Suggested_Index.Compare(Item1, Item2: Pointer): integer;
begin
  if fSortForSave then
  begin
    if pTran_Suggested_Index_Rec(Item1)^.tiDate_Effective < pTran_Suggested_Index_Rec(Item2)^.tiDate_Effective then result := -1 else
    if pTran_Suggested_Index_Rec(Item1)^.tiDate_Effective > pTran_Suggested_Index_Rec(Item2)^.tiDate_Effective then result := 1 else
    if pTran_Suggested_Index_Rec(Item1)^.tiTran_Seq_No    < pTran_Suggested_Index_Rec(Item2)^.tiTran_Seq_No then result := -1 else
    if pTran_Suggested_Index_Rec(Item1)^.tiTran_Seq_No    > pTran_Suggested_Index_Rec(Item2)^.tiTran_Seq_No then result := 1 else
    result := 0;
  end
  else
  begin
    Result := CompareValue(pTran_Suggested_Index_Rec(Item1)^.tiType,
                           pTran_Suggested_Index_Rec(Item2)^.tiType);

    if Result <> 0 then
      Exit;

    Result := CompareValue(pTran_Suggested_Index_Rec(Item1)^.tiDate_Effective,
                           pTran_Suggested_Index_Rec(Item2)^.tiDate_Effective);

    if Result <> 0 then
      Exit;

    Result := CompareValue(pTran_Suggested_Index_Rec(Item1)^.tiTran_Seq_No,
                           pTran_Suggested_Index_Rec(Item2)^.tiTran_Seq_No);
  end;
end;

{ TTransaction_List }
//------------------------------------------------------------------------------
procedure Dispose_Dissection_Rec(p : PDissection_Rec);
const
  ThisMethodName = 'Dispose_Dissection_Rec';
begin
  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

  if (BKDSIO.IsADissection_Rec( P ) )  then
  begin
    //DN BGL360 Extended Fields
    if assigned( p^.dsDissection_Extension ) then
      if BKDEIO.IsADissection_Extension_Rec( p^.dsDissection_Extension ) then begin
        BKDEIO.Free_Dissection_Extension_Rec_Dynamic_Fields( p^.dsDissection_Extension^ );
        MALLOC.SafeFreeMem( p^.dsDissection_Extension, Dissection_Extension_Rec_Size );
        p^.dsDissection_Extension := nil;
      end; 
    //DN BGL360 Extended Fields

    BKDSIO.Free_Dissection_Rec_Dynamic_Fields( p^);
    MALLOC.SafeFreeMem( P, Dissection_Rec_Size );
  end;

  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//------------------------------------------------------------------------------
procedure Dispose_Transaction_Rec(p: pTransaction_Rec);
const
  ThisMethodName = 'Dispose_Transaction_Rec';
Var
   This : pDissection_Rec;
   Next : pDissection_Rec;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   if ( BKTXIO.IsATransaction_Rec( P ) )  then With P^ do
   Begin
      This := pDissection_Rec( txFirst_Dissection );
      While ( This<>NIL ) do
      Begin
         Next := pDissection_Rec( This^.dsNext );
         Dispose_Dissection_Rec( This );
         This := Next;
      end;

      //DN BGL360 Extended Fields
      if assigned( p^.txTransaction_Extension ) then
        if BKTEIO.IsATransaction_Extension_Rec( p^.txTransaction_Extension ) then begin
          BKTEIO.Free_Transaction_Extension_Rec_Dynamic_Fields( p^.txTransaction_Extension^ );
          MALLOC.SafeFreeMem( p^.txTransaction_Extension, Transaction_Extension_Rec_Size );
          p^.txTransaction_Extension := nil; 
        end;
      //DN BGL360 Extended Fields

      BKTXIO.Free_Transaction_Rec_Dynamic_Fields( P^);
      MALLOC.SafeFreeMem( P, Transaction_Rec_Size );
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

//------------------------------------------------------------------------------
procedure Copy_Dissection(var aSource , aDest : pDissection_Rec);
begin
  aDest.dsRecord_Type := aSource.dsRecord_Type;
  aDest.dsSequence_No := aSource.dsSequence_No;
  aDest.dsAccount := aSource.dsAccount;
  aDest.dsAmount := aSource.dsAmount;
  aDest.dsGST_Class := aSource.dsGST_Class;
  aDest.dsGST_Amount := aSource.dsGST_Amount;
  aDest.dsQuantity := aSource.dsQuantity;
  aDest.dsOld_Narration := aSource.dsOld_Narration;
  aDest.dsHas_Been_Edited := aSource.dsHas_Been_Edited;
  aDest.dsJournal_Type := aSource.dsJournal_Type;
  aDest.dsGST_Has_Been_Edited := aSource.dsGST_Has_Been_Edited;
  aDest.dsPayee_Number := aSource.dsPayee_Number;
  aDest.dsNotes := aSource.dsNotes;
  aDest.dsECoding_Import_Notes := aSource.dsECoding_Import_Notes;
  aDest.dsGL_Narration := aSource.dsGL_Narration;
  aDest.dsLinked_Journal_Date := aSource.dsLinked_Journal_Date;
  aDest.dsSF_Imputed_Credit := aSource.dsSF_Imputed_Credit;
  aDest.dsSF_Tax_Free_Dist := aSource.dsSF_Tax_Free_Dist;

  aDest.dsSF_Tax_Exempt_Dist := aSource.dsSF_Tax_Exempt_Dist;
  aDest.dsSF_Tax_Deferred_Dist := aSource.dsSF_Tax_Deferred_Dist;
  aDest.dsSF_TFN_Credits := aSource.dsSF_TFN_Credits;
  aDest.dsSF_Foreign_Income := aSource.dsSF_Foreign_Income;
  aDest.dsSF_Foreign_Tax_Credits := aSource.dsSF_Foreign_Tax_Credits;
  aDest.dsSF_Capital_Gains_Indexed := aSource.dsSF_Capital_Gains_Indexed;
  aDest.dsSF_Capital_Gains_Disc := aSource.dsSF_Capital_Gains_Disc;
  aDest.dsSF_Super_Fields_Edited := aSource.dsSF_Super_Fields_Edited;
  aDest.dsSF_Capital_Gains_Other := aSource.dsSF_Capital_Gains_Other;
  aDest.dsSF_Other_Expenses := aSource.dsSF_Other_Expenses;
  aDest.dsSF_CGT_Date := aSource.dsSF_CGT_Date;
  aDest.dsExternal_GUID := aSource.dsExternal_GUID;
  aDest.dsDocument_Title := aSource.dsDocument_Title;

  aDest.dsDocument_Status_Update_Required := aSource.dsDocument_Status_Update_Required;
  aDest.dsNotes_Read := aSource.dsNotes_Read;
  aDest.dsImport_Notes_Read := aSource.dsImport_Notes_Read;
  aDest.dsReference := aSource.dsReference;
  aDest.dsSF_Franked := aSource.dsSF_Franked;
  aDest.dsSF_Unfranked := aSource.dsSF_Unfranked;
  aDest.dsSF_Interest := aSource.dsSF_Interest;
  aDest.dsSF_Capital_Gains_Foreign_Disc := aSource.dsSF_Capital_Gains_Foreign_Disc;
  aDest.dsSF_Rent := aSource.dsSF_Rent;
  aDest.dsSF_Special_Income := aSource.dsSF_Special_Income;

  aDest.dsSF_Other_Tax_Credit := aSource.dsSF_Other_Tax_Credit;
  aDest.dsSF_Non_Resident_Tax := aSource.dsSF_Non_Resident_Tax;
  aDest.dsSF_Member_ID := aSource.dsSF_Member_ID;
  aDest.dsSF_Foreign_Capital_Gains_Credit := aSource.dsSF_Foreign_Capital_Gains_Credit;
  aDest.dsSF_Member_Component := aSource.dsSF_Member_Component;
  aDest.dsPercent_Amount := aSource.dsPercent_Amount;
  aDest.dsAmount_Type_Is_Percent := (aDest.dsPercent_Amount <> 0);
  aDest.dsSF_Fund_ID := aSource.dsSF_Fund_ID;
  aDest.dsSF_Member_Account_ID := aSource.dsSF_Member_Account_ID;
  aDest.dsSF_Fund_Code := aSource.dsSF_Fund_Code;
  aDest.dsSF_Member_Account_Code := aSource.dsSF_Member_Account_Code;
  aDest.dsSF_Transaction_ID := aSource.dsSF_Transaction_ID;
  aDest.dsSF_Transaction_Code := aSource.dsSF_Transaction_Code;
  aDest.dsSF_Capital_Gains_Fraction_Half := aSource.dsSF_Capital_Gains_Fraction_Half;
  aDest.dsAudit_Record_ID := aSource.dsAudit_Record_ID;
  aDest.dsJob_Code := aSource.dsJob_Code;
  aDest.dsTax_Invoice := aSource.dsTax_Invoice;
  aDest.dsForex_Conversion_Rate := aSource.dsForex_Conversion_Rate;
  aDest.dsForeign_Currency_Amount := aSource.dsForeign_Currency_Amount;
  aDest.dsForex_Document_Date := aSource.dsForex_Document_Date;
  aDest.dsOpening_Balance_Currency := aSource.dsOpening_Balance_Currency;
  aDest.dsTemp_Base_Amount := aSource.dsTemp_Base_Amount;

  if Assigned(aSource.dsDissection_Extension) then
  begin
    if not Assigned(aDest.dsDissection_Extension) then
      aDest.dsDissection_Extension := Create_New_Dissection_Extension;
      
    aDest.dsDissection_Extension.deRecord_Type := aSource.dsDissection_Extension.deRecord_Type;
    aDest.dsDissection_Extension.deSequence_No := aSource.dsDissection_Extension.deSequence_No;
    aDest.dsDissection_Extension.deSF_Other_Income := aSource.dsDissection_Extension.deSF_Other_Income;
    aDest.dsDissection_Extension.deSF_Other_Trust_Deductions := aSource.dsDissection_Extension.deSF_Other_Trust_Deductions;
    aDest.dsDissection_Extension.deSF_CGT_Concession_Amount := aSource.dsDissection_Extension.deSF_CGT_Concession_Amount;
    aDest.dsDissection_Extension.deSF_CGT_ForeignCGT_Before_Disc := aSource.dsDissection_Extension.deSF_CGT_ForeignCGT_Before_Disc;
    aDest.dsDissection_Extension.deSF_CGT_ForeignCGT_Indexation := aSource.dsDissection_Extension.deSF_CGT_ForeignCGT_Indexation;
    aDest.dsDissection_Extension.deSF_CGT_ForeignCGT_Other_Method := aSource.dsDissection_Extension.deSF_CGT_ForeignCGT_Other_Method;
    aDest.dsDissection_Extension.deSF_CGT_TaxPaid_Indexation := aSource.dsDissection_Extension.deSF_CGT_TaxPaid_Indexation;
    aDest.dsDissection_Extension.deSF_CGT_TaxPaid_Other_Method := aSource.dsDissection_Extension.deSF_CGT_TaxPaid_Other_Method;
    aDest.dsDissection_Extension.deSF_Other_Net_Foreign_Income := aSource.dsDissection_Extension.deSF_Other_Net_Foreign_Income;
    aDest.dsDissection_Extension.deSF_Cash_Distribution := aSource.dsDissection_Extension.deSF_Cash_Distribution;
    aDest.dsDissection_Extension.deSF_AU_Franking_Credits_NZ_Co := aSource.dsDissection_Extension.deSF_AU_Franking_Credits_NZ_Co;
    aDest.dsDissection_Extension.deSF_Non_Res_Witholding_Tax := aSource.dsDissection_Extension.deSF_Non_Res_Witholding_Tax;
    aDest.dsDissection_Extension.deSF_LIC_Deductions := aSource.dsDissection_Extension.deSF_LIC_Deductions;
    aDest.dsDissection_Extension.deSF_Non_Cash_CGT_Discounted_Before_Discount := aSource.dsDissection_Extension.deSF_Non_Cash_CGT_Discounted_Before_Discount;
    aDest.dsDissection_Extension.deSF_Non_Cash_CGT_Indexation := aSource.dsDissection_Extension.deSF_Non_Cash_CGT_Indexation;
    aDest.dsDissection_Extension.deSF_Non_Cash_CGT_Other_Method := aSource.dsDissection_Extension.deSF_Non_Cash_CGT_Other_Method;
    aDest.dsDissection_Extension.deSF_Non_Cash_CGT_Capital_Losses := aSource.dsDissection_Extension.deSF_Non_Cash_CGT_Capital_Losses;
    aDest.dsDissection_Extension.deSF_Share_Brokerage := aSource.dsDissection_Extension.deSF_Share_Brokerage;
    aDest.dsDissection_Extension.deSF_Share_Consideration := aSource.dsDissection_Extension.deSF_Share_Consideration;
    aDest.dsDissection_Extension.deSF_Share_GST_Amount := aSource.dsDissection_Extension.deSF_Share_GST_Amount;
    aDest.dsDissection_Extension.deSF_Share_GST_Rate := aSource.dsDissection_Extension.deSF_Share_GST_Rate;
    aDest.dsDissection_Extension.deSF_Cash_Date := aSource.dsDissection_Extension.deSF_Cash_Date;
    aDest.dsDissection_Extension.deSF_Accrual_Date := aSource.dsDissection_Extension.deSF_Accrual_Date;
    aDest.dsDissection_Extension.deSF_Record_Date := aSource.dsDissection_Extension.deSF_Record_Date;
    aDest.dsDissection_Extension.deSF_Contract_Date := aSource.dsDissection_Extension.deSF_Contract_Date;
    aDest.dsDissection_Extension.deSF_Settlement_Date := aSource.dsDissection_Extension.deSF_Settlement_Date;
  end;
end;
//------------------------------------------------------------------------------
procedure ReAssign_Dissections(P: pTransaction_Rec; DissectionList :TList);
var
  i : Integer;
begin
  P^.txFirst_Dissection := nil;
  P^.txLast_Dissection := nil;
  for i := 0 to DissectionList.Count - 1 do
  begin
    AppendDissection(P, DissectionList.Items[i], nil );
  end;
end;
//------------------------------------------------------------------------------
procedure Copy_Dissections_Temporarily(P: pTransaction_Rec; DissectionList :TList);
const
  ThisMethodName = 'Copy_Dissections_Temporarily';
Var
   This, New : pDissection_Rec;
   Next : pDissection_Rec;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   if ( BKTXIO.IsATransaction_Rec( P ) )  then With P^ do
   Begin
      This := pDissection_Rec( txFirst_Dissection );
      if This <> nil then
      begin
        while (This <> nil ) do
        Begin
          New := New_Dissection_Rec;
          Copy_Dissection(This, New);
          DissectionList.Add(New);

          Next := pDissection_Rec( This^.dsNext );
          This := Next;
        end;
      end;
   end;

   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//------------------------------------------------------------------------------
procedure Dump_Dissections(var p : pTransaction_Rec; AAuditIDList: TList = nil);
const
  ThisMethodName = 'Dump_Dissections';
Var
   This : pDissection_Rec;
   Next : pDissection_Rec;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   if ( BKTXIO.IsATransaction_Rec( P ) )  then With P^ do
   Begin
      This := pDissection_Rec( txFirst_Dissection );
      While ( This<>NIL ) do
      Begin
         Next := pDissection_Rec( This^.dsNext );

         //Save audit ID's for reuse when dissections are edited
         if Assigned(AAuditIDList) then
            AAuditIDList.Add(Pointer(This^.dsAudit_Record_ID));

         Dispose_Dissection_Rec( This );
         This := Next;
      end;
      P^.txFirst_Dissection := NIL;
      P^.txLast_Dissection := NIL;
      P^.txAccount := '';
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//------------------------------------------------------------------------------

Procedure AppendDissection( T : pTransaction_Rec; D : pDissection_Rec;
            AClientAuditManager: TClientAuditManager = nil);
const
  ThisMethodName = 'AppendDissection';
Var
   Seq : Integer;
Begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
  Seq := 0;
  If T^.txLast_Dissection<>NIL then Seq := T^.txLast_Dissection^.dsSequence_No;
  Inc( Seq );
  With D^ do
  Begin
    dsTransaction  := T;
    dsSequence_No  := Seq;
    dsNext         := NIL;
    dsClient       := T.txClient;
    dsBank_Account := T.txBank_Account;
    if Assigned(AClientAuditManager) then
      dsAudit_Record_ID := AClientAuditManager.NextAuditRecordID;
  end;
  With T^ do
  Begin
    If ( txFirst_Dissection = NIL ) then txFirst_Dissection := D;
    If ( txLast_Dissection<>NIL ) then txLast_Dissection^.dsNext := D;
    txLast_Dissection := D;
  end;

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

//------------------------------------------------------------------------------
//DN BGL360 Extended fields
procedure AppendDissectionExtension( D : pDissection_Rec; DE : pDissection_Extension_Rec );
const
  ThisMethodName = 'AppendDissectionExtension';
Begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

  D^.dsDissection_Extension := DE;
  DE^.deSequence_No := D^.dsSequence_No;

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

procedure Safe_Read_Transaction_Rec( var aTransaction_Rec : TTransaction_Rec; var aIOStream: TIOStream );
var
  lpTransaction_Extension_Rec : PTransaction_Extension_Rec;
begin
  lpTransaction_Extension_Rec := aTransaction_Rec.txTransaction_Extension;
  Read_Transaction_Rec ( aTransaction_Rec, aIOStream );
  aTransaction_Rec.txTransaction_Extension := lpTransaction_Extension_Rec;
  if assigned( aTransaction_Rec.txTransaction_Extension ) then begin
    aTransaction_Rec.txTransaction_Extension.teSequence_No    := aTransaction_Rec.txSequence_No;
    aTransaction_Rec.txTransaction_Extension.teDate_Effective := aTransaction_Rec.txDate_Effective;
  end;
end;

procedure Safe_Read_Dissection_Rec ( var aDissection_Rec : TDissection_Rec; var aIOStream : TIOStream );
var
  lpDissection_Extension_Rec : PDissection_Extension_Rec;
begin
  lpDissection_Extension_Rec := aDissection_Rec.dsDissection_Extension;
  Read_Dissection_Rec ( aDissection_Rec, aIOStream );
  aDissection_Rec.dsDissection_Extension := lpDissection_Extension_Rec;
  if assigned( aDissection_Rec.dsDissection_Extension ) then begin
    aDissection_Rec.dsDissection_Extension^.deSequence_No    := aDissection_Rec.dsSequence_No;
  end;
end;

function Create_New_Transaction: pTransaction_Rec;
begin
  // Create a Transaction Rec with Object references
  // so we can call Helper Methods on it
  // before it is inserted into the list.
  Result := BKTXIO.New_Transaction_Rec;

//DN need to make sure that the Extension record is generated here as well
  if not assigned( Result.txTransaction_Extension ) then
    Result.txTransaction_Extension := Create_New_Transaction_Extension;
//DN need to make sure that the Extension record is generated here as well

  ClearSuperFundFields(Result);
end;

//DN BGL360 Extended Fields
function Create_New_Transaction_Extension: pTransaction_Extension_Rec;
begin
  // Create a Transaction Extension Rec which is referenced from the main Transaction Rec
  // so we can call Helper Methods on it
  // before it is inserted into the list.

  Result := BKTEIO.New_Transaction_Extension_Rec;

  ClearSuperFundFields(Result);
end;

function Create_New_Dissection: pDissection_Rec;
begin
  result := BKDSIO.New_Dissection_Rec;

  if not assigned( result.dsDissection_Extension ) then
    AppendDissectionExtension( result, Create_New_Dissection_Extension );
end;

function Create_New_Dissection_Extension: pDissection_Extension_Rec;
begin
  result := BKDEIO.New_Dissection_Extension_Rec;
end;

//------------------------------------------------------------------------------
function TTransaction_List.Compare(Item1, Item2 : pointer): integer;
begin
  if pTransaction_Rec(Item1)^.txDate_Effective < pTransaction_Rec(Item2)^.txDate_Effective then result := -1 else
  if pTransaction_Rec(Item1)^.txDate_Effective > pTransaction_Rec(Item2)^.txDate_Effective then result := 1 else
  if pTransaction_Rec(Item1)^.txSequence_No    < pTransaction_Rec(Item2)^.txSequence_No then result := -1 else
  if pTransaction_Rec(Item1)^.txSequence_No    > pTransaction_Rec(Item2)^.txSequence_No then result := 1 else
  result := 0;
end;
//------------------------------------------------------------------------------
procedure TTransaction_List.Insert(Item:Pointer);
const
  ThisMethodName = 'TTransaction_List.Insert';
var
  Msg : string;
begin
  Msg := Format( '%s : Called Direct', [ ThisMethodName] );
  LogUtil.LogMsg(lmError, UnitName, Msg );
  raise EInvalidCall.CreateFmt( '%s - %s', [ UnitName, Msg ] );
end;

//------------------------------------------------------------------------------
procedure TTransaction_List.FreeItem(Item : Pointer);
begin
  Dispose_Transaction_Rec(pTransaction_Rec(item));
end;

//------------------------------------------------------------------------------
procedure TTransaction_List.Insert_Transaction_Rec(var p: pTransaction_Rec;
  NewAuditID: Boolean = True);
const
  ThisMethodName = 'TTransaction_List.Insert_Transaction_Rec';
var
  NewTran_Suggested_Index_Rec : pTran_Suggested_Index_Rec;
  NewTran_Transaction_Code_Index_Rec : pTran_Transaction_Code_Index_Rec;
  TranIndex : integer;
Begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
  If BKTXIO.IsATransaction_Rec( P ) then
  Begin
    if (not FLoading) then
    begin
      Inc( FLastSeq );
      P^.txSequence_No  := FLastSeq;
    end
    else
    begin
      if FLastSeq < P^.txSequence_No then
        FLastSeq := P^.txSequence_No;
    end;

    P^.txBank_Account := fBank_Account;
    P^.txClient       := fClient;

    // Build suggested Mems Index
    if (fBank_Account is TBank_Account) and
       (not (TBank_Account(fBank_Account).IsAJournalAccount)) then
    begin
      NewTran_Suggested_Index_Rec := fTran_Suggested_Index.NewItem;
      NewTran_Suggested_Index_Rec^.tiType                := P^.txType;
      NewTran_Suggested_Index_Rec^.tiDate_Effective      := P^.txDate_Effective;
      NewTran_Suggested_Index_Rec^.tiTran_Seq_No         := P^.txSequence_No;
      NewTran_Suggested_Index_Rec^.tiStatement_Details   := P^.txStatement_Details;
      NewTran_Suggested_Index_Rec^.tiAccount             := P^.txAccount;
      NewTran_Suggested_Index_Rec^.tiSuggested_Mem_State := P^.txSuggested_Mem_State;
      NewTran_Suggested_Index_Rec^.tiCoded_By            := P^.txCoded_By;

      SuggestedMem.UpdateAccountWithTransInsert(TBank_Account(fBank_Account),
                                                NewTran_Suggested_Index_Rec,
                                                ((not FLoading) and NewAuditID));

      fTran_Suggested_Index.Insert(NewTran_Suggested_Index_Rec);
    end;

    // Build Transaction Core ID Index
    if (fBank_Account is TBank_Account) and
       (not (TBank_Account(fBank_Account).IsAJournalAccount)) then
    begin
      NewTran_Transaction_Code_Index_Rec := fTran_Transaction_Code_Index.NewItem;
      if assigned( NewTran_Transaction_Code_Index_Rec ) then
        NewTran_Transaction_Code_Index_Rec^.tiCoreTransactionID :=
          CombineInt32ToInt64( P^.txCore_Transaction_ID_High,
            P^.txCore_Transaction_ID );

      FTran_Transaction_Code_Index.Insert( NewTran_Transaction_Code_Index_Rec );
    end;

    // Set additional BGL360 fields
    if (fBank_Account is TBank_Account) and
       (not (TBank_Account(fBank_Account).IsAJournalAccount)) then
    begin
      if assigned( P^.txTransaction_Extension ) then begin
        P^.txTransaction_Extension^.teSequence_No := P^.txSequence_No;
        P^.txTransaction_Extension^.teDate_Effective := P^.txDate_Effective;
      end;
(*
//DN Redundant code      if not assigned( P^.txTransaction_Extension ) then begin
        NewTran_Transaction_Extension_Rec := BKTEIO.New_Transaction_Extension_Rec;
        if assigned( NewTran_Transaction_Extension_Rec ) then begin
          NewTran_Transaction_Extension_Rec^.teSequence_No := P^.txSequence_No;
          NewTran_Transaction_Extension_Rec^.teDate_Effective := P^.txDate_Effective;

          P^.txTransaction_Extension := NewTran_Transaction_Extension_Rec;
        end;
      end
      else begin
          P^.txTransaction_Extension^.teSequence_No := P^.txSequence_No;
          P^.txTransaction_Extension^.teDate_Effective := P^.txDate_Effective;
      end;
//DN Redundant code *)
    end;

    //Get next audit ID for new transactions
    if (not FLoading) and Assigned(fAuditMgr) and NewAuditID then
      P^.txAudit_Record_ID := fAuditMgr.NextAuditRecordID;

    Inherited Insert( P );

    if (fBank_Account is TBank_Account) and
       (not (TBank_Account(fBank_Account).IsAJournalAccount)) then
    begin
      // When the Transaction count exceeds then PARTIAL_MATCH_MIN_TRANS redo Suggested mems
      if ItemCount = PARTIAL_MATCH_MIN_TRANS then
        SuggestedMem.ResetAccount(TBank_Account(fBank_Account));
    end;
  end;
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//------------------------------------------------------------------------------
procedure TTransaction_List.LoadFromFile(var S : TIOStream);
const
  ThisMethodName = 'TTransaction_List.LoadFromFile';
Var
   Token       : Byte;
   pTX         : pTransaction_Rec;
//   pTXe        : pTransaction_Extension_Rec;
   pDS         : pDissection_Rec;
//   pDSe        : pDissection_Extension_Rec;
   msg         : string;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   FLoading := True;
   fTran_Suggested_Index.SortingOn := false;
   fTran_Transaction_Code_Index.SortingOn := false;
   try
     if (fBank_Account is TBank_Account) then
       TBank_Account(fBank_Account).baFields.baSuggested_UnProcessed_Count := 0;

     pTX := NIL;
     Token := S.ReadToken;
     While ( Token <> tkEndSection ) do
     Begin
        Case Token of
           tkBegin_Transaction :
              Begin
                 pTX := Setup_New_Transaction;
                 Safe_Read_Transaction_Rec( pTX^, S );

                 Insert_Transaction_Rec( pTX );

                 Token := S.ReadToken;
                 if Token = tkBegin_Transaction_Extension then
                 begin
//DN this code should never be called               if not assigned( PTX^.txTransaction_Extension ) then             // The Extension has not been built yet
//DN this code should never be called                 PTX^.txTransaction_Extension := New_Transaction_Extension;
                   Read_Transaction_Extension_Rec( PTX^.txTransaction_Extension^, S )
                 end
                 else // There is NO stored Extended Record and therefore stream needs to be positioned back
                 begin
                   S.Position := S.Position - 1;
                 end;
              end;

           tkBegin_Dissection :
              Begin
                 pDS := Create_New_Dissection;
                 Safe_Read_Dissection_Rec ( pDS^, S );

//DN this code should never be called               //DN BGL360 Extended Fields - Check if the Dissection Extended record is there
//DN this code should never be called               //DN and if so react, else generate a new for saving, this code should never be called
//DN this code should never be called                 if not assigned( pDS^.dsDissection_Extension ) then
//DN this code should never be called                   pDS^.dsDissection_Extension := Create_New_Dissection_Extension;

                 Token := S.ReadToken;
                 if Token = tkBegin_Dissection_Extension then //DN This means the Extended record has been stored before
                 begin
                   Read_Dissection_Extension_Rec(pDS^.dsDissection_Extension^, S);
                 end
                 else // There is NO stored Extended Record and therefore stream needs to be positioned back
                 begin
                   S.Position := S.Position - 1;
                   pDS^.dsDissection_Extension^.deSequence_No := pDS^.dsSequence_No;
                 end;

                 AppendDissection( pTX, pDS );
                 AppendDissectionExtension( pDS, pDS^.dsDissection_Extension );
              end;

(*
           tkBegin_Transaction_Extension :
             begin
//DN this code should never be called               if not assigned( PTX^.txTransaction_Extension ) then             // The Extension has not been built yet
//DN this code should never be called                 PTX^.txTransaction_Extension := New_Transaction_Extension;
               Read_Transaction_Extension_Rec( PTX^.txTransaction_Extension^, S )
             end
*)
           else
           begin { Should never happen }
              Msg := Format( '%s : Unknown Token %d', [ ThisMethodName, Token ] );
              LogUtil.LogMsg(lmError, UnitName, Msg );
              raise ETokenException.CreateFmt( '%s - %s', [ UnitName, Msg ] );
           end;
        end; { of Case }
        Token := S.ReadToken;
     end;
   finally
     FLoading := False;
     fTran_Suggested_Index.SortingOn := true;
     fTran_Suggested_Index.Sort();

     fTran_Transaction_Code_Index.SortingOn := true;
     fTran_Transaction_Code_Index.Sort();
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

function TTransaction_List.Setup_New_Transaction: pTransaction_Rec;
begin
  result := Create_New_Transaction;
  Result.txBank_Account := fBank_Account;
  Result.txClient  := fClient;
end;

//------------------------------------------------------------------------------
procedure TTransaction_List.SaveToFile(var S: TIOStream);
const
  ThisMethodName = 'TTransaction_List.SaveToFile';
Var
   i    : LongInt;
   pTX  : pTransaction_Rec;
   pTXe : pTransaction_Extension_Rec;
   pDS  : pDissection_Rec;
   TXCount  : LongInt;
   DSCount  : LongInt;

   IsNotAJournalAccount : boolean;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   TXCount := 0;
   DSCount := 0;

   IsNotAJournalAccount := true;
   if (fBank_Account is TBank_Account) and
      (TBank_Account(fBank_Account).IsAJournalAccount) then
     IsNotAJournalAccount := false;

   if IsNotAJournalAccount then
   begin
     fTran_Suggested_Index.SortForSave := true;
     fTran_Suggested_Index.Sort();

     fTran_Transaction_Code_Index.Sort();
   end;

   S.WriteToken( tkBeginEntries );

   For i := 0 to Pred( ItemCount ) do
   Begin
      pTX := Transaction_At( i );

      if IsNotAJournalAccount then
        pTx^.txSuggested_Mem_State := self.GetIndexPRec(i)^.tiSuggested_Mem_State;

      pTx^.txLRN_NOW_UNUSED := 0;   //clear any obsolete data

      BKTXIO.Write_Transaction_Rec ( pTX^, S );
      Inc( TXCount );

      pTXe := pTX^.txTransaction_Extension;

      //DN BGL360 Extended Fields - Check if the Dissection Extended record
      //is there, if so store it
      if not assigned( pTXe ) then begin
        pTXe := BKTEIO.New_Transaction_Extension_Rec;
        pTXe^.teSequence_No := pTX^.txSequence_No;
        pTXe^.teDate_Effective := pTX^.txDate_Effective;
        pTX^.txTransaction_Extension := pTXe;
      end;

      BKTEIO.Write_Transaction_Extension_Rec( pTXe^, S );


      pDS := pTX^.txFirst_Dissection;
      While pDS<>NIL do
      Begin
         BKDSIO.Write_Dissection_Rec ( pDS^, S );
         Inc( DSCount );

         //DN BGL360 Extended Fields - Check if the Dissection Extended record
         //is there, if so store it
         if assigned( pDS^.dsDissection_Extension ) then begin
           BKDEIO.Write_Dissection_Extension_Rec( pDS^.dsDissection_Extension^, S );
         end;

         pDS := pDS^.dsNext;
      end;

(*      pTXe := pTX^.txTransaction_Extension;

      //DN BGL360 Extended Fields - Check if the Dissection Extended record
      //is there, if so store it
      if not assigned( pTXe ) then begin
        pTXe := BKTEIO.New_Transaction_Extension_Rec;
        pTXe^.teSequence_No := pTX^.txSequence_No;
        pTXe^.teDate_Effective := pTX^.txDate_Effective;
        pTX^.txTransaction_Extension := pTXe;
      end;

      BKTEIO.Write_Transaction_Extension_Rec( pTXe^, S ); *)
   end;
   S.WriteToken( tkEndSection );

   if IsNotAJournalAccount then
   begin
     fTran_Suggested_Index.SortForSave := false;
     fTran_Suggested_Index.Sort();

     fTran_Transaction_Code_Index.Sort();
   end;

   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, Format('%s : %d transactions %d dissection saved',[ThisMethodName, txCount, dsCount]));
end;

procedure TTransaction_List.SetAuditInfo(P1, P2: pTransaction_Rec;
  AParentID: integer; var AAuditInfo: TAuditInfo);
begin
  AAuditInfo.AuditAction := aaNone;
  AAuditInfo.AuditParentID := AParentID;
  AAuditInfo.AuditOtherInfo := Format('%s=%s', ['RecordType','Transaction']) +
                               VALUES_DELIMITER +
                               Format('%s=%d', ['ParentID', AParentID]);
  if not Assigned(P1) then begin
    //Delete
    AAuditInfo.AuditAction := aaDelete;
    AAuditInfo.AuditRecordID := P2.txAudit_Record_ID;
    AAuditInfo.AuditOtherInfo :=
      AAuditInfo.AuditOtherInfo + VALUES_DELIMITER +
      Format('%s=%s',[BKAuditNames.GetAuditFieldName(tkBegin_Transaction, 166), BkDate2Str(P2.txDate_Presented)]) +
      VALUES_DELIMITER +
      Format('%s=%s',[BKAuditNames.GetAuditFieldName(tkBegin_Transaction, 169), Money2Str(P2.txAmount)]);
  end else if Assigned(P2) then begin
    //Change
    AAuditInfo.AuditRecordID := P1.txAudit_Record_ID;
    if Transaction_Rec_Delta(P1, P2, AAuditInfo.AuditRecord, AAuditInfo.AuditChangedFields) then
      AAuditInfo.AuditAction := aaChange;
  end else begin
    //Add
    AAuditInfo.AuditAction := aaAdd;
    AAuditInfo.AuditRecordID := P1.txAudit_Record_ID;
    P1.txAudit_Record_ID := AAuditInfo.AuditRecordID;
    BKTXIO.SetAllFieldsChanged(AAuditInfo.AuditChangedFields);
    Copy_Transaction_Rec(P1, AAuditInfo.AuditRecord);
  end;
end;

procedure TTransaction_List.SetAuditMgr(const Value: TClientAuditManager);
begin
  FAuditMgr := Value;
end;

procedure TTransaction_List.SetBank_Account(const Value: TObject);
begin
  FBank_Account := Value;
end;

procedure TTransaction_List.SetClient(const Value: TObject);
begin
  FClient := Value;
end;

procedure TTransaction_List.SetDissectionAuditInfo(P1, P2: pDissection_Rec;
  AParentID: integer; var AAuditInfo: TAuditInfo);
begin
  AAuditInfo.AuditAction := aaNone;
  AAuditInfo.AuditParentID := AParentID;
  AAuditInfo.AuditOtherInfo := Format('%s=%s', ['RecordType','Dissection']) +
                               VALUES_DELIMITER +
                               Format('%s=%d', ['ParentID', AParentID]);
  if not Assigned(P1) then begin
    //Delete
    AAuditInfo.AuditAction := aaDelete;
    AAuditInfo.AuditRecordID := P2.dsAudit_Record_ID;
    AAuditInfo.AuditOtherInfo :=
      AAuditInfo.AuditOtherInfo + VALUES_DELIMITER +
      //Save Account and Amount
      Format('%s=%s',[BKAuditNames.GetAuditFieldName(tkBegin_Dissection, 183), P2.dsAccount]) +
      VALUES_DELIMITER +
      Format('%s=%s',[BKAuditNames.GetAuditFieldName(tkBegin_Dissection, 184), Money2Str(P2.dsAmount)]);
  end else if Assigned(P2) then begin
    //Change
    AAuditInfo.AuditRecordID := P1.dsAudit_Record_ID;
    if Dissection_Rec_Delta(P1, P2, AAuditInfo.AuditRecord, AAuditInfo.AuditChangedFields) then
      AAuditInfo.AuditAction := aaChange;
  end else begin
    //Add
    AAuditInfo.AuditAction := aaAdd;
    AAuditInfo.AuditRecordID := P1.dsAudit_Record_ID;
    P1.dsAudit_Record_ID := AAuditInfo.AuditRecordID;
    BKDSIO.SetAllFieldsChanged(AAuditInfo.AuditChangedFields);
    Copy_Dissection_Rec(P1, AAuditInfo.AuditRecord);
  end;

end;

//------------------------------------------------------------------------------
function TTransaction_List.TransactionCoreIDExists(aCore_Transaction_ID,
  aCore_Transaction_ID_High: integer): Boolean;
var
  aIndex : integer;
begin
  result := SearchByTransactionCoreID(aCore_Transaction_ID, aCore_Transaction_ID_High, aIndex);
end;

function TTransaction_List.Transaction_At(Index : longint) : pTransaction_Rec;
const
  ThisMethodName = 'TTransaction_List.Transaction_At';
Var
   P : Pointer;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   result := nil;
   P := At( Index );
   If BKTXIO.IsATransaction_Rec( P ) then
      result := P;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

//------------------------------------------------------------------------------
function TTransaction_List.GetIndexPRec(aIndex: integer): pTran_Suggested_Index_Rec;
begin
  Result := fTran_Suggested_Index.At(aIndex);
end;

//------------------------------------------------------------------------------
function TTransaction_List.GetTransCoreID_At(Index : longint) : int64;
begin
  Result := BKUTIL32.GetTransCoreID(Transaction_At(Index));
end;

//------------------------------------------------------------------------------
function TTransaction_List.FirstEffectiveDate : LongInt;
var
  i: integer;
  Transaction: TTransaction_Rec;
begin
  result := 0;

  for i := 0 to ItemCount-1 do
  begin
    Transaction := Transaction_At(i)^;

    if (i = 0) then
      result := Transaction.txDate_Effective
    else
      result := Min(result, Transaction.txDate_Effective);
  end;
end;

//------------------------------------------------------------------------------
function TTransaction_List.LastEffectiveDate : LongInt;
var
  i: integer;
  Transaction: TTransaction_Rec;
begin
  result := 0;

  for i := 0 to ItemCount-1 do
  begin
    Transaction := Transaction_At(i)^;

    if (i = 0) then
      result := Transaction.txDate_Effective
    else
      result := Max(result, Transaction.txDate_Effective);
  end;
end;

//------------------------------------------------------------------------------
function TTransaction_List.FirstPresDate : LongInt;
//returns 0 if no transactions or the first Date of Presentation
const
  ThisMethodName = 'TTransaction_List.FirstDate';
var
  i: integer;
  TransRec: TTransaction_Rec;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

  Result := 0;
  for i := 0 to Pred(itemCount) do begin
    TransRec := Transaction_At(i)^;
    if (Result = 0) or
       ((Result > 0) and (TransRec.txDate_Presented < Result)
                     and (TransRec.txDate_Presented > 0)) then
      Result := TransRec.txDate_Presented;
  end;

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;
//------------------------------------------------------------------------------
function TTransaction_List.LastPresDate : LongInt;
//returns 0 if no transactions or the highest Date of Presentation
const
  ThisMethodName = 'TTransaction_List.LastDate';
var
  i: integer;
  TransRec: TTransaction_Rec;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

  Result := 0;
  for i := 0 to Pred(itemCount) do begin
    TransRec := Transaction_At( I )^;
    if (Result < TransRec.txDate_Presented) then
      Result := TransRec.txDate_Presented;
  end;

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

//------------------------------------------------------------------------------
procedure TTransaction_List.UpdateCRC(var CRC: Longword);
var
  T: Integer;
  Transaction: pTransaction_Rec;
  Dissection: pDissection_Rec;
begin
  For T := 0 to Pred( ItemCount ) do Begin
     Transaction := Transaction_At( T );
     BKCRC.UpdateCRC( Transaction^, CRC );
     With Transaction^ do Begin
        Dissection := txFirst_Dissection;
        While Dissection<>NIL do With Dissection^ do Begin
           BKCRC.UpdateCRC( Dissection^, CRC );
           Dissection := Dissection^.dsNext;
        end;
     end;
  end;
end;

//------------------------------------------------------------------------------
constructor TTransaction_List.Create(AClient, ABank_Account: TObject; AAuditMgr: TClientAuditManager);
begin
  inherited Create;

  fTran_Suggested_Index := TTran_Suggested_Index.Create;
  fTran_Transaction_Code_Index := TTran_Transaction_Code_Index.Create;

  FLoading := False;
  Duplicates := false;
  FLastSeq := 0;
  FClient := AClient;
  FBank_Account := ABank_Account;
  FAuditMgr := AAuditMgr;
end;

destructor TTransaction_List.Destroy;
begin
  FreeAndNil( fTran_Transaction_Code_Index );
  FreeAndNil( fTran_Suggested_Index );
  inherited;
end;

//------------------------------------------------------------------------------
procedure TTransaction_List.DoAudit(ATransactionListCopy: TTransaction_List;
  AParentID: integer; AAccountType: byte; var AAuditTable: TAuditTable);
var
  i: integer;
  P1, P2: pTransaction_Rec;
  AuditInfo: TAuditInfo;
  ProvDateStr: string;
  T1, T2: pTransaction_Rec;
begin
  //Note: AuditType is dependant on the type of bank account
  AuditInfo.AuditUser := FAuditMgr.CurrentUserCode;
  AuditInfo.AuditRecordType := tkBegin_Transaction;
  //Adds, changes
  for i := 0 to Pred(ItemCount) do begin
    P1 := Items[i];
    P2 := nil;
    if Assigned(ATransactionListCopy) then
      P2 := ATransactionListCopy.FindRecordID(P1.txAudit_Record_ID);
    AuditInfo.AuditRecord := Setup_New_Transaction;
    try
      AuditInfo.AuditType := FAuditMgr.GetTransactionAuditType(P1^.txSource, AAccountType);
      SetAuditInfo(P1, P2, AParentID, AuditInfo);
      if AuditInfo.AuditAction in [aaAdd, aaChange] then begin
        //Add provisional info
        if (AuditInfo.AuditAction = aaAdd) and (P1.txSource = orProvisional) then begin
          if (P1^.txTemp_Prov_Date_Time = 0) then
            ProvDateStr := 'UNKNOWN'
          else
            ProvDateStr := FormatDateTime('dd/MM/yy hh:mm:ss', P1^.txTemp_Prov_Date_Time);
          AuditInfo.AuditOtherInfo := Format('%s%sEntered By=%s%sEntered At=%s',
                                             [AuditInfo.AuditOtherInfo,
                                              VALUES_DELIMITER,
                                              P1^.txTemp_Prov_Entered_By,
                                              VALUES_DELIMITER,
                                              ProvDateStr]);
        end;
        AAuditTable.AddAuditRec(AuditInfo);
      end;
    finally
      Dispose(AuditInfo.AuditRecord);
    end;
  end;
  //Deletes
  if Assigned(ATransactionListCopy) then begin //Sub list - may not be assigned
    for i := 0 to ATransactionListCopy.ItemCount - 1 do begin
      P2 := ATransactionListCopy.Items[i];
      AuditInfo.AuditType := FAuditMgr.GetTransactionAuditType(P2^.txSource, AAccountType);
      P1 := FindRecordID(P2.txAudit_Record_ID);
      AuditInfo.AuditRecord := Setup_New_Transaction;
      try
        SetAuditInfo(P1, P2, AParentID, AuditInfo);
        if (AuditInfo.AuditAction = aaDelete) then
          AAuditTable.AddAuditRec(AuditInfo);
      finally
        Dispose(AuditInfo.AuditRecord);
      end;
    end;
  end;

  //Dissections
  for i := 0 to Pred(itemCount) do begin
    T1 := Items[i];
    T2 := nil;
    if Assigned(ATransactionListCopy) then
      T2 := ATransactionListCopy.FindRecordID(T1.txAudit_Record_ID);
    if Assigned(T1) then
      DoDissectionAudit(T1, T2, AAccountType, AAuditTable)
  end;
end;

procedure TTransaction_List.DoDissectionAudit(ATransaction,
  ATransactionCopy: pTransaction_Rec; AAccountType: byte; var AAuditTable: TAuditTable);
var
  P1, P2: pDissection_Rec;
  AuditInfo: TAuditInfo;
begin
  //Note: AuditType is dependant on the type of bank account
  AuditInfo.AuditUser := FAuditMgr.CurrentUserCode;
  AuditInfo.AuditRecordType := tkBegin_Dissection;
  //Adds, changes
  if Assigned(ATransaction) then begin
    P1 := ATransaction.txFirst_Dissection;
    while (P1 <> nil) do begin
      P2 := nil;
      if Assigned(ATransactionCopy) then
        P2 := FindDissectionRecordID(ATransactionCopy, P1.dsAudit_Record_ID);
      AuditInfo.AuditRecord := Create_New_Dissection;
      try
        AuditInfo.AuditType := FAuditMgr.GetTransactionAuditType(ATransaction^.txSource, AAccountType);
        SetDissectionAuditInfo(P1, P2, ATransaction.txAudit_Record_ID , AuditInfo);
        if AuditInfo.AuditAction in [aaAdd, aaChange] then
          AAuditTable.AddAuditRec(AuditInfo);
      finally
        Dispose(AuditInfo.AuditRecord);
      end;
      P1 := P1^.dsNext;
    end;
  end;
  //Deletes
  if Assigned(ATransactionCopy) then begin //Sub list - may not be assigned
    P2 := ATransactionCopy.txFirst_Dissection;
    while P2 <> nil do begin
      AuditInfo.AuditType := FAuditMgr.GetTransactionAuditType(ATransactionCopy.txSource, AAccountType);
      P1 := nil;
      if Assigned(ATransaction) then
        P1 := FindDissectionRecordID(ATransaction, P2.dsAudit_Record_ID);
      AuditInfo.AuditRecord := Create_New_Dissection;
      try
        SetDissectionAuditInfo(P1, P2, ATransactionCopy.txAudit_Record_ID, AuditInfo);
        if (AuditInfo.AuditAction = aaDelete) then
          AAuditTable.AddAuditRec(AuditInfo);
      finally
        Dispose(AuditInfo.AuditRecord);
      end;
      P2 := P2^.dsNext;
    end;
  end;
end;

function TTransaction_List.FindDissectionRecordID(
  ATransaction: pTransaction_Rec; ARecordID: integer): pDissection_Rec;
var
  Dissection: pDissection_Rec;
begin
  Result := nil;
  if Assigned(ATransaction) then begin
    Dissection := ATransaction.txFirst_Dissection;
    while Dissection <> nil do begin
      if Dissection.dsAudit_Record_ID = ARecordID then begin
        Result := Dissection;
        Break;
      end;
      Dissection := Dissection.dsNext;
    end;
  end;
end;

function TTransaction_List.FindRecordID(ARecordID: integer): pTransaction_Rec;
var
  i : integer;
begin
  Result := nil;
  if (ItemCount = 0) then Exit;

  for i := 0 to Pred(ItemCount) do
    if Transaction_At(i).txAudit_Record_ID = ARecordID then begin
      Result := Transaction_At(i);
      Exit;
    end;
end;

function TTransaction_List.FindTransactionFromECodingUID(
  UID: integer): pTransaction_Rec;
var
  T: Integer;
  Transaction: pTransaction_Rec;
begin
  result := nil;
  for T := First to Last do
  begin
    Transaction := Transaction_At( T );
    if Transaction.txECoding_Transaction_UID = UID then
    begin
      result := Transaction;
      exit;
    end;
  end;
end;

function TTransaction_List.FindTransactionFromMatchId(
  UID: integer): pTransaction_Rec;
var
  T: Integer;
  Transaction: pTransaction_Rec;
begin
  result := nil;
  for T := First to Last do
  begin
    Transaction := Transaction_At( T );
    if (Transaction.txMatched_Item_ID = UID) and (Transaction.txUPI_State in [upReversedUPC, upReversedUPD, upReversedUPW]) then
    begin
      result := Transaction;
      exit;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TTransaction_List.SearchByTransactionCoreID(aCore_Transaction_ID,
  aCore_Transaction_ID_High: integer; var aIndex: integer): Boolean;
var
  SearchTran_Transaction_Code_Index_Rec : pTran_Transaction_Code_Index_Rec;

begin
  SearchTran_Transaction_Code_Index_Rec := fTran_Transaction_Code_Index.NewItem;
  try
    if assigned( SearchTran_Transaction_Code_Index_Rec ) then
      SearchTran_Transaction_Code_Index_Rec^.tiCoreTransactionID     :=
        CombineInt32ToInt64( aCore_Transaction_ID_High, aCore_Transaction_ID);
    Result := fTran_Transaction_Code_Index.Search(SearchTran_Transaction_Code_Index_Rec, aIndex);
  finally
    fTran_Transaction_Code_Index.FreeItem( SearchTran_Transaction_Code_Index_Rec );
  end;
end;

function TTransaction_List.SearchUsingDateandTranSeqNo(aDate_Effective, aTranSeqNo : integer; var aIndex: integer): Boolean;
var
  Top, Bottom, Index, CompRes : Integer;
begin
  Result := False;
  Top := 0;
  Bottom := FCount - 1;
  while Top <= Bottom do
  begin
    Index := ( Top + Bottom ) shr 1;

    CompRes := CompareValue(aDate_Effective, pTransaction_Rec(At(Index))^.txDate_Effective);
    if CompRes = 0 then
      CompRes := CompareValue(aTranSeqNo, pTransaction_Rec(At(Index))^.txSequence_No);

    if CompRes > 0 then
      Top := Index + 1
    else
    begin
      Bottom := Index - 1;
      if CompRes = 0 then
      begin
        Result := True;
        aIndex := Index;
        Exit;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TTransaction_List.SearchUsingTypeDateandTranSeqNo(aType: Byte; aDate_Effective, aTranSeqNo: integer; var aIndex: integer): Boolean;
var
  SearchpTran_Suggested_Index_Rec : pTran_Suggested_Index_Rec;
begin
  SearchpTran_Suggested_Index_Rec := fTran_Suggested_Index.NewItem;
  try
    SearchpTran_Suggested_Index_Rec^.tiType := aType;
    SearchpTran_Suggested_Index_Rec^.tiDate_Effective := aDate_Effective;
    SearchpTran_Suggested_Index_Rec^.tiTran_Seq_No := aTranSeqNo;
    Result := fTran_Suggested_Index.Search(SearchpTran_Suggested_Index_Rec, aIndex);
  finally
    fTran_Suggested_Index.FreeItem(SearchpTran_Suggested_Index_Rec);
  end;
end;

//------------------------------------------------------------------------------
{ TTran_Transaction_Code_Index }

function TTran_Transaction_Code_Index.Compare(Item1, Item2: Pointer): integer;
begin
  result := 0;
  if assigned( Item1 ) then begin // Then assume for the moment Item2 is not assigned
    result := 1;
    if assigned( Item2 ) then     // Ok Item2 is assigned, safe to compare
      Result := CompareValue( pTran_Transaction_Code_Index_Rec( Item1 )^.tiCoreTransactionID,
          pTran_Transaction_Code_Index_Rec( Item2 )^.tiCoreTransactionID );
  end;
end;

constructor TTran_Transaction_Code_Index.Create;
begin
  inherited;

  Duplicates := true;
end;

procedure TTran_Transaction_Code_Index.FreeItem(Item: Pointer);
begin
  fillchar( pTran_Transaction_Code_Index_Rec(Item)^, Tran_Transaction_Code_Index_Rec_Size, #0);

  SafeFreeMem(Item, Tran_Transaction_Code_Index_Rec_Size);
  Item := nil;
end;

procedure TTran_Transaction_Code_Index.FreeTheItem(Item: Pointer);
begin
  DelFreeItem(Item);
end;

function TTran_Transaction_Code_Index.NewItem: Pointer;
var                                  
  P : pTran_Transaction_Code_Index_Rec;
Begin
  SafeGetMem( P, Tran_Transaction_Code_Index_Rec_Size );

  If Assigned( P ) then
    FillChar( P^, Tran_Transaction_Code_Index_Rec_Size, 0 )
  else
    Raise EInsufficientMemory.CreateFmt( SInsufficientMemory, [ 'TTran_Transaction_Code_Index' ] );

  Result := P;

end;

initialization
   DebugMe := DebugUnit(UnitName);

end.
