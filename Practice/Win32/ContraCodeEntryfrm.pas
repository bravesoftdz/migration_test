unit ContraCodeEntryfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OSFont, StdCtrls, Buttons;

type
  TfrmContraCodeEntry = class(TForm)
    lblMessage: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    edtBankAccountCode: TEdit;
    sbtnChart: TSpeedButton;
    lblContraDesc: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure sbtnChartClick(Sender: TObject);
    procedure edtBankAccountCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtBankAccountCodeChange(Sender: TObject);
    procedure edtBankAccountCodeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBankAccountCodeExit(Sender: TObject);
  private
    FBankAccountName: String;
    FRemovingMask : boolean;

    procedure LookupContraCode;
    function GetContraCode: String;
    function GetBankAccountName: String;
    procedure SetBankAccountName(const Value: String);
    procedure DoRebranding();
  public
    class function EnterContraCode(const BankAccountName: String; out ContraCode: string): Boolean; overload; static;
    class function EnterContraCode(const bankAccountName: String; PopupParent: TCustomForm; out ContraCode: string): Boolean; overload; static;

    property BankAccountName: String read GetBankAccountName write SetBankAccountName;
    property ContraCode: String read GetContraCode;
  end;

var
  frmContraCodeEntry: TfrmContraCodeEntry;

implementation

uses
  AccountLookupFrm, imagesfrm, STDHINTS, bkConst, Globals, BKDEFS, bkMaskUtils,
  bkBranding, bkProduct;
  
{$R *.dfm}

class function TfrmContraCodeEntry.EnterContraCode(const BankAccountName: String; PopupParent: TCustomForm; out ContraCode: string): Boolean;
var
  EntryForm: TfrmContraCodeEntry;
begin
  EntryForm := TfrmContraCodeEntry.Create(nil);

  try
    EntryForm.PopupParent := PopupParent;
    EntryForm.PopupMode := pmExplicit;
    
    EntryForm.BankAccountName := BankAccountName;

    if EntryForm.ShowModal = mrOk then
    begin
      ContraCode := EntryForm.ContraCode;

      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    EntryForm.Free;
  end;
end;

procedure TfrmContraCodeEntry.FormCreate(Sender: TObject);
begin
  ActiveControl := edtBankAccountCode;
  
  ImagesFrm.AppImages.Coding.GetBitmap(CODING_CHART_BMP, sbtnChart.Glyph);

  edtBankAccountCode.MaxLength := MaxBk5CodeLen;
  edtBankAccountCode.Hint :=
                    'Enter the Contra Account Code to use for this Bank Account|' +
                    'Enter the Contra Account Code from the Chart of Accounts which corresponds to this Bank Account';

  sbtnChart.Hint := ChartLookupHint;

  FRemovingMask := False;

  DoRebranding();
end;

function TfrmContraCodeEntry.GetBankAccountName: String;
begin
  Result := FBankAccountName;
end;

function TfrmContraCodeEntry.GetContraCode: String;
begin
  Result := edtBankAccountCode.Text;
end;

procedure TfrmContraCodeEntry.LookupContraCode;
var
  ContraCode: String;
  HasChartBeenRefreshed : boolean;
begin
  ContraCode := edtBankAccountCode.Text;
  
  if PickAccount(ContraCode, HasChartBeenRefreshed) then
  begin
    edtBankAccountCode.Text := ContraCode;

    edtBankAccountCode.SelectAll;
  end;
end;

procedure TfrmContraCodeEntry.sbtnChartClick(Sender: TObject);
begin
  LookupContraCode;
end;

procedure TfrmContraCodeEntry.SetBankAccountName(const Value: String);
begin
  FBankAccountName := Value;

  lblMessage.Caption := Format(lblMessage.Caption, [Value]);
end;

procedure TfrmContraCodeEntry.DoRebranding;
begin
  lblMessage.Caption := BRAND_PRACTICE + ' needs to know the account code in your' +
                        ' client''s chart for the bank account %s';
end;

procedure TfrmContraCodeEntry.edtBankAccountCodeChange(Sender: TObject);
var
  pAcct: pAccount_Rec;
  ContraCode: string;
  IsValid: boolean;
begin
  if MyClient.clChart.ItemCount = 0 then
  begin
    Exit;
  end;

  ContraCode := Trim(edtBankAccountCode.Text);

  pAcct:= MyClient.clChart.FindCode(ContraCode);

  IsValid := Assigned( pAcct) and (pAcct^.chAccount_Type = atBankAccount) and pAcct^.chPosting_Allowed;

  if Assigned( pAcct) then
  begin
    lblContraDesc.Caption := pAcct^.chAccount_Description;
    lblContraDesc.Visible := True;
  end
  else
  begin
    lblContraDesc.Visible := False;
  end;

  if (ContraCode = '') or (IsValid) then
  begin
    edtBankAccountCode.Font.Color := clWindowText;
    edtBankAccountCode.Color := clWindow;
    ContraCode := edtBankAccountCode.Text;

    edtBankAccountCode.BorderStyle := bsNone;
    edtBankAccountCode.BorderStyle := bsSingle;

    edtBankAccountCode.Text := ContraCode;
  end
  else
  begin
    edtBankAccountCode.Font.Color := clWhite;
    edtBankAccountCode.Color      := clRed;
  end;
end;

procedure TfrmContraCodeEntry.edtBankAccountCodeExit(Sender: TObject);
begin
  if not MyClient.clChart.CodeIsThere(edtBankAccountCode.Text) then
  begin
    bkMaskUtils.CheckRemoveMaskChar(edtBankAccountCode, FRemovingMask);
  end;
end;

procedure TfrmContraCodeEntry.edtBankAccountCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key='-') and (myClient.clFields.clUse_Minus_As_Lookup_Key)) then
  begin
    Key := #0;

    LookupContraCode;
  end;
end;

procedure TfrmContraCodeEntry.edtBankAccountCodeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_F2) or ((key = VK_DOWN) and (Shift = [ssAlt])) then
  begin
    LookupContraCode;
  end
  else if (Key = VK_BACK) then
  begin
    bkMaskUtils.CheckRemoveMaskChar(edtBankAccountCode, FRemovingMask);
  end
  else
  begin
    bkMaskUtils.CheckForMaskChar(edtBankAccountCode, FRemovingMask);
  end;
end;

class function TfrmContraCodeEntry.EnterContraCode(const BankAccountName: String; out ContraCode: string): Boolean;
var
  EntryForm: TfrmContraCodeEntry;
begin
  EntryForm := TfrmContraCodeEntry.Create(nil);

  try
    EntryForm.BankAccountName := BankAccountName;
    
    if EntryForm.ShowModal = mrOk then
    begin
      ContraCode := EntryForm.ContraCode;

      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    EntryForm.Free;
  end;
end;
end.
