unit bkUrls;

interface

uses
  bkProduct;
  
type
  TUrls = class
  private
    class function GetBankLinkWebSites(Index: Integer): String; static;
    class function GetBankLinkWebSiteURLs(Index: Integer): String; static;
  public
    class function DefaultNZCatalogServer: String; static;
    class function DefaultAUCatalogServer: String; static;
    class function DefaultUKCatalogServer: String; static;
    class function DefaultDownloaderURL: String; static;
    class function DefaultDownloaderURL2: String; static;
    class function DefaultWebNotesURL: String; static;
    class function DefaultWebNotesMethodURI: String; static;
    class function DefaultBConnectPrimaryHost: String; static;
    class function DefaultBConnectSecondaryHost: String; static;
    class function BooksOnlineDefaultUrl: String; static;
    class function OnlineServicesDefaultUrl: String; static;
    class function DefInstListLinkNZ: String; static;
    class function DefInstListLinkAU: String; static;
    class function DefInstListLinkUK: String; static;
    class function ProvisionalAccountUrl: String; static;

    class property BankLinkWebSites[Index: Integer]: String read GetBankLinkWebSites;
    class property BankLinkWebSiteURLs[Index: Integer]: String read GetBankLinkWebSiteURLs;
  end;
  
implementation

uses
  bkBranding, Globals, bkConst;

{ TUrls }

class function TUrls.BooksOnlineDefaultUrl: String;
begin
  Result := OnlineServicesDefaultUrl;
end;

class function TUrls.DefaultAUCatalogServer: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'www.bankstream.com.au';
  end
  else
  }
  begin
    Result := 'www.banklink.com.au';
  end;
end;

class function TUrls.DefaultBConnectPrimaryHost: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'secure1.bankstream.co.nz';
  end
  else
  }
  begin
    Result := 'secure1.banklink.co.nz'
  end;
end;

class function TUrls.DefaultBConnectSecondaryHost: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'secure2.bankstream.co.nz';
  end
  else
  }
  begin
    Result := 'secure2.banklink.co.nz'
  end;
end;

class function TUrls.DefaultDownloaderURL: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'https://secure2.bankstream.co.nz/DownloaderService/DownloaderService.svc';
  end
  else
  }
  begin
    Result := 'https://secure2.banklink.co.nz/DownloaderService/DownloaderService.svc';
  end;
end;

class function TUrls.DefaultDownloaderURL2: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'https://secure1.bankstream.co.nz/DownloaderService/DownloaderService.svc';
  end
  else
  }
  begin
    Result := 'https://secure1.banklink.co.nz/DownloaderService/DownloaderService.svc';
  end;
end;

class function TUrls.DefaultNZCatalogServer: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'www.bankstream.co.nz'
  end
  else
  }
  begin
    Result := 'www.banklink.co.nz'
  end;
end;

class function TUrls.DefaultUKCatalogServer: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'www.bankstream.co.uk';
  end
  else
  }
  begin
    Result := 'www.banklink.co.uk';
  end;
end;

class function TUrls.DefaultWebNotesMethodURI: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'http://Bankstream.WebNotes.Interfaces/IPracticeIntegrationFacade';
  end
  else
  }
  begin
    Result := 'http://BankLink.WebNotes.Interfaces/IPracticeIntegrationFacade';
  end;
end;

class function TUrls.DefaultWebNotesURL: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'https://www.bankstreamonline.com/services/practiceintegrationfacade.svc';
  end
  else
  }
  begin
    Result := 'https://www.banklinkonline.com/services/practiceintegrationfacade.svc';
  end;
end;

class function TUrls.DefInstListLinkAU: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'http://www.bankstream.com.au/about_institutions.html';
  end
  else
  }
  begin
    Result := 'http://www.banklink.com.au/about_institutions.html';
  end;
end;

class function TUrls.DefInstListLinkNZ: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'http://www.bankstream.co.nz/about_institutions.html';
  end
  else
  }
  begin
    Result := 'http://www.banklink.co.nz/about_institutions.html';
  end;
end;

class function TUrls.DefInstListLinkUK: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'http://www.bankstream.co.uk/about_institutions.html';
  end
  else
  }
  begin
    Result := 'http://www.banklink.co.uk/about_institutions.html';
  end;
end;

class function TUrls.GetBankLinkWebSites(Index: Integer): String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'www.bankstream.co.uk'
  end
  else
  }
  begin
    Result := whBankLinkWebSites[Index];
  end;
end;

class function TUrls.GetBankLinkWebSiteURLs(Index: Integer): String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'http://www.bankstream.co.uk';
  end
  else
  }
  begin
    Result := whBankLinkWebSiteURLs[Index];
  end;
end;

class function TUrls.OnlineServicesDefaultUrl: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'https://www.bankstreamonline.com';
  end
  else
   }
  begin
    Result := 'https://www.banklinkonline.com';
  end;
end;

class function TUrls.ProvisionalAccountUrl: String;
begin
  {
  if TProduct.ProductBrand = btBankstream then
  begin
    Result := 'http://www.bankstream.co.nz';
  end
  else
  }
  begin
    Result := 'http://www.banklink.co.nz';
  end;  
end;

end.
