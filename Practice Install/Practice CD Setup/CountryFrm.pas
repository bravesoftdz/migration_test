unit CountryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmLocation = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    cmbCountry: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetCountry(Param: string = '') : integer;

implementation

{$R *.dfm}

function GetCountry(Param: string): integer;
var
   a                : array[0..7] of char;
   iLocale          : integer;
   Bytes            : integer;
begin
  result := -1;
  with TfrmLocation.Create( Application) do
  begin
    try
      //decide on country to use
      Bytes := GetLocaleInfo( LOCALE_USER_DEFAULT,
                             LOCALE_ICOUNTRY,
                             a,
                             SizeOf(a));
      if Bytes <> 0 then
      begin
        iLocale := StrToIntDef( a, -1);
        case iLocale of
          CTRY_NEW_ZEALAND : cmbCountry.ItemIndex := 1;
          CTRY_AUSTRALIA   : cmbCountry.ItemIndex := 0;
          CTRY_UNITED_KINGDOM : cmbCountry.ItemIndex := 2;
        end;
      end;

      //Temp - no UK Books yet
      if Param = 'BOOKS' then
        cmbCountry.Items.Delete(2);

      if ShowModal = mrOK then
      begin
        case cmbCountry.ItemIndex of
          0 : result := 1;  //whAustralia
          1 : result := 0;  //whNewZealand
          2 : result := 2;  //whUK          
        end;
      end;

    finally
      Free;
    end;
  end;
end;

end.
