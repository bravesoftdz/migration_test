unit rmList32;

interface

uses
  eCollect, BKDEFS, BKrmIO, rmObj32, IOSTREAM, Math, SysUtils, TOKENS, LogUtil,
  BKDbExcept,
  StDate,
  bkDateUtils,
  MoneyDef,
  bkConst;

type
  { ----------------------------------------------------------------------------
    TRecommended_Mem_List
  ---------------------------------------------------------------------------- }
  TRecommended_Mem_List = class(TExtdSortedCollection)
  protected
    procedure FreeItem(Item: Pointer); override;

  public
    constructor Create; override;
    function  Compare(Item1, Item2: Pointer) : integer; override;

    procedure SaveToFile(var S: TIOStream);
    procedure LoadFromFile(var S: TIOStream);

    function  Recommended_Mem_At(Index: integer): TRecommended_Mem;

    function  GetAs_pRec(Item: TRecommended_Mem): pRecommended_Mem_Rec;
  end;


implementation

const
   UnitName = 'rmList32';
   DebugMe: boolean = false;

{ ------------------------------------------------------------------------------
  TRecommended_Mem_List
------------------------------------------------------------------------------ }
constructor TRecommended_Mem_List.Create;
begin
  inherited Create;

  Duplicates := false;
end;

{------------------------------------------------------------------------------}
function TRecommended_Mem_List.Compare(Item1, Item2: Pointer): integer;
begin
  Result := CompareText(TRecommended_Mem(Item1).rmFields.rmStatement_Details,
                        TRecommended_Mem(Item2).rmFields.rmStatement_Details);
  if (Result <> 0) then Exit;
  Result := CompareValue(TRecommended_Mem(Item1).rmFields.rmType,
                         TRecommended_Mem(Item2).rmFields.rmType);
  if (Result <> 0) then Exit;
  Result := CompareText(TRecommended_Mem(Item1).rmFields.rmBank_Account_Number,
                        TRecommended_Mem(Item2).rmFields.rmBank_Account_Number);
  if (Result <> 0) then Exit;
  Result := CompareText(TRecommended_Mem(Item1).rmFields.rmAccount,
                        TRecommended_Mem(Item2).rmFields.rmAccount);
  if (Result <> 0) then Exit;
  Result := CompareValue(TRecommended_Mem(Item1).rmFields.rmManual_Count,
                         TRecommended_Mem(Item2).rmFields.rmManual_Count);
  if (Result <> 0) then Exit;
  Result := CompareValue(TRecommended_Mem(Item1).rmFields.rmUncoded_Count,
                         TRecommended_Mem(Item2).rmFields.rmUncoded_Count);
end;

{------------------------------------------------------------------------------}
procedure TRecommended_Mem_List.FreeItem(Item: Pointer);
var
  P: TRecommended_Mem;
begin
  P := TRecommended_Mem(Item);
  if Assigned(P) then
    P.Free;
end;

{------------------------------------------------------------------------------}
procedure TRecommended_Mem_List.SaveToFile(var S: TIOStream);
const
  ThisMethodName = 'TRecommended_Mem_List.SaveToFile';
var
  i: integer;
  Item: TRecommended_Mem;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins');

  S.WriteToken(tkBeginRecommended_Mem_List);

  for i := 0 to Pred(ItemCount) do
  begin
    Item := Recommended_Mem_At(i);
    ASSERT(Assigned(Item));
    Item.SaveToFile(S);
  end;

  S.WriteToken(tkEndSection);

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends');
end;

{------------------------------------------------------------------------------}
procedure TRecommended_Mem_List.LoadFromFile(var S: TIOStream);
const
  ThisMethodName = 'TRecommended_Mem_List.LoadFromFile';
var
  Token: Byte;
  Msg: string;
  P: TRecommended_Mem;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins');

  Token := S.ReadToken;
  While (Token <> tkEndSection) do
  begin
    // Should never happen
    if (Token <> tkBegin_Recommended_Mem) then
    begin
      Msg := Format('%s : Unknown Token %d', [ThisMethodName, Token]);
      LogUtil.LogMsg(lmError,UnitName, Msg);
      raise ETokenException.CreateFmt('%s - %s', [UnitName, Msg]);
    end;

    // Create, Load and then Insert
    P := TRecommended_Mem.Create;
    try
      P.LoadFromFile(S);
      Insert(P);
    except
      on E: Exception do
      begin
        FreeAndNil(P);
        raise;
      end;
    end;

    Token := S.ReadToken;
  end;

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends');
end;

{------------------------------------------------------------------------------}
function TRecommended_Mem_List.Recommended_Mem_At(Index: integer
  ): TRecommended_Mem;
var
  P: Pointer;
Begin
  P := At(Index);

  result := TRecommended_Mem(P);
end;

{------------------------------------------------------------------------------}
function TRecommended_Mem_List.GetAs_pRec(Item: TRecommended_Mem
  ): pRecommended_Mem_Rec;
begin
  if Assigned(Item) then
    result := Item.As_pRec
  else
    result := nil;
end;

{------------------------------------------------------------------------------}
initialization
  DebugMe := DebugUnit(UnitName);


end.
