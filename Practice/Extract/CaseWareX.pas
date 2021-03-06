unit CaseWareX;

{
   Author, SPA 13-07-99

   CaseWare contacts:

   Solly Lew (OZ Agent) slew@caseware.com.au
   Maureen Naughton (in Canada) maureen@caseware.com

   Advised on 8-07-99 that they wanted to use the ASCII
   export procedure.

   Advised on 12-07-99 that they wanted a better format.

   17-07-99 Want to use the BK5 CSV standard with the GST Contra
   Account appended to each line.
   
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
interface uses StDate;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ExtractData( const FromDate, ToDate : TStDate; const SaveTo : string );

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

uses TransactionUtils,Classes, Traverse, Globals, GenUtils, bkDateUtils, TravUtils, YesNoDlg,
     LogUtil, BaObj32,
{$IFDEF NEW}
     BaSelFrm,
{$ELSE}
     dlgSelect, 
{$ENDIF}
     BkConst, MoneyDef, SysUtils, StStrS,
     InfoMoreFrm, BKDefs, glConst;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     
Const
   UnitName = 'CaseWareX';
   DebugMe  : Boolean = False;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Var
   XFile              : Text;
   Buffer             : array[ 1..2048 ] of Byte;
   NoOfEntries        : LongInt;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


procedure CWWrite(   ABankContra      : ShortString;
 							ADate        : TStDate;
                     ARefce       : ShortString;
                     AAccount     : ShortString;
                     AAmount      : Money;
                     ANarration   : ShortString;
                     AQuantity	 : Money;
                     AGSTClass    : Byte;
                     AGSTAmount   : Money );
const
   ThisMethodName = 'CWWrite';
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   Write( XFile, NoOfEntries, ',' );
   write( XFile, '"', ReplaceCommasAndQuotes(ABankContra), '",' );
   Write( XFile, '"',Date2Str( ADate, 'dd/mm/yyyy' ),'",' );
   Write( XFile, '"',StStrS.TrimSpacesS(ReplaceCommasAndQuotes(ARefce)), '",' );
	write( XFile, '"', ReplaceCommasAndQuotes(AAccount), '",' );
   write( XFile, AAmount/100:0:2, ',' );
   write( XFile, '"', Copy(StStrS.TrimSpacesS(ReplaceCommasAndQuotes(ANarration)), 1, GetMaxNarrationLength), '",' );
   if (Globals.PRACINI_ExtractQuantity) then
     write( XFile, GetQuantityStringForExtract(AQuantity), ',' )
   else
     write( XFile, GetQuantityStringForExtract(0), ',' );

   with MyClient.clFields do
   begin { Convert our internal representation into the external code
           expected by  the accounting software }
      if ( AGSTClass in [ 1..MAX_GST_CLASS ] ) then
      Begin
         write( XFile, '"', clGST_Class_Codes[ AGSTClass ], '",' );
         write( XFile, AGSTAmount/100:0:2, ',' );
         writeln( XFile, '"', clGST_Account_Codes[ AGSTClass ], '"' );
      end
      else
      begin
         write( XFile,   '"",' ); { No GST Class }
         write( XFile, '0.00,' ); { No GST Amount }
         writeln( XFile, '""' ); { No GST Posting Account }
      end;
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DoAccountHeader;

const
   ThisMethodName = 'DoAccountHeader';
Begin
//   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
//   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure DoTransaction;

const
  ThisMethodName = 'DoTransaction';
Var
  S : ShortString;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   With MyClient.clFields, Bank_Account.baFields, Transaction^ do
   Begin
      txForex_Conversion_Rate := Bank_Account.Default_Forex_Conversion_Rate(txDate_Effective);
      
      txDate_Transferred := CurrentDate;
      if SkipZeroAmountExport(Transaction) then
         Exit; // Im done...

      Inc( NoOfEntries );
      If ( txFirst_Dissection = NIL ) then
      Begin
         S :=  GetNarration(TransAction,Bank_Account.baFields.baAccount_Type);
         If ( txGST_Class=0 ) then txGST_Amount := 0;
         CWWrite( 	baContra_Account_Code,  { AContra	   : ShortString      }
         				txDate_Effective, 	   { ADate        : TStDate;         }
                     GetReference(TransAction,Bank_Account.baFields.baAccount_Type),      		{ ARefce       : ShortString;     }
                     txAccount,        		{ AAccount     : ShortString;     }
                     txAmount,         		{ AAmount      : Money;           }
                     S,                      { ANarration	: ShortString;     }
                     txQuantity,             { AQuantity	   : Money;           }
                     txGST_Class,            { AGSTClass    : Byte;            }
                     txGST_Amount );         { AGSTAmount   : Money );         }
      end;
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure DoDissection ;

const
   ThisMethodName = 'DoDissection';
var
   S : shortstring;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   With MyClient.clFields, Bank_Account.baFields, Transaction^, Dissection^ do
   Begin
      If ( dsGST_Class=0 ) then dsGST_Amount := 0;
      S := dsGL_Narration;
      CWWrite( 	baContra_Account_Code,  { AContra	   : ShortString      }
      				txDate_Effective, 	   { ADate        : TStDate;         }
                  getDsctReference(Dissection,Transaction,Traverse.Bank_Account.baFields.baAccount_Type),      		{ ARefce       : ShortString;     }
                  dsAccount,        		{ AAccount     : ShortString;     }
                  dsAmount,         		{ AAmount      : Money;           }
                  S,                            { ANarration	: ShortString;     }
                  dsQuantity,             {  AQuantity	 : Money;          }
                  dsGST_Class,            {  AGSTClass    : Byte;           }
                  dsGST_Amount );         {  AGSTAmount   : Money );        }
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{$IFNDEF NEW}

procedure ExtractData( const FromDate, ToDate : TStDate; const SaveTo : string );

const
   ThisMethodName = 'ExtractData';
  
VAR
   BA           : TBank_Account;
   Msg          : String; 
	No			    : Integer;   
   Selected		 : TStringList;
   OK           : Boolean;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   Msg := 'Extract data [BK5 CW format] from '+BkDate2Str( FromDate ) + ' to ' + bkDate2Str( ToDate );
   
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' ' + Msg );
   
   Selected := dlgSelect.SelectBankAccountsForExport( FromDate, ToDate );
   If Selected = NIL then exit;

   Try
      with MyClient.clFields do
      begin
         for No := 0 to Pred( Selected.Count ) do
         Begin
            BA := TBank_Account( Selected.Objects[ No ] );
            With BA.baFields do
            Begin
               if TravUtils.NumberAvailableForExport( BA, FromDate, ToDate  )= 0 then
               Begin
                  HelpfulInfoMsg( 'There aren''t any new entries to extract from "'+baBank_Account_Number+'" in this date range!', 0 );
                  exit;
               end;

               if not TravUtils.AllCoded( BA, FromDate, ToDate  ) then
               Begin
                  HelpfulInfoMsg( 'Account "'+baBank_Account_Number+'" has uncoded entries. ' + 
                  'You must code all the entries before you can extract them.',  0 );
                  Exit;
               end;
      
               if BA.baFields.baContra_Account_Code = '' then
               Begin
                  HelpfulInfoMsg( 'Before you can extract these entries, you must specify a contra account code for bank account "'+
                     baBank_Account_Number + '". To do this, go to the Other Functions|Bank Accounts option and edit the account', 0 );
                  exit;
               end;
               
               if not TravUtils.HasRequiredGSTContraCodes( BA, FromDate, ToDate  ) then
               Begin
                  HelpfulInfoMsg( 'Before you can extract these entries, you must specify the control account for each GST Class.' + 
                     ' To do this, go to the Other Functions|GST Details and Rates option.', 0 );
                  exit;
               end;
               
            end;
         end;

         Assign( XFile, SaveTo );
         SetTextBuf( XFile, Buffer );
         Rewrite( XFile );
      
         Try
         	Writeln( XFile, '"Number","Bank","Date","Reference","Account","Amount","Narration","Quantity","GST Class","GST Amount","GST Account"' );
            NoOfEntries := 0;
            
            for No := 0 to Pred( Selected.Count ) do
            Begin
               BA := TBank_Account( Selected.Objects[ No ] );
               TRAVERSE.Clear;
               TRAVERSE.SetSortMethod( csDateEffective );
               TRAVERSE.SetSelectionMethod( TRAVERSE.twAllNewEntries );
               TRAVERSE.SetOnAHProc( DoAccountHeader );
               TRAVERSE.SetOnEHProc( DoTransaction );
               TRAVERSE.SetOnDSProc( DoDissection );
               TRAVERSE.TraverseEntriesForAnAccount( BA, FromDate, ToDate );
            end;
            OK := True;
         finally            
            System.Close( XFile );
         end;

         if OK then
         Begin
            Msg := SysUtils.Format( 'Extract Data Complete. %d Entries were saved in %s',[ NoOfEntries, SaveTo ] );
            LogUtil.LogMsg(lmInfo, UnitName, ThisMethodName + ' : ' + Msg );
            HelpfulInfoMsg( Msg, 0 );
         end;
      end; { Scope of MyClient }
   finally
      Selected.Free;            
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

{$ENDIF}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{$IFDEF NEW}

procedure ExtractData( const FromDate, ToDate : TStDate; const SaveTo : string );

const
   ThisMethodName = 'ExtractData';
  
VAR
   BA           : TBank_Account;
   Msg          : String; 
	No			    : Integer;   
   OK           : Boolean;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   OK := False;

   Msg := 'Extract data [BK5 CW format] from '+BkDate2Str( FromDate ) + ' to ' + bkDate2Str( ToDate );
   
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' ' + Msg );

   if not BaSelFrm.SelectBankAccountsForExport( FromDate, ToDate, MultipleAccounts ) then exit;
   
   with MyClient.clBank_Account_List do
   begin
      for No := 0 to Pred( ItemCount ) do
      Begin
         BA := Bank_Account_At( No );
         With BA.baFields do If baIs_Selected then
         Begin
            if TravUtils.NumberAvailableForExport( BA, FromDate, ToDate  )= 0 then
            Begin
               HelpfulInfoMsg( 'There aren''t any new entries to extract from "'+baBank_Account_Number+'" in this date range!', 0 );
               exit;
            end;

            if not TravUtils.AllCoded( BA, FromDate, ToDate  ) then
            Begin
               HelpfulInfoMsg( 'Account "'+baBank_Account_Number+'" has uncoded entries. ' + 
               'You must code all the entries before you can extract them.',  0 );
               Exit;
            end;
   
            if BA.baFields.baContra_Account_Code = '' then
            Begin
               HelpfulInfoMsg( 'Before you can extract these entries, you must specify a contra account code for bank account "'+
                  baBank_Account_Number + '". To do this, go to the Other Functions|Bank Accounts option and edit the account', 0 );
               exit;
            end;

            if not TravUtils.HasRequiredGSTContraCodes( BA, FromDate, ToDate  ) then
            Begin
               HelpfulInfoMsg( 'Before you can extract these entries, you must specify the control account for each GST Class.' + 
                  ' To do this, go to the Other Functions|GST Details and Rates option.', 0 );
               exit;
            end;
         end;
      end;

      Assign( XFile, SaveTo );
      SetTextBuf( XFile, Buffer );
      Rewrite( XFile );
   
      Try
      	Writeln( XFile, '"Number","Bank","Date","Reference","Account","Amount","Narration","Quantity","GST Class","GST Amount","GST Account"' );
         NoOfEntries := 0;

         for No := 0 to Pred( ItemCount ) do
         Begin
            BA := Bank_Account_At( No );
            With BA.baFields do 
            Begin
               If baIs_Selected then
               Begin
                  TRAVERSE.Clear;
                  TRAVERSE.SetSortMethod( csDateEffective );
                  TRAVERSE.SetSelectionMethod( TRAVERSE.twAllNewEntries );
                  TRAVERSE.SetOnAHProc( DoAccountHeader );
                  TRAVERSE.SetOnEHProc( DoTransaction );
                  TRAVERSE.SetOnDSProc( DoDissection );
                  TRAVERSE.TraverseEntriesForAnAccount( BA, FromDate, ToDate );
               end;
            end;
         end;
         OK := True;
      finally            
         System.Close( XFile );
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

{$ENDIF}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Initialization
   DebugMe := LogUtil.DebugUnit( UnitName );
end.


