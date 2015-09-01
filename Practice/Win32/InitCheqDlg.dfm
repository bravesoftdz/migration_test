object dlgInitCheq: TdlgInitCheq
  Left = 158
  Top = 149
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Add Initial Unpresented Cheques'
  ClientHeight = 457
  ClientWidth = 632
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    632
    457)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 0
    Width = 620
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Enter the numbers of all the Unpresented Cheques from the client' +
      #39's previous Bank Reconciliation Report.'
    WordWrap = True
  end
  object InfoBmp: TImage
    Left = 8
    Top = 186
    Width = 40
    Height = 40
    AutoSize = True
    Picture.Data = {
      07544269746D6170760A0000424D760A00000000000036040000280000002800
      0000280000000100080000000000400600000000000000000000000100000001
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
      E00000400000004020000040400000406000004080000040A0000040C0000040
      E00000600000006020000060400000606000006080000060A0000060C0000060
      E00000800000008020000080400000806000008080000080A0000080C0000080
      E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
      E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
      E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
      E00040000000400020004000400040006000400080004000A0004000C0004000
      E00040200000402020004020400040206000402080004020A0004020C0004020
      E00040400000404020004040400040406000404080004040A0004040C0004040
      E00040600000406020004060400040606000406080004060A0004060C0004060
      E00040800000408020004080400040806000408080004080A0004080C0004080
      E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
      E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
      E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
      E00080000000800020008000400080006000800080008000A0008000C0008000
      E00080200000802020008020400080206000802080008020A0008020C0008020
      E00080400000804020008040400080406000804080008040A0008040C0008040
      E00080600000806020008060400080606000806080008060A0008060C0008060
      E00080800000808020008080400080806000808080008080A0008080C0008080
      E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
      E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
      E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
      E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
      E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
      E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
      E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
      E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
      E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
      E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
      A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      08080808080808080808080808080808080808080808080808A4A40808080808
      0808080808080808080808080808080808080808080808080808080808080808
      A4A4A40808080808080808080808080808080808080808080808080808080808
      080808080808080000A4A4080808080808080808080808080808080808080808
      080808080808080808080808080800FF00A4A408080808080808080808080808
      08080808080808080808080808080808080808080800FFFF00A4A40808080808
      080808080808080808080808080808080808080808080808080808A400FFFFFF
      00A4A40808080808080808080808080808080808080808080808080808080808
      A4A4A4A400FFFFFF00A4A4A4A4A4080808080808080808080808080808080808
      080808080808A4A4A400000007FFFFFF00A4A4A4A4A4A4A40808080808080808
      08080808080808080808080808A400000007FFFFFFFFFFFF07000000A4A4A4A4
      A408080808080808080808080808080808080808000007FFFFFFFFFFFFFFFFFF
      FFFFFF070000A4A4A4A408080808080808080808080808080808080007FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF0700A4A4A4A408080808080808080808080808
      080800FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00A4A4A4A408080808
      08080808080808080800FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00A4A4A4A40808080808080808080808A4FFFFFFFFFFFFFFFFFCFCFCFCFCFCFC
      FCFCFFFFFFFFFFFFFF00A4A4A408080808080808080808A407FFFFFFFFFFFFFF
      FFFFFFFCFCFCFCFCFFFFFFFFFFFFFFFFFF0700A4A4A4080808080808080808A4
      FFFFFFFFFFFFFFFFFFFFFFFCFCFCFCFCFFFFFFFFFFFFFFFFFFFF00A4A4A40808
      080808080808A407FFFFFFFFFFFFFFFFFFFFFFFCFCFCFCFCFFFFFFFFFFFFFFFF
      FFFF0700A4A40808080808080808A4FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFCFC
      FFFFFFFFFFFFFFFFFFFFFF00A4A40808080808080808A4FFFFFFFFFFFFFFFFFF
      FFFFFFFCFCFCFCFCFFFFFFFFFFFFFFFFFFFFFF00A4A40808080808080808A4FF
      FFFFFFFFFFFFFFFFFFFFFFFCFCFCFCFCFFFFFFFFFFFFFFFFFFFFFF00A4A40808
      080808080808A4FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFCFCFFFFFFFFFFFFFFFF
      FFFFFF00A4A40808080808080808A4FFFFFFFFFFFFFFFFFFFFFCFCFCFCFCFCFC
      FFFFFFFFFFFFFFFFFFFFFF00A4080808080808080808A407FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0700A408080808080808080808A4
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00A408080808
      08080808080808A407FFFFFFFFFFFFFFFFFF07FCFCFCFC07FFFFFFFFFFFFFFFF
      FF070008080808080808080808080808A4FFFFFFFFFFFFFFFFFFFCFCFCFCFCFC
      FFFFFFFFFFFFFFFFFF00080808080808080808080808080808A4FFFFFFFFFFFF
      FFFFFCFCFCFCFCFCFFFFFFFFFFFFFFFF00080808080808080808080808080808
      0808A4FFFFFFFFFFFFFF07FCFCFCFC07FFFFFFFFFFFFFF000808080808080808
      0808080808080808080808A407FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF07A408
      0808080808080808080808080808080808080808A4A407FFFFFFFFFFFFFFFFFF
      FFFFFF07A4A4080808080808080808080808080808080808080808080808A4A4
      A407FFFFFFFFFFFF07A4A4A40808080808080808080808080808080808080808
      080808080808080808A4A4A4A4A4A4A4A4080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808}
    Stretch = True
    Transparent = True
  end
  object Label5: TLabel
    Left = 52
    Top = 187
    Width = 108
    Height = 13
    Caption = 'Cheques will be dated '
  end
  object lblChequesDate: TLabel
    Left = 54
    Top = 206
    Width = 44
    Height = 13
    Caption = '31/12/00'
  end
  object ShapeBorder: TShape
    Left = 0
    Top = 230
    Width = 633
    Height = 1
    Pen.Color = clSilver
  end
  object Shape2: TShape
    Left = 0
    Top = 180
    Width = 632
    Height = 1
    Align = alTop
    Pen.Color = clSilver
    ExplicitTop = 8
  end
  object tblCheques: TOvcTable
    Left = 0
    Top = 0
    Width = 632
    Height = 180
    LockedRows = 0
    TopRow = 0
    ActiveRow = 0
    RowLimit = 9
    LockedCols = 0
    LeftCol = 0
    ActiveCol = 0
    Align = alTop
    BorderStyle = bsNone
    Color = clWindow
    ColorUnused = clBtnFace
    Colors.Editing = clWindow
    Controller = OvcController1
    GridPenSet.NormalGrid.NormalColor = clBtnShadow
    GridPenSet.NormalGrid.Style = psSolid
    GridPenSet.NormalGrid.Effect = geVertical
    GridPenSet.LockedGrid.NormalColor = clBtnShadow
    GridPenSet.LockedGrid.Style = psSolid
    GridPenSet.LockedGrid.Effect = ge3D
    GridPenSet.CellWhenFocused.NormalColor = clBlack
    GridPenSet.CellWhenFocused.Style = psSolid
    GridPenSet.CellWhenFocused.Effect = geBoth
    GridPenSet.CellWhenUnfocused.NormalColor = clBlack
    GridPenSet.CellWhenUnfocused.Style = psSolid
    GridPenSet.CellWhenUnfocused.Effect = geBoth
    Options = [otoNoRowResizing, otoNoColResizing, otoEnterToArrow]
    ScrollBars = ssVertical
    TabOrder = 0
    OnActiveCellMoving = tblChequesActiveCellMoving
    OnBeginEdit = tblChequesBeginEdit
    OnEndEdit = tblChequesEndEdit
    OnEnter = tblChequesEnter
    OnExit = tblChequesExit
    OnGetCellData = tblChequesGetCellData
    CellData = (
      'dlgInitCheq.ColNumeric')
    RowData = (
      18)
    ColData = (
      123
      False
      True
      'dlgInitCheq.ColNumeric'
      123
      False
      True
      'dlgInitCheq.ColNumeric'
      123
      False
      True
      'dlgInitCheq.ColNumeric'
      123
      False
      True
      'dlgInitCheq.ColNumeric'
      123
      False
      True
      'dlgInitCheq.ColNumeric')
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 415
    Width = 632
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      632
      42)
    object ShapeBottom: TShape
      Left = 0
      Top = 0
      Width = 632
      Height = 1
      Align = alTop
      Pen.Color = clSilver
      ExplicitLeft = -1
      ExplicitTop = 48
      ExplicitWidth = 633
    end
    object btnOK: TButton
      Left = 463
      Top = 10
      Width = 77
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 546
      Top = 10
      Width = 77
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  inline fmeCheques: TfmeExistingCheques
    Left = 9
    Top = 235
    Width = 592
    Height = 164
    TabOrder = 1
    TabStop = True
    ExplicitLeft = 9
    ExplicitTop = 235
    ExplicitHeight = 164
    inherited label1: TLabel
      Top = -1
      ExplicitTop = -1
    end
    inherited lblDates: TLabel
      Top = -1
      ExplicitTop = -1
    end
    inherited pgCheques: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 586
      Height = 158
      ActivePage = fmeCheques.tbsAll
      Align = alClient
      ExplicitLeft = -1
      ExplicitTop = -3
      ExplicitWidth = 592
      ExplicitHeight = 164
      inherited tbsAll: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 569
        ExplicitHeight = 117
        inherited lbAllCheques: TListBox
          Left = 0
          Top = 0
          Width = 578
          Height = 130
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 584
          ExplicitHeight = 136
        end
      end
      inherited tblPresented: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 569
        ExplicitHeight = 117
        inherited lbPresented: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 578
          Height = 130
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
        end
      end
      inherited tbsUnpresented: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 569
        ExplicitHeight = 117
        inherited lbUnpresented: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 578
          Height = 130
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 584
          ExplicitHeight = 136
        end
      end
    end
  end
  object OvcController1: TOvcController
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
    Left = 608
    Top = 64
  end
  object ColNumeric: TOvcTCNumericField
    EFColors.Disabled.BackColor = clWindow
    EFColors.Disabled.TextColor = clGrayText
    EFColors.Error.BackColor = clRed
    EFColors.Error.TextColor = clBlack
    EFColors.Highlight.BackColor = clHighlight
    EFColors.Highlight.TextColor = clHighlightText
    PictureMask = '99999999'
    Table = tblCheques
    Left = 608
    Top = 24
    RangeHigh = {FFFFFF7F000000000000}
    RangeLow = {00000080000000000000}
  end
end
