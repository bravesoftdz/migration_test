�
 TFRMOPTIONS 0�!  TPF0TfrmOptions
frmOptionsLeftFTop� BorderStylebsDialogCaptionPreferencesClientHeight�ClientWidthKColor	clBtnFaceDefaultMonitor
dmMainForm
ParentFont	OldCreateOrderPositionpoScreenCenterScaledOnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight TPageControlPageControl1Left Top WidthKHeight�
ActivePage	tsToolbarAlignalClientTabOrder OnChangePageControl1Change 	TTabSheet	tsToolbarCaptionGene&ral TLabelLabel18LeftTop� WidthPHeightCaption&Auto save everyFocusControlrsAutoSaveTime  TLabellblAutoSaveTimeLeft� Top� Width%HeightCaptionminutes  TLabellblNarrationLeftTop� WidthHeightCaption7&Maximum number of characters to extract from NarrationFocusControlrsMaxNarration  TLabellblFontLeftTop/WidthMHeightCaptionCoding hint font  	TCheckBoxchkCaptionsLeftTopWidth�HeightCaption Show &caption on toolbar buttonsTabOrder   	TCheckBoxchkShowHintLeftTop8Width�HeightCaption*Show &hints on screens, fields and buttonsTabOrderOnClickchkShowHintClick  	TCheckBoxchkShowCodeHintLeftTopXWidth�HeightCaption=&Show descriptions next to chart codes in Code Entries ScreenTabOrder  TRzSpinEditrsAutoSaveTimeLeft� Top� Width1HeightAllowKeyEdit	Max       �@TabOrderOnChangersAutoSaveTimeChange  TRzSpinEditrsMaxNarrationLeftdTop� Width9HeightAllowKeyEdit	Max       �@Value       �@	AlignmenttaLeftJustifyTabOrder  	TCheckBoxCBShowPrintOptionLeftTop� Width�HeightCaption,Always show &printer options before printingTabOrder  	TCheckBoxchkCheckoutLeftTopxWidth�HeightCaptionAllow client &files to be sentTabOrder  TButtonbtnConfigureInternetLeftTop Width� HeightCaptionCo&nfigure Internet SettingsTabOrderOnClickbtnConfigureInternetClick  TButtonbtnResetLeftdTop+Width;HeightCaptionRese&tTabOrderOnClickbtnResetClick  TPanel
pnlCESFontLeft�TopWidth}Height8	AlignmenttaLeftJustify
BevelOuterbvNoneCaptionCoding hintFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder	  TRzFontComboBoxcbceFontLeft� Top,Width� HeightPreviewFontSizePreviewTextCoding HintDropDownWidth� 
ItemHeightTabOrder
OnChangecbceFontChange  TRzComboBoxcbSizeLeft4Top,Width*Height	AllowEditStylecsDropDownList
ItemHeightTabOrderOnChangecbSizeChangeItems.Strings5678910111213141516   TPanel
pnlUIStyleLeftTopWWidth2Height=
BevelOuterbvNoneParentColor	TabOrder TLabel
lblUIStyleLeftTopWidth<HeightCaptionScreen Style  TLabelLabel12Left}TopWidthHeightCaption;(Changes will take effect when you restart the application)  TRadioButtonrbGUIStandardLeft3Top!Width\HeightCaption	Standard TabOrder   TRadioButtonrbGUISimpleLeft� Top!Width\HeightCaption
SimplifiedChecked	TabOrderTabStop	    	TTabSheettsEmailCaption&E-mail
ImageIndex TPanelPanel2LeftTopWidth<Height� 
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  TLabelLabel4LeftTop/Width<HeightCaptionProfile &NameFocusControleProfileName  TLabelLabel5LeftTopKWidth.HeightCaption	&PasswordFocusControleMAPIPassword  	TCheckBoxchkMAPILeftTopWidth� HeightCaptionUse &Default ProfileChecked	State	cbCheckedTabOrder OnClickchkMAPIClick  TEditeProfileNameLeft� Top+Width� HeightBorderStylebsNoneTabOrderTexteProfileName  TEditeMAPIPasswordLeft� TopIWidth� HeightBorderStylebsNonePasswordChar*TabOrderTexteMAPIPassword  	TCheckBoxchkExtendedMAPILeftTopfWidth� HeightCaptionTurn on e&xtended MAPI support TabOrderOnClickchkExtendedMAPIClick   TPanelPanel3LeftTop� Width=Height
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder TLabelLabel1LeftTopWidth� HeightCaptionOu&tgoing Mail Server (SMTP) FocusControleSMTP  TLabelLabel2LeftTop� WidthEHeightCaptionAccount &NameFocusControleAccountName  TLabelLabel3LeftTop� Width.HeightCaption	&PasswordFocusControleSMTPPassword  TLabelLabel6LeftTopPWidthjHeightCaption&Return E-mail AddressFocusControleReturn  TLabelLabel7LeftTop2WidthEHeightCaption&Timeout (sec.)FocusControlnTimeout  TLabelLabel11LeftTopnWidth$HeightCaptionP&ort NoFocusControleReturn  	TCheckBoxchkAuthenticationLeftTop� Width)HeightCaption'My Mail Server requires &AuthenticationTabOrderOnClickchkAuthenticationClick  TEditeSMTPLeft� TopWidth+HeightBorderStylebsNoneTabOrder TexteSMTP  TEditeAccountNameLeft� Top� Width� HeightBorderStylebsNoneTabOrderTexteAccountName  TEditeSMTPPasswordLeft� Top� Width� HeightBorderStylebsNonePasswordChar*TabOrderTexteSMTPPassword  TEditeReturnLeft� TopMWidth+HeightBorderStylebsNone	MaxLengthPTabOrderTexteReturn  TOvcNumericFieldnTimeoutLeft� Top/Width9HeightCursorcrIBeamDataType
nftLongIntAutoSizeBorderStylebsNoneCaretOvr.ShapecsBlock
ControllerOvcController1EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextOptions PictureMask######TabOrder	RangeHigh

   ���      RangeLow

      �        	TCheckBox	chkUseSSLLeftTop� Width� HeightCaptionUse SSLTabOrderVisibleOnClickchkAuthenticationClick  TEdit	edtPortNoLeft� TopkWidth� HeightBorderStylebsNoneTabOrder   TRadioButtonrbMAPILeftTop�Width� HeightCaptionUse &MAPI MailChecked	TabOrderTabStop	OnClickrbMAPIClick  TRadioButtonrbSMTPLeftTop� Width� HeightCaptionUse &Internet Mail TabOrderOnClickrbMAPIClick   	TTabSheettsBackupCaption&Backups
ImageIndex TLabelLabel9LeftTopWidth� HeightCaption,Do the following when closing a client file:  TRadioButtonrbBackup_autoLeftXTop`Width1HeightCaptionba&ckup automaticallyTabOrderOnClickrbBackup_donothingClick  TRadioButtonrbBackup_promptLeftXTopHWidth� HeightCaption!&prompt me for a backup directoryTabOrderOnClickrbBackup_donothingClick  TRadioButtonrbBackup_donothingLeftXTop0WidthqHeightCaption&do nothingChecked	TabOrder TabStop	OnClickrbBackup_donothingClick  TPanelpnlBackupOptionsLeftTop� Width7Height6
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder TLabelLabel8LeftTopWidth\HeightCaptionBac&kup client file toFocusControledtBackupDir  TSpeedButton	btnFolderLeftTopWidthHeightHintClick to Select a FolderOnClickbtnFolderClick  TEditedtBackupDirLeft� TopWidth�HeightBorderStylebsNoneTabOrder   	TCheckBoxchkOverwriteLeftTop8Width� Height	AlignmenttaLeftJustifyCaptionOverwrite existing backup(s)Checked	State	cbCheckedTabOrderVisible    	TTabSheettsFilesCaptionF&ile Associations
ImageIndex 	TGroupBox
gbTRFfilesLeftTopWidth<Height� Caption BNotes files TabOrder  TLabellblClickOnBNotesLeftTop Width� HeightCaption When I click on a BNotes file...  TRadioButtonrbOpenTRFwithHandlerLeft0TopHWidth�HeightCaption0&Ask me whether to open it in BankLink or BNotesTabOrder   TRadioButtonrbOpenTRFwithBNotesLeft0TophWidth�HeightCaptionO&pen it with BNotesTabOrder    	TTabSheettsLinksCaption&Links
ImageIndex 	TGroupBox
gbWebPagesLeftTopWidth<Height� Caption	Web pagesTabOrder  TLabelLabel10LeftTop,Width7HeightCaptionG&ST ReturnFocusControlEgst101  TEditEgst101LefthTop(Width�HeightTabOrder      TPanelPanel1Left Top�WidthKHeight"AlignalBottom
BevelOuterbvNoneTabOrder
DesignSizeK"  TButtonbtnOkLeft�TopWidthKHeightAnchorsakRightakBottom Caption&OKDefault	ModalResultTabOrder OnClick
btnOkClick  TButton	btnCancelLeft�TopWidthKHeightAnchorsakRightakBottom Cancel	CaptionCancelModalResultTabOrder   TOvcControllerOvcController1EntryCommands.TableListDefault	 WordStar Grid  EpochlLeft�   