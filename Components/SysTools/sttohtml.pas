{*********************************************************}
{* SysTools: StToHTML.pas 3.03                           *}
{* Copyright (c) TurboPower Software Co 1996, 2001       *}
{* All rights reserved.                                  *}
{*********************************************************}
{* SysTools: HTML Text Formatter                         *}
{*********************************************************}

{$I StDefine.inc}

{$IFDEF WIN16}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StToHTML;

interface

uses
  SysUtils,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF WIN16}
  WinTypes, WinProcs,
  {$ENDIF}
  Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StStrms, StBase;

type
  TStOnProgressEvent = procedure(Sender : TObject; Percent : Word) of object;

  TStStreamToHTML = class(TObject)
  protected {private}
    { Private declarations }
    FCaseSensitive   : Boolean;
    FCommentMarkers  : TStringList;
    FEmbeddedHTML    : TStringList;
    FInFileSize      : Cardinal;
    FInFixedLineLen  : integer;
    FInLineTermChar  : AnsiChar;
    FInLineTerminator: TStLineTerminator;
    FInputStream     : TStream;
    FInSize          : Cardinal;
    FInTextStream    : TStAnsiTextStream;
    FIsCaseSensitive : Boolean;
    FKeywords        : TStringList;
    FOnProgress      : TStOnProgressEvent;
    FOutputStream    : TStream;
    FOutTextStream   : TStAnsiTextStream;
    FPageFooter      : TStringList;
    FPageHeader      : TStringList;
    FStringMarkers   : TStringList;
    FWordDelims      : string;
  protected
    { Protected declarations }

    {internal methods}
    function ParseBuffer : Boolean;

    procedure SetCommentMarkers(Value : TStringList);
    procedure SetEmbeddedHTML(Value : TStringList);
    procedure SetKeywords(Value : TStringList);
    procedure SetPageFooter(Value : TStringList);
    procedure SetPageHeader(Value : TStringList);
    procedure SetStringMarkers(Value : TStringList);

  public
    { Public declarations }

    property CaseSensitive : Boolean
      read FCaseSensitive
      write FCaseSensitive;

    property CommentMarkers : TStringList
      read FCommentMarkers
      write SetCommentMarkers;

    property EmbeddedHTML : TStringList
      read FEmbeddedHTML
      write SetEmbeddedHTML;

    property InFixedLineLength : integer
      read FInFixedLineLen
      write FInFixedLineLen;

    property InLineTermChar : AnsiChar
      read FInLineTermChar
      write FInLineTermChar;

    property InLineTerminator : TStLineTerminator
      read FInLineTerminator
      write FInLineTerminator;

    property InputStream : TStream
      read FInputStream
      write FInputStream;

    property Keywords : TStringList
      read FKeywords
      write SetKeywords;

    property OnProgress : TStOnProgressEvent
      read FOnProgress
      write FOnProgress;

    property OutputStream : TStream
      read FOutputStream
      write FOutputStream;

    property PageFooter : TStringList
      read FPageFooter
      write SetPageFooter;

    property PageHeader : TStringList
      read FPageHeader
      write SetPageHeader;

    property StringMarkers : TStringList
      read FStringMarkers
      write SetStringMarkers;

    property WordDelimiters : string
      read FWordDelims
      write FWordDelims;


    constructor Create;
    destructor Destroy; override;

    procedure GenerateHTML;
  end;


  TStFileToHTML = class(TComponent)
  protected {private}
    { Private declarations }

    FCaseSensitive      : Boolean;
    FCommentMarkers     : TStringList;
    FEmbeddedHTML       : TStringList;
    FInFile             : TFileStream;
    FInFileName         : string;
    FInLineLength       : integer;
    FInLineTermChar     : AnsiChar;
    FInLineTerminator   : TStLineTerminator;
    FKeywords           : TStringList;
    FOnProgress         : TStOnProgressEvent;
    FOutFile            : TFileStream;
    FOutFileName        : string;
    FPageFooter         : TStringList;
    FPageHeader         : TStringList;
    FStream             : TStStreamToHTML;
    FStringMarkers      : TStringList;
    FWordDelims         : string;

  protected

    procedure SetCommentMarkers(Value : TStringList);
    procedure SetEmbeddedHTML(Value : TStringList);
    procedure SetKeywords(Value : TStringList);
    procedure SetPageFooter(Value : TStringList);
    procedure SetPageHeader(Value : TStringList);
    procedure SetStringMarkers(Value : TStringList);

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure Execute;

  published
    property CaseSensitive : Boolean
      read FCaseSensitive
      write FCaseSensitive;

    property CommentMarkers : TStringList
      read FCommentMarkers
      write SetCommentMarkers;

    property EmbeddedHTML : TStringList
      read FEmbeddedHTML
      write SetEmbeddedHTML;

    property InFileName : string
      read FInFileName
      write FInFileName;

    property InFixedLineLength : integer
      read FInLineLength
      write FInLineLength;

    property InLineTermChar : AnsiChar
      read FInLineTermChar
      write FInLineTermChar;

    property InLineTerminator : TStLineTerminator
      read FInLineTerminator
      write FInLineTerminator;

    property Keywords : TStringList
      read FKeywords
      write SetKeywords;

    property OnProgress : TStOnProgressEvent
      read FOnProgress
      write FOnProgress;

    property OutFileName : string
      read FOutFileName
      write FOutFileName;

    property PageFooter : TStringList
      read FPageFooter
      write SetPageFooter;

    property PageHeader : TStringList
      read FPageHeader
      write SetPageHeader;

    property StringMarkers : TStringList
      read FStringMarkers
      write SetStringMarkers;

    property WordDelimiters : string
      read FWordDelims
      write FWordDelims;
  end;

implementation


uses
  StConst,
  StDict
{$IFDEF TRIALRUN}
  ,
  {$IFDEF MSWINDOWS}
  Registry,
  {$ENDIF}
  {$IFDEF WIN16}
  Ver,
  {$ENDIF}
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ELSE}
  ;
{$ENDIF}


(*****************************************************************************)
(*                         TStStreamToHTML Implementation                    *)
(*****************************************************************************)

constructor TStStreamToHTML.Create;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create;

  FCommentMarkers := TStringList.Create;
  FEmbeddedHTML   := TStringList.Create;
  FKeywords       := TStringList.Create;
  FPageFooter     := TStringList.Create;
  FPageHeader     := TStringList.Create;
  FStringMarkers  := TStringList.Create;

  FInputStream := nil;
  FOutputStream := nil;

  FInFileSize := 0;
  FWordDelims := ',; .()';

  FInLineTerminator := ltCRLF;  {normal Windows text file terminator}
  FInLineTermChar   := #10;
  FInFixedLineLen   := 80;

  with FEmbeddedHTML do begin
    Add('"=&quot;');
    Add('&=&amp;');
    Add('<=&lt;');
    Add('>=&gt;');
    Add('�=&iexcl;');
    Add('�=&cent;');
    Add('�=&pound;');
    Add('�=&copy;');
    Add('�=&reg;');
    Add('�=&plusmn;');
    Add('�=&frac14;');
    Add('�=&frac12;');
    Add('�=&frac34;');
    Add('�=&divide;');
  end;
end;


destructor TStStreamToHTML.Destroy;
begin
  FCommentMarkers.Free;
  FCommentMarkers := nil;

  FEmbeddedHTML.Free;
  FEmbeddedHTML := nil;

  FKeywords.Free;
  FKeywords := nil;

  FPageFooter.Free;
  FPageFooter := nil;

  FPageHeader.Free;
  FPageHeader := nil;

  FStringMarkers.Free;
  FStringMarkers := nil;

  FInTextStream.Free;
  FInTextStream := nil;

  FOutTextStream.Free;
  FOutTextStream := nil;

  inherited Destroy;
end;


procedure TStStreamToHTML.GenerateHTML;
begin
  if not ((Assigned(FInputStream) and (Assigned(FOutputStream)))) then
    RaiseStError(EStToHTMLError, stscBadStream)
  else
    ParseBuffer;
end;


procedure DisposeShortString(Data : Pointer); far;
begin
  Dispose(Data);
end;


function TStStreamToHTML.ParseBuffer : Boolean;
var
  I, J,
  P1,
  P2,
  BRead,
  PC          : Longint;
  CloseStr,
  SStr,
  EStr,
  S,
  VS,
  AStr,
  TmpStr       : string;
  P            : Pointer;
  PS           : ^ShortString;
  CommentDict  : TStDictionary;
  HTMLDict     : TStDictionary;
  KeywordsDict : TStDictionary;
  StringDict   : TStDictionary;
  CommentPend  : Boolean;

      function ConvertEmbeddedHTML(const Str2 : string) : string;
      var
        L,
        J  : Longint;
        PH : Pointer;
      begin
        Result := '';
        {$IFDEF MSWINDOWS}
        {avoid memory reallocations}
        SetLength(Result, 1024);
        {$ENDIF}
        J := 1;
        for L := 1 to Length(Str2) do begin
          if (not HTMLDict.Exists(Str2[L], PH)) then begin
            Result[J] := Str2[L];
            Inc(J);
          end else begin
            Move(ShortString(PH^)[1], Result[J], Length(ShortString(PH^)));
            Inc(J, Length(ShortString(PH^)));
          end;
        end;
        Dec(J);
        {$IFDEF MSWINDOWS}
        SetLength(Result, J);
        {$ENDIF}
        {$IFDEF WIN16}
        Result[0] := chr(J);
        {$ENDIF}
      end;

      procedure CheckSubString(const Str1 : string);
      var
        S2 : string;
      begin
        if (KeywordsDict.Exists(Str1, P)) then begin
          VS := ShortString(P^);
          S2 := Copy(VS, 1, pos(';', VS)-1)
              + ConvertEmbeddedHTML(Str1)
              + Copy(VS, pos(';', VS)+1, Length(VS));
          if (P1 >= Length(Str1)) and (P1 <= Length(TmpStr)) then
            S2 := S2 + ConvertEmbeddedHTML(TmpStr[P1]);
        end else begin
          S2 := ConvertEmbeddedHTML(Str1);
          if (P1 >= Length(Str1)) and (P1 <= Length(TmpStr)) then
            S2 := S2 + ConvertEmbeddedHTML(TmpStr[P1]);
        end;
        S := S + S2;
      end;

begin
  if (Length(FWordDelims) = 0) then
    RaiseStError(EStToHTMLError, stscWordDelimiters);

  {create Dictionaries for lookups}
  CommentDict  := TStDictionary.Create(FCommentMarkers.Count+1);
  KeywordsDict := TStDictionary.Create(FKeywords.Count+1);
  HTMLDict     := TStDictionary.Create(FEmbeddedHTML.Count+1);
  StringDict   := TStDictionary.Create(FStringMarkers.Count+1);

  CommentDict.DisposeData  := DisposeShortString;
  KeywordsDict.DisposeData := DisposeShortString;
  HTMLDict.DisposeData     := DisposeShortString;
  StringDict.DisposeData   := DisposeShortString;

  FInTextStream := TStAnsiTextStream.Create(FInputStream);
  FInTextStream.LineTermChar := FInLineTermChar;
  FInTextStream.LineTerminator := FInLineTerminator;
  FInTextStream.FixedLineLength := FInFixedLineLen;
  FInFileSize := FInTextStream.Size;

  FOutTextStream := TStAnsiTextStream.Create(FOutputStream);
  FOutTextStream.LineTermChar := #10;
  FOutTextStream.LineTerminator := ltCRLF;
  FOutTextStream.FixedLineLength := 80;

  FInLineTerminator := ltCRLF;  {normal Windows text file terminator}
  FInLineTermChar   := #10;
  FInFixedLineLen   := 80;

  try
    if (FCaseSensitive) then begin
      CommentDict.Hash  := AnsiHashStr;
      CommentDict.Equal := AnsiCompareStr;
      HTMLDict.Hash     := AnsiHashStr;
      HTMLDict.Equal    := AnsiCompareStr;
      KeywordsDict.Hash := AnsiHashStr;
      KeywordsDict.Equal:= AnsiCompareStr;
      StringDict.Hash   := AnsiHashStr;
      StringDict.Equal  := AnsiCompareStr;
    end else begin
      CommentDict.Hash  := AnsiHashText;
      CommentDict.Equal := AnsiCompareText;
      HTMLDict.Hash     := AnsiHashText;
      HTMLDict.Equal    := AnsiCompareText;
      KeywordsDict.Hash := AnsiHashText;
      KeywordsDict.Equal:= AnsiCompareText;
      StringDict.Hash   := AnsiHashText;
      StringDict.Equal  := AnsiCompareText;
    end;

    {Add items from string lists to dictionaries}
    for I := 0 to pred(FKeywords.Count) do begin
      if (Length(FKeywords[I]) = 0) then
        continue;
      if (pos('=', FKeywords[I]) > 0) then begin
        New(PS);

        {$IFDEF MSWINDOWS}
        S := FKeywords.Names[I];
        {$ENDIF}
        {$IFDEF WIN16}
        S := Copy(FKeywords[I], 1, pos('=', FKeywords[I])-1);
        {$ENDIF}

        PS^ := FKeywords.Values[S];
        if (not KeywordsDict.Exists(S, P)) then
          KeywordsDict.Add(S, PS)
        else
          Dispose(PS);
      end else
        RaiseStError(EStToHTMLError, stscInvalidSLEntry);
    end;

    for I := 0 to pred(FStringMarkers.Count) do begin
      if (Length(FStringMarkers[I]) = 0) then
        continue;
      if (pos('=', FStringMarkers[I]) > 0) then begin
        New(PS);
        {$IFDEF MSWINDOWS}
        S := FStringMarkers.Names[I];
        {$ENDIF}
        {$IFDEF WIN16}
        S := Copy(FStringMarkers[I], 1, pos('=', FStringMarkers[I])-1);
        {$ENDIF}
        PS^ := FStringMarkers.Values[S];
        if (not StringDict.Exists(S, P)) then
          StringDict.Add(S, PS)
        else
          Dispose(PS);
      end else
        RaiseStError(EStToHTMLError, stscInvalidSLEntry);
    end;

    for I := 0 to pred(FCommentMarkers.Count) do begin
      if (Length(FCommentMarkers[I]) = 0) then
        continue;
      if (pos('=', FCommentMarkers[I]) > 0) then begin
        New(PS);
        {$IFDEF MSWINDOWS}
        S := FCommentMarkers.Names[I];
        {$ENDIF}
        {$IFDEF WIN16}
        S := Copy(FCommentMarkers[I], 1, pos('=', FCommentMarkers[I])-1);
        {$ENDIF}
        if (Length(S) = 1) then
          PS^ := FCommentMarkers.Values[S]
        else begin
          PS^ := ':1' + S[2] + ';' + FCommentMarkers.Values[S];
          S := S[1];
        end;
        if (not CommentDict.Exists(S, P)) then
          CommentDict.Add(S, PS)
        else begin
          AStr := ShortString(P^);
          AStr := AStr + PS^;
          ShortString(P^) := AStr;
          CommentDict.Update(S, P);
          Dispose(PS);
        end;
      end else
        RaiseStError(EStToHTMLError, stscInvalidSLEntry);
    end;

    for I := 0 to pred(FEmbeddedHTML.Count) do begin
      if (pos('=', FEmbeddedHTML[I]) > 0) then begin
        New(PS);
        {$IFDEF MSWINDOWS}
        S := FEmbeddedHTML.Names[I];
        {$ENDIF}
        {$IFDEF WIN16}
        S := Copy(FEmbeddedHTML[I], 1, pos('=', FEmbeddedHTML[I])-1);
        {$ENDIF}
        PS^ := FEmbeddedHTML.Values[S];
        if (not HTMLDict.Exists(S, P)) then
          HTMLDict.Add(S, PS)
        else
          Dispose(PS);
      end else
        RaiseStError(EStToHTMLError, stscInvalidSLEntry);
    end;

    BRead := 0;
    if (FPageHeader.Count > 0) then begin
      for I := 0 to pred(FPageHeader.Count) do
        FOutTextStream.WriteLine(FPageHeader[I]);
    end;
    FOutTextStream.WriteLine('<pre>');
    CommentPend := False;
    AStr := '';
    SStr := '';
    EStr := '';

    {make sure buffer is at the start}
    FInTextStream.Position := 0;
    while not FInTextStream.AtEndOfStream do begin
      TmpStr := FInTextStream.ReadLine;
      Inc(BRead, Length(TmpStr) + Length(FInTextStream.LineTermChar));
      if (FInFileSize > 0) then begin
        PC := Round((BRead / FInFileSize * 100));
        if (Assigned(FOnProgress)) then
          FOnProgress(Self, PC);
      end;

      {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
      if (TmpStr = '') then begin
        if (CommentPend) then
          FOutTextStream.WriteLine(EStr)
        else
          FOutTextStream.WriteLine(' ');
        continue;
      end;

      if (CommentPend) then
        S := SStr
      else
        S := '';

      P1 := 1;
      repeat
        if (not CommentPend) and (CommentDict.Exists(TmpStr[P1], P)) then begin
          VS := ShortString(P^);
          if (Copy(VS, 1 , 2) = ':1') then begin
            while (Copy(VS, 1 , 2) = ':1') do begin
              System.Delete(VS, 1, 2);
              if (TmpStr[P1+1] = VS[1]) then begin
                System.Delete(VS, 1, 2);
                CloseStr := Copy(VS, 1, pos(';', VS)-1);
                System.Delete(VS, 1, pos(';', VS));
                SStr := Copy(VS, 1, pos(';', VS)-1);
                System.Delete(VS, 1, pos(';', VS));
                J := pos(':1', VS);
                if (J = 0) then
                  EStr := Copy(VS, pos(';', VS)+1, Length(VS))
                else begin
                  EStr := Copy(VS, 1, J-1);
                  System.Delete(VS, 1, J+2);
                end;

                if (CloseStr = '') then begin
                  S := S + SStr;
                  AStr := Copy(TmpStr, P1, Length(TmpStr));
                  CheckSubString(AStr);
                  S := S + EStr;
                  CloseStr := '';
                  SStr := '';
                  EStr := '';
                  TmpStr := '';
                  continue;
                end else begin
                  I := pos(CloseStr, TmpStr);
                  if (I = 0) then begin
                    CommentPend := True;
                    S := SStr + S;
                  end else begin
                    S := S + SStr;
                    AStr := Copy(TmpStr, P1, I-P1+Length(CloseStr));
                    CheckSubstring(AStr);
                    S := S + EStr;
                    System.Delete(TmpStr, P1, I-P1+Length(CloseStr));
                  end;
                end;
              end else begin
                J := pos(':1', VS);
                if (J > 0) then
                  System.Delete(VS, 1, J-1);
              end;
            end;
          end else begin
            {is it really the beginning of a comment?}
            CloseStr := Copy(VS, 1, pos(';', VS)-1);
            System.Delete(VS, 1, pos(';', VS));
            SStr := Copy(VS, 1, pos(';', VS)-1);
            EStr := Copy(VS, pos(';', VS)+1, Length(VS));
            I := pos(CloseStr, TmpStr);
            if (I > 0) and (I > P1) then begin
              {ending marker found}
              CommentPend := False;
              S := S + SStr;
              AStr := Copy(TmpStr, P1, I-P1+Length(CloseStr));
              CheckSubstring(AStr);
              S := S + EStr;
              System.Delete(TmpStr, P1, I-P1+Length(CloseStr));
              P1 := 1;
              CloseStr := '';
              SStr := '';
              EStr := '';
              if (TmpStr = '') then
                continue;
            end else begin  {1}
              CommentPend := True;
              S := S + SStr;
              if (Length(TmpStr) > 1) then begin
                AStr := Copy(TmpStr, P1, Length(TmpStr));
                CheckSubstring(AStr);
              end else
                S := S + TmpStr;
              S := S + EStr;
              TmpStr := '';
              continue;
            end;
          end;
        end;

        if (CommentPend) then begin
          I := pos(CloseStr, TmpStr);
          if (I < 1) then begin
            AStr := Copy(TmpStr, P1, Length(TmpStr));
            CheckSubstring(AStr);
            S := S + EStr;
            TmpStr := '';
            continue;
          end else begin {2}
            CommentPend := False;
            if (Length(TmpStr) > 1) then begin
              AStr := Copy(TmpStr, P1, I-P1+Length(CloseStr));
              CheckSubstring(AStr);
            end else
              S := S + TmpStr;
            S := S + EStr;
            System.Delete(TmpStr, P1, I-P1+Length(CloseStr));
            CloseStr := '';
            SStr := '';
            EStr := '';
            if (TmpStr = '') then
              continue
            else
              P1 := 1;
          end;
        end else begin
          CloseStr := '';
          SStr := '';
          EStr := '';
        end;

        if (TmpStr = '') then
          continue;

        P := nil;
        while (pos(TmpStr[P1], FWordDelims) = 0) and
              (not StringDict.Exists(TmpStr[P1], P)) and
              (P1 <= Length(TmpStr)) do
          Inc(P1);
        if (Assigned(P)) then begin
          P2 := P1+1;
          VS := ShortString(P^);
          CloseStr := Copy(VS, 1, pos(';', VS)-1);
          System.Delete(VS, 1, pos(';', VS));
          SStr := Copy(VS, 1, pos(';', VS)-1);
          System.Delete(VS, 1, pos(';', VS));
          EStr := Copy(VS, pos(';', VS)+1, Length(VS));

          while (TmpStr[P2] <> CloseStr) and (P2 <= Length(TmpStr)) do
            Inc(P2);
          S := S + SStr;
          AStr := Copy(TmpStr, P1, P2-P1+1);
          CheckSubString(AStr);
          S := S + EStr;

          System.Delete(TmpStr, P1, P2);
          if (TmpStr = '') then
            continue
          else
            P1 := 1;
          P := nil;
        end else if (pos(TmpStr[P1],  FWordDelims) > 0) then begin
          if (P1 = 1) then begin
            S := S + ConvertEmbeddedHTML(TmpStr[1]);
            System.Delete(TmpStr, 1, 1);
            P1 := 1;
          end else begin
            AStr := Copy(TmpStr, 1, P1-1);
            if (Length(AStr) > 0) then
              CheckSubstring(AStr);
            System.Delete(TmpStr, 1, P1);
            P1 := 1;
          end;
        end else begin
          AStr := TmpStr;
          CheckSubString(AStr);
          TmpStr := '';
        end;
      until (Length(TmpStr) = 0);
      FOutTextStream.WriteLine(S);
    end;
    if (Assigned(FOnProgress)) then
      FOnProgress(Self, 0);

    Result := True;
    FOutTextStream.WriteLine('</pre>');
    if (FPageFooter.Count > 0) then begin
      for I := 0 to pred(FPageFooter.Count) do
        FOutTextStream.WriteLine(FPageFooter[I]);
    end;
  finally
    CommentDict.Free;
    HTMLDict.Free;
    KeywordsDict.Free;
    StringDict.Free;

    FInTextStream.Free;
    FInTextStream := nil;

    FOutTextStream.Free;
    FOutTextStream := nil;
  end;
end;


procedure TStStreamToHTML.SetCommentMarkers(Value : TStringList);
begin
  FCommentMarkers.Assign(Value);
end;


procedure TStStreamToHTML.SetEmbeddedHTML(Value : TStringList);
begin
  FEmbeddedHTML.Assign(Value);
end;


procedure TStStreamToHTML.SetKeywords(Value : TStringList);
begin
  FKeywords.Assign(Value);
end;


procedure TStStreamToHTML.SetPageFooter(Value : TStringList);
begin
  FPageFooter.Assign(Value);
end;


procedure TStStreamToHTML.SetPageHeader(Value : TStringList);
begin
  FPageHeader.Assign(Value);
end;


procedure TStStreamToHTML.SetStringMarkers(Value : TStringList);
begin
  FStringMarkers.Assign(Value);
end;



(*****************************************************************************)
(*                         TStFileToHTML Implementation                      *)
(*****************************************************************************)


constructor TStFileToHTML.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FCommentMarkers := TStringList.Create;
  FEmbeddedHTML   := TStringList.Create;
  FKeywords       := TStringList.Create;
  FPageFooter     := TStringList.Create;
  FPageHeader     := TStringList.Create;
  FStringMarkers  := TStringList.Create;

  FWordDelims := ',; .()';

  FInLineTerminator := ltCRLF;
  FInLineTermChar   := #10;
  FInLineLength     := 80;

  with FEmbeddedHTML do begin
    Add('"=&quot;');
    Add('&=&amp;');
    Add('<=&lt;');
    Add('>=&gt;');
    Add('�=&iexcl;');
    Add('�=&cent;');
    Add('�=&pound;');
    Add('�=&copy;');
    Add('�=&reg;');
    Add('�=&plusmn;');
    Add('�=&frac14;');
    Add('�=&frac12;');
    Add('�=&frac34;');
    Add('�=&divide;');
  end;
end;


destructor TStFileToHTML.Destroy;
begin
  FCommentMarkers.Free;
  FCommentMarkers := nil;

  FEmbeddedHTML.Free;
  FEmbeddedHTML := nil;

  FKeywords.Free;
  FKeywords := nil;

  FPageFooter.Free;
  FPageFooter := nil;

  FPageHeader.Free;
  FPageHeader := nil;

  FStringMarkers.Free;
  FStringMarkers := nil;

  FInFile.Free;
  FInFile := nil;

  FOutFile.Free;
  FOutFile := nil;

  FStream.Free;
  FStream := nil;

  inherited Destroy;
end;


procedure TStFileToHTML.Execute;
begin
  FStream := TStStreamToHTML.Create;
  try
    if (FInFileName = '') then
      RaiseStError(EStToHTMLError, stscNoInputFile)
    else if (FOutFileName = '') then
      RaiseStError(EStToHTMLError, stscNoOutputFile)
    else begin
      if (Assigned(FInFile)) then
        FInFile.Free;
      try
        FInFile := TFileStream.Create(FInFileName, fmOpenRead or fmShareDenyWrite);
      except
        RaiseStError(EStToHTMLError, stscInFileError);
        Exit;
      end;

      if (Assigned(FOutFile)) then
        FOutFile.Free;
      try
        FOutFile := TFileStream.Create(FOutFileName, fmCreate);
      except
        RaiseStError(EStToHTMLError, stscOutFileError);
        Exit;
      end;

      try
        FStream.InputStream       := FInFile;
        FStream.OutputStream      := FOutFile;
        FStream.CaseSensitive     := CaseSensitive;
        FStream.CommentMarkers    := CommentMarkers;
        FStream.EmbeddedHTML      := EmbeddedHTML;
        FStream.InFixedLineLength := InFixedLineLength;
        FStream.InLineTermChar    := InLineTermChar;
        FStream.InLineTerminator  := InLineTerminator;
        FStream.Keywords          := Keywords;
        FStream.OnProgress        := OnProgress;
        FStream.PageFooter        := PageFooter;
        FStream.PageHeader        := PageHeader;
        FStream.StringMarkers     := StringMarkers;
        FStream.WordDelimiters    := WordDelimiters;

        FStream.GenerateHTML;
      finally
        FInFile.Free;
        FInFile := nil;
        FOutFile.Free;
        FOutFile := nil;
      end;
    end;
  finally
    FStream.Free;
    FStream := nil;
  end;
end;


procedure TStFileToHTML.SetCommentMarkers(Value : TStringList);
begin
  FCommentMarkers.Assign(Value);
end;


procedure TStFileToHTML.SetEmbeddedHTML(Value : TStringList);
begin
  FEmbeddedHTML.Assign(Value);
end;



procedure TStFileToHTML.SetKeywords(Value : TStringList);
begin
  FKeywords.Assign(Value);
end;


procedure TStFileToHTML.SetPageFooter(Value : TStringList);
begin
  FPageFooter.Assign(Value);
end;


procedure TStFileToHTML.SetPageHeader(Value : TStringList);
begin
  FPageHeader.Assign(Value);
end;


procedure TStFileToHTML.SetStringMarkers(Value : TStringList);
begin
  FStringMarkers.Assign(Value);
end;


end.
