unit utPromoDisplayForm;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, IdHTTP, dxGDIPlusClasses, IdTCPClient, PageNavigation, Contnrs, 
  SysUtils, PromoContentFme, ComCtrls, Windows, bkRichEdit, StdCtrls, Messages, 
  PromoDisplayForm, Variants, Controls, Classes, PromoWindowObj, IdComponent, Dialogs, 
  IdBaseComponent, Forms, IdTCPConnection, Buttons, OSFont, ExtCtrls, Graphics, ImgList;

type
  // Test methods for class TPromoDisplayFrm

  TestTPromoDisplayFrm = class(TTestCase)
  strict private
    FPromoDisplayFrm: TPromoDisplayFrm;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestWindowShow;
  end;

implementation

procedure TestTPromoDisplayFrm.SetUp;
begin
  FPromoDisplayFrm := TPromoDisplayFrm.Create(nil);
end;

procedure TestTPromoDisplayFrm.TearDown;
begin
  FPromoDisplayFrm.Free;
  FPromoDisplayFrm := nil;
end;

procedure TestTPromoDisplayFrm.TestWindowShow;
var
  aJSONData : string;
begin
  aJSONData := '';
  DisplayPromoContents.SourceContents.ProcessJSONData(aJSONData);
  FPromoDisplayFrm.FormShow(Application);
  Check(DisplayPromoContents.SourceContents.Count = 0);

  aJSONData := '{"sys": {"type": "Array"},"total": 13,"skip": 0,"limit": 100,"items": [{"fields": {"title": "Maintenance update available","description": "Some practices have reported a number of issues in BankLink Practice 5.29",';
  aJSONData := aJSONData + '"priority": 0,"geography": ["any"],"validVersions": [          "5.29.2",          "5.29.3"        ],';
  aJSONData := aJSONData + '"userType": ["admin","normal","restricted"],"id": "Ebva10lsCyqUQWyKS4i2G","revision": 4,"createdAt": "2015-12-16T04:21:54.477Z","updatedAt": "2015-12-16T19:51:46.088Z","locale": "en-US"}}, ],}}';
  DisplayPromoContents.SourceContents.ProcessJSONData(aJSONData);
  FPromoDisplayFrm.FormShow(Application);
  Check(DisplayPromoContents.SourceContents.Count = 0);

  aJSONData := '{"sys": {"type": "Array"},"total": 13,"skip": 0,"limit": 100,"items": [{';
  aJSONData := aJSONData + '"fields": {"title": "We have added more bank feeds",';
  aJSONData := aJSONData + '"description": "We�re committed to the ongoing improvement and investment in bank feeds so that you';
  aJSONData := aJSONData + 'continue to have timely access to the best quality and best coverage of secure and direct client transactional';
  aJSONData := aJSONData + 'data. \n\nSince our last release in June, we now include all personal and business credit cards';
  aJSONData := aJSONData + 'for **Westpac NZ**.","priority": 7,"geography": ["nz"],';
  aJSONData := aJSONData + '"validVersions": ["5.29.2","5.29.3"],';
  aJSONData := aJSONData + '"userType": ["practice"]},';
  aJSONData := aJSONData + '"sys": {"space": {"sys": {"type": "Link","linkType": "Space","id": "wdv0bic4eogs"}},';
  aJSONData := aJSONData + '"type": "Entry","contentType": {"sys": {"type": "Link","linkType": "ContentType"';
  aJSONData := aJSONData + '"id": "Ts5nC2Lm24ISAQm4aUO6E"}},"id": "1mc3CXjoMMceqKMaaOQUKi","revision": 12,';
  aJSONData := aJSONData + '"createdAt": "2015-09-30T02:23:59.069Z","updatedAt": "2016-02-09T22:06:12.876Z","locale": "en-US"}},],}';
  DisplayPromoContents.SourceContents.ProcessJSONData(aJSONData);
  FPromoDisplayFrm.FormShow(Application);
  Check(DisplayPromoContents.SourceContents.Count = 1);

end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTPromoDisplayFrm.Suite);
end.

