object dlgMemorise: TdlgMemorise
  Left = 345
  Top = 246
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Memorise Transaction'
  ClientHeight = 812
  ClientWidth = 1034
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 570
  DefaultMonitor = dmMainForm
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 776
    Width = 1034
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1034
      36)
    object btnOK: TButton
      Left = 871
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 952
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnCopy: TButton
      Left = 776
      Top = 6
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Copy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCopyClick
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 207
    Width = 1034
    Height = 569
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 265
      Width = 1034
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      ExplicitTop = 232
      ExplicitWidth = 328
    end
    object pnlAllocateTo: TPanel
      Left = 0
      Top = 0
      Width = 1034
      Height = 265
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 5
      TabOrder = 0
      DesignSize = (
        1034
        265)
      object lblAllocateTo: TLabel
        Left = 14
        Top = 60
        Width = 72
        Height = 16
        Caption = 'Allocate To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ToolBar: TPanel
        AlignWithMargins = True
        Left = 6
        Top = 15
        Width = 1024
        Height = 26
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 5
        Anchors = [akLeft, akTop, akRight]
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 0
        object sbtnPayee: TSpeedButton
          AlignWithMargins = True
          Left = 74
          Top = 2
          Width = 65
          Height = 22
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = 'Payee'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = sbtnPayeeClick
          ExplicitLeft = 0
          ExplicitTop = 0
        end
        object sbtnChart: TSpeedButton
          AlignWithMargins = True
          Left = 3
          Top = 2
          Width = 65
          Height = 22
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = 'Chart'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = sbtnChartClick
          ExplicitTop = 4
        end
        object sbtnJob: TSpeedButton
          AlignWithMargins = True
          Left = 145
          Top = 2
          Width = 65
          Height = 22
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = 'Job'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = sbtnJobClick
        end
        object sbtnSuper: TSpeedButton
          AlignWithMargins = True
          Left = 216
          Top = 2
          Width = 65
          Height = 22
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = 'Super'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = sbtnSuperClick
          ExplicitTop = 4
        end
        object chkMaster: TCheckBox
          AlignWithMargins = True
          Left = 287
          Top = 2
          Width = 141
          Height = 22
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = '&Memorise to MASTER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chkMasterClick
        end
        object chkAccountSystem: TCheckBox
          AlignWithMargins = True
          Left = 434
          Top = 2
          Width = 114
          Height = 22
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = 'Only Apply to :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = chkAccountSystemClick
        end
        object cbAccounting: TComboBox
          AlignWithMargins = True
          Left = 554
          Top = 1
          Width = 467
          Height = 24
          Margins.Top = 1
          Margins.Bottom = 1
          Align = alClient
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Sorted = True
          TabOrder = 2
        end
      end
      object tblSplit: TOvcTable
        Left = 6
        Top = 82
        Width = 1019
        Height = 132
        RowLimit = 6
        LockedCols = 0
        LeftCol = 0
        ActiveCol = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clWindow
        Colors.ActiveUnfocused = clWindow
        Colors.ActiveUnfocusedText = clWindowText
        Colors.Editing = clWindow
        Controller = memController
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridPenSet.NormalGrid.NormalColor = clBtnShadow
        GridPenSet.NormalGrid.Style = psSolid
        GridPenSet.NormalGrid.Effect = ge3D
        GridPenSet.LockedGrid.NormalColor = clBtnShadow
        GridPenSet.LockedGrid.Style = psSolid
        GridPenSet.LockedGrid.Effect = geBoth
        GridPenSet.CellWhenFocused.NormalColor = clBlack
        GridPenSet.CellWhenFocused.Style = psSolid
        GridPenSet.CellWhenFocused.Effect = geBoth
        GridPenSet.CellWhenUnfocused.NormalColor = clBlack
        GridPenSet.CellWhenUnfocused.Style = psDash
        GridPenSet.CellWhenUnfocused.Effect = geNone
        LockedRowsCell = Header
        Options = [otoNoRowResizing, otoEnterToArrow, otoNoSelection]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        OnActiveCellChanged = tblSplitActiveCellChanged
        OnActiveCellMoving = tblSplitActiveCellMoving
        OnBeginEdit = tblSplitBeginEdit
        OnDoneEdit = tblSplitDoneEdit
        OnEndEdit = tblSplitEndEdit
        OnEnter = tblSplitEnter
        OnEnteringRow = tblSplitEnteringRow
        OnExit = tblSplitExit
        OnGetCellData = tblSplitGetCellData
        OnGetCellAttributes = tblSplitGetCellAttributes
        OnMouseDown = tblSplitMouseDown
        OnUserCommand = tblSplitUserCommand
        CellData = (
          'dlgMemorise.Header'
          'dlgMemorise.colLineType'
          'dlgMemorise.ColPercent'
          'dlgMemorise.ColAmount'
          'dlgMemorise.ColGSTCode'
          'dlgMemorise.colJob'
          'dlgMemorise.ColPayee'
          'dlgMemorise.colNarration'
          'dlgMemorise.ColDesc'
          'dlgMemorise.ColAcct')
        RowData = (
          21)
        ColData = (
          86
          False
          True
          'dlgMemorise.ColAcct'
          172
          False
          True
          'dlgMemorise.ColDesc'
          145
          False
          True
          'dlgMemorise.colNarration'
          45
          False
          True
          'dlgMemorise.ColPayee'
          86
          False
          True
          'dlgMemorise.colJob'
          45
          False
          True
          'dlgMemorise.ColGSTCode'
          100
          False
          True
          'dlgMemorise.ColAmount'
          100
          False
          True
          'dlgMemorise.ColPercent'
          45
          False
          True
          'dlgMemorise.colLineType')
      end
      object Panel4: TPanel
        Left = 505
        Top = 220
        Width = 529
        Height = 39
        Anchors = [akRight, akBottom]
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object lblTotalPerc: TLabel
          Left = 287
          Top = 0
          Width = 40
          Height = 16
          Alignment = taRightJustify
          Caption = '1000%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblRemPerc: TLabel
          Left = 479
          Top = 0
          Width = 40
          Height = 16
          Alignment = taRightJustify
          Caption = '1000%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblRemPercHdr: TLabel
          Left = 341
          Top = 0
          Width = 76
          Height = 16
          Alignment = taRightJustify
          Caption = 'Remaining %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblTotalPercHdr: TLabel
          Left = 175
          Top = 0
          Width = 45
          Height = 16
          Alignment = taRightJustify
          Caption = 'Total %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblAmount: TLabel
          Left = 70
          Top = 0
          Width = 96
          Height = 16
          Caption = '$999,999,999.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblAmountHdr: TLabel
          Left = 0
          Top = 0
          Width = 44
          Height = 16
          Caption = 'Amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblFixed: TLabel
          Left = 230
          Top = 20
          Width = 96
          Height = 16
          Alignment = taRightJustify
          Caption = '$999,999,999.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblFixedHdr: TLabel
          Left = 175
          Top = 22
          Width = 41
          Height = 16
          Caption = 'Fixed $'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblRemDollar: TLabel
          Left = 423
          Top = 20
          Width = 96
          Height = 16
          Alignment = taRightJustify
          Caption = '$999,999,999.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblRemDollarHdr: TLabel
          Left = 341
          Top = 20
          Width = 71
          Height = 16
          Caption = 'Remaining $'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
      object pnlAllocateToLine: TPanel
        Left = 0
        Top = 50
        Width = 1034
        Height = 2
        HelpContext = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvLowered
        TabOrder = 3
      end
      object pnlChartLine: TPanel
        Left = 0
        Top = 5
        Width = 1034
        Height = 2
        HelpContext = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvLowered
        TabOrder = 4
      end
    end
    object pnlMatchingTransactions: TPanel
      Left = 0
      Top = 268
      Width = 1034
      Height = 301
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        1034
        301)
      object lblMatchingTransactions: TLabel
        Left = 14
        Top = 8
        Width = 146
        Height = 16
        Caption = 'Matching Transactions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object tblTran: TOvcTable
        Left = 6
        Top = 30
        Width = 1019
        Height = 267
        RowLimit = 2
        LockedCols = 0
        LeftCol = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clWindow
        Colors.ActiveUnfocused = clWindow
        Colors.ActiveUnfocusedText = clWindowText
        Colors.Editing = clWindow
        Controller = tranController
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridPenSet.NormalGrid.NormalColor = clBtnShadow
        GridPenSet.NormalGrid.Style = psSolid
        GridPenSet.NormalGrid.Effect = ge3D
        GridPenSet.LockedGrid.NormalColor = clBtnShadow
        GridPenSet.LockedGrid.Style = psSolid
        GridPenSet.LockedGrid.Effect = geBoth
        GridPenSet.CellWhenFocused.NormalColor = clBlack
        GridPenSet.CellWhenFocused.Style = psSolid
        GridPenSet.CellWhenFocused.Effect = geBoth
        GridPenSet.CellWhenUnfocused.NormalColor = clBlack
        GridPenSet.CellWhenUnfocused.Style = psDash
        GridPenSet.CellWhenUnfocused.Effect = geNone
        Options = [otoNoRowResizing, otoEnterToArrow, otoNoSelection]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        CellData = ()
        RowData = (
          21)
        ColData = (
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False
          150
          False
          False)
      end
    end
  end
  object pnlDetails: TPanel
    Left = 0
    Top = 0
    Width = 1034
    Height = 207
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1034
      207)
    object lblMatchOn: TLabel
      Left = 14
      Top = 7
      Width = 61
      Height = 16
      Caption = 'Match On'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cEntry: TCheckBox
      Left = 14
      Top = 29
      Width = 130
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Entry Type'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
    object cmbType: TComboBox
      Left = 152
      Top = 27
      Width = 270
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
    end
    object chkStatementDetails: TCheckBox
      Left = 14
      Top = 60
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = '&Statement Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkStatementDetailsClick
    end
    object eStatementDetails: TEdit
      Left = 152
      Top = 57
      Width = 270
      Height = 48
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      BorderStyle = bsNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 3
      Text = 'eStatement Details'
    end
    object cRef: TCheckBox
      Left = 14
      Top = 120
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = '&Reference'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = cRefClick
    end
    object eRef: TEdit
      Left = 152
      Top = 117
      Width = 270
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 5
      Text = 'eRef'
    end
    object eOther: TEdit
      Left = 152
      Top = 147
      Width = 270
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 6
      Text = 'eOther'
    end
    object cOther: TCheckBox
      Left = 14
      Top = 150
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = 'O&ther Party'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = cOtherClick
    end
    object cCode: TCheckBox
      Left = 14
      Top = 180
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = '&Analysis Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = cCodeClick
    end
    object eCode: TEdit
      Left = 152
      Top = 177
      Width = 270
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 9
      Text = 'eCode'
    end
    object cNotes: TCheckBox
      Left = 441
      Top = 151
      Width = 96
      Height = 17
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = '&Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = cNotesClick
    end
    object cPart: TCheckBox
      Left = 441
      Top = 121
      Width = 96
      Height = 17
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = '&Particulars'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = cPartClick
    end
    object cValue: TCheckBox
      Left = 441
      Top = 91
      Width = 96
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = '&Value'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnClick = cValueClick
    end
    object cbTo: TCheckBox
      Left = 441
      Top = 61
      Width = 96
      Height = 17
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Applies to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = cbToClick
    end
    object cbFrom: TCheckBox
      Left = 441
      Top = 31
      Width = 96
      Height = 17
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Applies from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = cbFromClick
    end
    object eDateFrom: TOvcPictureField
      Left = 543
      Top = 28
      Width = 70
      Height = 24
      Cursor = crIBeam
      DataType = pftDate
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = bsNone
      CaretOvr.Shape = csBlock
      Controller = memController
      ControlCharColor = clRed
      DecimalPlaces = 0
      EFColors.Disabled.BackColor = clWindow
      EFColors.Disabled.TextColor = clGrayText
      EFColors.Error.BackColor = clRed
      EFColors.Error.TextColor = clBlack
      EFColors.Highlight.BackColor = clHighlight
      EFColors.Highlight.TextColor = clHighlightText
      Enabled = False
      Epoch = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      InitDateTime = False
      MaxLength = 8
      Options = [efoCaretToEnd]
      ParentFont = False
      PictureMask = 'DD/mm/yy'
      TabOrder = 15
      OnDblClick = eDateFromDblClick
      RangeHigh = {25600D00000000000000}
      RangeLow = {00000000000000000000}
    end
    object eDateTo: TOvcPictureField
      Left = 543
      Top = 58
      Width = 70
      Height = 24
      Cursor = crIBeam
      DataType = pftDate
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = bsNone
      CaretOvr.Shape = csBlock
      Controller = memController
      ControlCharColor = clRed
      DecimalPlaces = 0
      EFColors.Disabled.BackColor = clWindow
      EFColors.Disabled.TextColor = clGrayText
      EFColors.Error.BackColor = clRed
      EFColors.Error.TextColor = clBlack
      EFColors.Highlight.BackColor = clHighlight
      EFColors.Highlight.TextColor = clHighlightText
      Enabled = False
      Epoch = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      InitDateTime = False
      MaxLength = 8
      Options = [efoCaretToEnd]
      ParentFont = False
      PictureMask = 'DD/mm/yy'
      TabOrder = 16
      OnDblClick = eDateFromDblClick
      RangeHigh = {25600D00000000000000}
      RangeLow = {00000000000000000000}
    end
    object cmbValue: TComboBox
      Left = 543
      Top = 88
      Width = 143
      Height = 24
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 17
      OnChange = cmbValueChange
    end
    object nValue: TOvcNumericField
      Left = 693
      Top = 88
      Width = 113
      Height = 24
      Cursor = crIBeam
      DataType = nftDouble
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = bsNone
      CaretOvr.Shape = csBlock
      Controller = memController
      EFColors.Disabled.BackColor = clWindow
      EFColors.Disabled.TextColor = clGrayText
      EFColors.Error.BackColor = clRed
      EFColors.Error.TextColor = clBlack
      EFColors.Highlight.BackColor = clHighlight
      EFColors.Highlight.TextColor = clHighlightText
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = []
      ParentFont = False
      PictureMask = '###,###,###.##'
      TabOrder = 18
      OnChange = nValueChange
      OnKeyPress = nValueKeyPress
      RangeHigh = {73B2DBB9838916F2FE43}
      RangeLow = {73B2DBB9838916F2FEC3}
    end
    object cbMinus: TComboBox
      Left = 812
      Top = 88
      Width = 53
      Height = 24
      Anchors = [akTop, akRight]
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 19
      OnChange = cbMinusChange
      Items.Strings = (
        'CR'
        'DR')
    end
    object btnShowMoreOptions: TButton
      Left = 896
      Top = 88
      Width = 129
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Show more options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 20
      OnClick = btnShowMoreOptionsClick
    end
    object ePart: TEdit
      Left = 543
      Top = 118
      Width = 262
      Height = 24
      Anchors = [akTop, akRight]
      BorderStyle = bsNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 21
      Text = 'ePart'
    end
    object eNotes: TEdit
      Left = 543
      Top = 148
      Width = 262
      Height = 24
      Anchors = [akTop, akRight]
      BorderStyle = bsNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 22
      Text = 'eCode'
    end
  end
  object memController: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    Epoch = 1900
    Left = 280
    Top = 336
  end
  object ColAmount: TOvcTCNumericField
    Adjust = otaCenterRight
    Color = clWindow
    DataType = nftDouble
    EFColors.Disabled.BackColor = clWindow
    EFColors.Disabled.TextColor = clGrayText
    EFColors.Error.BackColor = clRed
    EFColors.Error.TextColor = clBlack
    EFColors.Highlight.BackColor = clHighlight
    EFColors.Highlight.TextColor = clHighlightText
    Options = [efoCaretToEnd]
    PictureMask = '###,###,###.##'
    Table = tblSplit
    TableColor = False
    OnKeyPress = ColAmountKeyPress
    Left = 488
    Top = 360
    RangeHigh = {73B2DBB9838916F2FE43}
    RangeLow = {73B2DBB9838916F2FEC3}
  end
  object ColDesc: TOvcTCString
    Adjust = otaCenterLeft
    Color = clWindow
    Table = tblSplit
    TableColor = False
    Left = 328
    Top = 360
  end
  object ColAcct: TOvcTCString
    Adjust = otaCenterLeft
    AutoAdvanceLeftRight = True
    MaxLength = 10
    Table = tblSplit
    OnExit = ColAcctExit
    OnKeyDown = ColAcctKeyDown
    OnKeyPress = ColAcctKeyPress
    OnKeyUp = ColAcctKeyUp
    OnOwnerDraw = ColAcctOwnerDraw
    Left = 288
    Top = 360
  end
  object ColGSTCode: TOvcTCString
    MaxLength = 3
    Table = tblSplit
    OnKeyDown = ColGSTCodeKeyDown
    OnOwnerDraw = ColGSTCodeOwnerDraw
    Left = 456
    Top = 360
  end
  object Header: TOvcTCColHead
    Headings.Strings = (
      'Code'
      'Account Description'
      'Narration'
      'Payee'
      'Job'
      'GST'
      'Amount'
      'Percent'
      '%/$')
    ShowLetters = False
    Table = tblSplit
    Left = 256
    Top = 360
  end
  object colNarration: TOvcTCString
    MaxLength = 200
    Table = tblSplit
    Left = 360
    Top = 360
  end
  object colLineType: TOvcTCComboBox
    AcceptActivationClick = False
    DropDownCount = 2
    HideButton = True
    MaxLength = 1
    Style = csDropDownList
    Table = tblSplit
    Left = 392
    Top = 328
  end
  object popMem: TPopupMenu
    Images = AppImages.Coding
    OnPopup = popMemPopup
    Left = 704
    Top = 328
    object LookupChart1: TMenuItem
      Caption = '&Lookup Chart                                        F2'
      ImageIndex = 0
      OnClick = sbtnChartClick
    end
    object LookupPayee1: TMenuItem
      Caption = 'Lookup &Payee                                      F3'
      ImageIndex = 1
      OnClick = sbtnPayeeClick
    end
    object LookupJob1: TMenuItem
      Caption = 'Lookup &Job                                          F5'
      ImageIndex = 18
      OnClick = sbtnJobClick
    end
    object LookupGSTClass1: TMenuItem
      Caption = 'Lookup &GST class                                 F7'
      OnClick = LookupGSTClass1Click
    end
    object EditSuperfundDetails1: TMenuItem
      Caption = 'Edit Superfund Details                           F11'
      ImageIndex = 11
      OnClick = sbtnSuperClick
    end
    object ClearSuperfundDetails1: TMenuItem
      Caption = 'Clear Superfund Details'
      OnClick = ClearSuperfundDetails1Click
    end
    object Sep1: TMenuItem
      Caption = '-'
    end
    object FixedAmount1: TMenuItem
      Caption = 'Apply &fixed amount                             $'
      OnClick = FixedAmount1Click
    end
    object PercentageofTotal1: TMenuItem
      Caption = 'Apply percentage &split                        %'
      OnClick = PercentageofTotal1Click
    end
    object AmountApplyRemainingAmount1: TMenuItem
      Caption = 'Appl&y remaining                                   ='
      OnClick = AmountApplyRemainingAmount1Click
    end
    object Sep2: TMenuItem
      Caption = '-'
    end
    object CopyContentoftheCellAbove1: TMenuItem
      Caption = 'C&opy contents of the cell above          +'
      ImageIndex = 6
      OnClick = CopyContentoftheCellAbove1Click
    end
  end
  object ColPayee: TOvcTCNumericField
    Adjust = otaCenterLeft
    EFColors.Disabled.BackColor = clWindow
    EFColors.Disabled.TextColor = clGrayText
    EFColors.Error.BackColor = clRed
    EFColors.Error.TextColor = clBlack
    EFColors.Highlight.BackColor = clHighlight
    EFColors.Highlight.TextColor = clHighlightText
    Options = [efoCaretToEnd, efoTrimBlanks]
    PictureMask = '999999'
    ShowHint = True
    Table = tblSplit
    OnKeyDown = ColPayeeKeyDown
    OnOwnerDraw = ColPayeeOwnerDraw
    Left = 392
    Top = 361
    RangeHigh = {3F420F00000000000000}
    RangeLow = {00000000000000000000}
  end
  object ColPercent: TOvcTCNumericField
    Adjust = otaCenterRight
    Color = clWindow
    DataType = nftDouble
    EFColors.Disabled.BackColor = clWindow
    EFColors.Disabled.TextColor = clGrayText
    EFColors.Error.BackColor = clRed
    EFColors.Error.TextColor = clBlack
    EFColors.Highlight.BackColor = clHighlight
    EFColors.Highlight.TextColor = clHighlightText
    PictureMask = '###,###,###.####'
    Table = tblSplit
    TableColor = False
    OnKeyPress = ColAmountKeyPress
    Left = 520
    Top = 360
    RangeHigh = {73B2DBB9838916F2FE43}
    RangeLow = {73B2DBB9838916F2FEC3}
  end
  object colJob: TOvcTCString
    MaxLength = 8
    Table = tblSplit
    Left = 424
    Top = 360
  end
  object Rowtmr: TTimer
    Enabled = False
    Interval = 100
    OnTimer = RowtmrTimer
    Left = 104
    Top = 304
  end
  object tmrPayee: TTimer
    Interval = 30
    OnTimer = tmrPayeeTimer
    Left = 640
    Top = 328
  end
  object tranController: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    Epoch = 1900
    Left = 320
    Top = 696
  end
end
