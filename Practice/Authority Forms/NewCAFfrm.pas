unit NewCAFfrm;

//------------------------------------------------------------------------------
interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  PdfFieldEditor;

type
  TfrmNewCAF = class(TForm)
    btnFile: TButton;
    btnEmail: TButton;
    btnPrint: TButton;
    btnResetForm: TButton;
    btnCancel: TButton;
    PdfFieldEdit: TPdfFieldEdit;
    procedure edtClientCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtServiceStartYearKeyPress(Sender: TObject; var Key: Char);
    procedure edtCostCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbServiceStartMonthChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFileClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnResetFormClick(Sender: TObject);
    procedure edtAccountNumberKeyPress(Sender: TObject; var Key: Char);
  private
    FButton: Byte;

    procedure UpperCaseTextKeyPress(Sender: TObject; var Key: Char);
    procedure NumericDashKeyPress(Sender: TObject; var Key: Char);
    procedure NumericKeyPress(Sender: TObject; var Key: Char);

    function ValidateForm: Boolean;

    function GetPDFFormFieldEdit(aTitle : WideString) : TPDFFormFieldItemEdit;
    function InitPDF(aCountry, aInstitution : integer) : boolean;
  public
    function Execute(aCountry, aInstitution : integer) : boolean;

    property ButtonPressed: Byte read FButton;
  end;

  function OpenCustAuth(w_PopupParent: Forms.TForm; aCountry : integer) : boolean;

//------------------------------------------------------------------------------
implementation
{$R *.dfm}

uses
  ErrorMoreFrm,
  bkConst,
  globals,
  SelectInstitutionfrm,
  MailFrm;

//------------------------------------------------------------------------------
function OpenCustAuth(w_PopupParent: Forms.TForm; aCountry : integer) : boolean;
var
  frmNewCAF: TfrmNewCAF;
  Institution : integer;
begin
  Result := false;
  Institution := istUKNone;

  if aCountry = whUK then
  begin
    Institution := PickCAFInstitution(w_PopupParent, aCountry);
    if Institution = istUKNone then
      Exit;
  end;

  frmNewCAF := TfrmNewCAF.Create(Application);
  try
    //Required for the proper handling of the window z-order so that a modal window does not show-up behind another window
    frmNewCAF.PopupParent := w_PopupParent;
    frmNewCAF.PopupMode := pmExplicit;
    //Todo  //BKHelpSetUp(frmNewCAF, ----);

    Result := frmNewCAF.Execute(aCountry, Institution);
  finally
    FreeAndNil(frmNewCAF);
  end;
end;

//------------------------------------------------------------------------------
function TfrmNewCAF.Execute(aCountry, aInstitution : integer): boolean;
begin
  Result := false;

  if not (aCountry = whUK) then
    Exit;

  if aInstitution = istUKNone then
    Exit;

  if not InitPDF(aCountry, aInstitution) then
    Exit;

  ShowModal;

  Result := true;
end;

//------------------------------------------------------------------------------
function TfrmNewCAF.GetPDFFormFieldEdit(aTitle : WideString) : TPDFFormFieldItemEdit;
var
  PDFFormFieldItem : TPDFFormFieldItem;
begin
  Result := Nil;

  PDFFormFieldItem := PdfFieldEdit.PDFFormFields.GetFieldByTitle(aTitle);
  if (PDFFormFieldItem is TPDFFormFieldItemEdit) then
    Result := TPDFFormFieldItemEdit(PDFFormFieldItem);
end;

//------------------------------------------------------------------------------
function TfrmNewCAF.InitPDF(aCountry, aInstitution: integer): boolean;
var
  PDFFilePath : Widestring;
  PDFFormFieldItemEdit : TPDFFormFieldItemEdit;
begin
  Result := false;

  if not DirectoryExists( GLOBALS.TemplateDir ) then
  begin
    HelpfulErrorMsg('Can''t find Templates Direcotry - ' + GLOBALS.TemplateDir, 0);
    Exit;
  end;

  PDFFilePath := GLOBALS.TemplateDir + istUKTemplateFileNames[aInstitution];

  if not FileExists( PDFFilePath ) then
  begin
    HelpfulErrorMsg('Can''t find Template - ' + PDFFilePath, 0);
    Exit;
  end;

  try
    PdfFieldEdit.PDFFilePath := PDFFilePath;
    PdfFieldEdit.Zoom := 3;
    PdfFieldEdit.Active := true;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormNameOfAccount);
    if Assigned(PDFFormFieldItemEdit) then
      PDFFormFieldItemEdit.MaxLength := 60;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormBankCode);
    if Assigned(PDFFormFieldItemEdit) then
    begin
      PDFFormFieldItemEdit.MaxLength := 8;
      PDFFormFieldItemEdit.OnKeyPressed := NumericDashKeyPress;
    end;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormAccountNumber);
    if Assigned(PDFFormFieldItemEdit) then
      PDFFormFieldItemEdit.MaxLength := 22;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormClientCode);
    if Assigned(PDFFormFieldItemEdit) then
    begin
      PDFFormFieldItemEdit.MaxLength := 8;
      PDFFormFieldItemEdit.OnKeyPressed := UpperCaseTextKeyPress;
    end;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormCostCode);
    if Assigned(PDFFormFieldItemEdit) then
    begin
      PDFFormFieldItemEdit.MaxLength := 8;
      PDFFormFieldItemEdit.OnKeyPressed := UpperCaseTextKeyPress;
    end;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormBankName);
    if Assigned(PDFFormFieldItemEdit) then
      PDFFormFieldItemEdit.MaxLength := 60;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormBranchName);
    if Assigned(PDFFormFieldItemEdit) then
      PDFFormFieldItemEdit.MaxLength := 60;

    PDFFormFieldItemEdit := GetPDFFormFieldEdit(ukNormStartYear);
    if Assigned(PDFFormFieldItemEdit) then
    begin
      PDFFormFieldItemEdit.MaxLength := 2;
      PDFFormFieldItemEdit.OnKeyPressed := NumericKeyPress;
    end;

    Result := True;
  except
    on E : Exception do
      HelpfulErrorMsg('Error loading Customer Authority form - ' +  e.Message , 0);
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.UpperCaseTextKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z','A'..'Z','0'..'9',Chr(vk_Back)]) then
    Key := #0 // Discard the key
  else
    Key := UpCase(Key); // Upper case
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.NumericDashKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','-',Chr(vk_Back)]) then
    Key := #0; // Discard the key
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.NumericKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',Chr(vk_Back)]) then
    Key := #0; // Discard the key
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.btnEmailClick(Sender: TObject);
var
  EmailAddress: string;
  AttachmentSent: Boolean;
begin
  if ValidateForm then
  begin
    EmailAddress := AdminSystem.fdFields.fdPractice_EMail_Address;
    // TODO: Need to include the third party authority PDF (see SendFileTo parameters in MailFrm)
    MailFrm.SendFileTo('Send Customer Authority Form', 'test', '', '', AttachmentSent, False);
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.btnFileClick(Sender: TObject);
begin
//  if ValidateForm then
// TODO: File
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.btnPrintClick(Sender: TObject);
begin
//  if ValidateForm then
// TODO: Print
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.btnResetFormClick(Sender: TObject);
begin
  {edtAccountName.Text := '';
  edtSortCode.Text := '';
  edtAccountNumber.Text := '';
  edtClientCode.Text := '';
  edtCostCode.Text := '';
  if edtBank.Enabled then // We don't want to clear this field if this is an HSBC CAF
    edtBank.Text := '';
  edtBranch.Text := '';
  cmbServiceStartMonth.ItemIndex := -1;
  edtServiceStartYear.Text := '';
  chkSupplyAccount.Checked := False;
  rbDaily.Checked := True;}
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.cmbServiceStartMonthChange(Sender: TObject);
begin
  //edtServiceStartYear.Enabled := (cmbServiceStartMonth.Text <> 'ASAP');
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.edtAccountNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','-',Chr(vk_Back)]) then
    Key := #0; // Discard the key
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.edtClientCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z','A'..'Z','0'..'9',Chr(vk_Back)]) then
    Key := #0 // Discard the key
  else
    Key := UpCase(Key); // Upper case
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.edtCostCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z','A'..'Z','0'..'9',Chr(vk_Back)]) then
    Key := #0 // Discard the key
  else
    Key := UpCase(Key); // Upper case
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.edtServiceStartYearKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',Chr(vk_Back)]) then
    Key := #0; // Discard the key
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) then
  begin
    case Key of
      69: btnEmail.Click; // Alt + E
      70: btnFile.Click; // Alt + F
      80: btnPrint.Click; // Alt + P
    end;
  end;
  if (Key = VK_ESCAPE) then
    btnCancel.Click;  
end;

//------------------------------------------------------------------------------
procedure TfrmNewCAF.FormShow(Sender: TObject);
begin
  //edtAccountName.SetFocus;
end;

//------------------------------------------------------------------------------
function TfrmNewCAF.ValidateForm: Boolean;
var
  ErrorStr, DateErrorStr: string;
begin
  {DateErrorStr := '';
  if (cmbServiceStartMonth.ItemIndex = -1) then
  begin
    if (edtServiceStartYear.Text = '') then
      DateErrorStr := DateErrorStr + 'You must enter a starting date'
    else
      DateErrorStr := DateErrorStr + 'You must choose a starting month';
  end else
    if (Length(edtServiceStartYear.Text) < 2) then
      DateErrorStr := DateErrorStr + 'You must enter a valid starting year';

  ErrorStr := '';}


//  HelpfulErrorMsg(DateErrorStr, 0);

  Result := True;              
end;

end.
