unit AccountSoft;

//------------------------------------------------------------------------------
interface
//------------------------------------------------------------------------------

procedure RefreshChart;

//------------------------------------------------------------------------------
implementation
//------------------------------------------------------------------------------

uses
  Globals, sysutils, InfoMoreFrm, bkconst, chList32, bkchio,
  bkdefs, ovcDate, ErrorMoreFrm, classes, LogUtil, ChartUtils, 
  GenUtils, Progress, bkDateUtils, glConst, WinUtils;

Const
   UnitName = 'AccountSoft';
   DebugMe  : Boolean = False;
   
//------------------------------------------------------------------------------

procedure RefreshChart;

const
   ThisMethodName    = 'RefreshChart';
var
   ChartFileName     : string;
   ChartFilePath     : string;
   HCtx              : integer;
   f                 : TextFile;
   Line              : ShortString;
   NewChart          : TChart;
   NewAccount        : pAccount_Rec;
   p                 : integer;
   ACode             : Bk5CodeStr;
   ADesc             : String[80];
   APost             : String[10];
   AGSTClass         : String[10];
   AGstClassNo       : integer;
   Msg               : string;
   OK                : Boolean;
begin
   if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Begins' );

   if not Assigned(MyClient) then exit;

   OK := False;

   with MyClient.clFields do begin
      ChartFileName := clLoad_Client_Files_From;

      if DirectoryExists(ChartFileName) then // User only specified a directory - we need a filename
      begin
        ChartFileName := '';
        ChartFilePath := AddSlash(clLoad_Client_Files_From);
      end
      else
        ChartFilePath := RemoveSlash(clLoad_Client_Files_From);

      //check file exists, ask for a new one if not
      if not BKFileExists( ChartFileName ) then begin
      HCtx := 0;
      ChartFileName := RemoveSlash(ChartFileName);
      if not LoadChartFrom(
         clCode,
         ChartFileName,                                { Var Result }
         ExtractFilePath(ChartFilePath),  { Initial Directory }
         'Chart Files|*.CHT',                          { Filter }
         'CHT',                                      { Default Extension }
         HCtx ) then
         exit;
     end;

     try
        UpdateAppStatus('Loading Chart','',0);
        try
           //have a file to import - import into a new chart object
           AssignFile(F,ChartFileName);
           Reset(F);
           NewChart := TChart.Create(MyClient.ClientAuditMgr);
           try
              UpdateAppStatusLine2('Reading');
              While not EOF( F ) do Begin
                 Readln( F, Line );
                 if Copy( Line, 1, 2 )='A,' then Begin

                    Line := Copy( Line, 3, 255 ); { Strip the first two characters }
                 
                    p := Pos( '",', Line );
                    ACode := TrimSpacesAndQuotes( Copy( Line, 1, p-1 ) ); 
                    Line := Copy( Line, p+3, 255 );

                    p := Pos( '",', Line );
                    ADesc := TrimSpacesAndQuotes( Copy( Line, 1, p-1 ) ); 
                    Line := Copy( Line, p+3, 255 );
                    
                    p := Pos( '",', Line );
                    APost := TrimSpacesAndQuotes( Copy( Line, 1, p-1 ) ); 
                    Line := Copy( Line, p+3, 255 );

                    AGSTClass := Line;

                    AGSTClassNo := StrToIntSafe( AGSTClass);
                    if not (AGSTClassNo in [1..MAX_GST_CLASS]) then AGSTClassNo := 0;

                    if ( NewChart.FindCode( ACode )<> NIL ) then Begin
                       LogUtil.LogMsg( lmError, UnitName, 'Duplicate Code '+ACode+' found in '+ChartFileName );
                    end
                    else Begin
                       {insert new account into chart}
                       NewAccount := New_Account_Rec;
                       with NewAccount^ do begin
                          chAccount_Code        := aCode;
                          chAccount_Description := aDesc;
                          chPosting_Allowed     := ( APost = 'Y' );
                          chGST_Class           := AGSTClassNo;
                       end;
                       NewChart.Insert(NewAccount);
                    end;
                 end;
              end;
              if NewChart.ItemCount > 0 then begin
                 MergeCharts(NewChart, MyClient);

                 clLoad_Client_Files_From := ChartFileName;
                 clChart_Last_Updated     := CurrentDate;
                 OK := True;
              end;
              ClearStatus(True);
           finally
              NewChart.Free;   {free is ok because Merge charts will have set NewChart to nil}
              CloseFile(f);
              if OK then HelpfulInfoMsg( 'The client''s chart of accounts has been refreshed.', 0 );
           end;
        finally
           ClearStatus(True);
        end;
     except
        on E : EInOutError do begin //Normally EExtractData but File I/O only
           Msg := Format( 'Error refreshing chart %s.', [ChartFileName] );
           LogUtil.LogMsg( lmError, UnitName, ThisMethodName + ' : ' + Msg );
           HelpfulErrorMsg( Msg, 0 , false, 'The existing chart has not been modified.'#13#13 + E.Message, True);
           exit;
        end;
     end; {except}
  end; {with}
  if DebugMe then LogUtil.LogMsg(lmDebug, UnitName, ThisMethodName + ' Ends' );
end;

//------------------------------------------------------------------------------

Initialization
   DebugMe := LogUtil.DebugUnit( UnitName );
end.


