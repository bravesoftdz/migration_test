�
 TDLGPAYEEREP 0�  TPF0TdlgPayeeRepdlgPayeeRepLeft�Top?BorderStylebsDialogCaptionSpending by Payee ReportClientHeight0ClientWidthQColor	clBtnFaceDefaultMonitor
dmMainFormFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style OldCreateOrderPositionpoScreenCenterScaledOnCreate
FormCreate
OnShortCutFormShortCut
DesignSizeQ0 PixelsPerInch`
TextHeight TPanelpnlAllCodesLeftpTopWidth� Height� 
BevelInnerbvRaised
BevelOuter	bvLoweredFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrder TLabelLabel3Left TopWidthgHeight CaptionAll Payees will be reported on.WordWrap	   TButtonbtnOKLeft�TopWidthKHeightHintPrint the ReportAnchorsakRightakBottom Caption&PrintFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontParentShowHintShowHint	TabOrder	OnClick
btnOKClickExplicitLeft�  TButton	btnCancelLeftTopWidthKHeightHintCancel the reportAnchorsakRightakBottom Cancel	CaptionCancelFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontParentShowHintShowHint	TabOrder
OnClickbtnCancelClickExplicitLeft   TButton
btnPreviewLeftTopWidthKHeightHintPreview the ReportAnchorsakLeftakBottom CaptionPrevie&wDefault	Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontParentShowHintShowHint	TabOrderOnClickbtnPreviewClick  TButtonbtnFileLeftXTopWidthKHeightHintSend the Report to a fileAnchorsakLeftakBottom CaptionFil&eFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontParentShowHintShowHint	TabOrderOnClickbtnFileClick  TPanelpnlAccountsLeftTopWidthIHeight1
BevelInnerbvRaised
BevelOuter	bvLoweredFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrder  TLabelLabel1LeftTopWidth(HeightCaptionPayees  TRadioButton
rbAllCodesLeftjTopWidthIHeightHintShow all payees on ReportCaption&AllChecked	ParentShowHintShowHint	TabOrder TabStop	OnClickrbAllCodesClick  TRadioButtonrbSelectedCodesLeft� TopWidthYHeightHintShow selected payees on ReportCaption	Sele&ctedParentShowHintShowHint	TabOrderOnClickrbSelectedCodesClick   TPanelpnlDatesLeft	TopAWidthHHeightT
BevelInnerbvRaised
BevelOuter	bvLoweredFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrder �TfmeDateSelectorDateSelectorLeftTopWidthHeight>TabOrder TabStop	ExplicitLeftExplicitTopExplicitHeight> �TLabelLabel2LeftExplicitLeft  �TLabelLabel3LeftExplicitLeft  �TOvcPictureField	eDateFromEpoch 	RangeHigh

   %`       RangeLow

               �TOvcPictureFieldeDateToEpoch 	RangeHigh

   %`       RangeLow

               �TOvcControllerOvcController1EntryCommands.TableListDefault	 WordStar Grid      TPanel
pnlOptionsLeftTop� WidthIHeightnAnchorsakLeftakTopakBottom 
BevelInnerbvRaised
BevelOuter	bvLoweredFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrder TLabelLabel9LeftTopWidth)HeightCaptionFormat  TRadioButton
rbDetailedLeft`TopWidthaHeightCaption	De&tailedChecked	TabOrder TabStop	OnClickrbDetailedClick  TRadioButtonrbSummarisedLeft� TopWidthqHeightCaption&SummarisedTabOrderOnClickrbDetailedClick  	TCheckBoxchkWrapLeftTopQWidth� HeightHint.Check to show wrapped narrations in the ReportCaptionW&rap NarrationTabOrder  	TCheckBox	chkTotalsLeftTop:Width� HeightHint)Check to show period totals in the ReportCaptionS&how Periodic TotalsTabOrderOnClickchkTotalsClick  	TComboBox	cmbTotalsLeft� Top6Width}HeightStylecsDropDownList
ItemHeightTabOrder  	TCheckBoxchkNetandGstAmountsLeftTop#Width� HeightHint!Check to show Net and GST AmountsCaptionShow &Net and GST AmountsTabOrderOnClickchkTotalsClick   TPanelpnlSelectedCodesLeftXTopWidth� HeightAnchorsakLeftakTopakBottom 
BevelInnerbvRaised
BevelOuter	bvLoweredCaptionpnlSelectedCodesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrderVisible
DesignSize�   TLabelLabel6LeftTopWidth"HeightCaptionFrom   TLabelLabel7LeftrTopWidthHeightCaptionTo  TSpeedButtonbtnPayeeLeft� TopWidthAHeightHintLookup PayeesCaptionPayeeFlat	ParentShowHintShowHint	OnClickbtnPayeeClick  TtsGridtgRangesLeftTop Width� Height� Hint%Select payee ranges to show on ReportAnchorsakLeftakTopakBottom 	AutoScale	CheckBoxStylestCheckColsDefaultColWidthiDefaultRowHeightExportDelimiter,Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.Style HeadingFont.CharsetDEFAULT_CHARSETHeadingFont.ColorclWindowTextHeadingFont.Height�HeadingFont.NameMS Sans SerifHeadingFont.Style HeadingHeight	HeadingOnHeadingParentFontMaskDefstsMaskDefs1
ParentFontParentShowHintRowBarIndicatorRowBarOnRows
ScrollBars
ssVerticalShowHint		StoreData	TabOrder Version2.20.26WantTabsXMLExport.Version1.0XMLExport.DataPacketVersion2.0OnCellLoadedtgRangesCellLoadedOnEndCellEdittgRangesEndCellEdit	OnKeyDowntgRangesKeyDownOnResizetgRangesResizeColPropertiesDataColCol.ControlTypectTextCol.MaskNamesysLongIntegerCol.MaxLength
	Col.Widthi DataColCol.ControlTypectTextCol.MaskNamesysLongIntegerCol.MaxLength
	Col.Widthh  Data
                           TButtonbtnSaveTemplateLeftTop� WidthnHeightAnchorsakLeftakBottom CaptionSave Te&mplateTabOrderOnClickbtnSaveTemplateClick  TButtonbtnLoadLeft� Top� WidthnHeightAnchorsakLeftakBottom Caption&Load TemplateTabOrderOnClickbtnLoadClick   TBitBtnbtnSaveLeft_TopWidthKHeightAnchorsakRightakBottom CaptionSa&veFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrderOnClickbtnSaveClickExplicitLeft^  TButtonbtnEmailLeft� TopWidthKHeightHintAttach Report to EmailAnchorsakLeftakBottom CaptionE&mailFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontParentShowHintShowHint	TabOrderOnClickbtnEmailClick  TtsMaskDefstsMaskDefs1MasksNamesysLongIntegerPicture*9[#]  LeftxTop@  TOpenDialogOpenDialog1
DefaultExt.prtFilter#Payee Report Template (*.prt)|*.prtOptionsofHideReadOnlyofPathMustExistofFileMustExistofEnableSizing TitleLoad Payee Report TemplateLeftTop  TSaveDialogSaveDialog1
DefaultExt.prtFilter#Payee Report Template (*.prt)|*.prtOptionsofOverwritePromptofHideReadOnlyofEnableSizing TitleSave Payee Report TemplateLeft8Top   