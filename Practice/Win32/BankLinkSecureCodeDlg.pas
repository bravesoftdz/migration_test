unit BankLinkSecureCodeDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OSFont, StdCtrls;

type
  TfrmBankLinkSecureCode = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edtSecureCode: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetSecureCode: String;
    procedure DoRebranding();
    { Private declarations }
  public
    class function PromptUser(Owner: TCustomForm; out SecureCode: String): Boolean; static;

    property SecureCode: String read GetSecureCode;
  end;

var
  frmBankLinkSecureCode: TfrmBankLinkSecureCode;

implementation

uses
  WarningMoreFrm,
  bkBranding,
  bkProduct,
  bkConst;
  
{$R *.dfm}

{ TfrmBankLinkSecureCode }

procedure TfrmBankLinkSecureCode.Button1Click(Sender: TObject);
begin
  if Trim(edtSecureCode.Text) <> '' then
  begin
    ModalResult := mrOK;
  end
  else
  begin
    HelpfulWarningMsg('The ' + bkBranding.ProductOnlineName + ' Secure Code cannot be blank.', 0);

    edtSecureCode.SetFocus;
  end;
end;

procedure TfrmBankLinkSecureCode.DoRebranding;
begin
  Caption := 'Enter ' + BRAND_SECURE + ' Code';
  Label1.Caption := BRAND_SECURE + ' Code';
end;

procedure TfrmBankLinkSecureCode.FormCreate(Sender: TObject);
begin
  DoRebranding();
end;

function TfrmBankLinkSecureCode.GetSecureCode: String;
begin
  Result := edtSecureCode.Text;
end;

class function TfrmBankLinkSecureCode.PromptUser(Owner: TCustomForm; out SecureCode: String): Boolean;
var
  SecureCodeDlg: TfrmBankLinkSecureCode;
begin
  SecureCodeDlg := TfrmBankLinkSecureCode.Create(Owner);

  try
    SecureCodeDlg.PopupParent := Owner;
    SecureCodeDlg.PopupMode := pmExplicit;
    
    if SecureCodeDlg.ShowModal = mrOk then
    begin
      SecureCode := SecureCodeDlg.SecureCode;
      
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    SecureCodeDlg.Free;
  end;
end;

end.
