�
 TPRNDIALOG 0�  TPF0
TPrnDialog	PrnDialogLeft4Top� ActiveControl
cmbPrinterBorderStylebsDialogCaption!Setup Print Job & Report SettingsClientHeight�ClientWidthColor	clBtnFaceDefaultMonitor
dmMainForm
ParentFont	OldCreateOrder	PositionpoScreenCenterScaledShowHint	OnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShow
DesignSize� PixelsPerInch`
TextHeight TBitBtnbtOKLeftGTopoWidthVHeightAnchorsakLeftakBottom Caption&OKDefault	TabOrder OnClick	btOkClick  TBitBtnbtCancelLeft�TopoWidthVHeightAnchorsakLeftakBottom Cancel	CaptionCancelTabOrderOnClickbtCancelClick  	TGroupBox	GBPrinterLeftTopWidth�Height� CaptionPrinterTabOrder TLabelLabel2LeftTopfWidth#HeightCaptionStatus:Transparent	  TLabel	lblStatusLeftPTopfWidthHeightCaptionReadyTransparent	  TLabelLabel3LeftTop:WidthHeightCaptionType:  TLabellblTypeLeftPTop:Width"HeightCaptionlblType  TLabelLabel1LeftTopPWidth$HeightCaptionWhere:  TLabellblWhereLeftPTopPWidth*HeightCaptionlblWhere  	TComboBox
cmbPrinterLeftTopWidthqHeightStylecsDropDownListCtl3D	
ItemHeightParentCtl3DTabOrder OnChangecmbPrinterChangeItems.StringsHP 5HP 6HP 7   TButtonbtnPropLeft�TopWidthVHeightHint'Access Advanced Printer Device SettingsCaption&Properties...TabOrderOnClickbtnPropClick  	TCheckBoxchkUseDefaultLeftPTop� WidthYHeightBiDiModebdLeftToRightCaption6Always use the Windows default printer for this reportChecked	ParentBiDiModeState	cbCheckedTabOrder   	TGroupBoxGBPrintLeftTop� Width� Height� CaptionPrintTabOrder TLabelLabel5Left� TophWidthHeightCaptionTo:  TLabelLabel6LeftTopWidth$HeightCaption&Copies:Transparent	  TLabelLabel4LeftTop4WidthHeightCaptionPages  TRadioButton
rbAllPagesLeftTopPWidth� HeightCaption&All Checked	TabOrderTabStop	  TRadioButtonrbFromLeftTophWidth9HeightCaption&From:TabOrder  TOvcPictureFieldopFromLeftPTopcWidth)HeightCursorcrIBeamDataType
pftLongIntAutoSizeBorderStylebsNoneCaretOvr.ShapecsBlock
ControllerOvcController1ControlCharColorclRedDecimalPlaces EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextEpoch InitDateTime	MaxLengthOptionsefoCaretToEnd PictureMaskiiiiTabOrderOnEnteropFromEnter	RangeHigh

   ���      RangeLow

      �        TOvcPictureFieldopToLeft� TopcWidth)HeightCursorcrIBeamDataType
pftLongIntAutoSizeBorderStylebsNoneCaretOvr.ShapecsBlock
ControllerOvcController1ControlCharColorclRedDecimalPlaces EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextEpoch InitDateTime	MaxLengthOptionsefoCaretToEnd PictureMaskiiiiTabOrderOnEnter	opToEnter	RangeHigh

   ���      RangeLow

      �        TOvcPictureFieldopCopiesLeftPTopWidth)HeightCursorcrIBeamDataType
pftLongIntAutoSizeBorderStylebsNoneCaretOvr.ShapecsBlock
ControllerOvcController1ControlCharColorclRedDecimalPlaces EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextEpoch InitDateTime	MaxLengthOptionsefoCaretToEnd PictureMaskiiiTabOrder OnChangeopCopiesChange	RangeHigh

   d         RangeLow

               	TGroupBoxGBPaperLeft Top� Width� Height� CaptionPaperTabOrder
DesignSize� �   TLabelLabel7LeftTopWidthHeightCaptionSize:Transparent	  TLabelLabel8LeftTop4Width%HeightCaptionSource:Transparent	  TLabellblOrientationLeftTopXWidth:HeightCaptionOrientation:Transparent	  	TComboBoxcmbSizeLeftBTopWidth� HeightStylecsDropDownListAnchorsakTop 
ItemHeightTabOrder OnChangecmbSizeChangeItems.StringsA4A5   	TComboBox	cmbSourceLeftBTop0Width� HeightStylecsDropDownListAnchorsakTop 
ItemHeightTabOrderOnChangecmbSourceChangeItems.StringsManual Feed
First Tray   TRadioButton
rbPortraitLeftPTopXWidthQHeightCaptionPortraitChecked	Color	clBtnFaceParentColorTabOrderTabStop	OnClickrbPortraitClick  TRadioButtonrbLandscapeLeftPTopoWidthaHeightCaption	LandscapeColor	clBtnFaceParentColorTabOrderOnClickrbLandscapeClick  TButtonbtnSetMarginsLeftSTop� WidthVHeightHintSet the Report MarginsCaption &Margins...TabOrderOnClickbtnSetMarginsClick   	TGroupBoxGBSaveLeftTop8Width� Height1TabOrder TButtonbtnSaveLeft� TopWidthVHeightHint)Always use these settings for this ReportCaption&Save TabOrderOnClickbtnSaveClick  TButtonbtnResetLeftTopWidthyHeightHint*Restore ALL settings to the default valuesCaptionRestore &DefaultsParentShowHintShowHint	TabOrder OnClickbtnResetClick   TBitBtn	BtPreviewLeftTopoWidthVHeightAnchorsakLeftakBottom CaptionPre&viewTabOrderOnClickBtPreviewClick  TBitBtnbtPrintLeftGTopoWidthVHeightAnchorsakLeftakBottom CaptionPr&intDefault	TabOrderOnClickbtPrintClick  TOvcControllerOvcController1EntryCommands.TableListDefault	 WordStar Grid  EpochlLeft�    