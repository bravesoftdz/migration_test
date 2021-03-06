unit ImportExport;

interface

uses
  fastMM4,
  IOStream,
  sysutils,
  classes,
  LogUtil,
  ProcTypes;



procedure SetOutputFileProc (value: OutputFileProc);export; stdcall;

procedure SetStatusProc (value: OutputStatusProc);export; stdcall;

procedure ImportBooksFile(data: pchar)export; stdcall;

procedure ExportBooksFile(data: PChar)export; stdcall;


// Theres are only exposed for the Debug EXE
function DecodeText(Value: PChar): TIOStream;
function EnCodetext(Value: Tstream): string;

implementation
uses

    SHFolder,
    MoneyDef,
    ErrorLog,
    LockUtils,
    windows,
    logger,
    listHelpers,
    CLObj32,
    Dialogs,
    OmniXMLUtils;



const
  XMLData = $00000000;
  BK5File = $00000001;


  UnitName = 'ImportExport';


var
  FileOutputProc : OutputFileProc;
  DebugMe: Boolean = false;
  LogHere: Boolean = false;
  StatusProc: OutputStatusProc;



procedure SetOutputFileProc (Value: OutputFileProc);
begin
   FileOutputProc := Value;
end;


procedure SetStatusProc (Value: OutputStatusProc);
begin
   StatusProc := Value;
end;


procedure DoStatus(Status: LogMsgType; StatusText: pChar);
begin
  if Assigned(StatusProc) then
      StatusProc(Integer(Status), StatusText);

end;

//var glMsg : string;

procedure MyLogMsg(msgType: logMsgType; logMsg: string);
begin

   //glMsg := logMsg + #0;
   case msgType of
     Info, Trace, Warning: begin
              DoStatus(msgType,pChar(logMsg));
              if LogHere then
                  LogUtil.LogMsg(lmInfo,'BooksIO',logMsg );
           end;
     Debug: begin
               if DebugMe then
                  DoStatus(msgType,pChar(logMsg));
               if LogHere then
                  LogUtil.LogMsg(lmDebug,'BooksIO',logMsg );
           end;
     Error: begin
               DoStatus(msgType,pChar(logMsg));
               if LogHere then
                  LogUtil.LogMsg(lmError,'BooksIO',logMsg );
           end;
   end;

end;



procedure DoOutputData(FileType: Integer; Filename: pChar; Data: PChar);
begin
   logDebug('procedure DoOutputData beginning');
   if Assigned(FileOutputProc) then
      // Got somthing to do..
      FileOutputProc(FileType, Data)
   else
      // Not that likely to work then....
      DoStatus(Error,'OutputFileProc not set');

   logDebug('procedure DoOutputData complete');
end;



function DecodeText(Value: PChar): TIOStream;
var
   InStream : TStringStream;
begin
   Result := TIOStream.Create;
   InStream := TStringStream.Create (Value);
   try
      Base64Decode(InStream, Result);
      Result.Position := 0;
   finally
      FreeandNil(Instream);
   end;

   logDebug('procedure DeCodetext complete');
end;

function EnCodetext(Value: Tstream): string;
var
    OutStream: TStringStream;
begin
  logDebug('function EnCodetext beginning');
  Result := '';
  OutStream := TStringStream.Create('');
  try
     Base64Encode(Value, OutStream);
     //Instream is now the result..
     Result := OutStream.DataString;
  finally
     FreeandNil(Outstream);
  end;

  logDebug('function EnCodetext complete');
end;



procedure SaveString(value, name: string);
var f: Text;
begin
   AssignFile(F,'C:\booksiotest\' + name );
   Rewrite(F);
   WriteLn(F,value);
   Close(F);
end;



procedure ImportBooksFile(data: pchar);
// The incomming blob is the actual Client file stream...
var
   ClientStream: TIostream;
   Client: TClientObj;
   XML:  TXML_Helper;
   outs: string;
begin
   logTrace( 'procedure ImportBooksFile beginning');
   ClientStream := nil;
   Client := nil;
   XML := nil;
   try
      try
        LogDebug('ImportStart');
        ClientStream := DecodeText(data);

      except
         on E: exception do  LogException(E,'Decoding Text');
      end;

      Client := TClientObj.Create;
      try
         LogDebug('read Client Start');
         Client.SimpleRead('', ClientStream);
      except
         on E: exception do  LogException(E,'Reading Client file');
      end;
      if not Assigned(Client) then
         LogError( 'procedure ImportBooksFile: Client is nil');


      // Conserve Mem
      FreeAndNil(clientStream);

      XML := TXML_Helper.Create;
      try
         LogDebug('Make XML Start');
         outS := xml.MakeXML(Client);

         {****
         SaveString(outS, 'out.XML');
         {****}

         DoOutputData(XMLData,pchar( string(Client.clFields.clCode)), PChar(outS));
         LogDebug('Import done');
      except
         on E: exception do  logException(E,'Serialising XML');
      end;


   finally
      // Clean up
      FreeAndNil(clientStream);
      FreeAndNil(Client);
      FreeAndNil(XML);
   end;

   FileOutputProc := nil;
   StatusProc := nil;
   LogTrace('procedure ImportBooksFile complete');
end;




procedure ExportBooksFile(data: pchar);
// The incomming blob is expected to be the XML stream
var
   XMLHelper:  TXML_Helper;
   Client: TClientObj;
   Stream : TBigMemoryStream;
   EncodedBK5: string;
   TempS: string;
   //TempWs: widestring;
begin
   LogTrace('procedure ExportBooksFile beginning');

   TempS :=  string(data);

   {***
   SaveString(TempS,'test.xml');
   {***}

   try
     Client := nil;
     Stream := nil;
     XMLHelper := TXML_Helper.Create;
     try
        try
           Client := XMLHelper.ReadClient(Temps);
           LogDebug('Read Client done');
           try
              try
               LogDebug('Save Client start');
                 Stream := Client.SaveClientToStream;
                 try
                    //Stream.SaveToFile(pChar(Client.clFields.clCode) + '.bk5');
                    try
                      EncodedBK5 := EnCodetext(Stream);
                    except
                       on E: exception do  LogException(E,'Encoding Client file');
                    end;
                    DoOutputData(BK5File, PChar(string(Client.clFields.clCode)), PChar(EncodedBK5));
                 finally
                   FreeAndNil(Stream);
                 end;
              except
                on E: exception do  LogException(E,'Saving Client file');
              end;
           finally
              FreeAndNil(Client);
           end;
        except
          on E: exception do  LogException(E,'Deserializing XML');
        end;
     finally
        FreeAndNil(XMLHelper);
     end;
   finally
      LogTrace('procedure ExportBooksFile Complete');
      FileOutputProc := nil;
      StatusProc := nil;
   end;
end;


procedure setPaths;

var
   AppData: PChar;
   path: String;
begin
  GetMem(AppData, MAX_PATH+1);
  if (AppData <> nil) then try

      SHGetFolderPath(0,CSIDL_APPDATA,0 , 0,AppData);



      path := string(AppData);

      //TWindowsFileLocking(FileLocking).SetLockingFileLocation(path);
      SysLog.LogPath := Path;
      SysLog.LogFilename := '\BooksIO.log';


      //path := format('%d',[Trunc(unknown)]);
      //path := '';
  finally
     FreeMem(AppData);
  end;

end;


initialization
   FileOutputProc := nil;
   StatusProc := nil;

   setPaths;
   logger.logMessageProcedure := MyLogMsg;
   //InitLocking;

finalization
   //FreeAndNil(FileLocking);

   //  LogError('Ok Then ');

end.

