�
 TDLGFIND 0s	  TPF0TdlgFinddlgFindLeftTop� BorderStylebsDialogCaptionFind a TransactionClientHeight� ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style OldCreateOrder	PositionpoScreenCenterScaledOnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel1Left TopWidth� Height'CaptiondEnter a Date, a Reference, an Amount, or a combination, then press OK to search for the transaction.WordWrap	  TLabelLabel2Left TopPWidth4HeightCaptionEntry &DateFocusControl	EntryDate  TLabelLabel3Left ToppWidth2HeightCaption
&ReferenceFocusControl
tReference  TLabelLabel4Left Top� WidthEHeightCaptionEntry &Amount FocusControlnAmount  TOvcPictureField	EntryDateLeftxTopPWidthiHeightCursorcrIBeamDataTypepftDateBorderStylebsNoneCaretOvr.ShapecsBlock
ControllerOvcController1ControlCharColorclRedDecimalPlaces EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextEpoch InitDateTime	MaxLengthOptionsefoCaretToEnd PictureMaskDD/mm/yyTabOrder 
OnDblClickEntryDateDblClickOnErrorEntryDateError
OnKeyPressEntryDateKeyPress	RangeHigh

   %`       RangeLow

               TEdit
tReferenceLeftxToppWidth� HeightBorderStylebsNoneTabOrderText
tReference  TOvcNumericFieldnAmountLeftxTop� WidthiHeightCursorcrIBeamDataType	nftDoubleBorderStylebsNoneCaretOvr.ShapecsBlock
ControllerOvcController1EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextOptions PictureMask###,###,###.##TabOrder	RangeHigh

   s�۹����CRangeLow

   s�۹�����  TButtonbtnOKLeft� Top� WidthKHeightCaption&OKDefault	TabOrderOnClick
btnOKClick  TButton	btnCancelLeft0Top� WidthKHeightCancel	CaptionCancelTabOrderOnClickbtnCancelClick  TButtonBtnCalLeft� TopPWidthHeightCaption...TabOrderOnClickBtnCalClick  TOvcControllerOvcController1EntryCommands.TableListGrid	  EpochlLeft@   