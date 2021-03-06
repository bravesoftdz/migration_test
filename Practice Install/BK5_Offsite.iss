[Setup]
;--------------------------------------------------------------
;   Offsite Setup file
;--------------------------------------------------------------
#Include "Bin\BankLinkBooks.txt"
#include "Bin\BankLinkCopyRight.txt"
DefaultDirName={sd}\BK5
DefaultGroupName=BankLink
DisableStartupPrompt=yes
LicenseFile=Bin\BK5_EULA.RTF
MinVersion=4.1,5
OutputDir=..\Binaries\OffsiteInstall
OutputBaseFilename=setup_books
Compression=lzma
SolidCompression=yes
AppendDefaultDirName=no

[Files]
Source: "..\Binaries\BK5WIN.EXE"; DestDir: "{app}"
Source: "..\Binaries\bkhandlr.exe"; DestDir: "{app}"

Source: "Bin\BK5WIN.EXE.Manifest"; DestDir: "{app}"
Source: "Bin\bkinstall.exe"; DestDir: "{app}"
Source: "Bin\bkupgcor.dll"; DestDir: "{app}"

Source: "3rd Party\wPDF200a.DLL"; DestDir: "{app}"
Source: "3rd Party\wPDFView01.DLL"; DestDir: "{app}"
Source: "3rd Party\ipwssl6.dll"; DestDir: "{app}"
Source: "3rd Party\gdiplus.dll"; DestDir: "{app}"
Source: "3rd Party\libeay32.dll"; DestDir: "{app}"
Source: "3rd Party\zint.dll"; DestDir: "{app}"

[Icons]
Name: "{group}\BankLink Books"; Filename: "{app}\BK5WIN.EXE"

[Registry]
Root: HKCR; Subkey: ".bk5"; ValueType: string; ValueName: ""; ValueData: "BankLink.bkHandlr"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "BankLink.bkHandlr"; ValueType: string; ValueName: ""; ValueData: "BankLink Client File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "BankLink.bkHandlr"; ValueType: string; ValueName: "AlwaysShowExt"; ValueData: ""; Flags: uninsdeletekey
Root: HKCR; Subkey: "BankLink.bkHandlr\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\bkhandlr.exe,1"
Root: HKCR; Subkey: "BankLink.bkHandlr\shell"; ValueType: string; ValueName: ""; ValueData: "open"
Root: HKCR; Subkey: "BankLink.bkHandlr\shell\open"; ValueType: string; ValueName: ""; ValueData: "Check In"
Root: HKCR; Subkey: "BankLink.bkHandlr\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\bkhandlr.exe"" ""%1"""
Root: HKCR; Subkey: "BankLink.bkHandlr\shell\open\ddeexec"; ValueType: string; ValueName: ""; ValueData: "[CheckIn(""%1"")]"
Root: HKCR; Subkey: "BankLink.bkHandlr\shell\open\ddeexec\Application"; ValueType: string; ValueName: ""; ValueData: "bkhandlr"
Root: HKCR; Subkey: "BankLink.bkHandlr\shell\open\ddeexec\Topic"; ValueType: string; ValueName: ""; ValueData: "bksystem"
Root: HKCU; Subkey: "Software\BankLink"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\BankLink\"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"
