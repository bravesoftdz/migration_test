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
    fcode             : string;
    fname             : string;
    faccountClass     : string;
    fsecurityId       : string;
    fsecurityCode     : string;
    fmarketType       : string;
    fchartAccountType : TChart_AccountTypeObj;
  public
    property code             : string read fcode;
    property name             : string read fname;
    property accountClass     : string read faccountClass;
    property securityId       : string read fsecurityId;
    property securityCode     : string read fsecurityCode;
    property marketType       : string read fmarketType;
    property chartAccountType : TChart_AccountTypeObj read fchartAccountType;

  end;

  TChar_Of_Accounts_Obj = class(TBaseList_Obj)
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
    fChar_Of_Accounts_Obj : TChar_Of_Accounts_Obj;
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

    procedure SetAndSynchroniseLogMessage( aLogMessage : string );
    procedure SynchroniseLogMessage;

    function Get_Auth_Code : boolean;
    function Get_Auth_Tokens : boolean;
    function Get_Refresh_Tokens : boolean;

    function Get_FundList: boolean;
    function Get_Chart_Of_Accounts( aFundID : string ) : boolean;
    procedure Set_Auth_Tokens( Access_token : string; Token_type : string;
      Refresh_token : string; Expires_in : string; Scope : string );
(*    procedure SetNPSIdentity(Identity: TJsonObject);
    procedure GetNPSSurvey(UserId: String; Survey: TJsonObject);
    procedure setEventTrack( UserId: string; MessageContent : TJsonObject);
    procedure setFeedBackResponse(UserId : string; MessageContent : TJsonObject; Feedback : TFeedbackJSON); *)

    property AuthenticationKey : string read fAuthenticationKey;
    property AuthenticationPassword : string read fAuthenticationPassword;
    property Auth_Code              : string read fAuth_Code write fAuth_Code;
    property Authorization          : string read GetAuthorization write SetAuthorization;
    property Auth_Token             : TAuth_TokenObj read fAuth_TokenObj;

    property FundList : TFundList_Obj read fFundList_Obj;
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

constructor TBGLServer.Create(aOwner : TThread; aAuthenticationKey,
              aAuthenticationPassword, aServerBaseUrl: String);
begin
  inherited Create;
  fAuth_TokenObj   := TAuth_TokenObj.Create;
  fFundList_Obj    := TFundList_Obj.Create;
  fChar_Of_Accounts_Obj := TChar_Of_Accounts_Obj.Create;


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
  freeAndNil( fChar_Of_Accounts_Obj );
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
  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code] ) );

  Post( asBasic, format( ENDPOINT_BGI360_Auth_Token, [ Auth_Code ]), nil,
    fAuth_TokenObj );

  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code ] ) );

end;

function TBGLServer.Get_Chart_Of_Accounts( aFundID : string ) : boolean;
begin
  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code] ) );

  Post( asOAuth, format( ENDPOINT_BGI360_Chart_Of_Accounts, [ aFundID ] ),
    nil, fChar_Of_Accounts_Obj );

  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code ] ) );

end;

function TBGLServer.Get_FundList: boolean;
begin
  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code] ) );

  Post( asOAuth, ENDPOINT_BGI360_Fund_List, nil, fFundList_Obj );

  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code ] ) );
end;

function TBGLServer.Get_Refresh_Tokens: boolean;
begin
  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'Before Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code] ) );

  Post( asOAuth, format( ENDPOINT_BGI360_Refresh_Token,
    [ fAuth_TokenObj.fRefresh_token, fAuthenticationKey ]), nil,
    fAuth_TokenObj );

  if DebugMe then
    SetAndSynchroniseLogMessage( format( 'After Http Post in TBGLServer.Get_Auth_Tokens(Auth_Code= %s) )',
      [ Auth_Code ] ) );

end;

procedure TBGLServer.SetAndSynchroniseLogMessage(aLogMessage: string);
begin
  if DebugMe then begin
    fSynchroniseLogMessage := aLogMessage;
    if assigned( fOwner ) then
      fOwner.Synchronize( fOwner, SynchroniseLogMessage );
  end;
end;

procedure TBGLServer.Set_Auth_Tokens(Access_token, Token_type, Refresh_token,
  Expires_in, Scope: string);
begin
  fAuth_TokenObj.fAccess_token  := Access_token;
  fAuth_TokenObj.fToken_type    := Token_type;
  fAuth_TokenObj.fRefresh_token := Refresh_token;
  fAuth_TokenObj.fExpires_in    := Expires_in;
  fAuth_TokenObj.fScope         := Scope;
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
  for Index := 0 to List.Count - 1 do
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

procedure TAuth_TokenObj.Deserialize(Json: String);
var
  JsonObject: TlkJSONbase;
//  Authentication: TlkJSONobject;
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
    //fWill_Expire_At
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

procedure TChar_Of_Accounts_Obj.Deserialize(Json: String);
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
      for Index := 0 to ChartOfAccountsList.Count - 1 do
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

function TChar_Of_Accounts_Obj.GetItems(Index: Integer): TChart_AccountObj;
begin
  Result := FItems[Index] as TChart_AccountObj;
end;

function TChar_Of_Accounts_Obj.Serialize: String;
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

    for Index := 0 to FundList.Count - 1 do
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
