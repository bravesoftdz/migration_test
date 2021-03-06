UNIT SYusIO;

// This code was generated automatically by running DBGen
// Do not change it - any changes you make will disappear
// when DBGen is run again.

{  -------------------------------------------------------------------  }
INTERFACE USES SYDEFS, IOSTREAM;
{  -------------------------------------------------------------------  }

CONST
   tkBegin_User                         = 60 ;
   tkEnd_User                           = 61 ;

FUNCTION  IsAUser_Rec ( P : Pointer ): Boolean;
PROCEDURE Write_User_Rec ( Var O : TUser_Rec ; Var F : TIOStream );
PROCEDURE Read_User_Rec ( Var O : TUser_Rec ; Var F : TIOStream );
FUNCTION  New_User_Rec : pUser_Rec ;
PROCEDURE Free_User_Rec_Dynamic_Fields ( Var O : TUser_Rec );
function User_Rec_Delta(P1, P2, P3: pUser_Rec): boolean;
procedure Copy_User_Rec(P1, P2: pUser_Rec);

{  -------------------------------------------------------------------  }
IMPLEMENTATION USES MONEYDEF, MALLOC, BKDBEXCEPT, SYAUDITUTILS;
{  -------------------------------------------------------------------  }

CONST
   SUnitName           = 'SYUSIO';
   SBoundsError        = 'SYUSIO Error: %s is out of bounds [ %d %d ], value is %d';
   SInvalidPointer     = 'SYUSIO Error: Pointer is NIL in IsAUser_Rec';
   SInvalidType        = 'SYUSIO Error: Type is invalid in IsAUser_Rec';
   SInvalidEOR         = 'SYUSIO Error: EOR is missing in IsAUser_Rec';
   SUnknownToken       = 'SYUSIO Error: Unknown token %d in Read_User_Rec';
   SInsufficientMemory = 'SYUSIO Error: Out of memory in New_User_Rec';

{  -------------------------------------------------------------------  }

PROCEDURE CheckBounds( Const Value, Min, Max : Integer; Const FieldName : ShortString );
Begin
   If ( Value >= Min ) and
      ( Value <= Max ) then exit;
   Raise EBoundsException.CreateFmt( SBoundsError, [ FieldName, Min, Max, Value ] );
end;

{  -------------------------------------------------------------------  }

CONST
   tkusCode                             = 62 ;
   tkusName                             = 63 ;
   tkusPassword                         = 64 ;
   tkusEMail_Address                    = 65 ;
   tkusSystem_Access                    = 66 ;
   tkusDialog_Colour                    = 67 ;
   tkusLogged_In                        = 68 ;
   tkusReverse_Mouse_Buttons            = 69 ;
   tkusMASTER_Access                    = 70 ;
   tkusLRN                              = 71 ;
   tkusSpare_String                     = 72 ;
   tkusWorkstation_Logged_In_At         = 73 ;
   tkusIs_Remote_User                   = 74 ;
   tkusDirect_Dial                      = 75 ;
   tkusShow_CM_on_open                  = 76 ;
   tkusShow_Printer_Choice              = 77 ;
   tkusEULA_Version                     = 78 ;
   tkusSpare_Boolean                    = 79 ;
   tkusLogin_Count                      = 80 ;
   tkusReset_Count                      = 81 ;
   tkusSuppress_HF                      = 82 ;
   tkusShow_Practice_Logo               = 83 ;
   tkusAudit_Record_ID                  = 84 ;

{  -------------------------------------------------------------------  }

FUNCTION IsAUser_Rec ( P : Pointer ): Boolean;

Begin
   If P=NIL then
      Raise ECorruptData.Create( SInvalidPointer );
   With PUser_Rec ( P )^ do Begin
      If usRecord_Type <> tkBegin_User then
         Raise ECorruptData.Create( SInvalidType );
      If usEOR <> tkEnd_User then
         Raise ECorruptData.Create( SInvalidEOR );
   end;
   Result := TRUE;
end;

{  -------------------------------------------------------------------  }

PROCEDURE Write_User_Rec ( Var O : TUser_Rec ; Var F : TIOStream );

Begin
   If IsAUser_Rec ( @O ) then With O do
   Begin
      F.WriteToken( tkBegin_User );
      F.WriteStringValue( tkusCode , usCode );
      F.WriteStringValue( tkusName , usName );
      F.WriteStringValue( tkusPassword , usPassword );
      F.WriteStringValue( tkusEMail_Address , usEMail_Address );
      F.WriteBooleanValue( tkusSystem_Access , usSystem_Access );
      F.WriteByteValue( tkusDialog_Colour , usDialog_Colour );
      F.WriteBooleanValue( tkusLogged_In , usLogged_In );
      F.WriteBooleanValue( tkusReverse_Mouse_Buttons , usReverse_Mouse_Buttons );
      F.WriteBooleanValue( tkusMASTER_Access , usMASTER_Access );
      F.WriteIntegerValue( tkusLRN , usLRN );
      F.WriteStringValue( tkusSpare_String , usSpare_String );
      F.WriteStringValue( tkusWorkstation_Logged_In_At , usWorkstation_Logged_In_At );
      F.WriteBooleanValue( tkusIs_Remote_User , usIs_Remote_User );
      F.WriteStringValue( tkusDirect_Dial , usDirect_Dial );
      F.WriteBooleanValue( tkusShow_CM_on_open , usShow_CM_on_open );
      F.WriteBooleanValue( tkusShow_Printer_Choice , usShow_Printer_Choice );
      F.WriteAnsiStringValue( tkusEULA_Version , usEULA_Version );
      F.WriteBooleanValue( tkusSpare_Boolean , usSpare_Boolean );
      F.WriteIntegerValue( tkusLogin_Count , usLogin_Count );
      F.WriteIntegerValue( tkusReset_Count , usReset_Count );
      F.WriteByteValue( tkusSuppress_HF , usSuppress_HF );
      F.WriteBooleanValue( tkusShow_Practice_Logo , usShow_Practice_Logo );
      F.WriteIntegerValue( tkusAudit_Record_ID , usAudit_Record_ID );
      F.WriteToken( tkEnd_User );
   end;
end; { of Write_User_Rec }

{  -------------------------------------------------------------------  }

PROCEDURE Read_User_Rec ( Var O : TUser_Rec; Var F : TIOStream );

Var
   Token : Byte;

Begin
   FillChar( O, User_Rec_Size, 0 );
   O.usRecord_Type := tkBegin_User;
   O.usEOR := tkEnd_User;
   Token := tkBegin_User;

   While Token <> tkEnd_User do With O do
   Begin
      Case Token of
         tkBegin_User :; { Do Nothing }
         tkEnd_User :; { Do Nothing }
         tkusCode                             : usCode := F.ReadStringValue;
         tkusName                             : usName := F.ReadStringValue;
         tkusPassword                         : usPassword := F.ReadStringValue;
         tkusEMail_Address                    : usEMail_Address := F.ReadStringValue;
         tkusSystem_Access                    : usSystem_Access := F.ReadBooleanValue;
         tkusDialog_Colour                    : usDialog_Colour := F.ReadByteValue;
         tkusLogged_In                        : usLogged_In := F.ReadBooleanValue;
         tkusReverse_Mouse_Buttons            : usReverse_Mouse_Buttons := F.ReadBooleanValue;
         tkusMASTER_Access                    : usMASTER_Access := F.ReadBooleanValue;
         tkusLRN                              : usLRN := F.ReadIntegerValue;
         tkusSpare_String                     : usSpare_String := F.ReadStringValue;
         tkusWorkstation_Logged_In_At         : usWorkstation_Logged_In_At := F.ReadStringValue;
         tkusIs_Remote_User                   : usIs_Remote_User := F.ReadBooleanValue;
         tkusDirect_Dial                      : usDirect_Dial := F.ReadStringValue;
         tkusShow_CM_on_open                  : usShow_CM_on_open := F.ReadBooleanValue;
         tkusShow_Printer_Choice              : usShow_Printer_Choice := F.ReadBooleanValue;
         tkusEULA_Version                     : usEULA_Version := F.ReadAnsiStringValue;
         tkusSpare_Boolean                    : usSpare_Boolean := F.ReadBooleanValue;
         tkusLogin_Count                      : usLogin_Count := F.ReadIntegerValue;
         tkusReset_Count                      : usReset_Count := F.ReadIntegerValue;
         tkusSuppress_HF                      : usSuppress_HF := F.ReadByteValue;
         tkusShow_Practice_Logo               : usShow_Practice_Logo := F.ReadBooleanValue;
         tkusAudit_Record_ID                  : usAudit_Record_ID := F.ReadIntegerValue;
         else
            Raise ETokenException.CreateFmt( SUnknownToken, [ Token ] );
      end; { of Case }
      Token := F.ReadToken;
   end; { of While }
end; { of Read_User_Rec }

{  -------------------------------------------------------------------  }

FUNCTION New_User_Rec : pUser_Rec ;

Var
   P : pUser_Rec;
Begin
   SafeGetMem( P, User_Rec_Size ); 
   If Assigned( P ) then With P^ do
   Begin
      FillChar( P^, User_Rec_Size, 0 );
      usRecord_Type := tkBegin_User;
      usEOR         := tkEnd_User;
   end
   else
      Raise EInsufficientMemory.Create( SInsufficientMemory );
   New_User_Rec := P;
end;

{  -------------------------------------------------------------------  }

PROCEDURE Free_User_Rec_Dynamic_Fields ( Var O : TUser_Rec );

Begin
   If IsAUser_Rec ( @O ) then With O do
   Begin
      { Free any dynamically allocated memory }
      usEULA_Version := '' ;
   end;
end;

{  -------------------------------------------------------------------  }

Function User_Rec_Delta(P1, P2, P3: pUser_Rec): boolean;
begin
  Result := False;

  //Add
  if not Assigned(P2) then begin
    Copy_User_Rec(P1, P3);
    Result := True;
    Exit;
  end;

  //Change
  if (P1.usCode <> P2.usCode) then begin
    Result := true;
    P3.usCode := P1.usCode;
  end;
  if (P1.usName <> P2.usName) then begin
    Result := true;
    P3.usName := P1.usName;
  end;
  if (P1.usPassword <> P2.usPassword) then begin
    Result := true;
    P3.usPassword := P1.usPassword;
  end;
  if (P1.usEMail_Address <> P2.usEMail_Address) then begin
    Result := true;
    P3.usEMail_Address := P1.usEMail_Address;
  end;
  if (P1.usSystem_Access <> P2.usSystem_Access) then begin
    Result := true;
    P3.usSystem_Access := P1.usSystem_Access;
  end;
  if (P1.usDialog_Colour <> P2.usDialog_Colour) then begin
    Result := true;
    P3.usDialog_Colour := P1.usDialog_Colour;
  end;
  if (P1.usLogged_In <> P2.usLogged_In) then begin
    Result := true;
    P3.usLogged_In := P1.usLogged_In;
  end;
  if (P1.usReverse_Mouse_Buttons <> P2.usReverse_Mouse_Buttons) then begin
    Result := true;
    P3.usReverse_Mouse_Buttons := P1.usReverse_Mouse_Buttons;
  end;
  if (P1.usMASTER_Access <> P2.usMASTER_Access) then begin
    Result := true;
    P3.usMASTER_Access := P1.usMASTER_Access;
  end;
  if (P1.usLRN <> P2.usLRN) then begin
    Result := true;
    P3.usLRN := P1.usLRN;
  end;
  if (P1.usSpare_String <> P2.usSpare_String) then begin
    Result := true;
    P3.usSpare_String := P1.usSpare_String;
  end;
  if (P1.usWorkstation_Logged_In_At <> P2.usWorkstation_Logged_In_At) then begin
    Result := true;
    P3.usWorkstation_Logged_In_At := P1.usWorkstation_Logged_In_At;
  end;
  if (P1.usIs_Remote_User <> P2.usIs_Remote_User) then begin
    Result := true;
    P3.usIs_Remote_User := P1.usIs_Remote_User;
  end;
  if (P1.usDirect_Dial <> P2.usDirect_Dial) then begin
    Result := true;
    P3.usDirect_Dial := P1.usDirect_Dial;
  end;
  if (P1.usShow_CM_on_open <> P2.usShow_CM_on_open) then begin
    Result := true;
    P3.usShow_CM_on_open := P1.usShow_CM_on_open;
  end;
  if (P1.usShow_Printer_Choice <> P2.usShow_Printer_Choice) then begin
    Result := true;
    P3.usShow_Printer_Choice := P1.usShow_Printer_Choice;
  end;
  if (P1.usEULA_Version <> P2.usEULA_Version) then begin
    Result := true;
    P3.usEULA_Version := P1.usEULA_Version;
  end;
  if (P1.usSpare_Boolean <> P2.usSpare_Boolean) then begin
    Result := true;
    P3.usSpare_Boolean := P1.usSpare_Boolean;
  end;
  if (P1.usLogin_Count <> P2.usLogin_Count) then begin
    Result := true;
    P3.usLogin_Count := P1.usLogin_Count;
  end;
  if (P1.usReset_Count <> P2.usReset_Count) then begin
    Result := true;
    P3.usReset_Count := P1.usReset_Count;
  end;
  if (P1.usSuppress_HF <> P2.usSuppress_HF) then begin
    Result := true;
    P3.usSuppress_HF := P1.usSuppress_HF;
  end;
  if (P1.usShow_Practice_Logo <> P2.usShow_Practice_Logo) then begin
    Result := true;
    P3.usShow_Practice_Logo := P1.usShow_Practice_Logo;
  end;
  if (P1.usAudit_Record_ID <> P2.usAudit_Record_ID) then begin
    Result := true;
    P3.usAudit_Record_ID := P1.usAudit_Record_ID;
  end;

end;

{  -------------------------------------------------------------------  }

procedure Copy_User_Rec(P1, P2: pUser_Rec);
var
  S: TIOStream;
begin
  S := TIOStream.Create;
  try
    Write_User_Rec(P1^, S);
    S.Position := 0;
    Read_User_Rec(P2^, S);
  finally
    S.Free;
  end;
end;

{  -------------------------------------------------------------------  }

END.
