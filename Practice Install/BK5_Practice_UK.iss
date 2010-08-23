[Setup]
;--------------------------------------------------------------
;   UK Practice Setup file
;--------------------------------------------------------------
#Include "Bin\BankLinkPractice.txt"
#include "Bin\BankLinkCopyRight.txt"
DefaultDirName={sd}\BK5
DefaultGroupName=BankLink
DisableStartupPrompt=yes
LicenseFile=Bin\BK5_EULA.RTF
MinVersion=4.1,5
OutputDir=..\Binaries\PracticeInstall_UK
OutputBaseFilename=setup_practice_uk
Compression=lzma
SolidCompression=yes
RestartIfNeededByRun=no
AppendDefaultDirName=no

[Files]
Source: "..\Binaries\BK5WIN.EXE"; DestDir: "{app}"
Source: "..\Binaries\bkLookup.dll"; DestDir: "{app}"
Source: "..\Binaries\BKHandler\bkHandlerSetup.exe"; DestDir: "{app}"

Source: "Bin\bkExtMapi.dll"; DestDir: "{app}"
Source: "Bin\BK5WIN.EXE.Manifest"; DestDir: "{app}"
Source: "Bin\bkinstall.exe"; DestDir: "{app}"
Source: "Bin\bkupgcor.dll"; DestDir: "{app}"
Source: "Bin\*.INF"; DestDir: "{app}"

Source: "Practice Help\guide_uk.chm"; DestDir: "{app}"; DestName: "guide.chm"

Source: "Mail Merge\BKDataSource.csv"; DestDir: "{app}"
Source: "Mail Merge\BKPrintMerge.doc"; DestDir: "{app}"
Source: "Mail Merge\BKEmailMerge.doc"; DestDir: "{app}"

Source: "Fixes\bkNetHelpFix.exe"; DestDir: "{app}"

Source: "3rd Party\wPDF200a.DLL"; DestDir: "{app}"
Source: "3rd Party\wPDFView01.DLL"; DestDir: "{app}"
Source: "3rd Party\Expat_License.txt"; DestDir: "{app}"
Source: "3rd Party\WDDX_License.html"; DestDir: "{app}"
Source: "3rd Party\wddx_com.dll"; DestDir: "{app}"
Source: "3rd Party\xmlparse.dll"; DestDir: "{app}"
Source: "3rd Party\xmltok.dll"; DestDir: "{app}"
Source: "3rd Party\ipwssl6.dll"; DestDir: "{app}"
Source: "3rd Party\RTM.EXE"; DestDir: "{app}"
Source: "3rd Party\DPMI16BI.OVL"; DestDir: "{app}"
Source: "3rd Party\STUB.EXE"; DestDir: "{app}"
Source: "3rd Party\FETCH.EXE"; DestDir: "{app}"
Source: "3rd Party\BKCASYS.EXE"; DestDir: "{app}"
Source: "3rd Party\GET4CEE.EXE"; DestDir: "{app}"
Source: "3rd Party\ACTCHART.EXE"; DestDir: "{app}"
Source: "3rd Party\S6BNK.COM"; DestDir: "{app}"

;Source: "AuthorityForms\Client Authority Form.pdf"; DestDir: "{app}"

Source: "UK Samples\*.BK5"; DestDir: "{app}\SAMPLES"

Source: "Templates\BGL.TPM"; DestDir: "{app}\TEMPLATE"
Source: "Templates\ELITE.TPM"; DestDir : "{app}\TEMPLATE"
Source: "Templates\GENERIC.TPM"; DestDir : "{app}\TEMPLATE"

[Icons]
Name: "{group}\BankLink Practice"; Filename: "{app}\BK5WIN.EXE"
Name: "{group}\Create Initial Database"; Filename: "{app}\BK5WIN.EXE"; Parameters: "/dbcreate";

[Tasks]
Name: createdb; Description: "Create an initial database";

[Run]
Filename: "{app}\BK5WIN.EXE"; Parameters : "/dbcreate_norun"; Description : "Create an initial BankLink Practice Database"; WorkingDir: "{app}"; Tasks : createdb;
Filename: "{app}\BK5WIN.EXE"; Description : "Start BankLink Practice"; WorkingDir: "{app}"; Flags: postinstall nowait;

[Registry]
Root: HKCU; Subkey: "Software\BankLink"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\BankLink\"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"
