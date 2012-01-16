// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://banklinkonline.com/Services/BlopiServiceFacade.svc?wsdl
//  >Import : https://banklinkonline.com/Services/BlopiServiceFacade.svc?wsdl=wsdl0
//  >Import : https://banklinkonline.com/Services/BlopiServiceFacade.svc?wsdl=wsdl0>0
//  >Import : https://banklinkonline.com/Services/BlopiServiceFacade.svc?xsd=xsd0
//  >Import : https://banklinkonline.com/Services/BlopiServiceFacade.svc?xsd=xsd2
//  >Import : https://banklinkonline.com/Services/BlopiServiceFacade.svc?xsd=xsd1
//  >Import : https://banklinkonline.com/Services/BlopiServiceFacade.svc?xsd=xsd3
// Encoding : utf-8
// Codegen  : [wfMapStringsToWideStrings+, wfUseScopedEnumeration-]
// Version  : 1.0
// (17/01/2012 9:36:17 a.m. - - $Rev: 25127 $)
// ************************************************************************ //

unit BlopiServiceFacade;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  MessageResponse      = class;                 { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  MessageResponseOfArrayOfCatalogueEntryMIdCYrSK = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  ServiceErrorMessage  = class;                 { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  ExceptionDetails     = class;                 { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  MessageResponseOfPracticeDetailMIdCYrSK = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  MessageResponseOfguid = class;                { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  MessageResponseOfClientListMIdCYrSK = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  MessageResponseOfClientDetailMIdCYrSK = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  MessageResponseOfArrayOfCatalogueEntryMIdCYrSK2 = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  MessageResponse2     = class;                 { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  ServiceErrorMessage2 = class;                 { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  ExceptionDetails2    = class;                 { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  MessageResponseOfPracticeDetailMIdCYrSK2 = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  MessageResponseOfguid2 = class;               { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  MessageResponseOfClientListMIdCYrSK2 = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  MessageResponseOfClientDetailMIdCYrSK2 = class;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblElm] }
  CatalogueEntry       = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  Practice             = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  PracticeDetail       = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  Role                 = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  User                 = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  UserDetail           = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  UserPracticeNew      = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  UserPractice         = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ClientList           = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  Client               = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ClientSummary        = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ClientDetail         = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ClientNew            = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ClientUpdate         = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  CatalogueEntry2      = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  PracticeDetail2      = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  Practice2            = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  Role2                = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  UserDetail2          = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  User2                = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  UserPracticeNew2     = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  UserPractice2        = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  ClientList2          = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  ClientSummary2       = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  Client2              = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  ClientDetail2        = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  ClientNew2           = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }
  ClientUpdate2        = class;                 { "http://www.banklinkonline.com/2011/11/Blopi"[GblElm] }

  { "http://www.banklinkonline.com/2011/11/Blopi"[GblSmpl] }
  Status = (Active, Suspended, Deactivated);

  guid            =  type WideString;      { "http://schemas.microsoft.com/2003/10/Serialization/"[GblSmpl] }
  ArrayOfstring = array of WideString;          { "http://schemas.microsoft.com/2003/10/Serialization/Arrays"[GblCplx] }
  ArrayOfguid = array of guid;                  { "http://schemas.microsoft.com/2003/10/Serialization/Arrays"[GblCplx] }
  ArrayOfCatalogueEntry = array of CatalogueEntry;   { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ArrayOfServiceErrorMessage = array of ServiceErrorMessage;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }
  ArrayOfExceptionDetails = array of ExceptionDetails;   { "http://schemas.datacontract.org/2004/07/BankLink.Common.Services"[GblCplx] }


  // ************************************************************************ //
  // XML       : MessageResponse, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponse = class(TRemotable)
  private
    FErrorMessages: ArrayOfServiceErrorMessage;
    FErrorMessages_Specified: boolean;
    FExceptions: ArrayOfExceptionDetails;
    FExceptions_Specified: boolean;
    FSuccess: Boolean;
    FSuccess_Specified: boolean;
    procedure SetErrorMessages(Index: Integer; const AArrayOfServiceErrorMessage: ArrayOfServiceErrorMessage);
    function  ErrorMessages_Specified(Index: Integer): boolean;
    procedure SetExceptions(Index: Integer; const AArrayOfExceptionDetails: ArrayOfExceptionDetails);
    function  Exceptions_Specified(Index: Integer): boolean;
    procedure SetSuccess(Index: Integer; const ABoolean: Boolean);
    function  Success_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ErrorMessages: ArrayOfServiceErrorMessage  Index (IS_OPTN or IS_NLBL) read FErrorMessages write SetErrorMessages stored ErrorMessages_Specified;
    property Exceptions:    ArrayOfExceptionDetails     Index (IS_OPTN or IS_NLBL) read FExceptions write SetExceptions stored Exceptions_Specified;
    property Success:       Boolean                     Index (IS_OPTN) read FSuccess write SetSuccess stored Success_Specified;
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfArrayOfCatalogueEntryMIdCYrSK, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfArrayOfCatalogueEntryMIdCYrSK = class(MessageResponse)
  private
    FResult: ArrayOfCatalogueEntry;
    FResult_Specified: boolean;
    procedure SetResult(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
    function  Result_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Result: ArrayOfCatalogueEntry  Index (IS_OPTN or IS_NLBL) read FResult write SetResult stored Result_Specified;
  end;



  // ************************************************************************ //
  // XML       : ServiceErrorMessage, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  ServiceErrorMessage = class(TRemotable)
  private
    FErrorCode: WideString;
    FErrorCode_Specified: boolean;
    FMessage_: WideString;
    FMessage__Specified: boolean;
    procedure SetErrorCode(Index: Integer; const AWideString: WideString);
    function  ErrorCode_Specified(Index: Integer): boolean;
    procedure SetMessage_(Index: Integer; const AWideString: WideString);
    function  Message__Specified(Index: Integer): boolean;
  published
    property ErrorCode: WideString  Index (IS_OPTN or IS_NLBL) read FErrorCode write SetErrorCode stored ErrorCode_Specified;
    property Message_:  WideString  Index (IS_OPTN or IS_NLBL) read FMessage_ write SetMessage_ stored Message__Specified;
  end;



  // ************************************************************************ //
  // XML       : ExceptionDetails, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  ExceptionDetails = class(TRemotable)
  private
    FMessage_: WideString;
    FMessage__Specified: boolean;
    FSource: WideString;
    FSource_Specified: boolean;
    FStackTrace: WideString;
    FStackTrace_Specified: boolean;
    procedure SetMessage_(Index: Integer; const AWideString: WideString);
    function  Message__Specified(Index: Integer): boolean;
    procedure SetSource(Index: Integer; const AWideString: WideString);
    function  Source_Specified(Index: Integer): boolean;
    procedure SetStackTrace(Index: Integer; const AWideString: WideString);
    function  StackTrace_Specified(Index: Integer): boolean;
  published
    property Message_:   WideString  Index (IS_OPTN or IS_NLBL) read FMessage_ write SetMessage_ stored Message__Specified;
    property Source:     WideString  Index (IS_OPTN or IS_NLBL) read FSource write SetSource stored Source_Specified;
    property StackTrace: WideString  Index (IS_OPTN or IS_NLBL) read FStackTrace write SetStackTrace stored StackTrace_Specified;
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfPracticeDetailMIdCYrSK, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfPracticeDetailMIdCYrSK = class(MessageResponse)
  private
    FResult: PracticeDetail;
    FResult_Specified: boolean;
    procedure SetResult(Index: Integer; const APracticeDetail: PracticeDetail);
    function  Result_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Result: PracticeDetail  Index (IS_OPTN or IS_NLBL) read FResult write SetResult stored Result_Specified;
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfguid, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfguid = class(MessageResponse)
  private
    FResult: guid;
    FResult_Specified: boolean;
    procedure SetResult(Index: Integer; const Aguid: guid);
    function  Result_Specified(Index: Integer): boolean;
  published
    property Result: guid  Index (IS_OPTN) read FResult write SetResult stored Result_Specified;
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfClientListMIdCYrSK, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfClientListMIdCYrSK = class(MessageResponse)
  private
    FResult: ClientList;
    FResult_Specified: boolean;
    procedure SetResult(Index: Integer; const AClientList: ClientList);
    function  Result_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Result: ClientList  Index (IS_OPTN or IS_NLBL) read FResult write SetResult stored Result_Specified;
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfClientDetailMIdCYrSK, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfClientDetailMIdCYrSK = class(MessageResponse)
  private
    FResult: ClientDetail;
    FResult_Specified: boolean;
    procedure SetResult(Index: Integer; const AClientDetail: ClientDetail);
    function  Result_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Result: ClientDetail  Index (IS_OPTN or IS_NLBL) read FResult write SetResult stored Result_Specified;
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfArrayOfCatalogueEntryMIdCYrSK, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfArrayOfCatalogueEntryMIdCYrSK2 = class(MessageResponseOfArrayOfCatalogueEntryMIdCYrSK)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : MessageResponse, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponse2 = class(MessageResponse)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ServiceErrorMessage, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  ServiceErrorMessage2 = class(ServiceErrorMessage)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ExceptionDetails, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  ExceptionDetails2 = class(ExceptionDetails)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfPracticeDetailMIdCYrSK, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfPracticeDetailMIdCYrSK2 = class(MessageResponseOfPracticeDetailMIdCYrSK)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfguid, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfguid2 = class(MessageResponseOfguid)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfClientListMIdCYrSK, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfClientListMIdCYrSK2 = class(MessageResponseOfClientListMIdCYrSK)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : MessageResponseOfClientDetailMIdCYrSK, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/BankLink.Common.Services
  // ************************************************************************ //
  MessageResponseOfClientDetailMIdCYrSK2 = class(MessageResponseOfClientDetailMIdCYrSK)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : CatalogueEntry, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  CatalogueEntry = class(TRemotable)
  private
    FCatalogueType: WideString;
    FCatalogueType_Specified: boolean;
    FDescription: WideString;
    FDescription_Specified: boolean;
    FId: guid;
    FId_Specified: boolean;
    procedure SetCatalogueType(Index: Integer; const AWideString: WideString);
    function  CatalogueType_Specified(Index: Integer): boolean;
    procedure SetDescription(Index: Integer; const AWideString: WideString);
    function  Description_Specified(Index: Integer): boolean;
    procedure SetId(Index: Integer; const Aguid: guid);
    function  Id_Specified(Index: Integer): boolean;
  published
    property CatalogueType: WideString  Index (IS_OPTN or IS_NLBL) read FCatalogueType write SetCatalogueType stored CatalogueType_Specified;
    property Description:   WideString  Index (IS_OPTN or IS_NLBL) read FDescription write SetDescription stored Description_Specified;
    property Id:            guid        Index (IS_OPTN) read FId write SetId stored Id_Specified;
  end;

  ArrayOfRole = array of Role;                  { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }
  ArrayOfUserDetail = array of UserDetail;      { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }


  // ************************************************************************ //
  // XML       : Practice, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  Practice = class(TRemotable)
  private
    FCatalogue: ArrayOfCatalogueEntry;
    FCatalogue_Specified: boolean;
    FDefaultAdminUserId: guid;
    FDefaultAdminUserId_Specified: boolean;
    FDisplayName: WideString;
    FDisplayName_Specified: boolean;
    FDomainName: WideString;
    FDomainName_Specified: boolean;
    FEMail: WideString;
    FEMail_Specified: boolean;
    FPhone: WideString;
    FPhone_Specified: boolean;
    FRoles: ArrayOfRole;
    FRoles_Specified: boolean;
    FStatus: Status;
    FStatus_Specified: boolean;
    FSubscription: ArrayOfguid;
    FSubscription_Specified: boolean;
    FUsers: ArrayOfUserDetail;
    FUsers_Specified: boolean;
    procedure SetCatalogue(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
    function  Catalogue_Specified(Index: Integer): boolean;
    procedure SetDefaultAdminUserId(Index: Integer; const Aguid: guid);
    function  DefaultAdminUserId_Specified(Index: Integer): boolean;
    procedure SetDisplayName(Index: Integer; const AWideString: WideString);
    function  DisplayName_Specified(Index: Integer): boolean;
    procedure SetDomainName(Index: Integer; const AWideString: WideString);
    function  DomainName_Specified(Index: Integer): boolean;
    procedure SetEMail(Index: Integer; const AWideString: WideString);
    function  EMail_Specified(Index: Integer): boolean;
    procedure SetPhone(Index: Integer; const AWideString: WideString);
    function  Phone_Specified(Index: Integer): boolean;
    procedure SetRoles(Index: Integer; const AArrayOfRole: ArrayOfRole);
    function  Roles_Specified(Index: Integer): boolean;
    procedure SetStatus(Index: Integer; const AStatus: Status);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetSubscription(Index: Integer; const AArrayOfguid: ArrayOfguid);
    function  Subscription_Specified(Index: Integer): boolean;
    procedure SetUsers(Index: Integer; const AArrayOfUserDetail: ArrayOfUserDetail);
    function  Users_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Catalogue:          ArrayOfCatalogueEntry  Index (IS_OPTN or IS_NLBL) read FCatalogue write SetCatalogue stored Catalogue_Specified;
    property DefaultAdminUserId: guid                   Index (IS_OPTN) read FDefaultAdminUserId write SetDefaultAdminUserId stored DefaultAdminUserId_Specified;
    property DisplayName:        WideString             Index (IS_OPTN or IS_NLBL) read FDisplayName write SetDisplayName stored DisplayName_Specified;
    property DomainName:         WideString             Index (IS_OPTN or IS_NLBL) read FDomainName write SetDomainName stored DomainName_Specified;
    property EMail:              WideString             Index (IS_OPTN or IS_NLBL) read FEMail write SetEMail stored EMail_Specified;
    property Phone:              WideString             Index (IS_OPTN or IS_NLBL) read FPhone write SetPhone stored Phone_Specified;
    property Roles:              ArrayOfRole            Index (IS_OPTN or IS_NLBL) read FRoles write SetRoles stored Roles_Specified;
    property Status:             Status                 Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Subscription:       ArrayOfguid            Index (IS_OPTN or IS_NLBL) read FSubscription write SetSubscription stored Subscription_Specified;
    property Users:              ArrayOfUserDetail      Index (IS_OPTN or IS_NLBL) read FUsers write SetUsers stored Users_Specified;
  end;



  // ************************************************************************ //
  // XML       : PracticeDetail, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  PracticeDetail = class(Practice)
  private
    FId: guid;
    FId_Specified: boolean;
    procedure SetId(Index: Integer; const Aguid: guid);
    function  Id_Specified(Index: Integer): boolean;
  published
    property Id: guid  Index (IS_OPTN) read FId write SetId stored Id_Specified;
  end;



  // ************************************************************************ //
  // XML       : Role, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  Role = class(TRemotable)
  private
    FDescription: WideString;
    FDescription_Specified: boolean;
    FId: guid;
    FId_Specified: boolean;
    FRoleName: WideString;
    FRoleName_Specified: boolean;
    procedure SetDescription(Index: Integer; const AWideString: WideString);
    function  Description_Specified(Index: Integer): boolean;
    procedure SetId(Index: Integer; const Aguid: guid);
    function  Id_Specified(Index: Integer): boolean;
    procedure SetRoleName(Index: Integer; const AWideString: WideString);
    function  RoleName_Specified(Index: Integer): boolean;
  published
    property Description: WideString  Index (IS_OPTN or IS_NLBL) read FDescription write SetDescription stored Description_Specified;
    property Id:          guid        Index (IS_OPTN) read FId write SetId stored Id_Specified;
    property RoleName:    WideString  Index (IS_OPTN or IS_NLBL) read FRoleName write SetRoleName stored RoleName_Specified;
  end;



  // ************************************************************************ //
  // XML       : User, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  User = class(TRemotable)
  private
    FEMail: WideString;
    FEMail_Specified: boolean;
    FFullName: WideString;
    FFullName_Specified: boolean;
    FRoleNames: ArrayOfstring;
    FRoleNames_Specified: boolean;
    FSubscription: ArrayOfguid;
    FSubscription_Specified: boolean;
    FUserCode: WideString;
    FUserCode_Specified: boolean;
    procedure SetEMail(Index: Integer; const AWideString: WideString);
    function  EMail_Specified(Index: Integer): boolean;
    procedure SetFullName(Index: Integer; const AWideString: WideString);
    function  FullName_Specified(Index: Integer): boolean;
    procedure SetRoleNames(Index: Integer; const AArrayOfstring: ArrayOfstring);
    function  RoleNames_Specified(Index: Integer): boolean;
    procedure SetSubscription(Index: Integer; const AArrayOfguid: ArrayOfguid);
    function  Subscription_Specified(Index: Integer): boolean;
    procedure SetUserCode(Index: Integer; const AWideString: WideString);
    function  UserCode_Specified(Index: Integer): boolean;
  published
    property EMail:        WideString     Index (IS_OPTN or IS_NLBL) read FEMail write SetEMail stored EMail_Specified;
    property FullName:     WideString     Index (IS_OPTN or IS_NLBL) read FFullName write SetFullName stored FullName_Specified;
    property RoleNames:    ArrayOfstring  Index (IS_OPTN or IS_NLBL) read FRoleNames write SetRoleNames stored RoleNames_Specified;
    property Subscription: ArrayOfguid    Index (IS_OPTN or IS_NLBL) read FSubscription write SetSubscription stored Subscription_Specified;
    property UserCode:     WideString     Index (IS_OPTN or IS_NLBL) read FUserCode write SetUserCode stored UserCode_Specified;
  end;



  // ************************************************************************ //
  // XML       : UserDetail, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  UserDetail = class(User)
  private
    FId: guid;
    FId_Specified: boolean;
    procedure SetId(Index: Integer; const Aguid: guid);
    function  Id_Specified(Index: Integer): boolean;
  published
    property Id: guid  Index (IS_OPTN) read FId write SetId stored Id_Specified;
  end;



  // ************************************************************************ //
  // XML       : UserPracticeNew, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  UserPracticeNew = class(User)
  private
    FPassword: WideString;
    FPassword_Specified: boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
  published
    property Password: WideString  Index (IS_OPTN or IS_NLBL) read FPassword write SetPassword stored Password_Specified;
  end;



  // ************************************************************************ //
  // XML       : UserPractice, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  UserPractice = class(UserDetail)
  private
    FPassword: WideString;
    FPassword_Specified: boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
  published
    property Password: WideString  Index (IS_OPTN or IS_NLBL) read FPassword write SetPassword stored Password_Specified;
  end;

  ArrayOfClientSummary = array of ClientSummary;   { "http://www.banklinkonline.com/2011/11/Blopi"[GblCplx] }


  // ************************************************************************ //
  // XML       : ClientList, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientList = class(TRemotable)
  private
    FCatalogue: ArrayOfCatalogueEntry;
    FCatalogue_Specified: boolean;
    FClients: ArrayOfClientSummary;
    FClients_Specified: boolean;
    procedure SetCatalogue(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
    function  Catalogue_Specified(Index: Integer): boolean;
    procedure SetClients(Index: Integer; const AArrayOfClientSummary: ArrayOfClientSummary);
    function  Clients_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Catalogue: ArrayOfCatalogueEntry  Index (IS_OPTN or IS_NLBL) read FCatalogue write SetCatalogue stored Catalogue_Specified;
    property Clients:   ArrayOfClientSummary   Index (IS_OPTN or IS_NLBL) read FClients write SetClients stored Clients_Specified;
  end;



  // ************************************************************************ //
  // XML       : Client, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  Client = class(TRemotable)
  private
    FBillingFrequency: WideString;
    FBillingFrequency_Specified: boolean;
    FClientCode: WideString;
    FClientCode_Specified: boolean;
    FMaxInactiveDays: Integer;
    FMaxInactiveDays_Specified: boolean;
    FName_: WideString;
    FName__Specified: boolean;
    FStatus: Status;
    FStatus_Specified: boolean;
    FSubscription: ArrayOfguid;
    FSubscription_Specified: boolean;
    procedure SetBillingFrequency(Index: Integer; const AWideString: WideString);
    function  BillingFrequency_Specified(Index: Integer): boolean;
    procedure SetClientCode(Index: Integer; const AWideString: WideString);
    function  ClientCode_Specified(Index: Integer): boolean;
    procedure SetMaxInactiveDays(Index: Integer; const AInteger: Integer);
    function  MaxInactiveDays_Specified(Index: Integer): boolean;
    procedure SetName_(Index: Integer; const AWideString: WideString);
    function  Name__Specified(Index: Integer): boolean;
    procedure SetStatus(Index: Integer; const AStatus: Status);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetSubscription(Index: Integer; const AArrayOfguid: ArrayOfguid);
    function  Subscription_Specified(Index: Integer): boolean;
  published
    property BillingFrequency: WideString   Index (IS_OPTN or IS_NLBL) read FBillingFrequency write SetBillingFrequency stored BillingFrequency_Specified;
    property ClientCode:       WideString   Index (IS_OPTN or IS_NLBL) read FClientCode write SetClientCode stored ClientCode_Specified;
    property MaxInactiveDays:  Integer      Index (IS_OPTN) read FMaxInactiveDays write SetMaxInactiveDays stored MaxInactiveDays_Specified;
    property Name_:            WideString   Index (IS_OPTN or IS_NLBL) read FName_ write SetName_ stored Name__Specified;
    property Status:           Status       Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Subscription:     ArrayOfguid  Index (IS_OPTN or IS_NLBL) read FSubscription write SetSubscription stored Subscription_Specified;
  end;



  // ************************************************************************ //
  // XML       : ClientSummary, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientSummary = class(Client)
  private
    FId: guid;
    FId_Specified: boolean;
    procedure SetId(Index: Integer; const Aguid: guid);
    function  Id_Specified(Index: Integer): boolean;
  published
    property Id: guid  Index (IS_OPTN) read FId write SetId stored Id_Specified;
  end;



  // ************************************************************************ //
  // XML       : ClientDetail, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientDetail = class(ClientSummary)
  private
    FCatalogue: ArrayOfCatalogueEntry;
    FCatalogue_Specified: boolean;
    FPrimaryContactUserId: guid;
    FPrimaryContactUserId_Specified: boolean;
    FRoles: ArrayOfRole;
    FRoles_Specified: boolean;
    FUsers: ArrayOfUserDetail;
    FUsers_Specified: boolean;
    procedure SetCatalogue(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
    function  Catalogue_Specified(Index: Integer): boolean;
    procedure SetPrimaryContactUserId(Index: Integer; const Aguid: guid);
    function  PrimaryContactUserId_Specified(Index: Integer): boolean;
    procedure SetRoles(Index: Integer; const AArrayOfRole: ArrayOfRole);
    function  Roles_Specified(Index: Integer): boolean;
    procedure SetUsers(Index: Integer; const AArrayOfUserDetail: ArrayOfUserDetail);
    function  Users_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Catalogue:            ArrayOfCatalogueEntry  Index (IS_OPTN or IS_NLBL) read FCatalogue write SetCatalogue stored Catalogue_Specified;
    property PrimaryContactUserId: guid                   Index (IS_OPTN) read FPrimaryContactUserId write SetPrimaryContactUserId stored PrimaryContactUserId_Specified;
    property Roles:                ArrayOfRole            Index (IS_OPTN or IS_NLBL) read FRoles write SetRoles stored Roles_Specified;
    property Users:                ArrayOfUserDetail      Index (IS_OPTN or IS_NLBL) read FUsers write SetUsers stored Users_Specified;
  end;



  // ************************************************************************ //
  // XML       : ClientNew, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientNew = class(Client)
  private
    FAbn: WideString;
    FAbn_Specified: boolean;
    FAddress1: WideString;
    FAddress1_Specified: boolean;
    FAddress2: WideString;
    FAddress2_Specified: boolean;
    FAddress3: WideString;
    FAddress3_Specified: boolean;
    FAddressCountry: WideString;
    FAddressCountry_Specified: boolean;
    FCountryCode: WideString;
    FCountryCode_Specified: boolean;
    FEmail: WideString;
    FEmail_Specified: boolean;
    FFax: WideString;
    FFax_Specified: boolean;
    FGstNo: WideString;
    FGstNo_Specified: boolean;
    FMobile: WideString;
    FMobile_Specified: boolean;
    FPhone: WideString;
    FPhone_Specified: boolean;
    FSalutation: WideString;
    FSalutation_Specified: boolean;
    FTfn: WideString;
    FTfn_Specified: boolean;
    FVatNo: WideString;
    FVatNo_Specified: boolean;
    procedure SetAbn(Index: Integer; const AWideString: WideString);
    function  Abn_Specified(Index: Integer): boolean;
    procedure SetAddress1(Index: Integer; const AWideString: WideString);
    function  Address1_Specified(Index: Integer): boolean;
    procedure SetAddress2(Index: Integer; const AWideString: WideString);
    function  Address2_Specified(Index: Integer): boolean;
    procedure SetAddress3(Index: Integer; const AWideString: WideString);
    function  Address3_Specified(Index: Integer): boolean;
    procedure SetAddressCountry(Index: Integer; const AWideString: WideString);
    function  AddressCountry_Specified(Index: Integer): boolean;
    procedure SetCountryCode(Index: Integer; const AWideString: WideString);
    function  CountryCode_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const AWideString: WideString);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetFax(Index: Integer; const AWideString: WideString);
    function  Fax_Specified(Index: Integer): boolean;
    procedure SetGstNo(Index: Integer; const AWideString: WideString);
    function  GstNo_Specified(Index: Integer): boolean;
    procedure SetMobile(Index: Integer; const AWideString: WideString);
    function  Mobile_Specified(Index: Integer): boolean;
    procedure SetPhone(Index: Integer; const AWideString: WideString);
    function  Phone_Specified(Index: Integer): boolean;
    procedure SetSalutation(Index: Integer; const AWideString: WideString);
    function  Salutation_Specified(Index: Integer): boolean;
    procedure SetTfn(Index: Integer; const AWideString: WideString);
    function  Tfn_Specified(Index: Integer): boolean;
    procedure SetVatNo(Index: Integer; const AWideString: WideString);
    function  VatNo_Specified(Index: Integer): boolean;
  published
    property Abn:            WideString  Index (IS_OPTN or IS_NLBL) read FAbn write SetAbn stored Abn_Specified;
    property Address1:       WideString  Index (IS_OPTN or IS_NLBL) read FAddress1 write SetAddress1 stored Address1_Specified;
    property Address2:       WideString  Index (IS_OPTN or IS_NLBL) read FAddress2 write SetAddress2 stored Address2_Specified;
    property Address3:       WideString  Index (IS_OPTN or IS_NLBL) read FAddress3 write SetAddress3 stored Address3_Specified;
    property AddressCountry: WideString  Index (IS_OPTN or IS_NLBL) read FAddressCountry write SetAddressCountry stored AddressCountry_Specified;
    property CountryCode:    WideString  Index (IS_OPTN or IS_NLBL) read FCountryCode write SetCountryCode stored CountryCode_Specified;
    property Email:          WideString  Index (IS_OPTN or IS_NLBL) read FEmail write SetEmail stored Email_Specified;
    property Fax:            WideString  Index (IS_OPTN or IS_NLBL) read FFax write SetFax stored Fax_Specified;
    property GstNo:          WideString  Index (IS_OPTN or IS_NLBL) read FGstNo write SetGstNo stored GstNo_Specified;
    property Mobile:         WideString  Index (IS_OPTN or IS_NLBL) read FMobile write SetMobile stored Mobile_Specified;
    property Phone:          WideString  Index (IS_OPTN or IS_NLBL) read FPhone write SetPhone stored Phone_Specified;
    property Salutation:     WideString  Index (IS_OPTN or IS_NLBL) read FSalutation write SetSalutation stored Salutation_Specified;
    property Tfn:            WideString  Index (IS_OPTN or IS_NLBL) read FTfn write SetTfn stored Tfn_Specified;
    property VatNo:          WideString  Index (IS_OPTN or IS_NLBL) read FVatNo write SetVatNo stored VatNo_Specified;
  end;



  // ************************************************************************ //
  // XML       : ClientUpdate, global, <complexType>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientUpdate = class(ClientSummary)
  private
    FPrimaryContactUserId: guid;
    FPrimaryContactUserId_Specified: boolean;
    procedure SetPrimaryContactUserId(Index: Integer; const Aguid: guid);
    function  PrimaryContactUserId_Specified(Index: Integer): boolean;
  published
    property PrimaryContactUserId: guid  Index (IS_OPTN) read FPrimaryContactUserId write SetPrimaryContactUserId stored PrimaryContactUserId_Specified;
  end;



  // ************************************************************************ //
  // XML       : CatalogueEntry, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  CatalogueEntry2 = class(CatalogueEntry)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : PracticeDetail, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  PracticeDetail2 = class(PracticeDetail)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Practice, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  Practice2 = class(Practice)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Role, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  Role2 = class(Role)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UserDetail, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  UserDetail2 = class(UserDetail)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : User, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  User2 = class(User)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UserPracticeNew, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  UserPracticeNew2 = class(UserPracticeNew)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : UserPractice, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  UserPractice2 = class(UserPractice)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ClientList, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientList2 = class(ClientList)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ClientSummary, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientSummary2 = class(ClientSummary)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Client, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  Client2 = class(Client)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ClientDetail, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientDetail2 = class(ClientDetail)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ClientNew, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientNew2 = class(ClientNew)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ClientUpdate, global, <element>
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // ************************************************************************ //
  ClientUpdate2 = class(ClientUpdate)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : http://www.banklinkonline.com/2011/11/Blopi
  // soapAction: http://www.banklinkonline.com/2011/11/Blopi/IBlopiServiceFacade/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : BasicHttpBinding_IBlopiServiceFacade
  // service   : BlopiServiceFacade
  // port      : BasicHttpBinding_IBlopiServiceFacade
  // URL       : https://banklinkonline.com/Services/BlopiServiceFacade.svc
  // ************************************************************************ //
  IBlopiServiceFacade = interface(IInvokable)
  ['{88E4B606-483E-CC24-1C42-418E3CD2E07E}']
    function  Echo(const aString: WideString): WideString; stdcall;
    function  EchoArrayOfstring(const strings: ArrayOfstring): WideString; stdcall;
    function  GetPracticeCatalogue(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString): MessageResponseOfArrayOfCatalogueEntryMIdCYrSK; stdcall;
    function  GetSmeCatalogue(const countryCode: WideString; const practiceCode: WideString): MessageResponseOfArrayOfCatalogueEntryMIdCYrSK; stdcall;
    function  GetUserCatalogue(const countryCode: WideString; const practiceCode: WideString; const clientCode: WideString): MessageResponseOfArrayOfCatalogueEntryMIdCYrSK; stdcall;
    function  GetPractice(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString): MessageResponseOfPracticeDetailMIdCYrSK; stdcall;
    function  SavePractice(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const practice: PracticeDetail): MessageResponse; stdcall;
    function  CreatePracticeUser(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const user: UserPracticeNew): MessageResponseOfguid; stdcall;
    function  SavePracticeUser(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const user: UserPractice): MessageResponse; stdcall;
    function  SetPracticeUserPassword(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const userId: guid; const newPassword: WideString): MessageResponse; stdcall;
    function  DeleteUser(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const userId: guid): MessageResponse; stdcall;
    function  GetClientList(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString): MessageResponseOfClientListMIdCYrSK; stdcall;
    function  GetClient(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const clientId: guid): MessageResponseOfClientDetailMIdCYrSK; stdcall;
    function  CreateClient(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const newClient: ClientNew): MessageResponseOfguid; stdcall;
    function  SaveClient(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const client: ClientUpdate): MessageResponse; stdcall;
    function  CreateClientUser(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const clientId: guid; const user: User): MessageResponseOfguid; stdcall;
    function  SaveClientUser(const countryCode: WideString; const practiceCode: WideString; const passwordHash: WideString; const clientId: guid; const user: UserDetail): MessageResponse; stdcall;
  end;

function GetIBlopiServiceFacade(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IBlopiServiceFacade;


implementation
  uses SysUtils;

function GetIBlopiServiceFacade(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IBlopiServiceFacade;
const
  defWSDL = 'https://banklinkonline.com/Services/BlopiServiceFacade.svc?wsdl';
  defURL  = 'https://banklinkonline.com/Services/BlopiServiceFacade.svc';
  defSvc  = 'BlopiServiceFacade';
  defPrt  = 'BasicHttpBinding_IBlopiServiceFacade';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IBlopiServiceFacade);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor MessageResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FErrorMessages)-1 do
    SysUtils.FreeAndNil(FErrorMessages[I]);
  System.SetLength(FErrorMessages, 0);
  for I := 0 to System.Length(FExceptions)-1 do
    SysUtils.FreeAndNil(FExceptions[I]);
  System.SetLength(FExceptions, 0);
  inherited Destroy;
end;

procedure MessageResponse.SetErrorMessages(Index: Integer; const AArrayOfServiceErrorMessage: ArrayOfServiceErrorMessage);
begin
  FErrorMessages := AArrayOfServiceErrorMessage;
  FErrorMessages_Specified := True;
end;

function MessageResponse.ErrorMessages_Specified(Index: Integer): boolean;
begin
  Result := FErrorMessages_Specified;
end;

procedure MessageResponse.SetExceptions(Index: Integer; const AArrayOfExceptionDetails: ArrayOfExceptionDetails);
begin
  FExceptions := AArrayOfExceptionDetails;
  FExceptions_Specified := True;
end;

function MessageResponse.Exceptions_Specified(Index: Integer): boolean;
begin
  Result := FExceptions_Specified;
end;

procedure MessageResponse.SetSuccess(Index: Integer; const ABoolean: Boolean);
begin
  FSuccess := ABoolean;
  FSuccess_Specified := True;
end;

function MessageResponse.Success_Specified(Index: Integer): boolean;
begin
  Result := FSuccess_Specified;
end;

destructor MessageResponseOfArrayOfCatalogueEntryMIdCYrSK.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FResult)-1 do
    SysUtils.FreeAndNil(FResult[I]);
  System.SetLength(FResult, 0);
  inherited Destroy;
end;

procedure MessageResponseOfArrayOfCatalogueEntryMIdCYrSK.SetResult(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
begin
  FResult := AArrayOfCatalogueEntry;
  FResult_Specified := True;
end;

function MessageResponseOfArrayOfCatalogueEntryMIdCYrSK.Result_Specified(Index: Integer): boolean;
begin
  Result := FResult_Specified;
end;

procedure ServiceErrorMessage.SetErrorCode(Index: Integer; const AWideString: WideString);
begin
  FErrorCode := AWideString;
  FErrorCode_Specified := True;
end;

function ServiceErrorMessage.ErrorCode_Specified(Index: Integer): boolean;
begin
  Result := FErrorCode_Specified;
end;

procedure ServiceErrorMessage.SetMessage_(Index: Integer; const AWideString: WideString);
begin
  FMessage_ := AWideString;
  FMessage__Specified := True;
end;

function ServiceErrorMessage.Message__Specified(Index: Integer): boolean;
begin
  Result := FMessage__Specified;
end;

procedure ExceptionDetails.SetMessage_(Index: Integer; const AWideString: WideString);
begin
  FMessage_ := AWideString;
  FMessage__Specified := True;
end;

function ExceptionDetails.Message__Specified(Index: Integer): boolean;
begin
  Result := FMessage__Specified;
end;

procedure ExceptionDetails.SetSource(Index: Integer; const AWideString: WideString);
begin
  FSource := AWideString;
  FSource_Specified := True;
end;

function ExceptionDetails.Source_Specified(Index: Integer): boolean;
begin
  Result := FSource_Specified;
end;

procedure ExceptionDetails.SetStackTrace(Index: Integer; const AWideString: WideString);
begin
  FStackTrace := AWideString;
  FStackTrace_Specified := True;
end;

function ExceptionDetails.StackTrace_Specified(Index: Integer): boolean;
begin
  Result := FStackTrace_Specified;
end;

destructor MessageResponseOfPracticeDetailMIdCYrSK.Destroy;
begin
  SysUtils.FreeAndNil(FResult);
  inherited Destroy;
end;

procedure MessageResponseOfPracticeDetailMIdCYrSK.SetResult(Index: Integer; const APracticeDetail: PracticeDetail);
begin
  FResult := APracticeDetail;
  FResult_Specified := True;
end;

function MessageResponseOfPracticeDetailMIdCYrSK.Result_Specified(Index: Integer): boolean;
begin
  Result := FResult_Specified;
end;

procedure MessageResponseOfguid.SetResult(Index: Integer; const Aguid: guid);
begin
  FResult := Aguid;
  FResult_Specified := True;
end;

function MessageResponseOfguid.Result_Specified(Index: Integer): boolean;
begin
  Result := FResult_Specified;
end;

destructor MessageResponseOfClientListMIdCYrSK.Destroy;
begin
  SysUtils.FreeAndNil(FResult);
  inherited Destroy;
end;

procedure MessageResponseOfClientListMIdCYrSK.SetResult(Index: Integer; const AClientList: ClientList);
begin
  FResult := AClientList;
  FResult_Specified := True;
end;

function MessageResponseOfClientListMIdCYrSK.Result_Specified(Index: Integer): boolean;
begin
  Result := FResult_Specified;
end;

destructor MessageResponseOfClientDetailMIdCYrSK.Destroy;
begin
  SysUtils.FreeAndNil(FResult);
  inherited Destroy;
end;

procedure MessageResponseOfClientDetailMIdCYrSK.SetResult(Index: Integer; const AClientDetail: ClientDetail);
begin
  FResult := AClientDetail;
  FResult_Specified := True;
end;

function MessageResponseOfClientDetailMIdCYrSK.Result_Specified(Index: Integer): boolean;
begin
  Result := FResult_Specified;
end;

procedure CatalogueEntry.SetCatalogueType(Index: Integer; const AWideString: WideString);
begin
  FCatalogueType := AWideString;
  FCatalogueType_Specified := True;
end;

function CatalogueEntry.CatalogueType_Specified(Index: Integer): boolean;
begin
  Result := FCatalogueType_Specified;
end;

procedure CatalogueEntry.SetDescription(Index: Integer; const AWideString: WideString);
begin
  FDescription := AWideString;
  FDescription_Specified := True;
end;

function CatalogueEntry.Description_Specified(Index: Integer): boolean;
begin
  Result := FDescription_Specified;
end;

procedure CatalogueEntry.SetId(Index: Integer; const Aguid: guid);
begin
  FId := Aguid;
  FId_Specified := True;
end;

function CatalogueEntry.Id_Specified(Index: Integer): boolean;
begin
  Result := FId_Specified;
end;

destructor Practice.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FCatalogue)-1 do
    SysUtils.FreeAndNil(FCatalogue[I]);
  System.SetLength(FCatalogue, 0);
  for I := 0 to System.Length(FRoles)-1 do
    SysUtils.FreeAndNil(FRoles[I]);
  System.SetLength(FRoles, 0);
  for I := 0 to System.Length(FUsers)-1 do
    SysUtils.FreeAndNil(FUsers[I]);
  System.SetLength(FUsers, 0);
  inherited Destroy;
end;

procedure Practice.SetCatalogue(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
begin
  FCatalogue := AArrayOfCatalogueEntry;
  FCatalogue_Specified := True;
end;

function Practice.Catalogue_Specified(Index: Integer): boolean;
begin
  Result := FCatalogue_Specified;
end;

procedure Practice.SetDefaultAdminUserId(Index: Integer; const Aguid: guid);
begin
  FDefaultAdminUserId := Aguid;
  FDefaultAdminUserId_Specified := True;
end;

function Practice.DefaultAdminUserId_Specified(Index: Integer): boolean;
begin
  Result := FDefaultAdminUserId_Specified;
end;

procedure Practice.SetDisplayName(Index: Integer; const AWideString: WideString);
begin
  FDisplayName := AWideString;
  FDisplayName_Specified := True;
end;

function Practice.DisplayName_Specified(Index: Integer): boolean;
begin
  Result := FDisplayName_Specified;
end;

procedure Practice.SetDomainName(Index: Integer; const AWideString: WideString);
begin
  FDomainName := AWideString;
  FDomainName_Specified := True;
end;

function Practice.DomainName_Specified(Index: Integer): boolean;
begin
  Result := FDomainName_Specified;
end;

procedure Practice.SetEMail(Index: Integer; const AWideString: WideString);
begin
  FEMail := AWideString;
  FEMail_Specified := True;
end;

function Practice.EMail_Specified(Index: Integer): boolean;
begin
  Result := FEMail_Specified;
end;

procedure Practice.SetPhone(Index: Integer; const AWideString: WideString);
begin
  FPhone := AWideString;
  FPhone_Specified := True;
end;

function Practice.Phone_Specified(Index: Integer): boolean;
begin
  Result := FPhone_Specified;
end;

procedure Practice.SetRoles(Index: Integer; const AArrayOfRole: ArrayOfRole);
begin
  FRoles := AArrayOfRole;
  FRoles_Specified := True;
end;

function Practice.Roles_Specified(Index: Integer): boolean;
begin
  Result := FRoles_Specified;
end;

procedure Practice.SetStatus(Index: Integer; const AStatus: Status);
begin
  FStatus := AStatus;
  FStatus_Specified := True;
end;

function Practice.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure Practice.SetSubscription(Index: Integer; const AArrayOfguid: ArrayOfguid);
begin
  FSubscription := AArrayOfguid;
  FSubscription_Specified := True;
end;

function Practice.Subscription_Specified(Index: Integer): boolean;
begin
  Result := FSubscription_Specified;
end;

procedure Practice.SetUsers(Index: Integer; const AArrayOfUserDetail: ArrayOfUserDetail);
begin
  FUsers := AArrayOfUserDetail;
  FUsers_Specified := True;
end;

function Practice.Users_Specified(Index: Integer): boolean;
begin
  Result := FUsers_Specified;
end;

procedure PracticeDetail.SetId(Index: Integer; const Aguid: guid);
begin
  FId := Aguid;
  FId_Specified := True;
end;

function PracticeDetail.Id_Specified(Index: Integer): boolean;
begin
  Result := FId_Specified;
end;

procedure Role.SetDescription(Index: Integer; const AWideString: WideString);
begin
  FDescription := AWideString;
  FDescription_Specified := True;
end;

function Role.Description_Specified(Index: Integer): boolean;
begin
  Result := FDescription_Specified;
end;

procedure Role.SetId(Index: Integer; const Aguid: guid);
begin
  FId := Aguid;
  FId_Specified := True;
end;

function Role.Id_Specified(Index: Integer): boolean;
begin
  Result := FId_Specified;
end;

procedure Role.SetRoleName(Index: Integer; const AWideString: WideString);
begin
  FRoleName := AWideString;
  FRoleName_Specified := True;
end;

function Role.RoleName_Specified(Index: Integer): boolean;
begin
  Result := FRoleName_Specified;
end;

procedure User.SetEMail(Index: Integer; const AWideString: WideString);
begin
  FEMail := AWideString;
  FEMail_Specified := True;
end;

function User.EMail_Specified(Index: Integer): boolean;
begin
  Result := FEMail_Specified;
end;

procedure User.SetFullName(Index: Integer; const AWideString: WideString);
begin
  FFullName := AWideString;
  FFullName_Specified := True;
end;

function User.FullName_Specified(Index: Integer): boolean;
begin
  Result := FFullName_Specified;
end;

procedure User.SetRoleNames(Index: Integer; const AArrayOfstring: ArrayOfstring);
begin
  FRoleNames := AArrayOfstring;
  FRoleNames_Specified := True;
end;

function User.RoleNames_Specified(Index: Integer): boolean;
begin
  Result := FRoleNames_Specified;
end;

procedure User.SetSubscription(Index: Integer; const AArrayOfguid: ArrayOfguid);
begin
  FSubscription := AArrayOfguid;
  FSubscription_Specified := True;
end;

function User.Subscription_Specified(Index: Integer): boolean;
begin
  Result := FSubscription_Specified;
end;

procedure User.SetUserCode(Index: Integer; const AWideString: WideString);
begin
  FUserCode := AWideString;
  FUserCode_Specified := True;
end;

function User.UserCode_Specified(Index: Integer): boolean;
begin
  Result := FUserCode_Specified;
end;

procedure UserDetail.SetId(Index: Integer; const Aguid: guid);
begin
  FId := Aguid;
  FId_Specified := True;
end;

function UserDetail.Id_Specified(Index: Integer): boolean;
begin
  Result := FId_Specified;
end;

procedure UserPracticeNew.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function UserPracticeNew.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure UserPractice.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function UserPractice.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

destructor ClientList.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FCatalogue)-1 do
    SysUtils.FreeAndNil(FCatalogue[I]);
  System.SetLength(FCatalogue, 0);
  for I := 0 to System.Length(FClients)-1 do
    SysUtils.FreeAndNil(FClients[I]);
  System.SetLength(FClients, 0);
  inherited Destroy;
end;

procedure ClientList.SetCatalogue(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
begin
  FCatalogue := AArrayOfCatalogueEntry;
  FCatalogue_Specified := True;
end;

function ClientList.Catalogue_Specified(Index: Integer): boolean;
begin
  Result := FCatalogue_Specified;
end;

procedure ClientList.SetClients(Index: Integer; const AArrayOfClientSummary: ArrayOfClientSummary);
begin
  FClients := AArrayOfClientSummary;
  FClients_Specified := True;
end;

function ClientList.Clients_Specified(Index: Integer): boolean;
begin
  Result := FClients_Specified;
end;

procedure Client.SetBillingFrequency(Index: Integer; const AWideString: WideString);
begin
  FBillingFrequency := AWideString;
  FBillingFrequency_Specified := True;
end;

function Client.BillingFrequency_Specified(Index: Integer): boolean;
begin
  Result := FBillingFrequency_Specified;
end;

procedure Client.SetClientCode(Index: Integer; const AWideString: WideString);
begin
  FClientCode := AWideString;
  FClientCode_Specified := True;
end;

function Client.ClientCode_Specified(Index: Integer): boolean;
begin
  Result := FClientCode_Specified;
end;

procedure Client.SetMaxInactiveDays(Index: Integer; const AInteger: Integer);
begin
  FMaxInactiveDays := AInteger;
  FMaxInactiveDays_Specified := True;
end;

function Client.MaxInactiveDays_Specified(Index: Integer): boolean;
begin
  Result := FMaxInactiveDays_Specified;
end;

procedure Client.SetName_(Index: Integer; const AWideString: WideString);
begin
  FName_ := AWideString;
  FName__Specified := True;
end;

function Client.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

procedure Client.SetStatus(Index: Integer; const AStatus: Status);
begin
  FStatus := AStatus;
  FStatus_Specified := True;
end;

function Client.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure Client.SetSubscription(Index: Integer; const AArrayOfguid: ArrayOfguid);
begin
  FSubscription := AArrayOfguid;
  FSubscription_Specified := True;
end;

function Client.Subscription_Specified(Index: Integer): boolean;
begin
  Result := FSubscription_Specified;
end;

procedure ClientSummary.SetId(Index: Integer; const Aguid: guid);
begin
  FId := Aguid;
  FId_Specified := True;
end;

function ClientSummary.Id_Specified(Index: Integer): boolean;
begin
  Result := FId_Specified;
end;

destructor ClientDetail.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FCatalogue)-1 do
    SysUtils.FreeAndNil(FCatalogue[I]);
  System.SetLength(FCatalogue, 0);
  for I := 0 to System.Length(FRoles)-1 do
    SysUtils.FreeAndNil(FRoles[I]);
  System.SetLength(FRoles, 0);
  for I := 0 to System.Length(FUsers)-1 do
    SysUtils.FreeAndNil(FUsers[I]);
  System.SetLength(FUsers, 0);
  inherited Destroy;
end;

procedure ClientDetail.SetCatalogue(Index: Integer; const AArrayOfCatalogueEntry: ArrayOfCatalogueEntry);
begin
  FCatalogue := AArrayOfCatalogueEntry;
  FCatalogue_Specified := True;
end;

function ClientDetail.Catalogue_Specified(Index: Integer): boolean;
begin
  Result := FCatalogue_Specified;
end;

procedure ClientDetail.SetPrimaryContactUserId(Index: Integer; const Aguid: guid);
begin
  FPrimaryContactUserId := Aguid;
  FPrimaryContactUserId_Specified := True;
end;

function ClientDetail.PrimaryContactUserId_Specified(Index: Integer): boolean;
begin
  Result := FPrimaryContactUserId_Specified;
end;

procedure ClientDetail.SetRoles(Index: Integer; const AArrayOfRole: ArrayOfRole);
begin
  FRoles := AArrayOfRole;
  FRoles_Specified := True;
end;

function ClientDetail.Roles_Specified(Index: Integer): boolean;
begin
  Result := FRoles_Specified;
end;

procedure ClientDetail.SetUsers(Index: Integer; const AArrayOfUserDetail: ArrayOfUserDetail);
begin
  FUsers := AArrayOfUserDetail;
  FUsers_Specified := True;
end;

function ClientDetail.Users_Specified(Index: Integer): boolean;
begin
  Result := FUsers_Specified;
end;

procedure ClientNew.SetAbn(Index: Integer; const AWideString: WideString);
begin
  FAbn := AWideString;
  FAbn_Specified := True;
end;

function ClientNew.Abn_Specified(Index: Integer): boolean;
begin
  Result := FAbn_Specified;
end;

procedure ClientNew.SetAddress1(Index: Integer; const AWideString: WideString);
begin
  FAddress1 := AWideString;
  FAddress1_Specified := True;
end;

function ClientNew.Address1_Specified(Index: Integer): boolean;
begin
  Result := FAddress1_Specified;
end;

procedure ClientNew.SetAddress2(Index: Integer; const AWideString: WideString);
begin
  FAddress2 := AWideString;
  FAddress2_Specified := True;
end;

function ClientNew.Address2_Specified(Index: Integer): boolean;
begin
  Result := FAddress2_Specified;
end;

procedure ClientNew.SetAddress3(Index: Integer; const AWideString: WideString);
begin
  FAddress3 := AWideString;
  FAddress3_Specified := True;
end;

function ClientNew.Address3_Specified(Index: Integer): boolean;
begin
  Result := FAddress3_Specified;
end;

procedure ClientNew.SetAddressCountry(Index: Integer; const AWideString: WideString);
begin
  FAddressCountry := AWideString;
  FAddressCountry_Specified := True;
end;

function ClientNew.AddressCountry_Specified(Index: Integer): boolean;
begin
  Result := FAddressCountry_Specified;
end;

procedure ClientNew.SetCountryCode(Index: Integer; const AWideString: WideString);
begin
  FCountryCode := AWideString;
  FCountryCode_Specified := True;
end;

function ClientNew.CountryCode_Specified(Index: Integer): boolean;
begin
  Result := FCountryCode_Specified;
end;

procedure ClientNew.SetEmail(Index: Integer; const AWideString: WideString);
begin
  FEmail := AWideString;
  FEmail_Specified := True;
end;

function ClientNew.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure ClientNew.SetFax(Index: Integer; const AWideString: WideString);
begin
  FFax := AWideString;
  FFax_Specified := True;
end;

function ClientNew.Fax_Specified(Index: Integer): boolean;
begin
  Result := FFax_Specified;
end;

procedure ClientNew.SetGstNo(Index: Integer; const AWideString: WideString);
begin
  FGstNo := AWideString;
  FGstNo_Specified := True;
end;

function ClientNew.GstNo_Specified(Index: Integer): boolean;
begin
  Result := FGstNo_Specified;
end;

procedure ClientNew.SetMobile(Index: Integer; const AWideString: WideString);
begin
  FMobile := AWideString;
  FMobile_Specified := True;
end;

function ClientNew.Mobile_Specified(Index: Integer): boolean;
begin
  Result := FMobile_Specified;
end;

procedure ClientNew.SetPhone(Index: Integer; const AWideString: WideString);
begin
  FPhone := AWideString;
  FPhone_Specified := True;
end;

function ClientNew.Phone_Specified(Index: Integer): boolean;
begin
  Result := FPhone_Specified;
end;

procedure ClientNew.SetSalutation(Index: Integer; const AWideString: WideString);
begin
  FSalutation := AWideString;
  FSalutation_Specified := True;
end;

function ClientNew.Salutation_Specified(Index: Integer): boolean;
begin
  Result := FSalutation_Specified;
end;

procedure ClientNew.SetTfn(Index: Integer; const AWideString: WideString);
begin
  FTfn := AWideString;
  FTfn_Specified := True;
end;

function ClientNew.Tfn_Specified(Index: Integer): boolean;
begin
  Result := FTfn_Specified;
end;

procedure ClientNew.SetVatNo(Index: Integer; const AWideString: WideString);
begin
  FVatNo := AWideString;
  FVatNo_Specified := True;
end;

function ClientNew.VatNo_Specified(Index: Integer): boolean;
begin
  Result := FVatNo_Specified;
end;

procedure ClientUpdate.SetPrimaryContactUserId(Index: Integer; const Aguid: guid);
begin
  FPrimaryContactUserId := Aguid;
  FPrimaryContactUserId_Specified := True;
end;

function ClientUpdate.PrimaryContactUserId_Specified(Index: Integer): boolean;
begin
  Result := FPrimaryContactUserId_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IBlopiServiceFacade), 'http://www.banklinkonline.com/2011/11/Blopi', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IBlopiServiceFacade), 'http://www.banklinkonline.com/2011/11/Blopi/IBlopiServiceFacade/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IBlopiServiceFacade), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(guid), 'http://schemas.microsoft.com/2003/10/Serialization/', 'guid');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfstring), 'http://schemas.microsoft.com/2003/10/Serialization/Arrays', 'ArrayOfstring');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfguid), 'http://schemas.microsoft.com/2003/10/Serialization/Arrays', 'ArrayOfguid');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfCatalogueEntry), 'http://www.banklinkonline.com/2011/11/Blopi', 'ArrayOfCatalogueEntry');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfServiceErrorMessage), 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'ArrayOfServiceErrorMessage');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfExceptionDetails), 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'ArrayOfExceptionDetails');
  RemClassRegistry.RegisterXSClass(MessageResponse, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponse');
  RemClassRegistry.RegisterXSClass(MessageResponseOfArrayOfCatalogueEntryMIdCYrSK, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfArrayOfCatalogueEntryMIdCYrSK');
  RemClassRegistry.RegisterXSClass(ServiceErrorMessage, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'ServiceErrorMessage');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ServiceErrorMessage), 'Message_', 'Message');
  RemClassRegistry.RegisterXSClass(ExceptionDetails, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'ExceptionDetails');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ExceptionDetails), 'Message_', 'Message');
  RemClassRegistry.RegisterXSClass(MessageResponseOfPracticeDetailMIdCYrSK, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfPracticeDetailMIdCYrSK');
  RemClassRegistry.RegisterXSClass(MessageResponseOfguid, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfguid');
  RemClassRegistry.RegisterXSClass(MessageResponseOfClientListMIdCYrSK, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfClientListMIdCYrSK');
  RemClassRegistry.RegisterXSClass(MessageResponseOfClientDetailMIdCYrSK, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfClientDetailMIdCYrSK');
  RemClassRegistry.RegisterXSClass(MessageResponseOfArrayOfCatalogueEntryMIdCYrSK2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfArrayOfCatalogueEntryMIdCYrSK2', 'MessageResponseOfArrayOfCatalogueEntryMIdCYrSK');
  RemClassRegistry.RegisterXSClass(MessageResponse2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponse2', 'MessageResponse');
  RemClassRegistry.RegisterXSClass(ServiceErrorMessage2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'ServiceErrorMessage2', 'ServiceErrorMessage');
  RemClassRegistry.RegisterXSClass(ExceptionDetails2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'ExceptionDetails2', 'ExceptionDetails');
  RemClassRegistry.RegisterXSClass(MessageResponseOfPracticeDetailMIdCYrSK2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfPracticeDetailMIdCYrSK2', 'MessageResponseOfPracticeDetailMIdCYrSK');
  RemClassRegistry.RegisterXSClass(MessageResponseOfguid2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfguid2', 'MessageResponseOfguid');
  RemClassRegistry.RegisterXSClass(MessageResponseOfClientListMIdCYrSK2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfClientListMIdCYrSK2', 'MessageResponseOfClientListMIdCYrSK');
  RemClassRegistry.RegisterXSClass(MessageResponseOfClientDetailMIdCYrSK2, 'http://schemas.datacontract.org/2004/07/BankLink.Common.Services', 'MessageResponseOfClientDetailMIdCYrSK2', 'MessageResponseOfClientDetailMIdCYrSK');
  RemClassRegistry.RegisterXSClass(CatalogueEntry, 'http://www.banklinkonline.com/2011/11/Blopi', 'CatalogueEntry');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfRole), 'http://www.banklinkonline.com/2011/11/Blopi', 'ArrayOfRole');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Status), 'http://www.banklinkonline.com/2011/11/Blopi', 'Status');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfUserDetail), 'http://www.banklinkonline.com/2011/11/Blopi', 'ArrayOfUserDetail');
  RemClassRegistry.RegisterXSClass(Practice, 'http://www.banklinkonline.com/2011/11/Blopi', 'Practice');
  RemClassRegistry.RegisterXSClass(PracticeDetail, 'http://www.banklinkonline.com/2011/11/Blopi', 'PracticeDetail');
  RemClassRegistry.RegisterXSClass(Role, 'http://www.banklinkonline.com/2011/11/Blopi', 'Role');
  RemClassRegistry.RegisterXSClass(User, 'http://www.banklinkonline.com/2011/11/Blopi', 'User');
  RemClassRegistry.RegisterXSClass(UserDetail, 'http://www.banklinkonline.com/2011/11/Blopi', 'UserDetail');
  RemClassRegistry.RegisterXSClass(UserPracticeNew, 'http://www.banklinkonline.com/2011/11/Blopi', 'UserPracticeNew');
  RemClassRegistry.RegisterXSClass(UserPractice, 'http://www.banklinkonline.com/2011/11/Blopi', 'UserPractice');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfClientSummary), 'http://www.banklinkonline.com/2011/11/Blopi', 'ArrayOfClientSummary');
  RemClassRegistry.RegisterXSClass(ClientList, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientList');
  RemClassRegistry.RegisterXSClass(Client, 'http://www.banklinkonline.com/2011/11/Blopi', 'Client');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Client), 'Name_', 'Name');
  RemClassRegistry.RegisterXSClass(ClientSummary, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientSummary');
  RemClassRegistry.RegisterXSClass(ClientDetail, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientDetail');
  RemClassRegistry.RegisterXSClass(ClientNew, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientNew');
  RemClassRegistry.RegisterXSClass(ClientUpdate, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientUpdate');
  RemClassRegistry.RegisterXSClass(CatalogueEntry2, 'http://www.banklinkonline.com/2011/11/Blopi', 'CatalogueEntry2', 'CatalogueEntry');
  RemClassRegistry.RegisterXSClass(PracticeDetail2, 'http://www.banklinkonline.com/2011/11/Blopi', 'PracticeDetail2', 'PracticeDetail');
  RemClassRegistry.RegisterXSClass(Practice2, 'http://www.banklinkonline.com/2011/11/Blopi', 'Practice2', 'Practice');
  RemClassRegistry.RegisterXSClass(Role2, 'http://www.banklinkonline.com/2011/11/Blopi', 'Role2', 'Role');
  RemClassRegistry.RegisterXSClass(UserDetail2, 'http://www.banklinkonline.com/2011/11/Blopi', 'UserDetail2', 'UserDetail');
  RemClassRegistry.RegisterXSClass(User2, 'http://www.banklinkonline.com/2011/11/Blopi', 'User2', 'User');
  RemClassRegistry.RegisterXSClass(UserPracticeNew2, 'http://www.banklinkonline.com/2011/11/Blopi', 'UserPracticeNew2', 'UserPracticeNew');
  RemClassRegistry.RegisterXSClass(UserPractice2, 'http://www.banklinkonline.com/2011/11/Blopi', 'UserPractice2', 'UserPractice');
  RemClassRegistry.RegisterXSClass(ClientList2, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientList2', 'ClientList');
  RemClassRegistry.RegisterXSClass(ClientSummary2, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientSummary2', 'ClientSummary');
  RemClassRegistry.RegisterXSClass(Client2, 'http://www.banklinkonline.com/2011/11/Blopi', 'Client2', 'Client');
  RemClassRegistry.RegisterXSClass(ClientDetail2, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientDetail2', 'ClientDetail');
  RemClassRegistry.RegisterXSClass(ClientNew2, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientNew2', 'ClientNew');
  RemClassRegistry.RegisterXSClass(ClientUpdate2, 'http://www.banklinkonline.com/2011/11/Blopi', 'ClientUpdate2', 'ClientUpdate');

end.