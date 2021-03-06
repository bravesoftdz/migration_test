{*********************************************************}
{* SysTools: StReg.pas 3.03                              *}
{* Copyright (c) TurboPower Software Co 1996, 2001       *}
{* All rights reserved.                                  *}
{*********************************************************}
{* SysTools: Component Registration Unit                 *}
{*********************************************************}

{$I StDefine.inc}

{$IFDEF WIN16}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
  {$R StReg.r16}
{$ENDIF}

{$IFDEF MSWINDOWS}
  {$R StReg.r32}
{$ENDIF}

unit StReg;

interface

uses
  Classes,
{$IFDEF VERSION6}
  DesignIntf,
  DesignEditors;
{$ELSE}
  DsgnIntf;
{$ENDIF}

procedure Register;

implementation

uses
  StBase,
  StAbout0,
  StBarC,
  StBarPN,
{  StFAssoc,}
  StNVBits,
  StNVDict,
  StNVList,
  StNVDQ,
  StNVLAry,
  StNVLMat,
  StNVColl,
  StNVSCol,
  StNVTree,
  {$IFDEF MSWINDOWS}
  StAbout,
  StBrowsr,
  StFormat,
  StFileOp,
  StShllPe,
  StTrIcon,
  StDrop,
  StShrtCt,
  StShBase,
  {$IFDEF VERSION3}
  StShlCtl,
  StNetCon,
  StNetPfm,
  StNetMsg,
  StNotif0,
  {$ENDIF}
  {$ENDIF}
  StSpawn,
  StRegEx,
  StToHTML,
  StWMDCpy,
  StVInfo,
  {forces these units to be compiled when components are installed}
  {vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv}
  StAstro,
  StAstroP,
  StBCD,
  StBits,
  StColl,
  StConst,
  StCrc,
  StDate,
  StDateSt,
  StDict,
  StDQue,
  StEclpse,
  StFIN,
  StHASH,
  StJup,
  StJupsat,
  StLArr,
  StList,
  StMars,
  StMerc,
  StMime,
  StNeptun,
  StNVCont,
  StOStr,
  StPluto,
  StPQueue,
  StRegIni,
  StSaturn,
  StSort,

  StStrms,
  StStrZ,
  StText,
  StTree,
  StUranus,
  StUtils,
  StVArr,
  StVenus,
  StFirst,
  StStat,

  {$IFDEF MSWINDOWS}
  StStrL,
  {$ENDIF}
  StStrS,
  {$IFDEF VERSION3}
  StStrW,
  StNet,
  {$ENDIF}

  {^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^}
  StExpr,
  StPropEd;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string), TStComponent, 'Version',
                         TStVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TStBarCode, 'Version',
                         TStVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TStPNBarCode, 'Version',
                         TStVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TStRegEx, 'InputFile',
                         TStGenericFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStRegEx, 'OutputFile',
                         TStGenericFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStFileToHTML, 'InFileName',
                         TStGenericFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStFileToHTML, 'OutFileName',
                         TStGenericFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStVersionInfo, 'FileName',
                         TStFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStSpawnApplication, 'FileName',
                         TStGenericFileNameProperty);

  {$IFDEF MSWINDOWS}
  RegisterPropertyEditor(TypeInfo(string), TStBrowser, 'RootFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(string), TStBrowser, 'SelectedFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShortcut, 'DestinationDir',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShortcut, 'ShortcutFileName',
                         TStFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShortcut, 'FileName',
                         TStFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShortcut, 'StartInDir',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TStDropFiles, 'DropTarget',
                         TStDropTargetProperty);
  RegisterPropertyEditor(TypeInfo(TStSpecialRootFolder), TStBrowser, 'SpecialRootFolder',
                         TStSpecialFolderProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShortcut, 'IconPath',
                         TStFileNameProperty);
  {$IFDEF VERSION3}
  RegisterPropertyEditor(TypeInfo(string), TStShellTreeView, 'Version',
                         TStVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellListView, 'Version',
                         TStVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellComboBox, 'Version',
                         TStVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellTreeView, 'RootFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellTreeView, 'StartInFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(TStSpecialRootFolder), TStShellTreeView, 'SpecialRootFolder',
                         TStSpecialFolderProperty);
  RegisterPropertyEditor(TypeInfo(TStSpecialRootFolder), TStShellTreeView, 'SpecialStartInFolder',
                         TStSpecialFolderProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellListView, 'RootFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(TStSpecialRootFolder), TStShellListView, 'SpecialRootFolder',
                         TStSpecialFolderProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellNotification, 'WatchFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(TStSpecialRootFolder), TStShellNotification, 'SpecialWatchFolder',
                         TStSpecialFolderProperty);
  RegisterPropertyEditor(TypeInfo(string), TStShellEnumerator, 'RootFolder',
                         TStDirectoryProperty);
  RegisterPropertyEditor(TypeInfo(TStSpecialRootFolder), TStShellEnumerator, 'SpecialRootFolder',
                         TStSpecialFolderProperty);
  RegisterComponentEditor(TStShellNotification, TStShellNotificationEditor);
  {$ENDIF}
  {$ENDIF}

  RegisterComponents('SysTools',
    [{$IFDEF MSWINDOWS}
     TStShellAbout,
     TStBrowser,
     TStDropFiles,
     TStFileOperation,
     TStFormatDrive,
     TStShortcut,
     TStTrayIcon,
     {$IFDEF VERSION3}
     TStShellTreeView,
     TStShellListView,
     TStShellNotification,
     TStShellEnumerator,
     TStShellComboBox,
     TStNetConnection,
     TStNetPerformance,
     TStNetMessage,
     {$ENDIF}
     {$ENDIF}
     TStVersionInfo,
     TStExpression,
     TStExpressionEdit,
     TStBarCode,
     TStPNBarCode,
     TStRegEx,
     TStWMDataCopy,
     TStFileToHTML,
     TStSpawnApplication]);

  {non-visual container class components}
  RegisterComponents('SysTools (CC)',
    [TStNVBits,
     TStNVCollection,
     TStNVDictionary,
     TStNVDQue,
     TStNVLArray,
     TStNVList,
     TStNVLMatrix,
     TStNVSortedCollection,
     TStNVTree]);
end;

end.
