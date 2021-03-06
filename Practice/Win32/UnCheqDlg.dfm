object dlgUnCheque: TdlgUnCheque
  Left = 336
  Top = 180
  BorderStyle = bsDialog
  Caption = 'Add Unpresented Cheques'
  ClientHeight = 459
  ClientWidth = 595
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object label1: TLabel
    Left = 8
    Top = 8
    Width = 207
    Height = 40
    AutoSize = False
    Caption = 'Enter the cheque numbers for cheques which were issued during'
    Transparent = True
    WordWrap = True
  end
  object lblCodingRange: TLabel
    Left = 8
    Top = 48
    Width = 98
    Height = 13
    Caption = '01/01/00 - 31/12/01'
  end
  object ShapeBorder: TShape
    Left = 0
    Top = 227
    Width = 597
    Height = 1
    Pen.Color = clSilver
  end
  object tblFromTo: TOvcTable
    Left = 236
    Top = 4
    Width = 346
    Height = 223
    BorderStyle = bsNone
    Color = clWindow
    ColorUnused = clBtnFace
    Colors.ActiveUnfocused = clWindow
    Colors.ActiveUnfocusedText = clWindowText
    Colors.Editing = clWindow
    Controller = OvcController1
    GridPenSet.NormalGrid.NormalColor = clBtnShadow
    GridPenSet.NormalGrid.Style = psDot
    GridPenSet.NormalGrid.Effect = geNone
    GridPenSet.LockedGrid.NormalColor = clBtnShadow
    GridPenSet.LockedGrid.Style = psSolid
    GridPenSet.LockedGrid.Effect = geNone
    GridPenSet.CellWhenFocused.NormalColor = clBlack
    GridPenSet.CellWhenFocused.Style = psSolid
    GridPenSet.CellWhenFocused.Effect = geBoth
    GridPenSet.CellWhenUnfocused.NormalColor = clBtnFace
    GridPenSet.CellWhenUnfocused.Style = psSolid
    GridPenSet.CellWhenUnfocused.Effect = geBoth
    LockedRowsCell = OvcTCColHead1
    Options = [otoNoRowResizing, otoNoColResizing, otoEnterToArrow]
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 0
    OnActiveCellMoving = tblFromToActiveCellMoving
    OnBeginEdit = tblFromToBeginEdit
    OnEndEdit = tblFromToEndEdit
    OnEnter = tblFromToEnter
    OnExit = tblFromToExit
    OnGetCellData = tblFromToGetCellData
    CellData = (
      'dlgUnCheque.OvcTCColHead1'
      'dlgUnCheque.Col2'
      'dlgUnCheque.ColFrom'
      'dlgUnCheque.OvcTCRowHead1')
    RowData = (
      22
      2
      False
      21
      3
      False
      20)
    ColData = (
      45
      False
      True
      'dlgUnCheque.OvcTCRowHead1'
      140
      False
      True
      'dlgUnCheque.ColFrom'
      160
      False
      True
      'dlgUnCheque.Col2')
  end
  inline fmeCheques: TfmeExistingCheques
    Left = 1
    Top = 237
    Width = 592
    Height = 175
    TabOrder = 1
    TabStop = True
    ExplicitLeft = 1
    ExplicitTop = 237
    inherited pgCheques: TPageControl
      Left = 0
      Top = 0
      Width = 592
      Height = 175
      ActivePage = fmeCheques.tbsAll
      Align = alClient
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 592
      ExplicitHeight = 175
      inherited tbsAll: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 584
        ExplicitHeight = 147
        inherited lbAllCheques: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 578
          Height = 141
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ExplicitLeft = 3
          ExplicitTop = 3
          ExplicitWidth = 578
          ExplicitHeight = 141
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
          Width = 563
          Height = 111
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ExplicitLeft = 3
          ExplicitTop = 3
          ExplicitWidth = 563
          ExplicitHeight = 111
        end
      end
      inherited tbsUnpresented: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 584
        ExplicitHeight = 147
        inherited lbUnpresented: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 578
          Height = 141
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ExplicitLeft = 3
          ExplicitTop = 3
          ExplicitWidth = 578
          ExplicitHeight = 141
        end
      end
    end
  end
  object pnlChequeDate: TPanel
    Left = 8
    Top = 164
    Width = 197
    Height = 57
    TabOrder = 2
    object InfoBmp: TImage
      Left = 8
      Top = 8
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
      Transparent = True
    end
    object Label5: TLabel
      Left = 56
      Top = 8
      Width = 108
      Height = 13
      Caption = 'Cheques will be dated '
    end
    object lblChequesDate: TLabel
      Left = 56
      Top = 28
      Width = 44
      Height = 13
      Caption = '31/12/00'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 418
    Width = 595
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    DesignSize = (
      595
      41)
    object ShapeBottom: TShape
      Left = 0
      Top = 0
      Width = 595
      Height = 1
      Align = alTop
      Pen.Color = clSilver
      ExplicitLeft = -2
      ExplicitTop = 40
      ExplicitWidth = 597
    end
    object btnOK: TButton
      Left = 434
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 514
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCancelClick
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
    Left = 192
    Top = 192
  end
  object OvcTCColHead1: TOvcTCColHead
    Headings.Strings = (
      'Range'
      'From'
      'To')
    ShowLetters = False
    Adjust = otaCenter
    Table = tblFromTo
    Left = 192
    Top = 160
  end
  object ColFrom: TOvcTCNumericField
    Adjust = otaTopRight
    EFColors.Disabled.BackColor = clWindow
    EFColors.Disabled.TextColor = clGrayText
    EFColors.Error.BackColor = clRed
    EFColors.Error.TextColor = clBlack
    EFColors.Highlight.BackColor = clHighlight
    EFColors.Highlight.TextColor = clHighlightText
    PictureMask = '99999999'
    Table = tblFromTo
    Left = 192
    Top = 64
    RangeHigh = {FFFFFF7F000000000000}
    RangeLow = {00000080000000000000}
  end
  object Col2: TOvcTCNumericField
    Adjust = otaTopRight
    EFColors.Disabled.BackColor = clWindow
    EFColors.Disabled.TextColor = clGrayText
    EFColors.Error.BackColor = clRed
    EFColors.Error.TextColor = clBlack
    EFColors.Highlight.BackColor = clHighlight
    EFColors.Highlight.TextColor = clHighlightText
    PictureMask = '99999999'
    Table = tblFromTo
    Left = 192
    Top = 96
    RangeHigh = {FFFFFF7F000000000000}
    RangeLow = {00000080000000000000}
  end
  object OvcTCRowHead1: TOvcTCRowHead
    Adjust = otaCenter
    Table = tblFromTo
    Left = 192
    Top = 128
  end
end
