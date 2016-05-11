unit utPromoWindow;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, SYDEFS, Windows, ExtCtrls, ipshttps, PromoWindowObj, WinUtils, Classes,
  LogUtil, contnrs, SysUtils, Graphics, uLKJSON, uHttpLib;

type
  // Test methods for class TContentfulDataList

  TestTContentfulDataList = class(TTestCase)
  strict private
    FContentfulDataList: TContentfulDataList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPromoWindowContents;
    procedure TestProcessEmptyJSON;
    procedure TestProcessInvalidJSON;
  end;

implementation

procedure TestTContentfulDataList.SetUp;
begin
  FContentfulDataList := TContentfulDataList.Create;
end;

procedure TestTContentfulDataList.TearDown;
begin
  FContentfulDataList.Free;
  FContentfulDataList := nil;
end;

procedure TestTContentfulDataList.TestProcessEmptyJSON;
var
  aJSONData : string;
begin
  aJSONData := '';
  FContentfulDataList.ProcessJSONData(aJSONData);
end;

procedure TestTContentfulDataList.TestProcessInvalidJSON;
var
  aJSONData : string;
begin
  aJSONData := '{"sys": {"type": "Array"},"total": 13,"skip": 0,"limit": 100,"items": [{"fields": {"title": "Maintenance update available","description": "Some practices have reported a number of issues in BankLink Practice 5.29",';
  aJSONData := aJSONData + '"priority": 0,"geography": ["any"],"validVersions": [          "5.29.2",          "5.29.3"        ],';
  aJSONData := aJSONData + '"userType": ["admin","normal","restricted"],"id": "Ebva10lsCyqUQWyKS4i2G","revision": 4,"createdAt": "2015-12-16T04:21:54.477Z","updatedAt": "2015-12-16T19:51:46.088Z","locale": "en-US"}}, ],}}';
  FContentfulDataList.ProcessJSONData(aJSONData);
end;

procedure TestTContentfulDataList.TestPromoWindowContents;
var
  ReturnValue: Boolean;
  Retries: Integer;
  RetryCount: Integer;
  aContentType: TContentType;
begin
  aContentType := ctAll;
  RetryCount := 3;
  ReturnValue := FContentfulDataList.GetContents(aContentType, RetryCount, Retries);
  CheckTrue(ReturnValue = True);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTContentfulDataList.Suite);
end.
