�
 TDLGEDITUSER 0.  TPF0TdlgEditUserdlgEditUserLeft�TopBorderStylebsDialogCaptionUser DetailsClientHeightClientWidthCColor	clBtnFaceDefaultMonitor
dmMainFormFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style OldCreateOrderPositionpoScreenCenterScaledShowHint	OnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShow
DesignSizeC PixelsPerInch`
TextHeight TButtonbtnOKLeft�Top�WidthKHeightAnchorsakRightakBottom Caption&OKDefault	Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrderOnClick
btnOKClick  TButton	btnCancelLeft�Top�WidthKHeightAnchorsakRightakBottom Cancel	CaptionCancelFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrderOnClickbtnCancelClick  TPageControlpcMainLeftTopWidth6Height�
ActivePagetsMYOBAnchorsakLeftakTopakRightakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrder  	TTabSheet	tsDetailsCaptionUser Details TPanelpnlMainLeft Top Width.HeightWAlignalTop
BevelOuterbvNoneTabOrder OnClickpnlMainClick TLabellblUserTypeLeft� Top� Width1HeightAutoSizeCaptionlblUserType  TLabelLabel7LeftTop� Width+HeightCaptionOptions  TLabelLabel8LeftTop� Width:HeightCaption
User &TypeFocusControlcmbUserType  TLabelLabel9LeftTopoWidth:HeightCaptionD&irect DialFocusControleDirectDial  TLabelLabel3LeftTopOWidthHeightCaption&EmailFocusControleMail  TLabelLabel2LeftTop/Width?HeightCaption
User &NameFocusControl	eFullName  TLabelLabel1LeftTopWidth;HeightCaption
&User CodeFocusControl	eUserCode  TLabel
stUserNameLeftxTopWidthEHeightCaption
stUserName  TPanelpnlEnterPasswordLeftTop� Width%Height?
BevelOuterbvNoneTabOrder TLabelLabel4LeftTopWidth7HeightCaption	&PasswordFocusControlePass  TLabelLabel5LeftTopWidthhHeightCaption&Confirm PasswordFocusControleConfirmPass  TLabelLblPasswordValidationLeftTop%Width� HeightCaption(Maximum 12 characters)  TEditePassLefttTopWidthyHeightBorderStylebsNoneFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name	Wingdings
Font.Style 	MaxLength
ParentFontPasswordChar   ŸTabOrder TextEPASS  TEditeConfirmPassLeft�TopWidthyHeightBorderStylebsNoneFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name	Wingdings
Font.Style 	MaxLength
ParentFontPasswordChar   ŸTabOrderTextECONFIRMPASS   TPanelpnlResetPasswordLeftTop� Width%Height?
BevelOuterbvNoneTabOrder TLabelLabel11LeftTopWidth7HeightCaptionPassword  TButtonbtnResetPasswordLefttTop	WidtheHeightCaptionReset PasswordTabOrder OnClickbtnResetPasswordClick   TPanelpnlGeneratedPasswordLeftTop� Width%Height?
BevelOuterbvNoneTabOrder TLabelLabel12LeftTopWidth7HeightCaptionPassword  TLabelLabel13LefttTopWidthsHeightCaptionABankLink Online will automatically generate this user's password.   	TCheckBoxchkShowPracticeLogoLeftxTopDWidthIHeightCaptionShow practice logoTabOrder  	TCheckBoxCBSuppressHeaderFooterLeftxTop&WidthIHeightCaption$&Suppress Reporting Headers/Footers TabOrder
  	TCheckBoxCBPrintDialogOptionLeftxTopWidthIHeightCaption,&Always show printer options before printingTabOrder	OnClickCBPrintDialogOptionClick  	TCheckBox	chkMasterLeftxTop� WidthIHeightCaption.User can create and edit Master &MemorisationsTabOrderOnClickchkMasterClick  	TComboBoxcmbUserTypeLeftxTop� WidthyHeightStylecsDropDownList
ItemHeightTabOrderOnSelectcmbUserTypeSelect  TEditeDirectDialLeftxToplWidth� HeightBorderStylebsNone	MaxLengthTabOrderTexteDirectDialOnChangeeDirectDialChange  TEditeMailLeftxTopLWidth�HeightBorderStylebsNone	MaxLengthPTabOrderTexteMailOnChangeeMailChange  TEdit	eFullNameLeftxTop,Width�HeightBorderStylebsNone	MaxLength<TabOrderText	eFullNameOnChangeeFullNameChange  TEdit	eUserCodeLeftxTopWidthyHeightBorderStylebsNoneCharCaseecUpperCase	MaxLengthTabOrder Text	EUSERCODE   TPanelpnlUserIsLoggedOnLeft Top�Width.Height'AlignalBottom
BevelOuterbvNoneTabOrder TPanel
pnlSpecialLeftlTopWidth�Height
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  	TCheckBoxchkLoggedInLeftTopWidth�HeightCaptionUser is &Logged InTabOrder OnClickchkLoggedInClick    TPanel	pnlOnlineLeft TopWWidth.HeightCAlignalClient
BevelOuterbvNoneTabOrder TPanelpnlOnlineLeftLeft Top WidthkHeightCAlignalLeft
BevelOuterbvNoneTabOrder   TPanelpnlOnlineRightLeftTop Width&HeightCAlignalRight
BevelOuterbvNoneTabOrder  TPanelpnlOnlineMidLeftkTop Width�HeightCAlignalClient
BevelInner	bvLoweredTabOrder TPanelpnlAllowAccessLeftTopWidth�HeightAlignalTop
BevelOuterbvNoneTabOrder  TLabellblPrimaryContactLeft� Top
WidtheHeightCaption(Primary Contact)Visible  	TCheckBoxchkCanAccessBankLinkOnlineLeftTopWidth� HeightCaption Allow access to &BankLink OnlineTabOrder OnClickchkCanAccessBankLinkOnlineClick   TPanelpnlUnlinkedLeftTop!Width�Height AlignalClient
BevelOuterbvNoneTabOrder TRadioButtonradCreateNewOnlineUserLeftTopWidth�HeightCaption#C&reate new user on BankLink OnlineChecked	TabOrder TabStop	OnClickradCreateNewOnlineUserClick  TRadioButtonradLinkExistingOnlineUserLeftTopWidth�HeightCaption)Lin&k to existing user on Banklink OnlineTabOrderOnClickradLinkExistingOnlineUserClick  	TComboBoxcmbLinkExistingOnlineUserLeft7Top0Width^HeightStylecsDropDownListEnabled
ItemHeightSorted	TabOrder   TPanelpnlOnlineUserLeftTop!Width�Height AlignalClient
BevelOuterbvNoneTabOrder TLabelLabel10Left#TopWidthHeightFocusControleOnlineUser  TEditeOnlineUserLeftTop WidthoHeightBorderStylebsNoneEnabled	MaxLengthPTabOrder TexteOnlineUser      	TTabSheettsFilesCaptionFiles
ImageIndex TLabelLabel6LeftTopWidth� HeightCaptionThis user has access to:   TRadioButton
rbAllFilesLeft0Top#WidthqHeightCaption
&All filesTabOrder OnClickrbAllFilesClick  TRadioButtonrbSelectedFilesLeft0Top;Width� HeightCaptionSelected &files onlyTabOrderOnClickrbSelectedFilesClick  TPanelpnlSelectedLeftTopPWidthHeight� 
BevelOuterbvNoneCaptionpnlSelectedTabOrder 	TListViewlvFilesLeftTopWidth�Height� ColumnsCaptionCodeWidthx AutoSize	CaptionName  MultiSelect	ReadOnly	SmallImagesAppImages.FilesTabOrder 	ViewStylevsReport  TButtonbtnAddLeft�TopWidthYHeightCaptionA&ddTabOrderOnClickbtnAddClick  TButton	btnRemoveLeft�Top*WidthYHeightCaption&RemoveTabOrderOnClickbtnRemoveClick  TButtonbtnRemoveAllLeft�TopVWidthYHeightCaptionRemo&ve AllTabOrderOnClickbtnRemoveAllClick    	TTabSheettsMYOBCaption
Interfaces
ImageIndex TLabelLabel14Left
TopWidthCHeightCaption
MYOB Login  TEdit
edtEmailIdLeftxTopWidthqHeightBorderStylebsNoneTabOrder      