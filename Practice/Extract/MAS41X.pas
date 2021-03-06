unit MAS41X;

{
   Author, SPA 24-05-99

   This is the extract data program for Solution 6 MAS 4.1. 4.1 is not Y2K
   compliant. The data is downloaded using the Direct Import option in MAS.

}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
interface uses StDate;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ExtractData( const FromDate, ToDate : TStDate; const SaveTo : string );

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

uses TransactionUtils,Classes, Traverse, Globals, GenUtils, bkDateUtils, TravUtils, YesNoDlg,
     LogUtil, BaObj32, dlgSelect, BkConst, MoneyDef, StStrS, StDateSt, SysUtils,
     InfoMoreFrm, glConst;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     
Const
   UnitName = 'MAS41X';
   DebugMe  : Boolean = False;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function MASDate( D : tstDate ): ShortString;
Begin
   Result := StDateToDateString( 'dd-mm-yyyy', d, False );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function InternalMASAmount( M : Money ): ShortString;

Var
   S : String[20];
Begin
   If M=0 then             {1234567890123}
   Begin                   {        0.00 }
      result :=            '        -    ';
      exit;
   end;
   Str( Abs( M )/100.0:0:2, S );
   If ( M < 0 ) then S := '(' + S + ')' else S := S + ' ';
   While Length( S ) < 13 do S := ' ' + S;
   Result := S;
end;

function InternalMASQty( M : Money ): ShortString;

Var
   S : String[20];
Begin
   If M=0 then             {1234567890123}
   Begin                   {        0.00 }
      result :=            '        -    ';
      exit;
   end;
   S := GetQuantityStringForExtract(Abs( M ), 2);
   If ( M < 0 ) then S := '(' + S + ')' else S := S + ' ';
   While Length( S ) < 13 do S := ' ' + S;
   Result := S;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function MasGSTID( classNo : integer) : string;
const
   MaxGSTFieldLength = 3;
begin
   result := trim( MyClient.clFields.clGST_Class_Codes[ classNo ]);
   //trim to max length, use first x chars
   if length( result) > MaxGSTFieldLength then
      result := Copy( result,1,MaxGSTFieldLength);
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Var
   XFile         : Text;
   Buffer        : array[ 1..2048 ] of Byte;
   NoOfEntries   : LongInt;
   Contra        : Money;
   GSTTotals     : array[ 0..MAX_GST_CLASS ] of Money; { GLOBALS.MAX_GST_CLASS }
   GST_Inclusive : Boolean;
   Credits       : Money;
   Debits        : Money;
   D1, D2        : TStDate;
   ECount        : Longint;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure Add( M : Money );
Begin
   If M < 0 then
      Credits := Credits + M
  else
      Debits := Debits + M;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DoAccountHeader;

const
   ThisMethodName = 'DoAccountHeader';
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   Contra := 0;
   FillChar( GSTTotals, Sizeof( GSTTotals ), 0 );
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DoAccountTrailer;
const
   ThisMethodName = 'DoAccountTrailer';
Var
   i : Integer;
   L : String[150];
   S : String[80];
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   With MyClient.clFields, Bank_Account.baFields do
   Begin
      For i := 1 to MAX_GST_CLASS do if GSTTotals[i]<>0 then
      Begin
         L := ConstStr( ' ', 150 );
         S := MASDate( D2 );                       Move( S[1], L[ 1], Length( S ) );
         S := 'BSt';                               Move( S[1], L[10], Length( S ) );
         S := 'Contra Tax entry';                  Move( S[1], L[27], Length( S ) );
         S := clGST_Account_Codes[i];              Move( S[1], L[71], Length( S ) );
         L[94] := '-'; { Bal2 }
         S := MasGstID( i);                        Move( S[1], L[ 102 - Length( S )], Length( S ) );
         L[112] := '-';
         S := InternalMASAmount( GSTTotals[i] );  Move( S[1], L[120], Length( S ) );
         Add( GSTTotals[i] );
         S := baContra_Account_Code;              Move( S[1], L[133], Length( S ) );
         L[144] := 'T';
         Writeln( XFile, L );
         Inc ( ECount );
      end;

      if Contra <> 0 then
      Begin
         L := ConstStr( ' ', 150 );
         S := MASDate( D2 );                       Move( S[1], L[ 1], Length( S ) );
         S := 'BSt';                               Move( S[1], L[10], Length( S ) );
         S := 'Contra Bank entry';                 Move( S[1], L[27], Length( S ) );

         S := baContra_Account_Code;               Move( S[1], L[71], Length( S ) );
         L[94]    := '-'; { Bal2 }
         L[101]   := '-'; { Rate }
         L[112]   := '-'; { Tax }
         S := InternalMASAmount( -Contra );        Move( S[1], L[120], Length( S ) );
         Add( -Contra );
         S := baContra_Account_Code;               Move( S[1], L[133], Length( S ) );
         L[144] := 'B';
         Writeln( XFile, L );
         Inc ( ECount );
      end;
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure DoTransaction;

const
   ThisMethodName = 'DoTransaction';
Var
   S : String[80];
   L : String;
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
         L := ConstStr( ' ', 150 );
         S := MASDate( txDate_Effective );  Move( S[1], L[ 1], Length( S ) );
         S := 'BSt';                        Move( S[1], L[10], Length( S ) );

         If ( txCheque_Number = 0 ) then
            S := ''
         else
         Begin
            Str( txCheque_Number, S );
            While ( Length( S )>6 ) do System.Delete( S, 1, 1 );
            While ( Length( S )<6 ) do S:=' '+S;
         end;

         Move( S[1], L[18], Length( S ) );

         S := Copy( GetNarration(TransAction,Bank_Account.baFields.baAccount_Type), 1, GetMaxNarrationLength);
         While Length( S ) > 40 do
         Begin
            Move( S[1], L[27], 40 );
            Writeln( XFile, L );
            Delete( S, 1, 40 );
            L := ConstStr( ' ', 150 );
         end;
         Move( S[1], L[27], Length( S ) );

         S := txAccount; Move( S[1], L[71], Length( S ) );
         if (Globals.PRACINI_ExtractQuantity) then
           S := InternalMASQty( txQuantity )
         else
           S := InternalMASQty( 0.0 );
         Move( S[1], L[86], Length( S ) );

         If not ( txGST_Class in [ 1..MAX_GST_CLASS ] ) then
         Begin
            txGST_Class  := 0;
            txGST_Amount := 0;
         end;

         If GST_Inclusive or ( txGST_Class = 0 ) then
         Begin
            L[101] := '-'; { Rate }
            S := InternalMASAmount( 0 );   Move( S[1], L[104], Length( S ) );
            S := InternalMASAmount( txAmount );
            Move( S[1], L[120], Length( S ) );
            Add( txAmount );
         end
         else
         Begin
            S := MasGstID( txGST_Class);                       Move( S[1], L[ 102 - Length( S )], Length( S ) );
            GSTTotals[ txGST_Class ] := GSTTotals[ txGST_Class ] + txGST_Amount;

            S := InternalMASAmount( txGST_Amount );            Move( S[1], L[104], Length( S ) );
            S := InternalMASAmount( txAmount - txGST_Amount ); Move( S[1], L[120], Length( S ) );
            Add( txAmount - txGST_Amount );
         end;

         S := baContra_Account_Code;               Move( S[1], L[133], Length( S ) );
         L[144] := ' ';
         Writeln( XFile, L );
         Contra := Contra + txAmount;
         Inc ( ECount );
      end;
      Inc( NoOfEntries );
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Procedure DoDissection ;

const
   ThisMethodName = 'DoDissection';
Var
   S : String[80];
   L : String[150];
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );
   With MyClient.clFields, Bank_Account.baFields, Transaction^, Dissection^ do
   Begin
      L := ConstStr( ' ', 150 );
      S := MASDate( txDate_Effective );  Move( S[1], L[ 1], Length( S ) );
      S := 'BSt';  Move( S[1], L[10], Length( S ) );

      If ( txCheque_Number = 0 ) then
         S := ''
      else
      Begin
         Str( txCheque_Number, S );
         While ( Length( S )>6 ) do System.Delete( S, 1, 1 );
         While ( Length( S )<6 ) do S:=' '+S;
      end;
      Move( S[1], L[18], Length( S ) );

      If ( dsGL_Narration<>'' ) then
         S := dsGL_Narration
      else
         S :=  GetNarration(TransAction,Bank_Account.baFields.baAccount_Type);
      S := Copy(S, 1, GetMaxNarrationLength);
      While Length( S ) > 40 do
      Begin
         Move( S[1], L[27], 40 );
         Writeln( XFile, L );
         Delete( S, 1, 40 );
         L := ConstStr( ' ', 150 );
      end;
      Move( S[1], L[27], Length( S ) );

      S := dsAccount;                                  Move( S[1], L[71], Length( S ) );
      if (Globals.PRACINI_ExtractQuantity) then
        S := InternalMASAmount( dsQuantity / 10.0 )
      else
        S := InternalMASAmount( 0.0 );
      Move( S[1], L[86], Length( S ) );

      If not ( dsGST_Class in [ 1..MAX_GST_CLASS ] ) then
      Begin
         dsGST_Class := 0;
         dsGST_Amount := 0;
      end;

      If GST_Inclusive or ( dsGST_Class = 0 ) then
      Begin
         L[101] := '-'; { Rate }
         S := InternalMASAmount( 0 );   Move( S[1], L[104], Length( S ) );
         S := InternalMASAmount( dsAmount );
         Move( S[1], L[120], Length( S ) );
         Add( dsAmount );
      end
      else
      Begin
         S := MasGSTId( dsGST_Class );                      Move( S[1], L[ 102 - Length( S )], Length( S ) );
         GSTTotals[ dsGST_Class ] := GSTTotals[ dsGST_Class ] + dsGST_Amount;
         S := InternalMASAmount( dsGST_Amount );            Move( S[1], L[104], Length( S ) );
         S := InternalMASAmount( dsAmount - dsGST_Amount ); Move( S[1], L[120], Length( S ) );
         Add( dsAmount - dsGST_Amount );
      end;

      S := baContra_Account_Code;               Move( S[1], L[133], Length( S ) );
      L[144] := ' ';
      Writeln( XFile, L );
      Inc ( ECount );
      Contra := Contra + dsAmount;
   end;
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ExtractData( const FromDate, ToDate : TStDate; const SaveTo : string );
const
   ThisMethodName = 'ExtractData';

   HorzLine : char = #196;

var
   GI           : Boolean;
   Msg          : String;
   Selected     : TStringList;
   No           : Integer;
   i            : Integer;
   ti           : Integer;
   M1, Y1       : Integer;
   M,Y          : Integer;
   BA           : TBank_Account;
   L            : String[150];
   S            : String[80];
   OK           : Boolean;
Begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   Msg := 'Extract data [MAS41 format] from '+BkDate2Str( FromDate ) + ' to ' + bkDate2Str( ToDate );
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' ' + Msg );

   Selected  := dlgSelect.SelectBankAccountsForExport( FromDate, ToDate );
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
                  HelpfulInfoMsg( 'Before you can extract these entries, you must specify a contra account code for this bank account. '+
                     ' To do this, go to the Other Functions|Bank Accounts option and edit the account', 0 );
                  exit;
               end;
            end;
         end;

         GI := Globals.PRACINI_REMOVEGST; { Usually FALSE }
         If Globals.PRACINI_PromptForGST then
         Begin
            Case GI of
               TRUE  :  GI := ( AskYesNo('GST Inclusive?','Do you want to transfer the entries GST INCLUSIVE?',
                                DLG_YES,0) = DLG_YES);

               FALSE :  GI := ( AskYesNo('GST Inclusive?','Do you want to transfer the entries GST INCLUSIVE?',
                                            DLG_NO,0) = DLG_YES);
            end;
         end;
         GST_Inclusive := GI;

         if ( not GST_Inclusive ) then
         begin { We will be creating entries for the GST Totals, so we need to check that the GST contra accounts exist }
            for No := 0 to Pred( Selected.Count ) do
            Begin
               BA := TBank_Account( Selected.Objects[ No ] );
               If not HasRequiredGSTContraCodes( BA, FromDate, ToDate ) then
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
            { Write the identification information so FETCH.EXE can validate
              the information MAS sends... }

            Writeln( XFile, clCode );
            Writeln( XFile, bkDate2Str( FromDate ) );
            Writeln( XFile, bkDate2Str( ToDate ) );
            Writeln( XFile, 'MAS' );

            { - - - - - - - - - - - - - - - -  }

            L := ConstStr( ' ', 150 );
            S := MASDate( CurrentDate ); Move( S[1], L[1], Length( S ) );
            S := MyClient.clFields.clName;
            Move( S[1], L[ ( 150 - Length( S ) ) div 2 ], Length( S ) );
            S := 'Page 1'; Move( S[1], L[144], Length( S ) );
            Writeln( XFile, L );

            { - - - - - - - - - - - - - - - -  }

            L := ConstStr( ' ', 150 );
            S := CurrentTimeString( 'hh:mm', true);        Move( S[1], L[1], Length( S ) );
            S := 'Export Transactions';                    Move( S[1], L[65], Length( S ) );
            Writeln( XFile, L );

            { - - - - - - - - - - - - - - - -  }

            L := ConstStr( ' ', 150 );
            S := 'Client Code:';                           Move( S[1], L[1], Length( S ) );
            S := MyClient.clFields.clCode;                   Move( S[1], L[14], Length( S ) );
            S := 'Tax Ledger';                             Move( S[1], L[32], Length( S ) );
            S := 'From '+MASDate( FromDate ) + ' To '+MASDate( ToDate ); Move( S[1], L[64], Length( S ) );
            Writeln( XFile, L );

            { - - - - - - - - - - - - - - - -  }

            Writeln( XFile, ConstStr( HorzLine, 148 ) );

            { - - - - - - - - - - - - - - - -  }

            Write( XFile, '  Date   Type    Ref.      Narration                                  Account   ' );
            Writeln( XFile, '          Bal2    Rate      Tax         Amount      Bank      B/T Curr' );

            { - - - - - - - - - - - - - - - -  }

            Writeln( XFile, ConstStr( HorzLine, 148 ) );

            { - - - - - - - - - - - - - - - -  }

            NoOfEntries       := 0;
            Debits            := 0;
            Credits           := 0;
            ECount            := 0;

            for No := 0 to Pred( Selected.Count ) do
            Begin
               BA := TBank_Account( Selected.Objects[ No ] );
               StDateToDMY( FromDate, ti, M1, Y1 ); { 01-04-97 }
               M := M1; Y := Y1;
               Repeat
                  D1 := DMYToStDate( 1, M, Y, Epoch );
                  If D1<FromDate then D1 := FromDate;
                  D2 := DMYToStDate( DaysInMonth( M, Y, Epoch ), M, Y, Epoch );
                  If D2 > ToDate then D2 := ToDate;

                  TRAVERSE.Clear;
                  TRAVERSE.SetSortMethod( csDateEffective );
                  TRAVERSE.SetSelectionMethod( twAllNewEntries );
                  TRAVERSE.SetOnAHProc( DoAccountHeader );
                  TRAVERSE.SetOnEHProc( DoTransaction );
                  TRAVERSE.SetOnDSProc( DoDissection );
                  TRAVERSE.SetOnATProc( DoAccountTrailer );
                  TRAVERSE.TraverseEntriesForAnAccount( BA, D1, D2 );

                  Inc( M ); If M>12 then Begin M:= 1; Inc( Y ); end;
               Until ( D2 = ToDate );
            end;
            For i := 1 to 3 do Writeln( XFile );

            L := ConstStr( ' ', 150 );
            S := 'Debits:'; Move( S[1], L[37], Length( S ) );
            S := InternalMASAmount( Abs( Debits ) ); Move( S[1], L[44], Length( S ) );
            Writeln( XFile, L );

            L := ConstStr( ' ', 150 );
            S := 'Credits:'; Move( S[1], L[36], Length( S ) );
            S := InternalMASAmount( Abs( Credits ) ); Move( S[1], L[44], Length( S ) );
            Writeln( XFile, L );
            Writeln( XFile );

            L := ConstStr( ' ', 150 );
            S := 'Total: '; Move( S[1], L[38], Length( S ) );
            S := InternalMASAmount( Credits + Debits ); Move( S[1], L[44], Length( S ) );
            Writeln( XFile, L );

            L := ConstStr( ' ', 150 );
            S := 'No. of Entries:'; Move( S[1], L[29], Length( S ) );
            Str( ECount, S ); Move( S[1], L[45], Length( S ) );
            Writeln( XFile, L );

            Writeln( XFile );
            Writeln( XFile );
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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Initialization
   DebugMe := LogUtil.DebugUnit( UnitName );
end.

