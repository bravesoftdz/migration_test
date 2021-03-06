unit SimpleFundX;
//------------------------------------------------------------------------------
{
   Title:       BGL Simple fund export

   Description:

   Remarks:     Oct 2000  Added GST amount and class fields

                Feb 2004  Added Super fund specific fields

   Author:

   Notes:       Simple Super from BGL Corporate Solutions
                Unit 2, Ormond Centre, 578-596 North Road
                Ormond Vic 3204

                Phone 00613 9530 6077

                Contact Ron Lesh

         Feb 04  Matt Crofts  mcrofts@bglcorp.com.au
                 Simple Fund Product Manager
                 1300 654 401

                Used by Flinders
}
//------------------------------------------------------------------------------
interface

uses
  Classes,
  StDate,
  Globals,
  OmniXML,
  OmniXMLUtils;

procedure ExtractData( const SuperFundType: byte; const FromDate, ToDate : TStDate; const SaveTo : string );
procedure ExtractDataBGL(const FromDate, ToDate: TStDate; const SaveTo : string);
procedure ExtractDataBGL360(const FromDate, ToDate: TStDate; const SaveTo : string; TestAccountList: TStringList = nil);
function StripBGL360ControlAccountCode( Value : string ) : integer;

//******************************************************************************
implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

uses
  BaObj32,
  baUtils,
  BkConst,
  bkDateUtils,
  BKDefs,
  dlgSelect,
  ExtractCommon,
  ExtractHelpers,
  GenUtils,
  glConst,
  InfoMoreFrm,
  IniFiles,
  LogUtil,
  MoneyDef,
  StStrS,
  SuperFieldsUtils,
  SysUtils,
  TransactionUtils,
  Traverse,
  TravUtils,
  YesNoDlg,
  GSTCalc32,
  Software;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Const
   UnitName = 'SimpleFundX';
   DebugMe  : Boolean = False;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Var
  XFile               : Text;
  Buffer              : array[ 1..2048 ] of Byte;
  NoOfEntries         : LongInt;
  FCloseBalance       : Money;
  FAccountNode        : IxmlNode;
  FOutputDocument     : IXMLDocument;
  FClientNode         : IxmlNode;
  FBalancesNode       : IxmlNode;
  FDateMask           : shortString;
  FRootNode           : IxmlNode;
  FTransactionsNode   : IxmlNode;
  FTransactionNode    : IxmlNode;
  FExtractFieldHelper : TExtractFieldHelper;
  FFields             : TStringList;
  ExtractFileExtn     : string;

 {Made this global since tester was getting an access violation in the sub functions where it's passed as a var parameter}
 TransactionNode: IXMLNode;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function FormatFloatBlankForZeroForXml(AFloat: comp; ADecimalPlaces: integer = 2;
                           AdivBy: integer = 100; AllowZero: boolean = false;
                           NeedCommaSeparator:Boolean=False): string;
begin
  if aFloat <> 0 then
    result := FormatFloatForXml(AFloat, ADecimalPlaces, AdivBy, AllowZero, NeedCommaSeparator )
  else
    result := '';
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function ExtractFieldHelper: TExtractFieldHelper;
begin
   if not Assigned(FExtractFieldHelper) then
      FExtractFieldHelper := TExtractFieldHelper.Create;

   Result := FExtractFieldHelper;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure SWrite(  const ADate        : TStDate;
                   const ARefce       : ShortString;
                   const AAccount     : ShortString;
                   const AAmount      : Money;
                   const AQuantity    : Money;
                   const ANarration   : ShortString;
                   const AGSTClass    : integer;
                   const AGSTAmount   : Money;

                   const aCGTDate              : integer;
                   const aImputedCredit        : Money;
                   const aTaxFreeDist          : Money;
                   const aTaxExemptDist        : Money;
                   const aTaxDeferredDist      : Money;
                   const aTFNCredit            : Money;
                   const aForeignIncome        : Money;
                   const aForeignTaxCredits    : Money;
                   const aOtherExpenses        : Money;
                   const aCapitalGainsIndexed  : Money;
                   const aCapitalGainsDisc     : Money;
                   const aCapitalGainsOther    : Money;
                   const aFranked              : Money;
                   const aUnfranked            : Money;
                   const aMember               : Byte);
const
   ThisMethodName = 'SWrite';
Var
   AbsGSTAmount : Money;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   Write( XFile, '"',Date2Str( ADate, 'dd/mm/yyyy' ),'",' );

   Write( XFile, '"',TrimSpacesS(ARefce), '",' );

   Write( XFile, '"',AAccount, '",' );

   Write( XFile, '"', AAmount/100:0:2, '",' );

   if (Globals.PRACINI_ExtractQuantity) then
     Write( XFile, '"', GetQuantityStringForExtract(AQuantity), '",' )
   else
     Write( XFile, '"', GetQuantityStringForExtract(0), '",' );

   Write( XFile, '"',Copy(TrimSpacesS( ANarration), 1, GetMaxNarrationLength), '",' );

   //BGL Simplefund requires that gst amount is always a positive number
   AbsGSTAmount := abs( AGSTAmount);

   if not ( AGSTClass in [ 1..MAX_GST_CLASS ] ) then
      Write( XFile, '"0.00","",' ) { No GST }
   else begin
      Write( XFile, '"', AbsGSTAmount/100:0:2, '",' );
      Write( XFile, '"', Copy( MyClient.clFields.clGST_Class_Codes[ AGSTClass ],1,1), '",' );
   end;

   Write( XFile, '"', AAmount/100:0:2, '",' );

   //super fields

   Write( XFile, '"', Date2Str( aCGTDate, 'dd/mm/yyyy' ),'",' );
   Write( XFile, '"', abs( aImputedCredit)/100:0:2, '",');       //must be +ve
   Write( XFile, '"', aTaxFreeDist/100:0:2, '",');
   Write( XFile, '"', aTaxExemptDist/100:0:2, '",');
   Write( XFile, '"', aTaxDeferredDist/100:0:2, '",');          
   Write( XFile, '"', abs( aTFNCredit)/100:0:2, '",');          //must be +ve
   Write( XFile, '"', aForeignIncome/100:0:2, '",');
   Write( XFile, '"', abs( aForeignTaxCredits)/100:0:2, '",');  //must be +ve
   Write( XFile, '"', abs( aOtherExpenses)/100:0:2, '",');      //must be +ve
   Write( XFile, '"', abs( aCapitalGainsIndexed)/100:0:2, '",');//must be +ve
   Write( XFile, '"', abs( aCapitalGainsDisc)/100:0:2, '",');   //must be +ve
   Write( XFile, '"', abs( aCapitalGainsOther)/100:0:2, '",');   //must be +ve
   Write( XFile, '"', abs( aFranked)/100:0:2, '",');             //must be +ve
   Write( XFile, '"', abs( aUnfranked)/100:0:2, '",');           //must be +ve
   write( XFile, '"', GetSFMemberText(ADate,aMember,true), '"');

   Writeln( XFile );

   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// We need to strip commas and quotes from CSV files, but leave them in for other file types
function FilterIfNeeded(Value: string): string;
begin
  if (ExtractFileExtn = '.CSV') then
    Result := ReplaceCommasAndQuotes(Value)
  else
    Result := Value;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure DoTransaction;
const
  ThisMethodName = 'DoTransaction';
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   With MyClient.clFields, Bank_Account.baFields, Transaction^ do
   Begin
      txForex_Conversion_Rate := Bank_Account.Default_Forex_Conversion_Rate(txDate_Effective);

      txDate_Transferred := CurrentDate;
      if SkipZeroAmountExport(Transaction) then
         Exit; // Im done...

      If ( txFirst_Dissection = NIL ) then
      Begin
         SWrite( txDate_Effective,           { ADate        : TStDate;         }
                 FilterIfNeeded(GetReference(TransAction,Bank_Account.baFields.baAccount_Type)),                { ARefce       : ShortString;     }
                 FilterIfNeeded(txAccount),                  { AAccount     : ShortString;     }
                 txAmount,                   { AAmount      : Money;           }
                 txQuantity,                 { AQuantity    : Money;           }
                 FilterIfNeeded(GetNarration(TransAction,Bank_Account.baFields.baAccount_Type)),             { ANarration   : ShortString );   }
                 txGST_Class,
                 txGST_Amount,

                 txSF_CGT_Date,
                 txSF_Imputed_Credit,
                 txSF_Tax_Free_Dist,
                 txSF_Tax_Exempt_Dist,
                 txSF_Tax_Deferred_Dist,
                 txSF_TFN_Credits,
                 txSF_Foreign_Income,
                 txSF_Foreign_Tax_Credits,
                 txSF_Other_Expenses,
                 txSF_Capital_Gains_Indexed,
                 txSF_Capital_Gains_Disc,
                 txSF_Capital_Gains_Other,
                 txSF_Franked,
                 txSF_Unfranked,
                 txSF_Member_Component
                 );
      end;

      Inc( NoOfEntries );
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure DoDissection ;
const
   ThisMethodName = 'DoDissection';
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   With MyClient.clFields, Bank_Account.baFields, Transaction^, Dissection^ do
   Begin
      SWrite( txDate_Effective,           { ADate        : TStDate;         }
              FilterIfNeeded(getDsctReference(Dissection,Transaction,baAccount_Type)),
                                          { ARefce       : ShortString;     }
              FilterIfNeeded(dsAccount),                  { AAccount     : ShortString;     }
              dsAmount,                   { AAmount      : Money;           }
              dsQuantity,                 { AQuantity    : Money;           }
              FilterIfNeeded(dsGL_Narration),             { ANarration   : ShortString      }
              dsGST_Class,
              dsGST_Amount,

              dsSF_CGT_Date,
              dsSF_Imputed_Credit,
              dsSF_Tax_Free_Dist,
              dsSF_Tax_Exempt_Dist,
              dsSF_Tax_Deferred_Dist,
              dsSF_TFN_Credits,
              dsSF_Foreign_Income,
              dsSF_Foreign_Tax_Credits,
              dsSF_Other_Expenses,
              dsSF_Capital_Gains_Indexed,
              dsSF_Capital_Gains_Disc,
              dsSF_Capital_Gains_Other,
              dsSF_Franked,
              dsSF_Unfranked,
              dsSF_Member_Component
             );
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function OutputDocument: IXMLDocument;
begin
  if FOutputDocument = nil then
    FOutputDocument := CreateXMLDoc;
  Result := FOutputDocument;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure AddFieldNode(var ToNode: IxmlNode; const Name, Value: string; AllowEmpty: boolean = false);
begin
  if (Value <> '') or AllowEmpty then
    SetNodeTextStr(ToNode,Name,Value);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure AddTextNode(var aNode: IXMLNode; aNarration : string; aChequeNumber : integer );
var
  lsReference, lsNarration: string;
  NarrationLength : integer;
begin
  lsNarration := trim( aNarration );
  lsReference := IntToStr( aChequeNumber );

  if (lsReference > '') and (lsReference <> '0') then
    lsReference := ' BL Ref: ' + lsReference
  else
    lsReference := '';

  lsReference := aNarration + lsReference;

  if GetMaxNarrationLength <= 150 then
    NarrationLength := GetMaxNarrationLength
  else
    NarrationLength := 150;

  lsReference := copy( lsReference, 1, NarrationLength );

  AddFieldNode(aNode, 'Text', lsReference, True);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ExtractData( const SuperFundType: byte; const FromDate, ToDate : TStDate; const SaveTo : string );
const
   ThisMethodName = 'ExtractData';
Begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
  if (SuperFundType in [saBGLSimpleFund, saBGLSimpleLedger]) then
    ExtractDataBGL(FromDate, ToDate, SaveTo)
  else if (SuperFundType = saBGL360) then
    ExtractDataBGL360(FromDate, ToDate, SaveTo);
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ExtractDataBGL(const FromDate, ToDate: TStDate; const SaveTo : string);
const
   ThisMethodName = 'ExtractDataBGL';
VAR
   BA : TBank_Account;
   Msg          : String;
   OK           : Boolean;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
  Msg := 'Extract data [BGL Simple Fund format] from '+BkDate2Str( FromDate ) + ' to ' + bkDate2Str( ToDate );
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' ' + Msg );

  ExtractFileExtn := AnsiUpperCase(ExtractFileExt(SaveTo));

  with MyClient.clFields do
  begin
    BA := dlgSelect.SelectBankAccountForExport( FromDate, ToDate );
    if not Assigned( BA ) then Exit;

    With BA.baFields do
    Begin
       if TravUtils.NumberAvailableForExport( BA, FromDate, ToDate  )= 0 then
       Begin
          HelpfulInfoMsg( 'There aren''t any new entries to extract from "'+baBank_Account_Number+'" in this date range!', 0 );
          exit;
       end;
       Assign( XFile, SaveTo );
       SetTextBuf( XFile, Buffer );
       Rewrite( XFile );

       Try
          NoOfEntries := 0;
          TRAVERSE.Clear;
          TRAVERSE.SetSortMethod( csDateEffective );
          TRAVERSE.SetSelectionMethod( twAllNewEntries );
          TRAVERSE.SetOnEHProc( DoTransaction );
          TRAVERSE.SetOnDSProc( DoDissection );
          TRAVERSE.TraverseEntriesForAnAccount( BA, FromDate, ToDate );
          OK := True;
       finally
          System.Close( XFile );
       end;
    end;
    if OK then
    Begin
       Msg := SysUtils.Format( 'Extract Data Complete. %d Entries were saved in %s',[ NoOfEntries, SaveTo ] );
       LogUtil.LogMsg(lmInfo, UnitName, ThisMethodName + ' : ' + Msg );
       HelpfulInfoMsg( Msg, 0 );
    end;
  end; { Scope of MyClient }
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

procedure RetrieveBSBAndAccountNum( aExtractAccountNumberAs, aBankAccountNumber: string; var aBSB, aAccountNumber : string );
var
  lsBSB,
  lsAccountNumber : string;

  function StripOutBSBAndAccountNum( aInStr : string; var aBSB, aAccountNumber : string ) : boolean;
  begin
    result := false;
    aInStr := Trim( aInStr );
    if length( aInStr ) < 7 then // String is too short
      exit
    else begin
      aBSB := copy( aInStr, 1, 6 ); // BSB Number is the first 6 characters
      aAccountNumber := copy( aInStr, 7, length( aInStr ) ); // Account Number is the rest
      result := ( length( aBSB ) > 0 ) and ( length( aAccountNumber ) > 0 );
    end;
  end;
begin
  aExtractAccountNumberAs :=                                         // Get the ExtractAccountNumberAS regardless
    StringReplace( aExtractAccountNumberAs, ' ', '',
      [ rfReplaceAll, rfIgnoreCase ] );

  ProcessDiskCode( trim( aBankAccountNumber ),
    lsBSB, lsAccountNumber);                                         // Get the normal Bank Account number

  if (not Software.CanExtractAccountNumberAs(                        // ExtractAccountNumberAs field CANNOT be used, get Normals
           MyClient.clFields.clCountry,
           MyClient.clFields.clAccounting_System_Used) ) or          // Else ExtractAccountNumberAs field can be used BUT,
      ( aExtractAccountNumberAs = '' ) or                            // ExtractAccountNumberAs is blank
      ( not StripOutBSBAndAccountNum(                                // ExtractAccountNumberAs field can be used BUT is in the incorrect format
              aExtractAccountNumberAs, aBSB, aAccountNumber ) ) then begin
    aBSB           := lsBSB;                                         // Use the normal BSB number
    aAccountNumber := lsAccountNumber;                               // Use the normal Bank Account number
  end;
end;



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DoAccountHeader;
const
  ThisMethodName = 'DoAccountHeader';
var
  OpenBalance, SystemOpBal, SystemClBal: Money;
  BSB, AccountNum: string;
begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins');

  OpenBalance := 0;
  FCloseBalance := 0;
  if Assigned(Bank_Account) then
  begin
    baUtils.GetBalances(Bank_Account,  Traverse_From, Traverse_To, OpenBalance,
                        FCloseBalance, SystemOpBal, SystemClBal);
    if OpenBalance = Unknown then
      Exit; // don't show accounts with unknown amounts
  end;

  FAccountNode := OutputDocument.CreateElement('Balance');
  FBalancesNode.AppendChild(FAccountNode);
  AddFieldNode(FAccountNode, 'BalanceDate', Date2Str(Traverse_From, FdateMask ));
  AddFieldNode(FAccountNode, 'BalanceAmount', FormatFloatForXml(OpenBalance, 2, 100, true));
  // BSB and Bank_Account_No
  RetrieveBSBAndAccountNum( Bank_Account.baFields.baExtract_Account_Number,
    Bank_Account.baFields.baBank_Account_Number, BSB, AccountNum );

//  ProcessDiskCode(Bank_Account.baFields.baBank_Account_Number, BSB, AccountNum);

  AddFieldNode(FAccountNode, 'BSB', BSB);
  AddFieldNode(FAccountNode, 'Bank_Account_No', AccountNum);
  AddFieldNode(FAccountNode, 'Balance_Type', '10'); // 10 = Opening Balance, 15 = Closing Balance

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure AddGuid(var ToNode: IxmlNode; const aName: string; const Value: string; MaxLen: integer = 16);
var
  id: string;
  i : integer;
begin
  id := '';
  for i := Length(Value) downto 1 do begin
    if Value[i] in ['0'..'9', 'A'..'F'] then begin
       id := Value[i] + id;
        if Length(id) >= MaxLen then
          Break; // Thats all we can fit..
     end;
  end;
  AddFieldNode(ToNode, aName, id);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure AddAccountCodeNode(var aNode: IXMLNode; AccountCode: string);
var
  PracIniFile: TIniFile;
begin
  if (AccountCode = '') then
  begin
    PracIniFile := TIniFile.Create(ExecDir + PRACTICEINIFILENAME);
    try
      AccountCode := PracIniFile.ReadString(BGL360code, 'ExtractCode', '91000');
      if AccountCode = '' then
        AccountCode := '91000'; // default account code for uncoded transactions
    finally
      PracIniFile.Free;
    end;
  end;
  AddFieldNode(aNode, 'Account_Code', AccountCode);
end;

Procedure AddShareTradeEntities(IsDissection:Boolean=False);//(var TransactionNode: IXMLNode);
const
  ThisMethodName = 'AddShareTradeEntities';
begin
  if DebugMe then
  begin
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' begins ');
    if Assigned(TransactionNode) then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is not null ')
    else
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is null ');
  end;
  // Units
  if IsDissection then
    AddFieldNode(TransactionNode, 'Units',
      FormatFloatBlankForZeroForXml(Dissection^.dsQuantity, 4, 10000, True),
      True )
  else
    AddFieldNode(TransactionNode, 'Units',
      FormatFloatBlankForZeroForXml(Transaction^.txQuantity, 4, 10000, True),
      True );

  if IsDissection then
  begin
    // Contract_date
    AddFieldNode(TransactionNode, 'Contract_date',
      Date2Str(Dissection^.dsDissection_Extension^.deSF_Contract_Date,
        FDateMask) );
    // Settlement_date
    AddFieldNode(TransactionNode, 'Settlement_date',
      Date2Str(Dissection^.dsDissection_Extension^.deSF_Settlement_Date,
        FDateMask) );
    // Brokerage
    AddFieldNode(
      TransactionNode,
      'Brokerage',
      FormatFloatForXml((Dissection^.dsDissection_Extension^.deSF_Share_Brokerage),
      2, 100) );

    // GST_Rate
    if Trim(Dissection^.dsDissection_Extension^.deSF_Share_GST_Rate) <> '' then
      AddFieldNode(
      TransactionNode,
      'GST_Rate',
      FormatFloatForXml(
        Abs(StrToIntDef(Dissection^.dsDissection_Extension^.deSF_Share_GST_Rate, 0)),
        0, 1, True),
      True);
    // GST_Amount
    AddFieldNode(
      TransactionNode,
      'GST_Amount',
      FormatFloatForXml(Abs(Dissection^.dsDissection_Extension^.deSF_Share_GST_Amount),
      2, 100) );

    // Consideration
    AddFieldNode(
      TransactionNode,
      'Consideration',
      FormatFloatForXml((Dissection^.dsDissection_Extension^.deSF_Share_Consideration),
      2, 100) );
  end
  else
  begin
    // Contract_date
    AddFieldNode(TransactionNode, 'Contract_date',
      Date2Str(Transaction^.txTransaction_Extension^.teSF_Contract_Date,
        FDateMask) );
    // Settlement_date
    AddFieldNode(TransactionNode, 'Settlement_date',
      Date2Str(Transaction^.txTransaction_Extension^.teSF_Settlement_Date,
        FDateMask) );
    // Brokerage
    AddFieldNode(
      TransactionNode,
      'Brokerage',
      FormatFloatForXml((Transaction^.txTransaction_Extension^.teSF_Share_Brokerage),
      2, 100) );


    // GST_Rate
    if Trim(Transaction^.txTransaction_Extension^.teSF_Share_GST_Rate) <> '' then
      AddFieldNode(
      TransactionNode,
      'GST_Rate',
      FormatFloatForXml(
        Abs(StrToIntDef(Transaction^.txTransaction_Extension^.teSF_Share_GST_Rate,0)),
        0, 1, True),
      True);
    // GST_Amount
    AddFieldNode(
      TransactionNode,
      'GST_Amount',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Share_GST_Amount),
      2, 100) );

    // Consideration
    AddFieldNode(
      TransactionNode,
      'Consideration',
      FormatFloatForXml(
        (Transaction^.txTransaction_Extension^.teSF_Share_Consideration),
      2, 100) );
  end;
  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
      ' Printed all relevant fields ');

end;

Procedure AddInterestEntities(IsDissection:Boolean=False);//(var TransactionNode: IXMLNode);
const
  ThisMethodName = 'AddInterestEntities';
begin
  if DebugMe then
  begin
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' begins ');
    if Assigned(TransactionNode) then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is not null ')
    else
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is null ');
  end;

  if IsDissection then
  begin
    // Interest
    AddFieldNode(
      TransactionNode,
      'Interest',
      FormatFloatForXml(Abs(Dissection^.dsSF_Interest), 2, 100) );
    // Other_Income
    AddFieldNode(
      TransactionNode,
      'Other_Income',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Other_Income),
      2, 100) );
    // TFN_Amounts_withheld
    AddFieldNode(
      TransactionNode,
      'TFN_Amounts_withheld',
      FormatFloatForXml(Abs(Dissection^.dsSF_TFN_Credits),
      2, 100) );
    // Non_Resident_Withholding_Tax
    AddFieldNode(
      TransactionNode,
      'Non_Resident_Withholding_Tax',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Res_Witholding_Tax),
      2, 100) );
  end
  else
  begin
    // Interest
    AddFieldNode(
      TransactionNode,
      'Interest',
      FormatFloatForXml(Abs(Transaction^.txSF_Interest), 2, 100) );
    // Other_Income
    AddFieldNode(
      TransactionNode,
      'Other_Income',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Other_Income),
      2, 100) );
    // TFN_Amounts_withheld
    AddFieldNode(
      TransactionNode,
      'TFN_Amounts_withheld',
      FormatFloatForXml(Abs(Transaction^.txSF_TFN_Credits), 2, 100) );
    // Non_Resident_Withholding_Tax
    AddFieldNode(
      TransactionNode,
      'Non_Resident_Withholding_Tax',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Res_Witholding_Tax),
      2, 100) );
  end;
  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
      ' Printed all relevant fields ');

end;

Procedure AddDividendEntities(IsDissection:Boolean=False);//(var TransactionNode: IXMLNode);
const
  ThisMethodName = 'AddDividendEntities';
begin
  if DebugMe then
  begin
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' begins ');
    if Assigned(TransactionNode) then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is not null ')
    else
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is null ');
  end;

  if IsDissection then
  begin
    // Dividends_Franked
    AddFieldNode(
      TransactionNode,
      'Dividends_Franked',
      FormatFloatBlankForZeroForXml(
        Abs(Dissection^.dsSF_Franked), 2, 100, True),
      True );
    // Dividends_Unfranked
    AddFieldNode(
      TransactionNode,
      'Dividends_Unfranked',
      FormatFloatBlankForZeroForXml(
        Abs(Dissection^.dsSF_Unfranked), 2, 100, True),
      True );
    // Franking_Credits
    AddFieldNode(
      TransactionNode,
      'Franking_Credits',
      FormatFloatBlankForZeroForXml(
        Abs(Dissection^.dsSF_Imputed_Credit), 2, 100, True),
      True );
    // Assessable_Foreign_Source_Income
    AddFieldNode(
      TransactionNode,
      'Assessable_Foreign_Source_Income',
      FormatFloatForXml(Abs(Dissection^.dsSF_Foreign_Income), 2, 100));
    // Foreign_Income_Tax_Paid_Offset_Credits
    AddFieldNode(
      TransactionNode,
      'Foreign_Income_Tax_Paid_Offset_Credits',
      FormatFloatForXml(Abs(Dissection^.dsSF_Foreign_Tax_Credits), 2, 100) );
    // Australian_Franking_Credits_from_a_New_Zealand_Company
    AddFieldNode(
      TransactionNode,
      'Australian_Franking_Credits_from_a_New_Zealand_Company',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_AU_Franking_Credits_NZ_Co),
      2, 100) );
    // TFN_Amounts_withheld
    AddFieldNode(
      TransactionNode,
      'TFN_Amounts_withheld',
      FormatFloatForXml(Abs(Dissection^.dsSF_TFN_Credits), 2, 100) );
    // Non_Resident_Withholding_Tax
    AddFieldNode(
      TransactionNode,
      'Non_Resident_Withholding_Tax',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Res_Witholding_Tax),
      2, 100) );
    // LIC_Deduction
    AddFieldNode(
      TransactionNode,
      'LIC_Deduction',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_LIC_Deductions),
      2, 100) );
  end
  else
  begin
    // Dividends_Franked
    AddFieldNode(
      TransactionNode,
      'Dividends_Franked',
      FormatFloatBlankForZeroForXml(
        Abs(Transaction^.txSF_Franked), 2, 100, True),
      True );
    // Dividends_Unfranked
    AddFieldNode(
      TransactionNode,
      'Dividends_Unfranked',
      FormatFloatBlankForZeroForXml(
        Abs(Transaction^.txSF_Unfranked), 2, 100, True),
      True );
    // Franking_Credits
    AddFieldNode(
      TransactionNode,
      'Franking_Credits',
      FormatFloatBlankForZeroForXml(
        Abs(Transaction^.txSF_Imputed_Credit), 2, 100, True),
      True );
    // Assessable_Foreign_Source_Income
    AddFieldNode(
      TransactionNode,
      'Assessable_Foreign_Source_Income',
      FormatFloatForXml(
        Abs(Transaction^.txSF_Foreign_Income),
      2, 100) );
    // Foreign_Income_Tax_Paid_Offset_Credits
    AddFieldNode(
      TransactionNode,
      'Foreign_Income_Tax_Paid_Offset_Credits',
      FormatFloatForXml(Abs(Transaction^.txSF_Foreign_Tax_Credits), 2, 100) );
    // Australian_Franking_Credits_from_a_New_Zealand_Company
    AddFieldNode(
      TransactionNode,
      'Australian_Franking_Credits_from_a_New_Zealand_Company',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_AU_Franking_Credits_NZ_Co),
      2, 100) );
    // TFN_Amounts_withheld
    AddFieldNode(
      TransactionNode,
      'TFN_Amounts_withheld',
      FormatFloatForXml(Abs(Transaction^.txSF_TFN_Credits), 2, 100) );
    // Non_Resident_Withholding_Tax
    AddFieldNode(
      TransactionNode,
      'Non_Resident_Withholding_Tax',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Res_Witholding_Tax),
      2, 100) );
    // LIC_Deduction
    AddFieldNode(
      TransactionNode,
      'LIC_Deduction',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_LIC_Deductions),
      2, 100) );
  end;
  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
      ' Printed all relevant fields ');
end;

Procedure AddDistributionEntities(IsDissection:Boolean=False);//(var TransactionNode: IXMLNode);
const
  ThisMethodName = 'AddDistributionEntities';
begin
  if DebugMe then
  begin
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' begins ');
    if Assigned(TransactionNode) then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' transaction node is not null ')
    else
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
       ' transaction node is null ');
  end;

  if IsDissection then
  begin
    // Dividends_Franked
    AddFieldNode(
      TransactionNode,
      'Dividends_Franked',
      FormatFloatForXml(Abs(Dissection^.dsSF_Franked), 2, 100) );
    // Dividends_Unfranked
    AddFieldNode(
      TransactionNode,
      'Dividends_Unfranked',
      FormatFloatForXml(Abs(Dissection^.dsSF_Unfranked), 2, 100) );
    // Franking_Credits
    AddFieldNode(
      TransactionNode,
      'Franking_Credits',
      FormatFloatForXml(Abs(Dissection^.dsSF_Imputed_Credit), 2, 100) );
    // Interest
    AddFieldNode(
      TransactionNode,
      'Interest',
      FormatFloatForXml(Abs(Dissection^.dsSF_Interest), 2, 100) );
    // Other_Income
    AddFieldNode(
      TransactionNode,
      'Other_Income',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Other_Income),
      2, 100) );

    // Less_Other_Allowable_Trust_Deductions
    AddFieldNode(
      TransactionNode,
      'Less_Other_Allowable_Trust_Deductions',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Other_Trust_Deductions),
      2, 100) );
    // Discounted_Capital_Gain_Before_Discount
    AddFieldNode(
      TransactionNode,
      'Discounted_Capital_Gain_Before_Discount',
      FormatFloatForXml(Abs(Dissection^.dsSF_Capital_Gains_Disc),
      2, 100) );
    // Capital_Gains_CGT_Concessional_Amount
    AddFieldNode(
      TransactionNode,
      'Capital_Gains_CGT_Concessional_Amount',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_CGT_Concession_Amount),
      2, 100) );
    // Capital_Gain_Indexation_Method
    AddFieldNode(
      TransactionNode,
      'Capital_Gain_Indexation_Method',
      FormatFloatForXml(Abs(Dissection^.dsSF_Capital_Gains_Indexed), 2, 100) );
    // Capital_Gain_Other_Method
    AddFieldNode(
      TransactionNode,
      'Capital_Gain_Other_Method',
      FormatFloatForXml(Abs(Dissection^.dsSF_Capital_Gains_Other), 2, 100) );
    // Foreign_Discounted_Capital_Gains_Before_Discount
    AddFieldNode(
      TransactionNode,
      'Foreign_Discounted_Capital_Gains_Before_Discount',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_CGT_ForeignCGT_Before_Disc),
      2, 100) );
    // Foreign_Capital_Gains_Indexation_Method
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Indexation_Method',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_CGT_ForeignCGT_Indexation),
      2, 100) );
    // Foreign_Capital_Gains_Other_Method
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Other_Method',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_CGT_ForeignCGT_Other_Method),
      2, 100) );

    // Foreign_Discounted_Capital_Gains_Before_Discount_Tax_Paid
    AddFieldNode(
      TransactionNode,
      'Foreign_Discounted_Capital_Gains_Before_Discount_Tax_Paid',
      FormatFloatForXml(Abs(Dissection^.dsSF_Capital_Gains_Foreign_Disc),
      2, 100) );
    // Foreign_Capital_Gains_Indexation_Method_Tax_Paid
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Indexation_Method_Tax_Paid',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_CGT_TaxPaid_Indexation),
      2, 100) );
    // Foreign_Capital_Gains_Other_Method_Tax_Paid
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Other_Method_Tax_Paid',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_CGT_TaxPaid_Other_Method),
      2, 100) );

    // Assessable_Foreign_Source_Income
    AddFieldNode(
      TransactionNode,
      'Assessable_Foreign_Source_Income',
      FormatFloatForXml(Abs(Dissection^.dsSF_Foreign_Income), 2, 100) );
    // Foreign_Income_Tax_Paid_Offset_Credits
    AddFieldNode(
      TransactionNode,
      'Foreign_Income_Tax_Paid_Offset_Credits',
      FormatFloatForXml(Abs(Dissection^.dsSF_Foreign_Tax_Credits), 2, 100) );
    // Australian_Franking_Credits_from_a_New_Zealand_Company
    AddFieldNode(
      TransactionNode,
      'Australian_Franking_Credits_from_a_New_Zealand_Company',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_AU_Franking_Credits_NZ_Co),
      2, 100) );
    // Other_Net_Foreign_Source_Income
    AddFieldNode(
      TransactionNode,
      'Other_Net_Foreign_Source_Income',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Other_Net_Foreign_Income),
      2, 100) );
    // Cash_Distribution
    AddFieldNode(
      TransactionNode,
      'Cash_Distribution',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Cash_Distribution),
      2, 100) );
    // Tax_Exempted_Amounts
    AddFieldNode(
      TransactionNode,
      'Tax_Exempted_Amounts',
      FormatFloatForXml(Abs(Dissection^.dsSF_Tax_Exempt_Dist), 2, 100) );
    // Tax_Free_Amounts
    AddFieldNode(
      TransactionNode,
      'Tax_Free_Amounts',
      FormatFloatForXml(Abs(Dissection^.dsSF_Tax_Free_Dist), 2, 100) );
    // Tax_Deferred_amounts
    AddFieldNode(
      TransactionNode,
      'Tax_Deferred_amounts',
      FormatFloatForXml(Abs(Dissection^.dsSF_Tax_Deferred_Dist), 2, 100) );
    // TFN_Amounts_withheld
    AddFieldNode(
      TransactionNode,
      'TFN_Amounts_withheld',
      FormatFloatForXml(Abs(Dissection^.dsSF_TFN_Credits), 2, 100) );
    // Non_Resident_Withholding_Tax
    AddFieldNode(
      TransactionNode,
      'Non_Resident_Withholding_Tax',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Res_Witholding_Tax),
      2, 100) );
    // Other_Expenses
    AddFieldNode(
      TransactionNode,
      'Other_Expenses',
      FormatFloatForXml(Abs(Dissection^.dsSF_Other_Expenses), 2, 100) );
    // LIC_Deduction
    AddFieldNode(
      TransactionNode,
      'LIC_Deduction',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_LIC_Deductions),
      2, 100) );
    // Discounted_Capital_Gain_Before_Discount_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Discounted_Capital_Gain_Before_Discount_Non_Cash',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Cash_CGT_Discounted_Before_Discount),
      2, 100) );
    // Capital_Gains_Indexation_Method_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Capital_Gains_Indexation_Method_Non_Cash',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Cash_CGT_Indexation),
      2, 100) );
    // Capital_Gains_Other_Method_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Capital_Gains_Other_Method_Non_Cash',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Cash_CGT_Other_Method),
      2, 100) );
    // Capital_Losses_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Capital_Losses_Non_Cash',
      FormatFloatForXml(
        Abs(Dissection^.dsDissection_Extension^.deSF_Non_Cash_CGT_Capital_Losses),
      2, 100) );
  end
  else
  begin
    // Dividends_Franked
    AddFieldNode(
      TransactionNode,
      'Dividends_Franked',
      FormatFloatForXml(Abs(Transaction^.txSF_Franked), 2, 100) );
    // Dividends_Unfranked
    AddFieldNode(
      TransactionNode,
      'Dividends_Unfranked',
      FormatFloatForXml(Abs(Transaction^.txSF_Unfranked), 2, 100) );
    // Franking_Credits
    AddFieldNode(
      TransactionNode,
      'Franking_Credits',
      FormatFloatForXml(Abs(Transaction^.txSF_Imputed_Credit), 2, 100) );
    // Interest
    AddFieldNode(
      TransactionNode,
      'Interest',
      FormatFloatForXml(Abs(Transaction^.txSF_Interest), 2, 100) );
    // Other_Income
    AddFieldNode(
      TransactionNode,
      'Other_Income',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Other_Income),
      2, 100) );

    // Less_Other_Allowable_Trust_Deductions
    AddFieldNode(
      TransactionNode,
      'Less_Other_Allowable_Trust_Deductions',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Other_Trust_Deductions),
      2, 100) );
    // Discounted_Capital_Gain_Before_Discount
    AddFieldNode(
      TransactionNode,
      'Discounted_Capital_Gain_Before_Discount',
      FormatFloatForXml(Abs(Transaction^.txSF_Capital_Gains_Disc), 2, 100) );
    // Capital_Gains_CGT_Concessional_Amount
    AddFieldNode(
      TransactionNode,
      'Capital_Gains_CGT_Concessional_Amount',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_CGT_Concession_Amount),
      2, 100) );
    // Capital_Gain_Indexation_Method
    AddFieldNode(
      TransactionNode,
      'Capital_Gain_Indexation_Method',
      FormatFloatForXml(Abs(Transaction^.txSF_Capital_Gains_Indexed), 2, 100) );
    // Capital_Gain_Other_Method
    AddFieldNode(
      TransactionNode,
      'Capital_Gain_Other_Method',
      FormatFloatForXml(Abs(Transaction^.txSF_Capital_Gains_Other), 2, 100) );
    // Foreign_Discounted_Capital_Gains_Before_Discount
    AddFieldNode(
      TransactionNode,
      'Foreign_Discounted_Capital_Gains_Before_Discount',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_CGT_ForeignCGT_Before_Disc),
      2, 100) );
    // Foreign_Capital_Gains_Indexation_Method
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Indexation_Method',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_CGT_ForeignCGT_Indexation),
      2, 100) );
    // Foreign_Capital_Gains_Other_Method
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Other_Method',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_CGT_ForeignCGT_Other_Method),
      2, 100) );

    // Foreign_Discounted_Capital_Gains_Before_Discount_Tax_Paid
    AddFieldNode(
      TransactionNode,
      'Foreign_Discounted_Capital_Gains_Before_Discount_Tax_Paid',
      FormatFloatForXml(
        Abs(Transaction^.txSF_Capital_Gains_Foreign_Disc),
      2, 100) );
    // Foreign_Capital_Gains_Indexation_Method_Tax_Paid
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Indexation_Method_Tax_Paid',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_CGT_TaxPaid_Indexation),
      2, 100) );
    // Foreign_Capital_Gains_Other_Method_Tax_Paid
    AddFieldNode(
      TransactionNode,
      'Foreign_Capital_Gains_Other_Method_Tax_Paid',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_CGT_TaxPaid_Other_Method),
      2, 100) );

    // Assessable_Foreign_Source_Income
    AddFieldNode(
      TransactionNode,
      'Assessable_Foreign_Source_Income',
      FormatFloatForXml(Abs(Transaction^.txSF_Foreign_Income), 2, 100) );
    // Foreign_Income_Tax_Paid_Offset_Credits
    AddFieldNode(
      TransactionNode,
      'Foreign_Income_Tax_Paid_Offset_Credits',
      FormatFloatForXml(Abs(Transaction^.txSF_Foreign_Tax_Credits), 2, 100) );
    // Australian_Franking_Credits_from_a_New_Zealand_Company
    AddFieldNode(
      TransactionNode,
      'Australian_Franking_Credits_from_a_New_Zealand_Company',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_AU_Franking_Credits_NZ_Co),
      2, 100) );
    // Other_Net_Foreign_Source_Income
    AddFieldNode(
      TransactionNode,
      'Other_Net_Foreign_Source_Income',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Other_Net_Foreign_Income),
      2, 100) );
    // Cash_Distribution
    AddFieldNode(
      TransactionNode,
      'Cash_Distribution',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Cash_Distribution),
      2, 100) );
    // Tax_Exempted_Amounts
    AddFieldNode(
      TransactionNode,
      'Tax_Exempted_Amounts',
      FormatFloatForXml(Abs(Transaction^.txSF_Tax_Exempt_Dist), 2, 100) );
    // Tax_Free_Amounts
    AddFieldNode(
      TransactionNode,
      'Tax_Free_Amounts',
      FormatFloatForXml(Abs(Transaction^.txSF_Tax_Free_Dist), 2, 100) );
    // Tax_Deferred_amounts
    AddFieldNode(
      TransactionNode,
      'Tax_Deferred_amounts',
      FormatFloatForXml(Abs(Transaction^.txSF_Tax_Deferred_Dist), 2, 100) );
    // TFN_Amounts_withheld
    AddFieldNode(
      TransactionNode,
      'TFN_Amounts_withheld',
      FormatFloatForXml(Abs(Transaction^.txSF_TFN_Credits), 2, 100) );
    // Non_Resident_Withholding_Tax
    AddFieldNode(
      TransactionNode,
      'Non_Resident_Withholding_Tax',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Res_Witholding_Tax),
      2, 100) );
    // Other_Expenses
    AddFieldNode(
      TransactionNode,
      'Other_Expenses',
      FormatFloatForXml(Abs(Transaction^.txSF_Other_Expenses), 2, 100) );
    // LIC_Deduction
    AddFieldNode(
      TransactionNode,
      'LIC_Deduction',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_LIC_Deductions),
      2, 100) );
    // Discounted_Capital_Gain_Before_Discount_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Discounted_Capital_Gain_Before_Discount_Non_Cash',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Cash_CGT_Discounted_Before_Discount),
      2, 100) );
    // Capital_Gains_Indexation_Method_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Capital_Gains_Indexation_Method_Non_Cash',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Cash_CGT_Indexation),
      2, 100) );
    // Capital_Gains_Other_Method_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Capital_Gains_Other_Method_Non_Cash',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Cash_CGT_Other_Method),
      2, 100) );
    // Capital_Losses_Non_Cash
    AddFieldNode(
      TransactionNode,
      'Capital_Losses_Non_Cash',
      FormatFloatForXml(
        Abs(Transaction^.txTransaction_Extension^.teSF_Non_Cash_CGT_Capital_Losses),
      2, 100) );
  end;

  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
      ' Printed all relevant fields ');
end;

function StripBGL360ControlAccountCode( Value : string ) : integer;
var
  liPos  : integer;
  lsControlCode : string;
begin
  Result := 0;
  Value := trim( Value );
  if Value <> '' then begin
    liPos := pos( '/', Value);  // Fetch the control account code, if this is a sub account type
    if liPos = 0 then           // Not a sub account type, so fetch the whole code
      lsControlCode := Value
    else
      lsControlCode := copy( Value, 1, pred( liPos ) ); // Fetch the first characters (or the whole acocunt code if not a sub account)
    result := StrToIntDef(  lsControlCode ,0 );
  end;
end;



procedure DoClassSuperIPTransaction;
const
  ThisMethodName = 'DoClassSuperIPTransaction';
var
  BSB, AccountNum: string;
  ContraEntries: IXMLNode;
  Entry: IXMLNode;
  EntryTypeDetail: IXMLNode;
  Rate: Extended;
  sAcctHead : string;
  AccountCode : Integer;
  TransType : TTransactionTypes;
  lsExtractAccountNumberAs : string;

  procedure AddField(const Name, Value: string);
  begin
     if Value > '' then
        FFields.Add(Name + '=' + Value );
  end;


begin
  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins');

  Transaction^.txDate_Transferred := CurrentDate;

  If ( Transaction^.txFirst_Dissection = NIL ) and
     ((Transaction^.txAmount <> 0) or Globals.PRACINI_ExtractZeroAmounts) then
  begin // only create node if there are no dissections, DoClassSuperIPTransaction handles dissections
    FTransactionNode := OutputDocument.CreateElement('Transaction');
    FTransactionsNode.AppendChild(FTransactionNode);

    // Transaction_Type
    AddFieldNode(FTransactionNode, 'Transaction_Type', 'Bank_Transaction');
    // Unique_Reference
    TransactionUtils.CheckExternalGUID(Transaction);

    AddGuid(FTransactionNode, 'Unique_Reference',
      Uppercase(Transaction^.txExternal_GUID), 15);

    // BSB and Bank_Account_No
    RetrieveBSBAndAccountNum(
      TBank_Account(Transaction^.txBank_Account).baFields.baExtract_Account_Number,
      TBank_Account(Transaction^.txBank_Account).baFields.baBank_Account_Number,
      BSB, AccountNum );

(*    lsExtractAccountNumberAs :=
      StringReplace(
        trim( TBank_Account(Transaction^.txBank_Account).baFields.baExtract_Account_Number ), ' ', '',
        [rfReplaceAll, rfIgnoreCase] );
    if (not Software.CanExtractAccountNumberAs(  // ExtractAccountNumberAs field CANNOT be used
             MyClient.clFields.clCountry,
             MyClient.clFields.clAccounting_System_Used) ) or // ExtractAccountNumberAs field  can be used BUT,
        ( lsExtractAccountNumberAs = '' ) then                // ExtractAccountNumberAs is blank

      ProcessDiskCode( // Use the nromal Bank Account number
        TBank_Account(Transaction^.txBank_Account).baFields.baBank_Account_Number,
          BSB, AccountNum)
    else
      if not StripOutBSBAndAccountNum( lsExtractAccountNumberAs, BSB, AccountNum ) then // ExtractAccountNumberAs field  can be used BUT, incorrect format
        ProcessDiskCode( // Use the nromal Bank Account number
          TBank_Account(Transaction^.txBank_Account).baFields.baBank_Account_Number,
            BSB, AccountNum); *)

    // Export the pre-initialised BSB and AccountNum fields
    AddFieldNode(FTransactionNode, 'BSB', BSB);
    AddFieldNode(FTransactionNode, 'Bank_Account_No', AccountNum);

    // Transaction_Date
    AddFieldNode(FTransactionNode, 'Transaction_Date',
      Date2Str(Transaction^.txDate_Effective, FDateMask));
    // Text

    AddTextNode(FTransactionNode, Transaction^.txGL_Narration,
      Transaction^.txCheque_Number);

    // Amount
    AddFieldNode(FTransactionNode, 'Amount',
                 FormatFloatForXml(-Transaction^.txAmount, 2, 100, true), true);

    // Contra_Entries
    ContraEntries := OutputDocument.CreateElement('Contra_Entries');

    FTransactionNode.AppendChild(ContraEntries);
    // Entry
    Entry := OutputDocument.CreateElement('Entry');
    ContraEntries.AppendChild(Entry);

    // Transaction Type
    AccountCode := StripBGL360ControlAccountCode( Transaction^.txAccount );
//DN BGL360 - Account sub-account fix   AccountCode := StrToIntDef(Transaction^.txAccount,0);
    if AccountCode = cttanDistribution then
    begin
      sAcctHead := 'Distribution_Transaction';
      TransType := ttDistribution;
    end
    else if AccountCode = cttanDividend then
    begin
      sAcctHead := 'Dividend_Transaction';
      TransType := ttDividend;
    end
    else if AccountCode = cttanInterest then
    begin
      sAcctHead := 'Interest_Transaction';
      TransType := ttInterest;
    end
    else if ( AccountCode >= cttanShareTradeRangeStart ) and
            ( AccountCode <= cttanShareTradeRangeEnd ) then //DN Refactored out, since range was introduced ((AccountCode >= cttanShareTradeRangeStart) and (AccountCode <= cttanShareTradeRangeEnd)) then
    begin
      sAcctHead := 'Share_Trade_Transaction';
      TransType := ttShareTrade;
    end
    else
    begin
      sAcctHead := 'Other_Transaction';
      TransType := ttOtherTx;
    end;

    // Entry_Type
    AddFieldNode(Entry, 'Entry_Type', sAcctHead);

    // Entry_Type_Detail
    EntryTypeDetail := OutputDocument.CreateElement('Entry_Type_Detail');
    Entry.AppendChild(EntryTypeDetail);

    TransactionNode := OutputDocument.CreateElement(sAcctHead);
    EntryTypeDetail.AppendChild(TransactionNode);

    // Account_Code
    AddAccountCodeNode(TransactionNode, Transaction^.txAccount);

    if TransType in [ ttDividend, ttDistribution] then
    begin
      // AccrualDate
      AddFieldNode(TransactionNode, 'AccrualDate',
        Date2Str(Transaction^.txTransaction_Extension^.teSF_Accrual_Date,
          FDateMask));
      // CashDate
      AddFieldNode(TransactionNode, 'CashDate',
        Date2Str(Transaction^.txTransaction_Extension^.teSF_Cash_Date,
          FDateMask));
      // RecordDate
      AddFieldNode(TransactionNode, 'RecordDate',
        Date2Str(Transaction^.txTransaction_Extension^.teSF_Record_Date,
          FDateMask));
    end
    else if TransType = ttInterest then
    begin
      if Trim(Transaction^.txAccount) = '' then
      begin
        AddFieldNode(FTransactionNode, 'BSB', BSB);
        AddFieldNode(FTransactionNode, 'Bank_Account_No', AccountNum);
      end;
    end;

    // Amount
    AddFieldNode(TransactionNode, 'Amount',
                 FormatFloatForXml(Transaction^.txAmount, 2, 100, true), true);


    // Output GST?
    if ((TransType= ttOtherTx) and (Transaction.txGST_Amount <> 0)) then
    begin
      // GST_Rate
(*      Rate := GetGSTClassPercent(MyClient, Transaction.txDate_Effective, Transaction.txGST_Class);
      AddFieldNode(
        TransactionNode,
        'GST_Rate',
        FormatFloatForXml(Rate, 0, 10000), false ); *)
      // GST_Amount
      AddFieldNode(
        TransactionNode,
        'GST_Amount',
        FormatFloatForXml(Abs(Transaction^.txGST_Amount), 2, 100), false );
    end;

    if DebugMe then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' printing specific fields for each type of transaction now');
    if DebugMe then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' Transaction type ' + IntToStr(Integer(TransType)));

    if TransType = ttDistribution then
      AddDistributionEntities()
    else if TransType = ttDividend then
      AddDividendEntities()
    else if TransType = ttInterest then
      AddInterestEntities()
    else if TransType = ttShareTrade then
      AddShareTradeEntities();

  end;

  inc(NoOfEntries);

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DoClassSuperIPDissection;
const
  ThisMethodName = 'DoClassSuperIPDissection';
var
  BSB, AccountNum: string;
  ContraEntries: IXMLNode;
  Entry: IXMLNode;
  EntryTypeDetail: IXMLNode;
  Rate: extended;
  sAcctHead : string;
  AccountCode : Integer;
  TransType : TTransactionTypes;

begin
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins');

  If ((Dissection^.dsAmount <> 0) or Globals.PRACINI_ExtractZeroAmounts) then begin
    FTransactionNode := OutputDocument.CreateElement('Transaction'); // BGL 360 export should output dissections as 'transactions'
    FTransactionsNode.AppendChild(FTransactionNode);

    // Transaction_Type
    AddFieldNode(FTransactionNode, 'Transaction_Type', 'Bank_Transaction');
    // Unique_Reference
    TransactionUtils.CheckExternalGUID(Dissection);
    AddGuid(FTransactionNode, 'Unique_Reference',
      Uppercase(Dissection^.dsExternal_GUID), 15);


    // BSB and Bank_Account_No
    RetrieveBSBAndAccountNum(
      TBank_Account(Transaction^.txBank_Account).baFields.baExtract_Account_Number,
      TBank_Account(Transaction^.txBank_Account).baFields.baBank_Account_Number,
      BSB, AccountNum );

(*    ProcessDiskCode(
      TBank_Account(Dissection^.dsBank_Account).baFields.baBank_Account_Number,
        BSB, AccountNum);
    AddFieldNode(FTransactionNode, 'BSB', BSB);
    AddFieldNode(FTransactionNode, 'Bank_Account_No', AccountNum);
(*    // BSB and Bank_Account_No
    lsExtractAccountNumberAs :=
      StringReplace(
        trim( TBank_Account(Transaction^.txBank_Account).baFields.baExtract_Account_Number ), ' ', '',
        [rfReplaceAll, rfIgnoreCase] );
    if (not Software.CanExtractAccountNumberAs(  // ExtractAccountNumberAs field CANNOT be used
             MyClient.clFields.clCountry,
             MyClient.clFields.clAccounting_System_Used) ) or // ExtractAccountNumberAs field  can be used BUT,
        ( lsExtractAccountNumberAs = '' ) then                // ExtractAccountNumberAs is blank

      ProcessDiskCode( // Use the nromal Bank Account number
        TBank_Account(Transaction^.txBank_Account).baFields.baBank_Account_Number,
          BSB, AccountNum)
    else
      if not StripOutBSBAndAccountNum( lsExtractAccountNumberAs, BSB, AccountNum ) then // ExtractAccountNumberAs field  can be used BUT, incorrect format
        ProcessDiskCode( // Use the nromal Bank Account number
          TBank_Account(Transaction^.txBank_Account).baFields.baBank_Account_Number,
            BSB, AccountNum);

    // Export the initiated BSB and AccountNum fields
    AddFieldNode(FTransactionNode, 'BSB', BSB);
    AddFieldNode(FTransactionNode, 'Bank_Account_No', AccountNum);
*)

    // Export the pre-initialised BSB and AccountNum fields
    AddFieldNode(FTransactionNode, 'BSB', BSB);
    AddFieldNode(FTransactionNode, 'Bank_Account_No', AccountNum);



    // Transaction_Date
    AddFieldNode(FTransactionNode, 'Transaction_Date',
      Date2Str(Dissection^.dsTransaction^.txDate_Effective, FDateMask));

    // Text
    if trim( Dissection^.dsGL_Narration ) <> '' then
      AddTextNode(FTransactionNode, Dissection^.dsGL_Narration,
        Dissection^.dsTransaction^.txCheque_Number )
    else
      AddTextNode(FTransactionNode, Dissection^.dsTransaction^.txGL_Narration,
        Dissection^.dsTransaction^.txCheque_Number );

    // Amount
    AddFieldNode(FTransactionNode, 'Amount',
      FormatFloatForXml(-Dissection^.dsAmount, 2, 100, true), true);


    // Contra_Entries
    ContraEntries := OutputDocument.CreateElement('Contra_Entries');
    FTransactionNode.AppendChild(ContraEntries);
    // Entry
    Entry := OutputDocument.CreateElement('Entry');
    ContraEntries.AppendChild(Entry);

    // Transaction Type
    AccountCode := StripBGL360ControlAccountCode( Dissection^.dsAccount );
  //DN BGL360 - Sub-Account fix  AccountCode := StrToIntDef(Dissection^.dsAccount,0);
    if AccountCode = cttanDistribution then
    begin
      sAcctHead := 'Distribution_Transaction';
      TransType := ttDistribution;
    end
    else if AccountCode = cttanDividend then
    begin
      sAcctHead := 'Dividend_Transaction';
      TransType := ttDividend;
    end
    else if AccountCode = cttanInterest then
    begin
      sAcctHead := 'Interest_Transaction';
      TransType := ttInterest;
    end
    else if ( AccountCode >= cttanShareTradeRangeStart ) and
            ( AccountCode <= cttanShareTradeRangeEnd ) then //DN Refactored out, since range was introduced ((AccountCode >= cttanShareTradeRangeStart) and (AccountCode <= cttanShareTradeRangeEnd)) then
    begin
      sAcctHead := 'Share_Trade_Transaction';
      TransType := ttShareTrade;
    end
    else
    begin
      sAcctHead := 'Other_Transaction';
      TransType := ttOtherTx;
    end;

    // Entry_Type
    AddFieldNode(Entry, 'Entry_Type', sAcctHead);
    // Entry_Type_Detail
    EntryTypeDetail := OutputDocument.CreateElement('Entry_Type_Detail');
    Entry.AppendChild(EntryTypeDetail);

    // Other_Transaction
    TransactionNode := OutputDocument.CreateElement(sAcctHead);
    EntryTypeDetail.AppendChild(TransactionNode);
    // Account_Code
    AddAccountCodeNode(TransactionNode, Dissection^.dsAccount);

    if TransType in [ ttDividend, ttDistribution] then
    begin
      // AccrualDate
      AddFieldNode(TransactionNode, 'AccrualDate',
        Date2Str(Dissection^.dsDissection_Extension^.deSF_Accrual_Date,
          FDateMask));
      // CashDate
      AddFieldNode(TransactionNode, 'CashDate',
        Date2Str(Dissection^.dsDissection_Extension^.deSF_Cash_Date,
          FDateMask));
      // RecordDate
      AddFieldNode(TransactionNode, 'RecordDate',
        Date2Str(Dissection^.dsDissection_Extension^.deSF_Record_Date,
          FDateMask));
    end
    else if TransType = ttInterest then
    begin
      if Trim(Transaction^.txAccount) = '' then
      begin
        AddFieldNode(FTransactionNode, 'BSB', BSB);
        AddFieldNode(FTransactionNode, 'Bank_Account_No', AccountNum);
      end;
    end;

    // Amount
    AddFieldNode(TransactionNode, 'Amount',
      FormatFloatForXml(Dissection^.dsAmount, 2, 100, true), true);

    // Output GST?
    if ((TransType= ttOtherTx) and (Dissection.dsGST_Amount <> 0 ) ) then
    begin
      // GST_Rate
(*      Rate := GetGSTClassPercent(MyClient, Transaction.txDate_Effective,
                Dissection.dsGST_Class);
      AddFieldNode( TransactionNode, 'GST_Rate',
        FormatFloatForXml(Rate, 0, 10000) ); *)
      // GST_Amount
      AddFieldNode( TransactionNode, 'GST_Amount',
        FormatFloatForXml(Abs(Dissection^.dsGST_Amount), 2, 100) );
    end;

    if DebugMe then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' printing specific fields for each type of transaction now');
    if DebugMe then
      LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName +
        ' Transaction type ' + IntToStr(Integer(TransType)));

    if TransType = ttDistribution then
      AddDistributionEntities(True)
    else if TransType = ttDividend then
      AddDividendEntities(True)
    else if TransType = ttInterest then
      AddInterestEntities(True)
    else if TransType = ttShareTrade then
      AddShareTradeEntities(True);
  end;
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends');
end;

procedure ExtractDataBGL360(const FromDate, ToDate: TStDate; const SaveTo : string; TestAccountList: TStringList = nil);
const
   ThisMethodName = 'ExtractDataBGL360';
VAR
  BA : TBank_Account;
  Msg          : String;
  No           : Integer;
  Selected: TStringList;
  PI: IXMLProcessingInstruction;
  IsJournal: boolean;

  function OutputDocument: IXMLDocument;
  begin
    if FOutputDocument = nil then
      FOutputDocument := CreateXMLDoc;
    Result := FOutputDocument;
  end;

  procedure AddNumberField(const Name: string; Value: Integer);
  begin
     FFields.Add(Name + '=' + InttoStr(Value));
  end;

begin
  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

  Msg := 'Extract data [BK5 XML format] from ' + BkDate2Str(FromDate) +
         ' to ' + bkDate2Str(ToDate);

  if DebugMe then
    LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' ' + Msg);

  if (TestAccountList <> nil) then
  begin
    Selected := TestAccountList;
  end else
  begin
    Selected := dlgSelect.SelectBankAccountsForExport( FromDate, ToDate );
    if Selected = NIL then
      Exit;
  end;

  try
    FRootNode := nil;
    FClientNode := nil;
    FAccountNode := nil;
    FTransactionsNode := nil;
    NoOfEntries := 0;
    OutputDocument.LoadXML(''); // Clear
    PI := OutputDocument.CreateProcessingInstruction('xml', 'version="1.0" encoding="ISO-8859-1"');
    OutputDocument.AppendChild(PI);
    FRootNode := EnsureNode(OutputDocument, 'BGL_Import_Export');
    SetNodeTextStr(FRootNode, 'Supplier', 'MYOB BankLink');
    SetNodeTextStr(FRootNode, 'Product', 'SF360');
    SetNodeTextStr(FRootNode, 'Import_Export_Version', '5.2');

    FDateMask := 'dd/mm/YYYY';

    for No := 0 to Pred(Selected.Count) do
    begin
      BA := TBank_Account(Selected.Objects[No]);

      //No entries
      if TravUtils.NumberAvailableForExport(BA, FromDate, ToDate) = 0 then begin
        HelpfulInfoMsg('There are no new entries to extract, for ' +
                       BA.baFields.baBank_Account_Number +
                       ', in the selected date range.',0);
        Exit;
      end;
    end;

    //Output XML
    if Assigned(MyClient) then
    begin
      //Client
      FClientNode := OutputDocument.CreateElement('Entity_Details');
      FRootNode.AppendChild(FClientNode);
      SetNodeTextStr(FClientNode, 'Entity_Code', MyClient.clFields.clCode);
      FBalancesNode := OutputDocument.CreateElement('BankBalances');
      FClientNode.AppendChild(FBalancesNode);
      FTransactionsNode := OutputDocument.CreateElement('Transactions');
      FClientNode.AppendChild(FTransactionsNode);

      for No := 0 to Pred( Selected.Count ) do begin
        BA := TBank_Account(Selected.Objects[No]);
        Traverse.Clear;
        IsJournal := TBank_Account(Selected.Objects[No]).IsAJournalAccount;

        Traverse.SetSortMethod(csDateEffective);
        Traverse.SetSelectionMethod(Traverse.twAllNewEntries);
        if not IsJournal then
          Traverse.SetOnAHProc(DoAccountHeader);
        Traverse.SetOnEHProc(DoClassSuperIPTransaction);
        Traverse.SetOnDSProc(DoClassSuperIPDissection);
        Traverse.TraverseEntriesForAnAccount(BA, FromDate, ToDate);
      end;

      //Write XML file
      OutputDocument.Save(SaveTo ,ofIndent);
      FOutputDocument := nil;
      FRootNode := nil;
      FClientNode := nil;
      FAccountNode := nil;
      FTransactionsNode := nil;
      //Display message
      Msg := SysUtils.Format('Extract Data Complete. %d Entries were saved in %s',
                             [NoOfEntries, SaveTo]);
      LogUtil.LogMsg(lmInfo, UnitName, ThisMethodName + ' : ' + Msg );
      if (TestAccountList = nil) then
        HelpfulInfoMsg( Msg, 0 );
    end;

  finally

  end;

  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Initialization
   DebugMe := LogUtil.DebugUnit( UnitName );
Finalization
  FreeAndNil(FExtractFieldHelper);
end.



