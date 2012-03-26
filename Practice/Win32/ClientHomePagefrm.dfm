object frmClientHomePage: TfrmClientHomePage
  Left = 0
  Top = 0
  ActiveControl = ClientTree
  Caption = 'Home'
  ClientHeight = 523
  ClientWidth = 1209
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 180
    Top = 31
    Width = 5
    Height = 492
  end
  object gbGroupBar: TRzGroupBar
    Left = 0
    Top = 31
    Width = 180
    Height = 492
    BorderSides = []
    BorderColor = clBlack
    GradientColorStyle = gcsCustom
    GradientColorStart = 16777192
    GradientColorStop = 11446784
    GroupBorderSize = 8
    Color = clBtnShadow
    Constraints.MaxWidth = 300
    Constraints.MinWidth = 100
    ParentColor = False
    TabOrder = 1
    object GrpAction: TRzGroup
      CaptionColorStart = 16773337
      CaptionColorStop = 10115840
      GroupController = AppImages.AppGroupController
      Items = <
        item
          Action = acUpdate
        end
        item
          Action = acForexRatesMissing
        end
        item
          Action = acMems
        end
        item
          Action = acRunCoding
        end
        item
          Action = acWebImport
        end
        item
          Action = acTransfer
        end
        item
          Caption = '-'
        end
        item
          Action = acTasks
        end
        item
          Action = acReports
          Caption = 'Favourite Reports'
        end
        item
          Caption = '-'
        end
        item
          Action = acReport
        end
        item
          Caption = '-'
        end
        item
          Action = acHelp
        end>
      Opened = True
      OpenedHeight = 400
      SmallImages = AppImages.ilFileActions_ClientMgr
      Caption = 'Client Tasks'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object gpClientDetails: TRzGroup
      CaptionColorStart = 16773337
      CaptionColorStop = 10115840
      GroupController = AppImages.AppGroupController
      Items = <>
      Opened = True
      OpenedHeight = 49
      SmallImages = AppImages.ilFileActions_ClientMgr
      Caption = 'Client Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object GrpReportSchedule: TRzGroup
      CaptionColorStart = 16773337
      CaptionColorStop = 10115840
      GroupController = AppImages.AppGroupController
      Items = <
        item
          Action = acSchedule
        end>
      Opened = True
      OpenedHeight = 64
      SmallImages = AppImages.ilFileActions_ClientMgr
      Caption = 'Report Schedule'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object GrpOptions: TRzGroup
      CaptionColorStart = 16773337
      CaptionColorStop = 10115840
      GroupController = AppImages.AppGroupController
      Items = <
        item
          Action = acShowlegend
        end>
      Opened = False
      OpenedHeight = 46
      SmallImages = AppImages.ilFileActions_ClientMgr
      Caption = 'Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 185
    Top = 31
    Width = 1024
    Height = 492
    Align = alClient
    TabOrder = 0
    object PnlClient: TRzPanel
      Left = 1
      Top = 28
      Width = 1022
      Height = 438
      Align = alClient
      TabOrder = 0
      object ClientTree: TVirtualStringTree
        Left = 2
        Top = 2
        Width = 1018
        Height = 434
        Hint = ' '
        Align = alClient
        Header.AutoSizeIndex = 4
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoOwnerDraw, hoVisible]
        Header.ParentFont = True
        Header.SortColumn = 0
        Header.Style = hsXPStyle
        HintMode = hmHint
        Indent = 0
        ParentBackground = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toWheelPanning]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowDropmark, toShowVertGridLines, toThemeAware, toUseBlendedImages, toAlwaysHideSelection, toUseBlendedSelection]
        TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect, toSiblingSelectConstraint, toSimpleDrawSelection]
        WantTabs = True
        OnHeaderClick = ClientTreeHeaderClick
        OnHeaderDraw = ClientTreeHeaderDraw
        OnKeyDown = ClientTreeKeyDown
        Columns = <
          item
            MinWidth = 100
            Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
            Position = 0
            Tag = 3
            Width = 200
            WideText = 'Account / Name'
          end
          item
            Options = [coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
            Position = 1
            Style = vsOwnerDraw
            Tag = 4
            Width = 396
            WideText = 'Processing'
          end
          item
            Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
            Position = 2
            Tag = 5
            Width = 90
            WideText = 'Last Entry'
          end
          item
            Alignment = taRightJustify
            Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
            Position = 3
            Tag = 6
            Width = 100
            WideText = 'Balance'
          end
          item
            MinWidth = 100
            Options = [coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
            Position = 4
            Tag = 8
            Width = 228
            WideText = 'Currency'
          end>
      end
      object btnMonthleft: TButton
        Left = 245
        Top = 6
        Width = 75
        Height = 25
        Caption = '<'
        TabOrder = 2
        Visible = False
        OnClick = btnMonthLeftClick
      end
      object BtnMonthRight: TButton
        Left = 245
        Top = 4
        Width = 75
        Height = 25
        Caption = '>'
        TabOrder = 3
        Visible = False
        OnClick = btnMonthRightClick
      end
      object BtnYearLeft: TButton
        Left = 245
        Top = 4
        Width = 75
        Height = 25
        Caption = '<'
        TabOrder = 0
        Visible = False
        OnClick = btnYearLeftClick
      end
      object BtnYearRight: TButton
        Left = 245
        Top = 4
        Width = 75
        Height = 25
        Caption = '>'
        TabOrder = 1
        Visible = False
        OnClick = BtnYearRightClick
      end
    end
    object pnlLegend: TPanel
      Left = 1
      Top = 1
      Width = 1022
      Height = 27
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 1
      object pnlLegendA: TPanel
        Left = 2
        Top = 2
        Width = 1018
        Height = 23
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblLegend: TLabel
          AlignWithMargins = True
          Left = 28
          Top = 0
          Width = 39
          Height = 23
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Legend:'
          Layout = tlCenter
          ExplicitLeft = 30
          ExplicitTop = 2
          ExplicitHeight = 13
        end
        object tbtnClose: TRzToolButton
          Left = 0
          Top = 0
          Height = 23
          GradientColorStyle = gcsCustom
          ImageIndex = 0
          Images = AppImages.ToolBtn
          UseToolbarButtonSize = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Align = alLeft
          Caption = 'Hide Legend'
          OnClick = acShowlegendExecute
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitHeight = 18
        end
        object sgLegend: TStringGrid
          AlignWithMargins = True
          Left = 73
          Top = 0
          Width = 681
          Height = 23
          HelpType = htKeyword
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnFace
          ColCount = 14
          DefaultColWidth = 75
          Enabled = False
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          Options = []
          ScrollBars = ssNone
          TabOrder = 0
          OnDrawCell = sgLegendDrawCell
          OnSelectCell = sgLegendSelectCell
        end
      end
    end
    object pnlTabs: TPanel
      Left = 1
      Top = 466
      Width = 1022
      Height = 25
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 2
      object tcWindows: TRzTabControl
        Left = 2
        Top = 2
        Width = 1018
        Height = 21
        Align = alClient
        TabIndex = 0
        TabOrder = 0
        TabOrientation = toBottom
        Tabs = <
          item
            Caption = 'Tab1'
          end>
        OnTabClick = tcWindowsTabClick
        FixedDimension = 19
      end
    end
  end
  object pnlTitle: TRzPanel
    Left = 0
    Top = 0
    Width = 1209
    Height = 31
    Align = alTop
    BorderOuter = fsNone
    BorderSides = []
    GradientColorStyle = gcsCustom
    GradientColorStop = 11183616
    TabOrder = 2
    VisualStyle = vsGradient
    object ImgLeft: TImage
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 123
      Height = 15
      Margins.Left = 8
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      AutoSize = True
      Center = True
      Proportional = True
      Transparent = True
      ExplicitLeft = 6
      ExplicitTop = 6
      ExplicitHeight = 19
    end
    object lblClientName: TLabel
      Left = 134
      Top = 0
      Width = 995
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Alignment = taCenter
      Caption = 'Client Name '
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10115840
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ShowAccelChar = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 95
      ExplicitHeight = 21
    end
    object imgRight: TImage
      Left = 1129
      Top = 0
      Width = 80
      Height = 31
      Align = alRight
      Anchors = [akTop, akRight]
      AutoSize = True
      Transparent = True
      ExplicitLeft = 859
    end
  end
  object ActionList1: TActionList
    Images = AppImages.ilFileActions_ClientMgr
    Left = 288
    Top = 64
    object acRunCoding: TAction
      Caption = 'Coding'
      ImageIndex = 16
      OnExecute = acRunCodingExecute
    end
    object acTasks: TAction
      Caption = 'Tasks'
      ImageIndex = 13
      OnExecute = acTasksExecute
    end
    object acUpdate: TAction
      Caption = 'Retrieve New Transactions'
      ImageIndex = 23
      OnExecute = acUpdateExecute
    end
    object acTransfer: TAction
      Caption = 'acTransfer'
      ImageIndex = 24
      OnExecute = acTransferExecute
    end
    object acReports: TAction
      Caption = 'Reports'
      ImageIndex = 25
      OnExecute = acReportsExecute
    end
    object acClientEmail: TAction
      Caption = 'Email'
      ImageIndex = 8
      OnExecute = acClientEmailExecute
    end
    object acEditClientDetails: TAction
      Caption = 'Edit Client Details'
      ImageIndex = 10
      OnExecute = acEditClientDetailsExecute
    end
    object acWebImport: TAction
      Caption = 'acWebImport'
      ImageIndex = 23
      OnExecute = acWebImportExecute
    end
    object acNotes: TAction
      Caption = 'View Notes'
      OnExecute = acNotesExecute
    end
    object acShowlegend: TAction
      Caption = 'Show Legend'
      ImageIndex = 21
      OnExecute = acShowlegendExecute
    end
    object acHelp: TAction
      Caption = 'Help'
      ImageIndex = 3
      OnExecute = acHelpExecute
    end
    object acSchedule: TAction
      Caption = 'Set up a Report Schedule'
      ImageIndex = 6
      OnExecute = acScheduleExecute
    end
    object acMems: TAction
      Caption = 'There are memorised entries with invalid chart codes'
      ImageIndex = 23
      OnExecute = acMemsExecute
    end
    object acReport: TAction
      Caption = 'Print'
      ImageIndex = 14
      OnExecute = acReportExecute
    end
    object acForexRatesMissing: TAction
      Caption = 
        'There are entries without exchange rates for [ISO1], [ISO2], and' +
        ' [ISO3] '
      ImageIndex = 23
      OnExecute = acForexRatesMissingExecute
    end
  end
  object pmNodes: TPopupMenu
    Left = 456
    Top = 48
  end
  object NotesTimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = NotesTimerTimer
    Left = 248
    Top = 16
  end
end
