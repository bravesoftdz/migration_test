unit PayeeObj;
//------------------------------------------------------------------------------
{
   Title:       PayeeObj

   Description: Payee Object

   Remarks:

   Author:      Matthew Hopkins, Michael Foot

}
//------------------------------------------------------------------------------
interface

uses
  Classes,
  BKDefs,
  IOStream,
  ECollect,
  AuditMgr;

type
   TPayeeLinesList = class(TExtdCollection)
   protected
     procedure FreeItem( Item : Pointer ); override;
   public
     function  PayeeLine_At( Index : LongInt ): pPayee_Line_Rec;
     procedure SaveToFile( Var S : TIOStream );
     procedure LoadFromFile( Var S : TIOStream );
     procedure UpdateCRC(var CRC : Longword);
     procedure CheckIntegrity;
   end;

   TPayee = class
     pdFields : TPayee_Detail_Rec;
     pdLines  : TPayeeLinesList;

     constructor Create;
     destructor Destroy; override;
   private
     function GetName : ShortString;
   public
     property  pdNumber : Integer read pdFields.pdNumber;
     property  pdName : ShortString read GetName;

     function  pdLinesCount : integer;
     function  IsDissected : boolean;
     function  FirstLine : pPayee_Line_Rec;

     procedure SaveToFile( Var S : TIOStream );
     procedure LoadFromFile( Var S : TIOStream );
     procedure UpdateCRC(var CRC : Longword);
   end;

   TPayee_List = class(TExtdSortedCollection)
      constructor Create;
      function Compare( Item1, Item2 : Pointer ) : integer; override;
      function FindRecordID( ARecordID : integer ):  TPayee;
   protected
      procedure FreeItem( Item : Pointer ); override;
   public
      function  Payee_At( Index : LongInt ): TPayee;
      function  Find_Payee_Number( CONST ANumber: LongInt ): TPayee;
      function  Find_Payee_Name( CONST AName: String ): TPayee;
      function  Search_Payee_Name( CONST AName : ShortString ): TPayee;
      function Guess_Next_Payee_Number(const ANumber: Integer): TPayee;

      procedure SaveToFile( Var S : TIOStream );
      procedure LoadFromFile( Var S : TIOStream );

      procedure UpdateCRC(var CRC : Longword);
      procedure CheckIntegrity;

      procedure DoAudit(AAuditType: TAuditType; APayeeDetailCopy: TPayee_List;
                        AParentID: integer; var AAuditTable: TAuditTable);
      procedure SetAuditInfo(P1, P2: pPayee_Detail_Rec; AParentID: integer;
                             var AAuditInfo: TAuditInfo);
      procedure AddAuditValues(const AAuditRecord: TAudit_Trail_Rec; var Values: string);
      procedure Insert(Item: Pointer); override;
   end;

implementation

uses
  Malloc,
  SysUtils,
  BK5Except,
  BKCRC,
  BKDBExcept,
  BKPLIO,
  BKPDIO,
  LogUtil,
  StStrS,
  Tokens,
  BKAUDIT;

const
  UnitName = 'PayeeObj';

{ TPayee_List }

constructor TPayee.Create;
begin
  inherited Create;

  FillChar( pdFields, Sizeof( pdFields ), 0 );
  with pdFields do
  begin
    pdRecord_Type := tkBegin_Payee_Detail;
    pdEOR := tkEnd_Payee_Detail;
  end;

  pdLines := TPayeeLinesList.Create;
end;

destructor TPayee.Destroy;
begin
  pdLines.Free;
  Free_Payee_Detail_Rec_Dynamic_Fields(pdFields);
  inherited Destroy;
end;

procedure TPayee_List.AddAuditValues(const AAuditRecord: TAudit_Trail_Rec;
  var Values: string);
var
  Token, Idx: byte;
  ARecord: Pointer;
begin
  ARecord := AAuditRecord.atAudit_Record;

  if ARecord = nil then begin
    Values := AAuditRecord.atOther_Info;
    Exit;
  end;

  Idx := 0;
  Token := AAuditRecord.atChanged_Fields[idx];
  while Token <> 0 do begin
    case Token of
      //Number
      92: ClientAuditMgr.AddAuditValue(BKAuditNames.GetAuditFieldName(tkBegin_Payee_Detail, 91),
                                       tPayee_Detail_Rec(ARecord^).pdNumber, Values);
      //Name
      93: ClientAuditMgr.AddAuditValue(BKAuditNames.GetAuditFieldName(tkBegin_Payee_Detail, 92),
                                       tPayee_Detail_Rec(ARecord^).pdName, Values);
    end;
    Inc(Idx);
    Token := AAuditRecord.atChanged_Fields[idx];    
  end;
end;

procedure TPayee_List.CheckIntegrity;
var
  LastCode : String[40];
  i : Integer;
  APayee : TPayee;
begin
  LastCode := '';
  for i := First to Last do
  begin
    APayee := Payee_At(i);
    if (APayee.pdName < LastCode) then
      Raise EDataIntegrity.CreateFmt('Payee List Sequence : %d', [i]);
    APayee.pdLines.CheckIntegrity;
    LastCode := APayee.pdName;
  end;
end;

function TPayee_List.Compare(Item1, Item2: Pointer): integer;
begin
  Result := StStrS.CompStringS(TPayee(Item1).pdName,TPayee(Item2).pdName);
end;

constructor TPayee_List.Create;
begin
  inherited;
end;

procedure TPayee_List.DoAudit(AAuditType: TAuditType;
  APayeeDetailCopy: TPayee_List; AParentID: integer; var AAuditTable: TAuditTable);
var
  i: integer;
  P1, P2: pPayee_Detail_Rec;
  AuditInfo: TAuditInfo;
  Payee: TPayee;
begin
  AuditInfo.AuditType := atPayees;
  AuditInfo.AuditUser := ClientAuditMgr.CurrentUserCode;
  AuditInfo.AuditRecordType := tkBegin_Payee_Detail;
  //Adds, changes
  for i := 0 to Pred(ItemCount) do begin
    P1 := @TPayee(Items[i]).pdFields;
    P2 := nil;
    Payee := nil;
    if Assigned(APayeeDetailCopy) then //Sub list - may not be assigned
      Payee := APayeeDetailCopy.FindRecordID(P1.pdAudit_Record_ID);
    if Assigned(Payee) then
      P2 := @Payee.pdFields;
    AuditInfo.AuditRecord := New_Payee_Detail_Rec;
    try
      SetAuditInfo(P1, P2, AParentID, AuditInfo);
      if AuditInfo.AuditAction in [aaAdd, aaChange] then
        AAuditTable.AddAuditRec(AuditInfo);
    finally
      Dispose(AuditInfo.AuditRecord);
    end;
  end;
  //Deletes
  if Assigned(APayeeDetailCopy) then begin //Sub list - may not be assigned
    for i := 0 to APayeeDetailCopy.ItemCount - 1 do begin
      P2 := @TPayee(APayeeDetailCopy.Items[i]).pdFields;
      Payee := FindRecordID(P2.pdAudit_Record_ID);
      P1 := nil;
      if Assigned(Payee) then
        P1 := @Payee.pdFields;
      AuditInfo.AuditRecord := New_Payee_Detail_Rec;
      try
        SetAuditInfo(P1, P2, AParentID, AuditInfo);
        if (AuditInfo.AuditAction = aaDelete) then
          AAuditTable.AddAuditRec(AuditInfo);
      finally
        Dispose(AuditInfo.AuditRecord);
      end;
    end;
  end;
end;

function TPayee_List.FindRecordID(ARecordID: integer): TPayee;
var
  i : integer;
begin
  Result := nil;
  if (itemCount = 0 ) then Exit;

  for i := 0 to Pred( ItemCount ) do
    if Payee_At(i).pdFields.pdAudit_Record_ID = ARecordID then begin
      Result := Payee_At(i);
      Exit;
    end;
end;

function TPayee_List.Find_Payee_Name(const AName: String): TPayee;
var
  i : Integer;
  APayee : TPayee;
begin
  Result := nil;

  for i := First to Last do
  begin
    APayee := Payee_At(i);
    if (APayee.pdName = AName) then
    begin
      Result := APayee;
      exit;
    end;
  end;
end;

function TPayee_List.Find_Payee_Number(const ANumber: Integer): TPayee;
var
  i : Integer;
  APayee : TPayee;
begin
  Result := nil;

  for i := First to Last do
  begin
    APayee := Payee_At(i);
    if (APayee.pdNumber = ANumber) then
    begin
      Result := APayee;
      exit;
    end;
  end;
end;

// Get next number given a number that doesn't exist
function TPayee_List.Guess_Next_Payee_Number(const ANumber: Integer): TPayee;
var
  i : Integer;
  APayee : TPayee;
  BestMatch: Integer;
begin
  Result := Find_Payee_Number(ANumber);
  if not Assigned(Result) then
  begin
    BestMatch := 999999;
    for I := First to Last do
    begin
      APayee := Payee_At(i);
      if (APayee.pdNumber > ANumber) and ((APayee.pdNumber - ANumber) < BestMatch) then
      begin
        BestMatch := APayee.pdNumber - ANumber;
        Result := APayee;
      end;
    end;
  end;
end;

procedure TPayee_List.Insert(Item: Pointer);
begin
  TPayee(Item).pdFields.pdAudit_Record_ID := ClientAuditMgr.NextClientRecordID;
  inherited;
end;

procedure TPayee_List.FreeItem(Item: Pointer);
begin
  TPayee(Item).Free;
end;

procedure TPayee_List.LoadFromFile(var S: TIOStream);
const
  ThisMethodName = 'TPayee_List.LoadFromFile';
var
  Token    : Byte;
  P        : TPayee;
  msg      : string;
begin
   Token := S.ReadToken;
   while ( Token <> tkEndSection ) do
   begin
      case Token of
         tkBegin_Payee_Detail :
           begin
              P := TPayee.Create;
              if not Assigned( P ) then
              begin
                 Msg := Format( '%s : Unable to allocate P',[ThisMethodName]);
                 LogUtil.LogMsg(lmError, UnitName, Msg );
                 raise EInsufficientMemory.CreateFmt( '%s - %s', [ UnitName, Msg ] );
              end;
              P.LoadFromFile( S );
              inherited Insert( P );
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
end;

function TPayee_List.Payee_At(Index: Integer): TPayee;
begin
  Result := At(Index);
end;

procedure TPayee_List.SaveToFile(var S: TIOStream);
var
  i : Integer;
begin
   S.WriteToken( tkBeginPayeesList );
   for i := First to Last do
     Payee_At(i).SaveToFile(S);
   S.WriteToken( tkEndSection );
end;

function TPayee_List.Search_Payee_Name(const AName: ShortString): TPayee;
begin
  //Not used. See pyList32.Search_Payee_Name.
  Result := nil;
end;

procedure TPayee_List.SetAuditInfo(P1, P2: pPayee_Detail_Rec;
  AParentID: integer; var AAuditInfo: TAuditInfo);
begin
  AAuditInfo.AuditAction := aaNone;
  AAuditInfo.AuditParentID := AParentID;
  AAuditInfo.AuditOtherInfo := Format('%s=%s', ['RecordType','Payee']) +
                               VALUES_DELIMITER +
                               Format('%s=%d', ['ParentID', AParentID]);
  if not Assigned(P1) then begin
    //Delete
    AAuditInfo.AuditAction := aaDelete;
    AAuditInfo.AuditRecordID := P2.pdAudit_Record_ID;
  end else if Assigned(P2) then begin
    //Change
    AAuditInfo.AuditRecordID := P1.pdAudit_Record_ID;
    if Payee_Detail_Rec_Delta(P1, P2, AAuditInfo.AuditRecord, AAuditInfo.AuditChangedFields) then
      AAuditInfo.AuditAction := aaChange;
  end else begin
    //Add
    AAuditInfo.AuditAction := aaAdd;
    AAuditInfo.AuditRecordID := P1.pdAudit_Record_ID;
    P1.pdAudit_Record_ID := AAuditInfo.AuditRecordID;
    BKPDIO.SetAllFieldsChanged(AAuditInfo.AuditChangedFields);
    Copy_Payee_Detail_Rec(P1, AAuditInfo.AuditRecord);
  end;
end;

procedure TPayee_List.UpdateCRC(var CRC: Longword);
var
  i : integer;
begin
  for i := First to Last do
    Payee_At(i).UpdateCRC(CRC);
end;

function TPayee.FirstLine: pPayee_Line_Rec;
begin
  if pdLines.ItemCount > 0 then
    result := pdLines.PayeeLine_At(0)
  else
    result := nil;
end;

function TPayee.GetName: ShortString;
begin
  Result := pdFields.pdName;
end;

function TPayee.IsDissected: boolean;
begin
  result := pdLines.ItemCount > 1;
end;

procedure TPayee.LoadFromFile(var S: TIOStream);
const
  ThisMethodName = 'TPayee.LoadFromFile';
var
  Token    : Byte;
  msg      : string;
begin
   Token := tkBegin_Payee_Detail;
   repeat
      case Token of
         tkBegin_Payee_Detail :
           BKPDIO.Read_Payee_Detail_Rec(pdFields, S);
         tkBeginPayeeLinesList :
           pdLines.LoadFromFile(S);
      else
         begin { Should never happen }
            Msg := Format( '%s : Unknown Token %d', [ ThisMethodName, Token ] );
            LogUtil.LogMsg(lmError, UnitName, Msg );
            raise ETokenException.CreateFmt( '%s - %s', [ UnitName, Msg ] );
         end;
      end; { of Case }
      Token := S.ReadToken;
   until Token = tkEndSection;
end;

function TPayee.pdLinesCount: integer;
begin
  result := pdLines.ItemCount;
end;

procedure TPayee.SaveToFile(var S: TIOStream);
begin
  BKPDIO.Write_Payee_Detail_Rec(pdFields, S);
  pdLines.SaveToFile(S);
  S.WriteToken(tkEndSection);
end;

procedure TPayee.UpdateCRC(var CRC: Longword);
begin
  BKCRC.UpdateCRC(pdFields, CRC);
  pdLines.UpdateCRC(CRC);
end;

{ TPayeeLinesList }

procedure TPayeeLinesList.CheckIntegrity;
var
  i : Integer;
begin
  for i := First to Last do
    with PayeeLine_At(i)^ do;
end;

procedure TPayeeLinesList.FreeItem(Item: Pointer);
begin
  if BKPLIO.IsAPayee_Line_Rec( Item ) then begin
    BKPLIO.Free_Payee_Line_Rec_Dynamic_Fields( pPayee_Line_Rec( Item)^ );
    SafeFreeMem( Item, Payee_Line_Rec_Size );
  end;
end;

procedure TPayeeLinesList.LoadFromFile(var S: TIOStream);
const
  ThisMethodName = 'TPayeeLinesList.LoadFromFile';
var
  Token    : Byte;
  PL       : pPayee_Line_Rec;
  msg      : string;
begin
   Token := S.ReadToken;
   while ( Token <> tkEndSection ) do
   begin
      case Token of
         tkBegin_Payee_Line :
           begin
              PL := New_Payee_Line_Rec;
              BKPLIO.Read_Payee_Line_Rec(PL^, S);
              Insert(PL);
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
end;

function TPayeeLinesList.PayeeLine_At(Index: Integer): pPayee_Line_Rec;
var
  P : Pointer;
begin
  Result := nil;
  P := At(Index);
  if (BKPLIO.IsAPayee_Line_Rec(P)) then
    Result := P;
end;

procedure TPayeeLinesList.SaveToFile(var S: TIOStream);
var
  i : Integer;
begin
  S.WriteToken(tkBeginPayeeLinesList);
  for i := First To Last do
    BKPLIO.Write_Payee_Line_Rec(PayeeLine_At(i)^, S);
  S.WriteToken(tkEndSection);
end;

procedure TPayeeLinesList.UpdateCRC(var CRC: Longword);
var
  i : Integer;
begin
  for i := First to Last do
    BKCRC.UpdateCRC(PayeeLine_At(i)^, CRC)
end;

end.
