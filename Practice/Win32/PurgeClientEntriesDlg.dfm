�
 TDLGPURGECLIENTENTRIES 0�  TPF0TdlgPurgeClientEntriesdlgPurgeClientEntriesLeftNTop� BorderIconsbiSystemMenu BorderStylebsDialogCaptionPurge Old EntriesClientHeight�ClientWidth�ColorclWindowDefaultMonitor
dmMainForm
ParentFont	OldCreateOrderPositionpoScreenCenterScaledOnCloseQueryFormCloseQueryOnCreate
FormCreatePixelsPerInch`
TextHeight TLabel
lblEntriesLeftTopWidth� HeightCaption)This Client File contains entries from %s  TLabellblPurgeDateLeftToplWidth� HeightCaption(This will purge entries before dd/mm/yy.  TBevelBevel1LeftTopXWidth�HeightShape	bsTopLine  TBevelBevel2Left2Top� Width� HeightShape	bsTopLine  TLabelLabel1LeftTop� Width� HeightCaption0Select the date range that you wish to be purged  TBevelBevel4LeftTop/Width� HeightShape	bsTopLine  TLabelLabel2Left� TopWidth� HeightCaption.&months prior to the Financial Year Start DateFocusControlnfMths  TLabelLabel3LeftATop3Width
HeightCaptiont&oFocusControl	eDateFrom  TRadioButtonrbMonthsLeftTopWidth� HeightCaption&Dated more thanChecked	TabOrderTabStop	OnClickrbMonthsClick  	TCheckBoxchkTransOnlyLeftTop�Width� HeightCaptionPurge &transferred entries onlyChecked	State	cbCheckedTabOrderOnClickchkTransOnlyClick  TOvcNumericFieldnfMthsLeft� TopWidth*HeightCursorcrIBeamDataType
nftIntegerCaretOvr.ShapecsBlock
ControllerOvcController1EFColors.Disabled.BackColorclWindowEFColors.Disabled.TextColor
clGrayTextEFColors.Error.BackColorclRedEFColors.Error.TextColorclBlackEFColors.Highlight.BackColorclHighlightEFColors.Highlight.TextColorclHighlightTextOptionsefoArrowIncDec PictureMask999TabOrderOnChangenfMthsChange
OnKeyPressnfMthsKeyPress	RangeHigh

   �        RangeLow

    ���        TOvcSpinnerOvcSpinner1Left� TopWidthHeight
AutoRepeat	Delta       ��?FocusedControlnfMthsWrapMode  TRadioButtonrbDateLeftTop3Width1HeightCaptionP&riorTabOrderOnClickrbMonthsClick  �TfmeAccountSelectorfmeAccountSelector1LeftTop!Width�Height� TabOrder TabStop	ExplicitLeftExplicitTop!ExplicitWidth� �TLabellblSelectAccountsLeft Width� Caption+Select the accounts that you wish be purgedExplicitLeft ExplicitWidth�   �TCheckListBoxchkAccountsLeft TopHeight� OnClicknfMthsChangeExplicitLeft ExplicitTopExplicitHeight�   �TButtonbtnSelectAllAccountsOnClick,fmeAccountSelector1btnSelectAllAccountsClick  �TButtonbtnClearAllAccountsOnClick+fmeAccountSelector1btnClearAllAccountsClick   TRzDateTimeEdit	eDateFromLeftXTop/Width� HeightEditTypeetDateTabOrderOnChangenfMthsChange  TPanelpnlControlsLeft Top�Width�Height)AlignalBottom
BevelOuterbvNoneCaption ParentBackgroundTabOrderExplicitLeftExplicitTop�ExplicitWidthH
DesignSize�)  TShapeShape1Left Top Width�HeightAlignalTop	Pen.ColorclSilver  TButtonbtnPurgeLeftTTopWidthKHeightAnchorsakRightakBottom Caption&PurgeDefault	ModalResultTabOrder   TButton	btnCancelLeft�TopWidthKHeightAnchorsakRightakBottom Cancel	CaptionCancelModalResultTabOrderExplicitLeft�    TOvcControllerOvcController1EntryCommands.TableListDefault	 WordStar Grid  EntryOptionsefoAutoSelectefoInsertPushes EpochlLeft�   