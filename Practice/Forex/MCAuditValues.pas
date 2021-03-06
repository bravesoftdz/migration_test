{-----------------------------------------------------------------------------
 Unit Name: MCAuditValues
 Author:    scott.wilson
 Date:      12-Jul-2011
 Purpose:   Gets Exchange Rate audit information for the audit report.
 History:
-----------------------------------------------------------------------------}

unit MCAuditValues;

interface

uses
  MCDEFS, AuditMgr, MCAuditUtils;

  procedure AddExchangeSourceAuditValues(AAuditRecord: TAudit_Trail_Rec;
                                         AAuditMgr: TExchangeRateAuditManager;
                                         var Values: string);
  procedure AddExchangeRateAuditValues(AAuditRecord: TAudit_Trail_Rec;
                                         AAuditMgr: TExchangeRateAuditManager;
                                         AExchangeRatesHeader: TExchange_Rates_Header_Rec;
                                         var Values: string);

implementation

uses
  Classes, SysUtils, MCAUDIT, MCEHIO, MCERIO, ExchangeRateList, bkdateutils,
  frmCurrencies, bkConst;

procedure ISO_Code_Audit_Values(V1: TISO_Codes_Array; V2: TCur_Type_Array; var Values: string);
var
  i: integer;
  Value: string;
  FieldName: string;
  TempStr: string;
  CurrencyType: string;
begin
  TempStr := '';
  for i := Low(V1) to High(V1) do begin
    Value := V1[i];
    if Value <> '' then begin
      if (Values <> '') or (TempStr <> '') then
        TempStr := TempStr + VALUES_DELIMITER;
      FieldName := MCAuditNames.GetAuditFieldName(tkBegin_Exchange_Rates_Header, 16);
      case V2[i] of
        ct_System : CurrencyType := 'System';
        ct_Base : CurrencyType := 'Base/Local';
        ct_User : CurrencyType := 'User Added';
      end;
      TempStr := Format('%s%s[%d]=%s (%s)', [TempStr, FieldName, i, Value, CurrencyType]);
    end;
  end;
  Values := Values + TempStr;
end;

procedure AddExchangeSourceAuditValues(AAuditRecord: TAudit_Trail_Rec;
  AAuditMgr: TExchangeRateAuditManager; var Values: string);
var
  Token, Idx: byte;
  ARecord: Pointer;
begin
  ARecord := AAuditRecord.atAudit_Record;

  if ARecord = nil then begin
    Values := AAuditRecord.atOther_Info;
    Exit;
  end;

  case AAuditRecord.atAudit_Record_Type of
    tkBegin_Exchange_Rates_Header:
      begin
        Idx := 0;
        Token := AAuditRecord.atChanged_Fields[idx];
        while Token <> 0 do begin
          case Token of
            //File Version
            12: AAuditMgr.AddAuditValue(MCAuditNames.GetAuditFieldName(tkBegin_Exchange_Rates_Header, Token),
                                        TExchange_Rates_Header_Rec(ARecord^).ehFile_Version, Values);
            //Name
            14: AAuditMgr.AddAuditValue(MCAuditNames.GetAuditFieldName(tkBegin_Exchange_Rates_Header, Token),
                                        TExchange_Rates_Header_Rec(ARecord^).ehFile_Version, Values);
            //ISO Codes
            16: ISO_Code_Audit_Values(TISO_Codes_Array(TExchange_Rates_Header_Rec(ARecord^).ehISO_Codes),
                                      TCur_Type_Array(TExchange_Rates_Header_Rec(ARecord^).ehCur_Type),
                                      Values);
          end;
          Inc(Idx);
          Token := AAuditRecord.atChanged_Fields[idx];
        end;
      end;
  end;
end;

procedure SetISOCodeList(AAuditRecord: TAudit_Trail_Rec;
  AExchangeRatesHeader: TExchange_Rates_Header_Rec; var AISOCodeList: TStringList);
var
  i: integer;
  StringList: TStringList;
  ISOCodes: string;
  CurrentISOCodes: TISO_Codes_Array;
begin
  //Current ISO Codes
  CurrentISOCodes := TISO_Codes_Array(AExchangeRatesHeader.ehISO_Codes);
  for i := Low(CurrentISOCodes) to High(CurrentISOCodes) do begin
    if (CurrentISOCodes[i] <> '') then
      AISOCodeList.Add(CurrentISOCodes[i] + '=')
    else
      Break;
  end;

  StringList := TStringList.Create;
  try
    StringList.StrictDelimiter := True;
    StringList.Delimiter := VALUES_DELIMITER;
    StringList.DelimitedText := AAuditRecord.atOther_Info;
    ISOCodes := StringList.Values['ISO Codes'];
    if ISOCodes <> '' then begin
      StringList.StrictDelimiter := True;
      StringList.Delimiter := ',';
      StringList.DelimitedText := ISOCodes;
      for i := 0 to StringList.Count - 1 do
        StringList[i] := StringList[i] + '=';
      //Added ISO Codes
      for i := 0 to AISOCodeList.Count - 1 do begin
        if StringList.IndexOfName(AISOCodeList.Names[i]) = -1  then
          AISOCodeList[i] := AISOCodeList[i] + ' Added';
      end;
      //Deleted ISO Codes
      for i := 0 to StringList.Count - 1 do begin
        if AISOCodeList.IndexOfName(StringList.Names[i]) = -1  then
          AISOCodeList.Add(StringList[i] + ' Deleted');
      end;
    end;
  finally
    StringList.Free;
  end;
end;   

procedure Rate_Audit_Values(AAuditRecord: TAudit_Trail_Rec;
  AExchangeRatesHeader: TExchange_Rates_Header_Rec; var Values: string);
var
  i: integer;
  Value: Double;
  TempStr: string;
  ISOCodeList: TStringList;
begin
  //Use ISO codes to restrict the number of rates in the audit report
  TempStr := '';
  ISOCodeList := TStringList.Create;
  try
    SetISOCodeList(AAuditRecord, AExchangeRatesHeader, ISOCodeList);
    for i := 0 to ISOCodeList.Count - 1 do begin
      Value := TExchange_Rate_Rec(AAuditRecord.atAudit_Record^).erRate[i +1];
      if (Values <> '') or (TempStr <> '') then
        TempStr := TempStr + VALUES_DELIMITER;
        TempStr := Format('%s%s=%0.4f%s', [TempStr, ISOCodeList.Names[i],
                                          Value, ISOCodeList.ValueFromIndex[i]]);
    end;
  finally
    ISOCodeList.Free;
  end;
  Values := Values + TempStr;
end;

procedure AddExchangeRateAuditValues(AAuditRecord: TAudit_Trail_Rec;
  AAuditMgr: TExchangeRateAuditManager;
  AExchangeRatesHeader: TExchange_Rates_Header_Rec; var Values: string);
var
  Token, Idx: byte;
  ARecord: Pointer;
begin
  ARecord := AAuditRecord.atAudit_Record;

  if ARecord = nil then begin
    Values := AAuditRecord.atOther_Info;
    Exit;
  end;

  case AAuditRecord.atAudit_Record_Type of
    tkBegin_Exchange_Rate:
      begin
        Idx := 0;
        Token := AAuditRecord.atChanged_Fields[idx];
        while Token <> 0 do begin
          case Token of
            //Applies_Until - Won't change so always included as OtherInfo
//            17: AAuditMgr.AddAuditValue(MCAuditNames.GetAuditFieldName(tkBegin_Exchange_Rate, Token),
//                                        BkDate2Str(TExchange_Rate_Rec(ARecord^).erApplies_Until), Values);
            //Rate
            18: Rate_Audit_Values(AAuditRecord, AExchangeRatesHeader, Values);
            //Locked
            19: AAuditMgr.AddAuditValue(MCAuditNames.GetAuditFieldName(tkBegin_Exchange_Rate, Token),
                                        TExchange_Rate_Rec(ARecord^).erLocked, Values);
          end;
          Inc(Idx);
          Token := AAuditRecord.atChanged_Fields[idx];
        end;
      end;
  end;
end;

end.
