unit SuggMemSortedList;

//------------------------------------------------------------------------------
interface

uses
  classes,
  eCollect;

type
  TColSortOrder = (csType, csPhrase, csAccount, csCodedMatch, csUncodedMatch);

  //----------------------------------------------------------------------------
  pSuggMemSortedListRec = ^TSuggMemSortedListRec;
  TSuggMemSortedListRec = Packed Record
    Id                 : integer;
    AccType            : Byte;
    MatchedPhrase      : String[200];
    Account            : String[20];
    TotalCount         : Integer;
    ManualCount        : integer;
    UnCodedCount       : integer;
    ManualAcountCount  : integer;
    IsExactMatch       : boolean;
    IsHidden           : boolean;
  end;

const
  BLANK_LINE = -1;
  NO_DATA = -2;
  SuggMemSortedListRecSize = Sizeof(TSuggMemSortedListRec);

type
  //----------------------------------------------------------------------------
  TSuggMemSortedList = class(TExtdSortedCollection)
  private
    fColSortOrder : TColSortOrder;
  protected
    function NewItem() : Pointer;
    procedure FreeItem(Item: Pointer); override;
  public
    constructor Create; override;
    function  Compare(Item1, Item2: Pointer) : integer; override;

    procedure AddItem(aSuggMemSortedItem : TSuggMemSortedListRec);
    function GetPRec(aIndex: integer): pSuggMemSortedListRec;

    property ColSortOrder : TColSortOrder read fColSortOrder write fColSortOrder;
  end;

//------------------------------------------------------------------------------
implementation

uses
  BKDbExcept,
  LogUtil,
  Math,
  SysUtils,
  MALLOC;

const
  UnitName = 'SuggMemSortedList';
  DebugMe: boolean = false;
  SInsufficientMemory = UnitName + ' Error: Out of memory in TSuggMemSortedListRec.NewItem';

{ TSuggMemSortedList }
//------------------------------------------------------------------------------
function TSuggMemSortedList.NewItem: Pointer;
var
  pSuggMem : pSuggMemSortedListRec;
Begin
  SafeGetMem( pSuggMem, SuggMemSortedListRecSize );

  If Assigned( pSuggMem ) then
    FillChar( pSuggMem^, SuggMemSortedListRecSize, 0 )
  else
    Raise EInsufficientMemory.Create( SInsufficientMemory );

  Result := pSuggMem;
end;

//------------------------------------------------------------------------------
procedure TSuggMemSortedList.FreeItem(Item: Pointer);
begin
  SafeFreeMem(Item, SuggMemSortedListRecSize);
end;

//------------------------------------------------------------------------------
constructor TSuggMemSortedList.Create;
begin
  inherited;

  fColSortOrder := csType;
  Duplicates := true;
end;

//------------------------------------------------------------------------------
function TSuggMemSortedList.Compare(Item1, Item2: Pointer): integer;
var
  SuggItem1, SuggItem2 : TSuggMemSortedListRec;

  function CompareHidden: integer;
  begin
    // Extra checking for blank line
    if SuggItem1.Id = BLANK_LINE then
    begin
      if SuggItem2.Id = BLANK_LINE then
        Result := 0
      else if SuggItem2.IsHidden then
        Result := -1
      else
        Result := 1;
    end
    else if SuggItem2.Id = BLANK_LINE then
    begin
      if SuggItem1.Id = BLANK_LINE then
        Result := 0
      else if SuggItem1.IsHidden then
        Result := 1
      else
        Result := -1;
    end
    else
    begin
      if (SuggItem1.IsHidden >
          SuggItem2.IsHidden) then
        Result := 1
      else if (SuggItem1.IsHidden =
               SuggItem2.IsHidden) then
        Result := 0
      else
        Result := -1;
    end;
  end;

begin
  SuggItem1 := pSuggMemSortedListRec(Item1)^;
  SuggItem2 := pSuggMemSortedListRec(Item2)^;

  Result := CompareHidden();
  if Result = 0 then
  begin
    case fColSortOrder of
      csType         : Result := CompareValue(SuggItem1.AccType, SuggItem2.AccType);
      csPhrase       : Result := CompareText(SuggItem1.MatchedPhrase, SuggItem2.MatchedPhrase);
      csAccount      : Result := CompareText(SuggItem1.Account, SuggItem2.Account);
      csCodedMatch   : Result := CompareValue(SuggItem1.ManualCount, SuggItem2.ManualCount);
      csUncodedMatch : Result := CompareValue(SuggItem1.UnCodedCount, SuggItem2.UnCodedCount);
    end;
  end;

  if (Result = 0) and (not (fColSortOrder = csPhrase)) then
    Result := CompareText(SuggItem1.MatchedPhrase, SuggItem2.MatchedPhrase);
end;

//------------------------------------------------------------------------------
procedure TSuggMemSortedList.AddItem(aSuggMemSortedItem : TSuggMemSortedListRec);
var
  NewSuggMem : pSuggMemSortedListRec;
begin
  NewSuggMem := NewItem;
  NewSuggMem^.Id                 := aSuggMemSortedItem.Id;
  NewSuggMem^.AccType            := aSuggMemSortedItem.AccType;

  NewSuggMem^.MatchedPhrase := StringReplace(aSuggMemSortedItem.MatchedPhrase, '&&', '&', [rfReplaceAll]);
  NewSuggMem^.MatchedPhrase := StringReplace(NewSuggMem^.MatchedPhrase, '&', '&&', [rfReplaceAll]);

  NewSuggMem^.Account            := aSuggMemSortedItem.Account;
  NewSuggMem^.TotalCount         := aSuggMemSortedItem.TotalCount;
  NewSuggMem^.ManualCount        := aSuggMemSortedItem.ManualCount;
  NewSuggMem^.ManualAcountCount  := aSuggMemSortedItem.ManualAcountCount;
  NewSuggMem^.IsExactMatch       := aSuggMemSortedItem.IsExactMatch;
  NewSuggMem^.IsHidden           := aSuggMemSortedItem.IsHidden;
  NewSuggMem^.UnCodedCount       := aSuggMemSortedItem.TotalCount - aSuggMemSortedItem.ManualCount;

  Insert(NewSuggMem);
end;

//------------------------------------------------------------------------------
function TSuggMemSortedList.GetPRec(aIndex: integer): pSuggMemSortedListRec;
begin
  Result := At(aIndex);
end;

//------------------------------------------------------------------------------
initialization
  DebugMe := DebugUnit(UnitName);

end.
