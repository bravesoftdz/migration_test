//------------------------------------------------------------------------------
unit BudgetImportExport;

//------------------------------------------------------------------------------
interface

uses
  Windows,
  SysUtils,
  Classes,
  bkConst,
  MoneyDef,
  BKDefs,
  BUDOBJ32;

const
  BUDGET_DEFAULT_FILENAME = 'BudgetDefaultLocations.dat';
  UnitName = 'BudgetImportExport';
  ACCOUNT_CODE_PREFIX = 'Acc_';

//------------------------------------------------------------------------------
type
   EClearType = (clrAll,clrColumn,clrRow,clrControlRows);

   { Note: when adding new members, you must also change the CopyBudgetData
     function }
   TBudgetRec = record
     bAccount           : Bk5CodeStr;
     bDesc              : string[60];
     bAmounts           : Array[1..12] of integer;
     bQuantitys         : Array[1..12] of Money;
     bUnitPrices        : Array[1..12] of Money;
     bTotal             : integer;
     bIsPosting         : boolean;
     bIsGSTAccountCode  : boolean;
     bDetailLine        : pBudget_Detail_Rec;
     bNeedsUpdate       : Boolean;
     PercentAccount     : Bk5CodeStr; // Only used if the figures for this row are calculated from a % of another account code, empty otherwise
     Percentage         : double; // Only used if PercentAccount is not empty, see above
     bGstAmounts        : Array[1..12] of integer;
     bNonRoundedGstAmounts : Array[1..12] of double;
     bTotalWithGST      : integer;
     ShowGstAmounts     : Boolean;
   end;

   TBudgetData = Array of tBudgetRec;  {dynamic array}

   TExternalCmdBudget = ( ecbGenerate,     {budget form commands}
                          ecbCopy,
                          ecbSplit,
                          ecbAverage,
                          ecbSmooth,
                          ecbZero,
                          ecbPercentageChange,
                          ecbHideUnused,
                          ecbShowAll,
                          ecbChart,
                          ecbQuit,
                          ecbImport,
                          ecbExport
                          );

  TBudgetImportExport = class
  private
    fBudgetDefaultFile : string;

    function GetIOErrorDescription(ErrorCode : integer; ErrorMsg : string) : string;
    procedure GetDefFileLineData(aBudgetDefaults : TStringList;
                                 aClientCode : string;
                                 aBudgetName : string;
                                 var aIndex : integer;
                                 var aLineData : TStringList);
    function AmountMatchesQuantityFormula(var aData : TBudgetData; RowIndex, ColIndex: Integer): boolean;
    procedure BudgetEditRow(var aBudgetData : TBudgetData; aBudgetAmount, RowNum, ColNum: Integer);
  public
    function GetDefaultFileLocation(aClientCode : string;
                                    aBudgetName : string) : string;
    procedure SetDefaultFileLocation(aClientCode   : string;
                                     aBudgetName   : string;
                                     aFileLocation : string);

    function ExportBudget(aBudgetFilePath : string;
                          aIncludeUnusedChartCodes : boolean;
                          aData : TBudgetData;
                          aStartDate : integer;
                          var aMsg : string;
                          aIncludeNonPostingChartCodes: boolean;
                          aPrefixAccountCode: boolean = false;
                          GSTInclusive: boolean = false;
                          const aAutoCalculateGST: boolean = false): boolean;

    function CopyBudgetData(aBudgetData : TBudgetData; SubtractGST: boolean;
                            BudgetStartDate: integer) : TBudgetData;
    procedure ClearWasUpdated(var aBudgetData : TBudgetData);
    procedure UpdateBudgetDetailRows(var aBudgetData : TBudgetData; var aBudget : TBudget);

    function ImportBudget(aBudgetFilePath: string;
                          aBudgetErrorFilePath : string;
                          ShowFiguresGSTInclusive: boolean;
                          var aRowsImported : integer;
                          var aRowsNotImported : integer;
                          var aBudgetData : TBudgetData;
                          var aMsg : string;
                          const aAutoCalculateGST: boolean = false): boolean;
    function  RemoveAccountCodePrefix(const aValue: string): string;

    property BudgetDefaultFile : string read fBudgetDefaultFile write fBudgetDefaultFile;
  end;

  { Keep this out of the class, so it can be used in BudgetFrm for initializing
    MyClient.clExtra.ceAdd_Prefix_For_Account_Code. This function is specific to
    this unit.
  }
  function DoAccountCodesNeedToBePrefixed(const aData: TBudgetData): boolean;

//------------------------------------------------------------------------------
implementation

uses
  ovcdate,
  StDateSt,
  strutils,
  LogUtil,
  Globals,
  BudgetUnitPriceEntry,
  BKbdIO,
  GenUtils,
  BudgetAutoGST,
  GSTCalc32;

{ TBudgetImportExport }
//------------------------------------------------------------------------------
procedure TBudgetImportExport.GetDefFileLineData(aBudgetDefaults : TStringList;
                                                 aClientCode : string;
                                                 aBudgetName : string;
                                                 var aIndex : integer;
                                                 var aLineData : TStringList);
var
  Index : integer;
begin
  aIndex := -1;

  for Index := 0 to aBudgetDefaults.Count - 1 do
  begin
    aLineData.Clear;
    aLineData.Delimiter := ',';
    aLineData.StrictDelimiter := True;
    aLineData.DelimitedText := aBudgetDefaults.Strings[Index];

    if aLineData.Count <> 3 then
      // Invalid data found don't load any of the file could be corrupt or an old version
      Exit;

    if (aLineData[0] = aClientCode) and
       (aLineData[1] = aBudgetName) then
    begin
      //Found what we are looking for, exit with results
      aIndex := Index;
      Exit;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TBudgetImportExport.GetDefaultFileLocation(aClientCode: string;
                                                    aBudgetName : string): string;
const
  ThisMethodName = 'GetDefaultFileLocation';
var
  BudgetDefaults : TStringList;
  BudgetLineData : TStringList;
  LineIndex : integer;
begin
  Result := '';
  if FileExists(fBudgetDefaultFile) then
  begin
    BudgetDefaults := TStringList.Create;
    BudgetDefaults.Delimiter := ',';
    BudgetDefaults.StrictDelimiter := True;
    try
      try
        BudgetDefaults.LoadFromFile(fBudgetDefaultFile);

        BudgetLineData := TStringList.Create();
        try
          GetDefFileLineData(BudgetDefaults, aClientCode, aBudgetName, LineIndex, BudgetLineData);

          if (Assigned(BudgetLineData)) and (LineIndex > -1) then
            Result := BudgetLineData[2];
        finally
          FreeAndNil(BudgetLineData);
        end;

      except
        on e : Exception do
          LogUtil.LogMsg( lmError, UnitName, ThisMethodName + ' : Error loading file : ' +
                                             UserDir + BUDGET_DEFAULT_FILENAME + ' : ' + e.Message);
      end;
    finally
      FreeAndNil(BudgetDefaults);
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TBudgetImportExport.SetDefaultFileLocation(aClientCode   : string;
                                                     aBudgetName   : string;
                                                     aFileLocation : string);
const
  ThisMethodName = 'SetDefaultFileLocation';
var
  BudgetDefaults : TStringList;
  BudgetLineData : TStringList;
  LineIndex : integer;
begin
  LineIndex := -1;
  BudgetDefaults := TStringList.Create;
  BudgetDefaults.Delimiter := ',';
  BudgetDefaults.StrictDelimiter := True;
  try
    try
      if FileExists(fBudgetDefaultFile) then
      begin
        BudgetDefaults.LoadFromFile(fBudgetDefaultFile);

        BudgetLineData := TStringList.Create();
        try
          GetDefFileLineData(BudgetDefaults, aClientCode, aBudgetName, LineIndex, BudgetLineData);

          if (Assigned(BudgetLineData)) and (LineIndex > -1) then
            BudgetDefaults.Strings[LineIndex] := aClientCode + ',' + aBudgetName + ',' + aFileLocation;
        finally
          FreeAndNil(BudgetLineData);
        end;
      end;

      if LineIndex = -1 then // not found
        BudgetDefaults.Add(aClientCode + ',' + aBudgetName + ',' + aFileLocation);

      BudgetDefaults.SaveToFile(fBudgetDefaultFile);
    except
      on e : Exception do
        LogUtil.LogMsg( lmError, UnitName, ThisMethodName + ' : Error Accessing file : ' +
                                             UserDir + BUDGET_DEFAULT_FILENAME + ' : ' + e.Message);
    end;
  finally
    FreeAndNil(BudgetDefaults);
  end;
end;

//------------------------------------------------------------------------------
function TBudgetImportExport.GetIOErrorDescription(ErrorCode: integer; ErrorMsg: string): string;
begin
  case ErrorCode of
    2  : Result := 'No such file or directory';
    3  : Result := 'Path not found';
    5  : Result := 'I/O Error';
    13 : Result := 'Permission denied';
    20 : Result := 'Not a directory';
    21 : Result := 'Is a directory';
    32 : Result := 'Check that the file is not already open and try again.';
  else
    Result := ErrorMsg;
  end;
end;

//------------------------------------------------------------------------------
function TBudgetImportExport.ExportBudget(aBudgetFilePath: string;
                                          aIncludeUnusedChartCodes : boolean;
                                          aData : TBudgetData;
                                          aStartDate : integer;
                                          var aMsg : string;
                                          aIncludeNonPostingChartCodes: boolean;
                                          aPrefixAccountCode: boolean;
                                          GSTInclusive: boolean;
                                          const aAutoCalculateGST: boolean): boolean;
const
  ThisMethodName = 'ExportBudget';
var
  OutputFile    : Text;
  DateIndex     : integer;
  ColDate       : integer;
  DataIndex     : integer;
  HeaderLine    : string;
  DataLine      : string;
  UseGST        : Boolean;
  IsNonPostingCode : boolean;
  IsUnusedChart : boolean;
  TotalGSTNonRounded : double;

  //----------------------------------------------------------------------------
  function CheckIfLineIsUsed(aDataIndex : integer) : boolean;
  var
    curDateIndex : integer;
  begin
    Result := false;
    for curDateIndex := 1 to 12 do
    begin
      if ((aData[aDataIndex].ShowGstAmounts = true) and (aData[DataIndex].bGstAmounts[curDateIndex] <> 0)) or
         ((aData[DataIndex].ShowGstAmounts = false) and (aData[DataIndex].bAmounts[curDateIndex] <> 0)) then
      begin
        Result := true;
        exit;
      end;
    end;
  end;
begin
  Result := false;
  aMsg := '';

  try
    AssignFile(OutPutFile, aBudgetFilePath);
    Rewrite(OutPutFile);
    try
      // Header
      HeaderLine := '"Account","Description","Total"';
      for DateIndex := 0 to 11 do
      begin
        ColDate := IncDate(aStartDate, 0, DateIndex, 0);
        HeaderLine := HeaderLine + ',"' + StDateToDateString('nnn yy', ColDate, true) + '"';
      end;
      Writeln(OutputFile, HeaderLine );

      // Data
      for DataIndex := 0 to high(aData) do
      begin
        if (aData[DataIndex].bAccount = '') then
          Continue;

        if (GSTInclusive) and
           (aData[DataIndex].bIsGSTAccountCode) and
           (aAutoCalculateGST) and
           (not aIncludeUnusedChartCodes) then
          Continue;

        IsNonPostingCode := not aData[DataIndex].bIsPosting;
        IsUnusedChart := not CheckIfLineIsUsed(DataIndex);

        if (not aIncludeNonPostingChartCodes and IsNonPostingCode) then
          Continue;

        if (not (aIncludeNonPostingChartCodes and IsNonPostingCode)) and
          (not aIncludeUnusedChartCodes and IsUnusedChart) then
          Continue;

        aData[DataIndex].bTotal := 0;
        TotalGSTNonRounded := 0;
        for DateIndex := 1 to 12 do
        begin
          TotalGSTNonRounded := TotalGSTNonRounded +
                                aData[DataIndex].bNonRoundedGstAmounts[DateIndex];
          aData[DataIndex].bTotal := aData[DataIndex].bTotal +
                                     aData[DataIndex].bAmounts[DateIndex];
        end;
        aData[DataIndex].bTotalWithGST := DoRoundUpHalves(TotalGSTNonRounded);

        DataLine := '';

        // Add a space if account is not numeric
        if aPrefixAccountCode then
          DataLine := DataLine + '"' + ACCOUNT_CODE_PREFIX + aData[DataIndex].bAccount + '",'
        else
          DataLine := DataLine + '"' + aData[DataIndex].bAccount + '",';

        DataLine := DataLine + '"' + aData[DataIndex].bDesc + '",';
        if aData[DataIndex].bIsPosting then
        begin
          if GSTInclusive then
            UseGST := not aData[DataIndex].bIsGSTAccountCode
          else
            UseGST := aData[DataIndex].bIsGSTAccountCode and aAutoCalculateGST;

          // Non posting chart codes shouldn't display a total in the budget
          if UseGST then
            DataLine := DataLine + IntToStr(aData[DataIndex].bTotalWithGST) + ','
          else
            DataLine := DataLine + IntToStr(aData[DataIndex].bTotal) + ',';
        end else
          DataLine := DataLine + ',';

        for DateIndex := 1 to 12 do
        begin
          if aData[DataIndex].bIsPosting then
          begin
            if aIncludeUnusedChartCodes and GSTInclusive and aData[DataIndex].bIsGSTAccountCode then
              DataLine := DataLine + '0'
            // Non posting chart codes shouldn't display amounts in the budget
            else if aData[DataIndex].ShowGstAmounts or GSTInclusive then
              DataLine := DataLine + IntToStr(aData[DataIndex].bGstAmounts[DateIndex])
            else
              DataLine := DataLine + IntToStr(aData[DataIndex].bAmounts[DateIndex]);
          end;

          if DateIndex < 12 then
            DataLine := DataLine +  ',';
        end;

        Writeln(OutputFile, DataLine );
      end;

      Result := true;
    finally
      CloseFile(OutPutFile);
    end;
  except
    on e : EInOutError do
    begin
      aMsg := Format( 'Unable to Export file. %s', [ GetIOErrorDescription(E.ErrorCode, E.Message) ] );
      LogUtil.LogMsg( lmError, UnitName, ThisMethodName + ' : ' + aMsg );
    end;
  end;
end;

//------------------------------------------------------------------------------
function IsPartialDate(const aCode: string): boolean;
var
  iPos: integer;
  sMonth: string;
  iMonth: integer;
  sYear: string;
  iYear: integer;
begin
  result := false;

  // No date separator?
  iPos := Pos('-', aCode);
  if (iPos = 0) then
  begin
    iPos := Pos('/', aCode);
    if (iPos = 0) then
      exit;
  end;
  ASSERT(iPos <> 0);

  // Valid month?
  sMonth := LeftStr(aCode, iPos-1);
  if not TryStrToInt(sMonth, iMonth) then
    exit;
  if not ((1 <= iMonth) and (iMonth <= 12)) then
    exit;

  // Valid year?
  sYear := MidStr(aCode, iPos+1, MaxInt);
  if not TryStrToInt(sYear, iYear) then
    exit;
  if (iYear < 1899) then
    exit;

  result := true;
end;

//------------------------------------------------------------------------------
function DoAccountCodesNeedToBePrefixed(const aData: TBudgetData): boolean;
var
  i: integer;
  sCode: string;
  dDummy: double;
  chLeading: char;
  iDecimalPlace: integer;
  iLength: integer;
  chTrailing: char;
  dtDummy: TDateTime;
begin
  for i := 0 to High(aData) do
  begin
    sCode := Trim(aData[i].bAccount);
    if (sCode = '') then
      continue;

    // Could Excel see this as a number?
    if TryStrToFloat(sCode, dDummy) then
    begin
      { Leading zero?
        Note: these will be removed from the 'number' by Excel }
      chLeading := sCode[1];
      if (chLeading = '0') then
      begin
        result := true;
        exit;
      end;

      { Trailing zero after a decimal place?
        Note: these will be removed from the 'number' by Excel }
      iDecimalPlace := Pos('.', sCode);
      iLength := Length(sCode);
      chTrailing := sCode[iLength];
      if (iDecimalPlace <> 0) and (chTrailing = '0') then
      begin
        result := true;
        exit;
      end;
    end;

    // Could Excel see this as a date?
    if TryStrToDateTime(sCode, dtDummy) then
    begin
      result := true;
      exit;
    end;

    // Could Excel see this as a partial date, e.g. 1-1950 => 1/1/1950?
    if IsPartialDate(sCode) then
    begin
      result := true;
      exit;
    end;
  end;

  result := false;
end;

//------------------------------------------------------------------------------
function TBudgetImportExport.AmountMatchesQuantityFormula(var aData : TBudgetData; RowIndex, ColIndex: Integer): boolean;
var
  Quantity: Money;
  UnitPrice: Money;
  CalculatedAmount : Money;
  Amount: Integer;
begin
  Quantity := aData[RowIndex].bQuantitys[ColIndex];
  UnitPrice := aData[RowIndex].bUnitPrices[ColIndex];
  CalculatedAmount := TfrmBudgetUnitPriceEntry.CalculateTotal(UnitPrice, Quantity);
  Amount := aData[RowIndex].bAmounts[ColIndex];
  Result := CalculatedAmount = Amount;
end;

  //------------------------------------------------------------------------------
procedure TBudgetImportExport.BudgetEditRow(var aBudgetData : TBudgetData; aBudgetAmount, RowNum, ColNum: Integer);
begin
  aBudgetData[RowNum].bAmounts[ColNum] := aBudgetAmount;
  if (aBudgetAmount = 0) or not AmountMatchesQuantityFormula(aBudgetData, RowNum, ColNum) then
  begin
    aBudgetData[RowNum].bQuantitys[ColNum] := 0;
    aBudgetData[RowNum].bUnitPrices[ColNum] := 0;
  end;
  aBudgetData[RowNum].bNeedsUpdate := false;
end;

//------------------------------------------------------------------------------
procedure TBudgetImportExport.UpdateBudgetDetailRows(var aBudgetData: TBudgetData;
                                                     var aBudget: TBudget);
var
  NewLine : pBudget_Detail_Rec;
  RowIndex, ColIndex : integer;
begin
  for RowIndex := 0 to length(aBudgetData) - 1 do
  begin
    if aBudgetData[RowIndex].bNeedsUpdate then
    begin
      if aBudgetData[RowIndex].bDetailLine = nil then
      begin
        NewLine := New_Budget_Detail_Rec;
        NewLine.bdAccount_Code := aBudgetData[RowIndex].bAccount;
        aBudget.buDetail.Insert(NewLine);

        aBudgetData[RowIndex].bDetailLine := NewLine;
      end;

      for ColIndex := 1 to 12 do
      begin
        aBudgetData[RowIndex].bDetailLine.bdBudget[ColIndex]      := aBudgetData[RowIndex].bAmounts[ColIndex];
        aBudgetData[RowIndex].bDetailLine.bdQty_Budget[ColIndex]  := aBudgetData[RowIndex].bQuantitys[ColIndex];
        aBudgetData[RowIndex].bDetailLine.bdEach_Budget[ColIndex] := aBudgetData[RowIndex].bUnitPrices[ColIndex];
      end;
      aBudgetData[RowIndex].bDetailLine.bdPercent_Account := aBudgetData[RowIndex].PercentAccount;
      aBudgetData[RowIndex].bDetailLine.bdPercentage := aBudgetData[RowIndex].Percentage;

      aBudgetData[RowIndex].bNeedsUpdate := false;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TBudgetImportExport.CopyBudgetData(aBudgetData: TBudgetData; SubtractGST: boolean;
                                            BudgetStartDate: integer): TBudgetData;
var
  Account   : pAccount_Rec;
  BudgetIndex : integer;
  ClassNo   : byte;
  GstAmount: Money;
  MonthDateInt: integer;
  MonthIndex : integer;
begin
  SetLength(Result, length(aBudgetData));

  for BudgetIndex := 0 to length(aBudgetData) - 1 do
  begin
    Result[BudgetIndex].bAccount := aBudgetData[BudgetIndex].bAccount;
    Result[BudgetIndex].bDesc    := aBudgetData[BudgetIndex].bDesc;

    if SubtractGST then
    begin
      Account := MyClient.clChart.FindCode(aBudgetData[BudgetIndex].bAccount);
      ClassNo := GetGSTClassNo(MyClient, GetGSTClassCode(MyClient, Account.chGST_Class));
    end;
    for MonthIndex := 1 to 12 do
    begin
      if SubtractGST then
      begin
        MonthDateInt := IncDate(BudgetStartDate, 0, MonthIndex - 1, 0);
        CalculateGST(MyClient,
                     MonthDateInt,
                     aBudgetData[BudgetIndex].bAccount,
                     aBudgetData[BudgetIndex].bAmounts[MonthIndex],
                     ClassNo,
                     GstAmount);
        Result[BudgetIndex].bAmounts[MonthIndex]  := Round(aBudgetData[BudgetIndex].bAmounts[MonthIndex] - GstAmount);
      end else
        Result[BudgetIndex].bAmounts[MonthIndex]  := aBudgetData[BudgetIndex].bAmounts[MonthIndex];
      Result[BudgetIndex].bGstAmounts[MonthIndex] := aBudgetdata[BudgetIndex].bGstAmounts[MonthIndex];
      Result[BudgetIndex].bNonRoundedGstAmounts[MonthIndex] := aBudgetdata[BudgetIndex].bNonRoundedGstAmounts[MonthIndex];
      Result[BudgetIndex].bQuantitys[MonthIndex]  := aBudgetData[BudgetIndex].bQuantitys[MonthIndex];
      Result[BudgetIndex].bUnitPrices[MonthIndex] := aBudgetData[BudgetIndex].bUnitPrices[MonthIndex];
    end;

    Result[BudgetIndex].PercentAccount := aBudgetData[BudgetIndex].PercentAccount;
    Result[BudgetIndex].Percentage := aBudgetData[BudgetIndex].Percentage;
    Result[BudgetIndex].bTotal := aBudgetData[BudgetIndex].bTotal;
    Result[BudgetIndex].bIsPosting := aBudgetData[BudgetIndex].bIsPosting;
    Result[BudgetIndex].bIsGSTAccountCode := aBudgetData[BudgetIndex].bIsGSTAccountCode;
    Result[BudgetIndex].bDetailLine := aBudgetData[BudgetIndex].bDetailLine;
    Result[BudgetIndex].bNeedsUpdate := aBudgetData[BudgetIndex].bNeedsUpdate;
  end;
end;

//------------------------------------------------------------------------------
procedure TBudgetImportExport.ClearWasUpdated(var aBudgetData: TBudgetData);
var
  BudgetIndex : integer;
begin
  for BudgetIndex := 0 to length(aBudgetData) - 1 do
    aBudgetData[BudgetIndex].bNeedsUpdate := false;
end;

//------------------------------------------------------------------------------
function TBudgetImportExport.ImportBudget(aBudgetFilePath: string;
                                          aBudgetErrorFilePath : string;
                                          ShowFiguresGSTInclusive: boolean;
                                          var aRowsImported : integer;
                                          var aRowsNotImported : integer;
                                          var aBudgetData : TBudgetData;
                                          var aMsg : string;
                                          const aAutoCalculateGST: boolean): boolean;
const
  ThisMethodName = 'ImportBudget';
var
  InputFile : Text;
  ErrorFile : Text;
  InStrLine : string;
  Done : boolean;
  InLineData : TStringList;
  DataIndex, DateIndex : integer;
  LineHasError : boolean;
  LineNumber : integer;
  DataHolder : array[1..12] of integer;
  Codestr : string;
  bAllowPosting: boolean;
  sAmount: string;

  function GetDataIndexWithAccount(aAccount : string) : integer;
  var
    Index : integer;
  begin
    Result := -1;
    for Index := 0 to high(aBudgetData) do
    begin
      if aBudgetData[Index].bAccount = aAccount then
      begin
        Result := Index;
        Exit;
      end;
    end;
  end;

  function FillDataHolder: boolean;
  var
    DateIndex: integer;
  begin
    Result := True;
    for DateIndex := 1 to 12 do
    begin
      if not TryStrtoInt(InLineData[2 + DateIndex], DataHolder[DateIndex]) then
      begin
        WriteLn(ErrorFile, 'Row ' + inttostr(LineNumber) + ', Column ' + inttostr(DateIndex + 3) +
                           ', Code ' + Trim(InLineData[0]) + ', Error converting value to a number.');
        LineHasError := true;
        inc(aRowsNotImported);
        Result := False;
        break;
      end;
    end;
  end;

  // We don't want to give the warning about auto-calculated rows if the row
  // to be imported is the same as the existing row
  function IsPercentWarningNeeded: boolean;
  var
    i: integer;
    BudgetAmount: integer;
  begin
    Result := False;
    for i := Low(DataHolder) to High(DataHolder) do
    begin
      if ShowFiguresGSTInclusive xor aBudgetData[DataIndex].bIsGSTAccountCode then
        BudgetAmount := aBudgetData[DataIndex].bGstAmounts[i]
      else
        BudgetAmount := aBudgetData[DataIndex].bAmounts[i];
      if (DataHolder[i] <> BudgetAmount) then
      begin
        Result := True;
        break;
      end;
    end;
  end;

begin
  aRowsImported := 0;
  aRowsNotImported := 0;
  Done := false;
  Result := false;
  LineNumber := 0;
  try
    AssignFile(InputFile, aBudgetFilePath);
    Reset(InputFile);

    try
      AssignFile(ErrorFile, aBudgetErrorFilePath);
      Rewrite(ErrorFile);

      try
        InLineData := TStringList.Create;
        try
          if eof(InputFile) then
          begin
            aMsg := 'Unable to Import file. The file is empty.';
            Exit;
          end;

          // Ignore header
          readln(InputFile, InStrLine);
          inc(LineNumber);

          // ignore header
          if eof(InputFile) then
          begin
            aMsg := 'Unable to Import file. The file has no data.';
            Exit;
          end;

          while not eof(InputFile) do
          begin
            LineHasError := false;
            readln(InputFile, InStrLine);
            inc(LineNumber);

            InLineData.Delimiter := ',';
            InLineData.StrictDelimiter := True;
            InLineData.DelimitedText := InStrLine;

            // Remove the account code prefix, for both error and normal situations
            if (InLineData.Count > 0) then
              InLineData[0] := RemoveAccountCodePrefix(InLineData[0]);

            if InLineData.Count <> 15 then
            begin
              if InLineData.Count > 0 then
                Codestr := InLineData[0]
              else
                Codestr := '(Error finding Code)';

              WriteLn(ErrorFile, 'Row ' + inttostr(LineNumber) + ', Code ' + Trim(Codestr) +
                                 ', Incorrect amount of columns, 15 expected, ' + inttostr(InLineData.Count) + ' found.');
              inc(aRowsNotImported);
            end
            else
            begin
              DataIndex := GetDataIndexWithAccount(InLineData[0]);
              if DataIndex <> -1 then
              begin
                // Determine whether we can post
                bAllowPosting := aBudgetData[DataIndex].bIsPosting;
                if aAutoCalculateGST and aBudgetData[DataIndex].bIsGSTAccountCode then
                  bAllowPosting := false;

                // Posting allowed?
                if bAllowPosting then
                begin
                  if FillDataHolder then
                  begin
                    if (aBudgetData[DataIndex].PercentAccount <> '') then
                    begin
                      if IsPercentWarningNeeded then
                      begin
                        WriteLn(ErrorFile, 'Row ' + IntToStr(LineNumber) + ', Code ' + Trim(InLineData[0]) +
                                ', Data Row is auto-calculated and cannot be updated.');
                        inc(aRowsNotImported);
                      end;
                    end else
                    begin
                      for DateIndex := 1 to 12 do
                        BudgetEditRow(aBudgetData, DataHolder[DateIndex], DataIndex, DateIndex);

                      aBudgetData[DataIndex].bTotal := 0;
                      for DateIndex := 1 to 12 do
                        aBudgetData[DataIndex].bTotal := aBudgetData[DataIndex].bTotal +
                                                         aBudgetData[DataIndex].bAmounts[DateIndex];
                      aBudgetData[DataIndex].bNeedsUpdate := true;
                      inc(aRowsImported);
                    end;
                  end;
                end // if bAllowPosting then
                else
                begin
                  // GST row? (values must match)
                  if aAutoCalculateGST and aBudgetData[DataIndex].bIsGSTAccountCode then
                  begin
                    if FillDataHolder then
                    begin
                      if IsPercentWarningNeeded then
                      begin
                        for DateIndex := 1 to 12 do
                        begin
                          if aBudgetData[DataIndex].bIsGSTAccountCode then
                            sAmount := IntToStr(aBudgetData[DataIndex].bGstAmounts[DateIndex])
                          else
                            sAmount := IntToStr(aBudgetData[DataIndex].bAmounts[DateIndex]);
                          if (InLineData[2 + DateIndex] <> sAmount) then
                          begin
                            WriteLn(ErrorFile,
                              'Row ' + inttostr(LineNumber) +
                              ', Code ' + Trim(InLineData[0]) +
                              ', Data row is auto-calculated and cannot be updated.');
                            Inc(aRowsNotImported);                                    
                            break;
                          end;
                        end;
                      end;
                    end;
                  end
                  else if not aBudgetData[DataIndex].bIsGSTAccountCode then
                  begin
                    // Only show non posting error if data is different
                    for DateIndex := 1 to 12 do
                    begin
                      if (InLineData[2+ DateIndex] <> '') then
                      begin
                        WriteLn(ErrorFile, 'Row ' + inttostr(LineNumber) + ', Code ' + Trim(InLineData[0]) +
                                       ', Data row is not a posting row and cannot be updated.');
                        inc(aRowsNotImported);
                        break;
                      end;
                    end;
                  end;
                end; // if bAllowPosting
              end
              else
              begin
                WriteLn(ErrorFile, 'Row ' + inttostr(LineNumber) + ', Code ' + Trim(InLineData[0]) +
                                   ', Cannot find Account code.');
                inc(aRowsNotImported);
              end;
            end;
          end; // while not eof(InputFile) do

          Result := true;
        finally
          FreeAndNil(InLineData);
        end;
      finally
        CloseFile(ErrorFile);
      end;
    finally
      CloseFile(InputFile);
    end;

  except
    on e : EInOutError do
    begin
      aMsg := Format( 'Unable to Import file. %s', [ GetIOErrorDescription(E.ErrorCode, E.Message) ] );
      LogUtil.LogMsg( lmError, UnitName, ThisMethodName + ' : ' + aMsg );
      Done := true;
    end;
    on e : Exception do
    begin
      if not Done then
      begin
        aMsg := Format( 'Unable to Import file. %s', [E.Message] );
        LogUtil.LogMsg( lmError, UnitName, ThisMethodName + ' : ' + aMsg );
      end;
    end;
  end;
end;

function TBudgetImportExport.RemoveAccountCodePrefix(const aValue: string
  ): string;
var
  iPos: integer;
  iCode: integer;
begin
  iPos := Pos(ACCOUNT_CODE_PREFIX, aValue);
  if (iPos = 0) then
    result := aValue
  else
  begin
    iCode := Length(ACCOUNT_CODE_PREFIX) + 1;
    result := MidStr(aValue, iCode, MaxInt);
  end;
end;

end.
