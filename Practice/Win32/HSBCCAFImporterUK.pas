unit HSBCCAFImporterUK;

interface

uses
  Windows, SysUtils, CAFImporter, PDFFieldEditor;

type
  TCAFSourceHelper = class helper for TCAFSource
  strict private
    function GetAccountName: String;
    function GetAccountNo: String;
    function GetAddressLine1: String;
    function GetAddressLine2: String;
    function GetAddressLine3: String;
    function GetAddressLine4: String;
    function GetBank: String;
    function GetBranch: String;
    function GetClientCode: String;
    function GetCostCode: String;
    function GetFrequency: String;
    function GetMonth: String;
    function GetPostCode: String;
    function GetProvisional: String;
    function GetSortCode: String;
    function GetYear: String;
    function GetAccountSignatory1: String;
    function GetAccountSignatory2: String;
  public
    property AccountName: String read GetAccountName;
    property SortCode: String read GetSortCode;
    property AccountNo: String read GetAccountNo;
    property AccountSignatory1: String read GetAccountSignatory1;
    property AccountSignatory2: String read GetAccountSignatory2;
    property ClientCode: String read GetClientCode;
    property CostCode: String read GetCostCode;
    property Bank: String read GetBank;
    property Branch: String read GetBranch;
    property Month: String read GetMonth;
    property Year: String read GetYear;
    property Frequency: String read GetFrequency;
    property Provisional: String read GetProvisional;
    property AddressLine1: String read GetAddressLine1;
    property AddressLine2: String read GetAddressLine2;
    property AddressLine3: String read GetAddressLine3;
    property AddressLine4: String read GetAddressLine4;
    property PostCode: String read GetPostCode;
  end;

  TPDFEditorHelper = class helper for TPDFFieldEdit
  public
    function FieldByTitle(const FieldTitle: String): TPDFFormFieldItem;
  end;

  THSBCCAFImporterUK = class(TCAFImporter)
  private
    FCAFCount: Integer;
    FMultiImport: Boolean;
  protected
    procedure ImportAsPDF(Source: TCAFSource; const OutputFolder: String); override;
    procedure DoRecordValidation(Source: TCAFSource); override;
    procedure DoFieldValidation(Source: TCAFSource); override;
    procedure Initialize(Source: TCAFSource); override;
  public
  end;

implementation

uses
  BKConst, Globals, DirUtils;
  
procedure THSBCCAFImporterUK.ImportAsPDF(Source: TCAFSource; const OutputFolder: String);
var
  Document: TPdfFieldEdit;
  Index: Integer;
  TemplateFile: String;
  OutputFile: String;
begin
  TemplateFile := AppendFileNameToPath(TemplateDir, istUKTemplateFileNames[1]);

  if FileExists(TemplateFile) then
  begin
    Document := TPdfFieldEdit.Create(nil);

    try
      Document.LoadPDF(TemplateFile);
      
      Document.FieldByTitle(ukCAFPracticeCode).Value := AdminSystem.fdFields.fdBankLink_Code; 
      Document.FieldByTitle(ukCAFPracticeName).Value := AdminSystem.fdFields.fdPractice_Name_for_Reports;
                                                                        
      Document.FieldByTitle(ukCAFClientCode).Value := Source.ClientCode;

      Document.FieldByTitle(ukCAFNameOfAccount).Value := Source.AccountName;
      Document.FieldByTitle(ukCAFAccountNumber).Value := Source.AccountNo;
      Document.FieldByTitle(ukCAFBankName).Value := Source.Bank;
      Document.FieldByTitle(ukCAFBranchName).Value := Source.Branch;
      Document.FieldByTitle(ukCAFStartMonth).Value := Source.Month;
      Document.FieldByTitle(ukCAFStartYear).Value := Source.Year;

      Document.FieldByTitle(ukCAFCostCode).Value := Source.CostCode;

      if CompareText(Trim(Source.Provisional), 'Y') = 0 then
      begin
        Document.FieldByTitle(ukCAFSupplyProvisionalAccounts).Value := '1';
      end;

      if CompareText(Trim(Source.Frequency), 'M') = 0 then
      begin
        Document.FieldByTitle(ukCAFMonthly).Value := '1';
      end
      else
      if CompareText(Trim(Source.Frequency), 'W') = 0 then
      begin
        Document.FieldByTitle(ukCAFWeekly).Value := '1';
      end
      else
      begin
        Document.FieldByTitle(ukCAFDaily).Value := '1';
      end;

      Document.FieldByTitle(ukCAFHSBCAccountSign1).Value := Source.AccountSignatory1;
      Document.FieldByTitle(ukCAFHSBCAccountSign2).Value := Source.AccountSignatory2;
                  
                  
      Document.FieldByTitle(ukCAFHSBCAddressLine1).Value := Source.AddressLine1;
      Document.FieldByTitle(ukCAFHSBCAddressLine2).Value := Source.AddressLine2;
      Document.FieldByTitle(ukCAFHSBCAddressLine3).Value := Source.AddressLine3;
      Document.FieldByTitle(ukCAFHSBCAddressLine4).Value := Source.AddressLine4;
                         
      Document.FieldByTitle(ukCAFHSBCPostalCode).Value := Source.PostCode;

      if FMultiImport then
      begin
        OutputFile := AppendFileNameToPath(OutputFolder, Format('Customer Authority Form%s%s.PDF', [Source.ClientCode, FCAFCount + 1]));
      end
      else
      begin
        OutputFile := AppendFileNameToPath(OutputFolder, 'Customer Authority Form.PDF');
      end;
      
      Document.SaveToFile(OutputFile);

      Inc(FCAFCount);
    finally
      Document.Free;
    end;
  end
  else
  begin
    raise Exception.Create(Format('Template document %s not found', [TemplateFile]));
  end;
end;

procedure THSBCCAFImporterUK.Initialize(Source: TCAFSource);
begin
  FCAFCount := 0;

  //Skip the field names row
  if CompareText(Trim(Source.AccountName), 'Account Name') = 0 then
  begin
    FMultiImport := Source.Count - 1 > 1;
    
    Source.Next;
  end
  else
  begin
    FMultiImport := Source.Count > 1;
  end;
end;

procedure THSBCCAFImporterUK.DoFieldValidation(Source: TCAFSource);
begin
  if Source.FieldCount < 18 then
  begin
    AddError('Fields', 'The file does not contain enough fields'); 
  end;
end;

procedure THSBCCAFImporterUK.DoRecordValidation(Source: TCAFSource);
begin
  if (Trim(Source.AccountName) = '') and (Trim(Source.SortCode) = '') and (Trim(Source.AccountNo) = '') then
  begin
    AddImportError(Source, 'You must enter the name of the account or the sort code or the account number.');
  end;

  if ContainsSymbols(Trim(Source.ClientCode)) then
  begin
    AddImportError(Source, 'The client code can only contain alpha numeric characters.');
  end;

  if ContainsSymbols(Trim(Source.CostCode)) then
  begin
    AddImportError(Source, 'The cost code can only contain alpha numeric characters.');
  end;

  if (Trim(Source.Month) = '') and (Trim(Source.Year) <> '') then
  begin
    AddImportError(Source, 'You must choose a starting month.');
  end
  else
  if CompareText(Source.Month, 'ASAP') <> 0 then
  begin
    if not IsLongMonthName(Trim(Source.Month)) then
    begin
      AddImportError(Source, 'You must enter a valid starting month.');
    end;
  end;

  if (Trim(Source.Year) = '') then
  begin
    if (CompareText(Source.Month, 'ASAP') <> 0) then
    begin
      AddImportError(Source, 'You must enter a valid starting year.');
    end;
  end
  else
  begin
    if Length(Trim(Source.Year)) = 2 then
    begin
      if not IsNumber(Source.Year) then
      begin
        AddImportError(Source, 'You must enter a valid starting year.');
      end;
    end
    else
    begin
      AddImportError(Source, 'You must enter a valid starting year.');
    end;
  end;
end;

{ TCAFSourceHelper }

function TCAFSourceHelper.GetAccountName: String;
begin
  Result := ValueByIndex(0);
end;

function TCAFSourceHelper.GetAccountNo: String;
begin
  Result := ValueByIndex(2);
end;

function TCAFSourceHelper.GetAccountSignatory1: String;
begin
  Result := ValueByIndex(3);
end;

function TCAFSourceHelper.GetAccountSignatory2: String;
begin
  Result := ValueByIndex(4);
end;

function TCAFSourceHelper.GetAddressLine1: String;
begin
  Result := ValueByIndex(13);
end;

function TCAFSourceHelper.GetAddressLine2: String;
begin
  Result := ValueByIndex(14);
end;

function TCAFSourceHelper.GetAddressLine3: String;
begin
  Result := ValueByIndex(15);
end;

function TCAFSourceHelper.GetAddressLine4: String;
begin
  Result := ValueByIndex(16);
end;

function TCAFSourceHelper.GetBank: String;
begin
  Result := ValueByIndex(7);
end;

function TCAFSourceHelper.GetBranch: String;
begin
  Result := ValueByIndex(8);
end;

function TCAFSourceHelper.GetClientCode: String;
begin
  Result := ValueByIndex(5);
end;

function TCAFSourceHelper.GetCostCode: String;
begin
  Result := ValueByIndex(6);
end;

function TCAFSourceHelper.GetFrequency: String;
begin
  Result := ValueByIndex(11);
end;

function TCAFSourceHelper.GetMonth: String;
begin
  Result := ValueByIndex(9);
end;

function TCAFSourceHelper.GetPostCode: String;
begin
  Result := ValueByIndex(17);
end;

function TCAFSourceHelper.GetProvisional: String;
begin
  Result := ValueByIndex(12);
end;

function TCAFSourceHelper.GetSortCode: String;
begin
  Result := ValueByIndex(1);
end;

function TCAFSourceHelper.GetYear: String;
begin
  Result := ValueByIndex(10);
end;

{ TPDFEditorHelper }

function TPDFEditorHelper.FieldByTitle(const FieldTitle: String): TPDFFormFieldItem;
begin
  Result := PDFFormFields.GetFieldByTitle(FieldTitle);

  if Result = nil then
  begin
    raise Exception.Create(Format('Field %s not found', [FieldTitle])); 
  end;
end;

end.
