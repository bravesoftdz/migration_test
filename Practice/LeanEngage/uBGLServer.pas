unit uBGLServer;

interface

uses
  Classes, SysUtils, uLKJSON, IdCoder, IdCoderMIME, StrUtils, uHttplib,
  uBaseRESTServer, ipshttps, Contnrs, Files;

const
  ENDPOINT_BGI360_Authorise  = '/oauth/authorize?response_type=code&client_id=%s&scope=%s';
  ENDPOINT_BGI360_Auth_Token = '/oauth/token?grant_type=authorization_code&code=%s&scope=fundList';
  ENDPOINT_BGI360_Refresh_Token = '/oauth/token?grant_type=refresh_token&refresh_token=%s&client_id=%s&scope=fundList';
  ENDPOINT_BGI360_Fund_List = '/fund/list';
  ENDPOINT_BGI360_Chart_Of_Accounts = 'fund/chartAccounts?fundId=%s';

type
  TBaseList_Obj = class(TJsonObject)
  private
    fItems: TObjectList;

    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property Count: Integer read GetCount;
  end;

  TAuth_TokenObj = class(TJsonObject)
  private
    fAccess_token,
    fToken_type,
    fRefresh_token,
    fExpires_in,
    fScope : string;
    fWill_Expire_At: TDateTime;
  public
    constructor Create; virtual;
    procedure Deserialize(Json: String); override;
    function Serialize: String; override;
    function SaveTokens: Boolean;

    property Access_token : string read fAccess_token;
    property Token_type : string read fToken_type;
    property Refresh_token : string read fRefresh_token;
    property Expires_in : string read fExpires_in;
    property Scope : string read fScope;
    property Will_Expire_At: TDateTime read fWill_Expire_At;
  end;

  TChart_AccountTypeObj = class
  private
    fTypeLabel   : string;
    fMinCode : string;
    fMaxCode : string;
    fName    : string;
  public
    property TypeLabel   : string read fTypeLabel;
    property MinCode : string read fMinCode;
    property MaxCode : string read fMaxCode;
    property Name    : string read fName;
  end;

  TChart_AccountObj = class
  private
    fCode             : string;
    fName             : string;
    fAccountClass     : string;
    fSecurityId       : string;
    fSecurityCode     : string;
    fMarketType       : string;
    fChartAccountType : TChart_AccountTypeObj;
  public
    property Code             : string read fCode;
    property Name             : string read fName;
    property AccountClass     : string read fAccountClass;
    property SecurityId       : string read fSecurityId;
    property SecurityCode     : string read fSecurityCode;
    property MarketType       : string read fMarketType;
    property ChartAccountType : TChart_AccountTypeObj read fChartAccountType;
  end;

  TChart_Of_Accounts_Obj = class(TBaseList_Obj)
  private
    function GetItems(Index: Integer): TChart_AccountObj;
  public
    procedure Deserialize(Json: String); override;
    function Serialize: String; override;

    property Items[Index: Integer]: TChart_AccountObj read GetItems; default;
  end;

  TFundObj = class
  private
    fFundID    : string;
    fFundCode  : string;
    fFundName  : string;
    fABN       : string;
    fFirmName  : string;
    fFirm      : string;
    fFundEmail : string;
  public

    property FundID    : string read fFundID;
    property FundCode  : string read fFundCode;
    property FundName  : string read fFundName;
    property ABN       : string read fABN;
    property FirmName  : string read fFirmName;
    property Firm      : string read fFirm;
    property FundEmail : string read fFundEmail;
  end;


  TFundList_Obj = class(TBaseList_Obj)
  private
    function GetItems(Index: Integer): TFundObj;
  public
    procedure Deserialize(Json: String); override;
    function Serialize: String; override;

    property Items[Index: Integer]: TFundObj read GetItems; default;
  end;

  TBGLServer = class(TBaseRESTServer)
  private
    fAuthenticationKey: String;
    fAuthenticationPassword: String;
    fAuth_Code             : string;

    fFeedbackURL: string;
    fHasFeedbackURL : boolean;
    fSynchroniseLogMessage : string;
    fOwner : TThread;

    fAuth_TokenObj : TAuth_TokenObj;
    fFundList_Obj  : TFundList_Obj;
    fChart_Of_Accounts_Obj : TChart_Of_Accounts_Obj;
  protected
    procedure AddAuthHeaders( AuthScheme: TAuthSchemes; Http: TipsHTTPS ); override;
    procedure AddHeaders( Http: TipsHTTPS ); override;
    procedure AddOAuthAuthenticationHeader( Http: TipsHTTPS );
    procedure AddBasicAuthenticationHeader( Http: TipsHTTPS );


    function GetAuthorization : string;
    procedure SetAuthorization( Value : string );
  public
  // Creates the BGL Communication Object
  // OAuth:
  //   aAuthenticationKey = Client_ID
  //   aAuthenticationPassword = Client_Secret
  //     e.g.
  //       Client_ID = 'bankLinkTest';
  //       Client_Secret = 'bankLinkSecret';
    constructor Create(aOwner : TThread; aAuthenticationKey,
                  aAuthenticationPassword, aServerBaseUrl: String); reintroduce;
    destructor Destroy; override;

  // Logging
    procedure SetAndSynchroniseLogMessage( aLogMessage : string );
    procedure SynchroniseLogMessage;

  // Authentication
    procedure Set_Auth_Tokens( aAccess_token : string; aToken_type : string;
      aRefresh_token : string; aWill_Expire_At: TDateTime );

    function CheckForAuthentication : boolean;

    function Get_Auth_Code : boolean;
    function Get_Auth_Tokens : boolean;
    function Get_Refresh_Tokens : boolean;

  // API Function calls
    function Get_FundList: boolean;
    function Get_Chart_Of_Accounts( aFundID : string ) : boolean;

    property AuthenticationKey : string read fAuthenticationKey;
    property AuthenticationPassword : string read fAuthenticationPassword;
    property Auth_Code              : string read fAuth_Code write fAuth_Code;
    property Authorization          : string read GetAuthorization write SetAuthorization;
    property Auth_Token             : TAuth_TokenObj read fAuth_TokenObj;

    property FundList : TFundList_Obj read fFundList_Obj;
    property Chart_Of_Accounts : TChart_Of_Accounts_Obj read fChart_Of_Accounts_Obj;
  end;

implementation
uses
  LogUtil,
  formWebHost,
  Variants,
  DateUtils,
  Globals;

const
  unitname = 'uNPSServer';
  DebugAutoSave: Boolean = False;
  AutoSaveUnit = 'AutoSave';

var
  DebugMe : boolean = false;

type
  TJSONStringList = class(TlkJSONobject)
  public
    procedure Assign(List: TStrings);
  end;

{ TNPSServer }

procedure TBGLServer.AddBasicAuthenticationHeader( Http: TipsHTTPS );
begin
  Authorization := 'Basic ' + Base64Encode(fAuthenticationKey + ':' +
                                fAuthenticationPassword)
end;

procedure TBGLServer.AddOAuthAuthenticationHeader(Http: TipsHTTPS);
var
  TempS : string;
begin
  Authorization := format( '%s %s',
                     [ fAuth_TokenObj.fToken_type, fAuth_TokenObj.fAccess_token]);
end;

procedure TBGLServer.AddHeaders(Http: TipsHTTPS);
begin
  inherited;
end;

procedure TBGLServer.AddAuthHeaders(AuthScheme: TAuthSchemes; Http: TipsHTTPS );
begin
  if AuthScheme = asBasic then
    AddBasicAuthenticationHeader( Http )
  else
    AddOAuthAuthenticationHeader( Http );
end;

function TBGLServer.CheckForAuthentication: boolean;
begin
  result :=
    ( trim( Auth_Token.Access_token ) <> '' ) and
    ( trim( Auth_Token.Token_type ) <> '' ) and
    ( trim( Auth_Token.Refresh_token ) <> '' ) and
    ( Now < Auth_Token.fWill_Expire_At );

  if not result then begin
    result := {Check if there was ever, a Token}
      ( trim( Auth_Token.Access_token ) <> '' ) and
      ( trim( Auth_Token.Token_type ) <> '' ) and
      ( trim( Auth_Token.Refresh_token ) <> '' );

    if not result then begin      // If there has never been a token
      result := Get_Auth_Code;    // Need to Authorise, and retrieve Auth_Code
      if result then
        result := Get_Auth_Tokens; // Now we can ask for the Tokens
        if not result then
          exit;
    end
    else
    begin // There has been a token previously, let's try and refresh
      result := Get_Refresh_Tokens; // Try and refresh the tokens
      if not result then begin // something went wrong, let's try and re-authorise
        freeAndNil(fAuth_TokenObj);               // Destroy so that we can clear in the recreate
        fAuth_TokenObj := TAuth_TokenObj.Create;  // Recreate the Auth Tokens;
        result := CheckForAuthentication;         // Call this routine recursively
      end;
    end;
  end;
end;

constructor TBGLServer.Create(aOwner : TThread; aAuthenticationKey,
              aAuthenticationPassword, aServerBaseUrl: String);
begin
  inherited Create;
  fAuth_TokenObj   := TAuth_TokenObj.Create;
  fFundList_Obj    := TFundList_Obj.Create;
  fChart_Of_Accounts_Obj := TChart_Of_Accounts_Obj.Create;


  Header [ 'Content-Type' ] := 'application/x-www-form-urlencoded';
  Header [ 'Accept' ] := 'application/json';


  fAuthenticationKey := aAuthenticationKey;
  fAuthenticationPassword := aAuthenticationPassword;
  fServerBaseUrl  := aServerBaseUrl;
  fHasFeedbackURL := false;

  fOwner := aOwner;
end;

destructor TBGLServer.Destroy;
begin
  freeAndNil( fChart_Of_Accounts_Obj );
  freeAndNil( fFundList_Obj );
  freeAndNil( fAuth_TokenObj );

  inherited;
end;

const
  cAuth = 'Authorization';

function TBGLServer.GetAuthorization: string;
begin
  if assigned( fHeaders ) then
    result := fHeaders.Values[ cAuth ];
end;

procedure TBGLServer.SetAuthorization(Value: string);
begin
  if assigned( fHeaders ) then
    fHeaders.Values[ cAuth ] := Value;
end;

function TBGLServer.Get_Auth_Code: boolean;
const
  cURLLeader = '/oauth/authCode?code=';
  cScope     = 'fundList';
var
  lUrl : string;
begin
  result := false;
  fAuth_Code := '';
  lUrl := TfrmWebHost.GetRedirectedURL( nil,
            format(fServerBaseUrl + ENDPOINT_BGI360_Authorise,
              [ fAuthenticationKey, cScope ] ), cURLLeader, true );
  if pos( cURLLeader, lURL ) <> 0 then begin
    fAuth_Code := copy(lURL, pos( cURLLeader, lURL ) + length( cURLLeader ),
                    length( lURL ));
    result := true;
  end;

end;

function TBGLServer.Get_Auth_Tokens: boolean;
begin
  result:= true;
  try
    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code] ) );

    Post( asBasic, format( ENDPOINT_BGI360_Auth_Token, [ Auth_Code ]), nil,
      fAuth_TokenObj );
      

    result := fAuth_TokenObj.SaveTokens;

    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code ] ) );

  except
    result := false
  end;
end;

function TBGLServer.Get_Chart_Of_Accounts( aFundID : string ) : boolean;
begin
  result:= true;
  try
    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code] ) );

    Post( asOAuth, format( ENDPOINT_BGI360_Chart_Of_Accounts, [ aFundID ] ),
      nil, fChart_Of_Accounts_Obj );

    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code ] ) );

  except
    result := false
  end;

end;

function TBGLServer.Get_FundList: boolean;
begin
  result := true;
  try
    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code] ) );

    Post( asOAuth, ENDPOINT_BGI360_Fund_List, nil, fFundList_Obj );

    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code ] ) );
  except
    result := false;
  end;
end;

function TBGLServer.Get_Refresh_Tokens: boolean;
begin
  result:= true;
  try
    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code] ) );

    Post( asOAuth, format( ENDPOINT_BGI360_Refresh_Token,
      [ fAuth_TokenObj.fRefresh_token, fAuthenticationKey ]), nil,
      fAuth_TokenObj );

    result := fAuth_TokenObj.SaveTokens;

    if DebugMe then
      SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
        [ Auth_Code ] ) );

  except
    result := false;
  end;
end;

procedure TBGLServer.SetAndSynchroniseLogMessage(aLogMessage: string);
begin
  if DebugMe then begin
    fSynchroniseLogMessage := aLogMessage;
    if assigned( fOwner ) then
      fOwner.Synchronize( fOwner, SynchroniseLogMessage );
  end;
end;

procedure TBGLServer.Set_Auth_Tokens( aAccess_token: string;
            aToken_type: string; aRefresh_token: string;
            aWill_Expire_At: TDateTime);
begin
  fAuth_TokenObj.fAccess_token   := aAccess_token;
  fAuth_TokenObj.fToken_type     := aToken_type;
  fAuth_TokenObj.fRefresh_token  := aRefresh_token;

  fAuth_TokenObj.fWill_Expire_At := aWill_Expire_At;

  fAuth_TokenObj.fExpires_in    := intToStr( SecondsBetween( aWill_Expire_At, Now ) );
end;

procedure TBGLServer.SynchroniseLogMessage;
begin
  if DebugMe then
    LogUtil.LogMsg(lmDebug, unitname, fSynchroniseLogMessage );
end;

{ TJSONStrings }

procedure TJSONStringList.Assign(List: TStrings);
var
  Index: Integer;
begin
  for Index := 0 to pred( List.Count ) do
  begin
    Self.Add(List.Names[Index], List.ValueFromIndex[Index]);
  end;
end;

{ TBaseList_Obj }

constructor TBaseList_Obj.Create;
begin
  FItems := TObjectList.Create(True);

end;

destructor TBaseList_Obj.Destroy;
begin
  FreeAndNil( FItems );

  inherited;
end;

function TBaseList_Obj.GetCount: Integer;
begin
  Result := FItems.Count;
end;


{ TAuth_Tokens }

constructor TAuth_TokenObj.Create;
begin
  inherited;
// Pre-Initialise the fields
  fAccess_Token   := '';
  fToken_type     := '';
  fRefresh_token  := '';
  fExpires_in     := '';
  fScope          := '';

  fWill_Expire_At :=  0;
end;

procedure TAuth_TokenObj.Deserialize(Json: String);
var
  JsonObject: TlkJSONbase;
begin
  JsonObject := TlkJSON.ParseText(Json);

  if (JsonObject = nil) then
  begin
    Exit;
  end;

  try
    fAccess_Token  := JsonObject.Field['access_token'].Value;
    fToken_type    := JsonObject.Field['token_type'].Value;
    fRefresh_token := JsonObject.Field['refresh_token'].Value;
    fExpires_in    := JsonObject.Field['expires_in'].Value;
    fScope         := JsonObject.Field['scope'].Value;

// Calculate when this token will expire//
    fWill_Expire_At := Now + ( OneSecond * strToInt( fExpires_In ) )
  finally
    JsonObject.Free;
  end;
end;

function TAuth_TokenObj.SaveTokens: Boolean;
begin
  // Save tokens to client file.
  if Assigned( MyClient ) then
  begin
    MyClient.clExtra.ceBGLAccessToken := fAccess_token;
    MyClient.clExtra.ceBGLRefreshToken := fRefresh_token;
    MyClient.clExtra.ceBGLTokenType := fToken_type;
    MyClient.clExtra.ceBGLTokenExpiresAt := fWill_Expire_At;
    SaveClient(false);
  end;
end;

function TAuth_TokenObj.Serialize: String;
begin

end;


{ TChartList_Obj }

procedure TChart_Of_Accounts_Obj.Deserialize(Json: String);
var
  JsonObject: TlkJSONbase;
  ChartOfAccountsList: TlkJSONlist;
  ChartAccount: TlkJSONobject;
  AccountType: TlkJSONobject;
  Account : TChart_AccountObj;
  Index: Integer;
  Temp : string;
  OldNullStrictConvert: boolean;
begin
  FItems.Clear;

  JsonObject := TlkJSON.ParseText(Json);

  if (JsonObject = nil) then
  begin
    Exit;
  end;

  try
    if not assigned( JsonObject.Field['chartAccounts'] ) then
      exit;

    if not (JsonObject.Field['chartAccounts'] is TlkJSONlist) then
    begin
      Exit;
    end;

    ChartOfAccountsList :=  JsonObject.Field['chartAccounts'] as TlkJSONlist;

    OldNullStrictConvert := NullStrictConvert;
    NullStrictConvert := false;
    try
      for Index := 0 to pred( ChartOfAccountsList.Count ) do
      begin
        if ( ChartOfAccountsList.Child[Index] is TlkJSONobject ) then begin
          ChartAccount := ChartOfAccountsList.Child[Index] as TlkJSONobject;
          Account := TChart_AccountObj.Create;
          try
            Account.fcode             := ChartAccount[ 'code' ].Value;
            Account.fname             := ChartAccount[ 'name' ].Value;
            Account.faccountClass     := ChartAccount[ 'accountClass' ].Value;
            Account.fsecurityId       := ChartAccount[ 'securityId' ].Value;
            Account.fsecurityCode     := ChartAccount[ 'securityCode' ].Value;
            Account.fmarketType       := ChartAccount[ 'marketType' ].Value;

            if assigned( ChartAccount[ 'chartAccountType' ] ) then
              if ( ChartAccount[ 'chartAccountType' ] is TlkJSONobject ) then begin

                AccountType := ChartAccount[ 'chartAccountType' ] as TlkJSONobject;
                Account.fchartAccountType := TChart_AccountTypeObj.Create;
                try
                  Account.chartAccountType.fTypeLabel := AccountType['label'].Value;
                  Account.chartAccountType.fMinCode   := AccountType['minCode'].Value;
                  Account.chartAccountType.fMaxCode   := AccountType['maxCode'].Value;
                  Account.chartAccountType.fName      := AccountType['name'].Value;
                except
                  freeAndNil( Account.fchartAccountType );
                end;

              end;
            FItems.Add( Account );
          except
            FreeAndNil( Account );
          end;
        end;

      end;
    finally
      NullStrictConvert := OldNullStrictConvert;
    end;
  finally
    JsonObject.Free;
  end;
end;

function TChart_Of_Accounts_Obj.GetItems(Index: Integer): TChart_AccountObj;
begin
  Result := FItems[Index] as TChart_AccountObj;
end;

function TChart_Of_Accounts_Obj.Serialize: String;
begin

end;

{ TFundList_Obj }


procedure TFundList_Obj.Deserialize(Json: String);
var
  JsonObject: TlkJSONbase;
  FundList: TlkJSONlist;
  jFund: TlkJSONObject;
  Fund    : TFundObj;
  Index: Integer;
  Temp : string;
begin
  FItems.Clear;

  JsonObject := TlkJSON.ParseText(Json);

  if (JsonObject = nil) then
  begin
    Exit;
  end;

  try
    if not assigned( JsonObject.Field['funds'] ) then
      exit;

    if not (JsonObject.Field['funds'] is TlkJSONlist) then
    begin
      Exit;
    end;

    FundList :=  JsonObject.Field['funds'] as TlkJSONlist;

    for Index := 0 to pred( FundList.Count ) do
    begin
      if ( FundList.Child[Index] is TlkJSONobject ) then begin
        jFund := FundList.Child[Index] as TlkJSONobject;
        Fund    := TFundObj.Create;
        try
          Fund.fFundID    := jFund['fundID'].Value;
          Fund.fFundCode  := jFund['fundCode'].Value;
          Fund.fFundName  := jFund['fundName'].Value;
          Fund.fABN       := jFund['ABN'].Value;
          Fund.fFirmName  := jFund['firmName'].Value;
          Fund.fFirm      := jFund['firm'].Value;
          Fund.fFundEmail := jFund['fundEmail'].Value;

          FItems.Add( Fund );
        except
          FreeAndNil( Fund );
        end;
      end;

    end;
  finally
    JsonObject.Free;
  end;
end;

function TFundList_Obj.GetItems(Index: Integer): TFundObj;
begin
  Result := FItems[Index] as TFundObj;
end;

function TFundList_Obj.Serialize: String;
begin

end;

initialization
   DebugMe := DebugUnit(UnitName);
   DebugAutoSave := DebugUnit(AutoSaveUnit);
end.