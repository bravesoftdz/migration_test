object frmAuditReportOption: TfrmAuditReportOption
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Audit Report'
  ClientHeight = 527
  ClientWidth = 889
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 889
    Height = 527
    ActivePage = tsSystem
    Align = alClient
    Style = tsButtons
    TabOrder = 0
    object tsSystem: TTabSheet
      Caption = 'System Audit Report'
      object pnlSelectDate: TPanel
        Left = 0
        Top = 102
        Width = 881
        Height = 107
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object gbxReportPeriod: TGroupBox
          Left = 4
          Top = 4
          Width = 440
          Height = 100
          Caption = 'Select Date Range'
          TabOrder = 0
          inline DateSelector: TfmeDateSelector
            Left = 16
            Top = 28
            Width = 276
            Height = 70
            TabOrder = 0
            TabStop = True
            ExplicitLeft = 16
            ExplicitTop = 28
            inherited Label2: TLabel
              Top = 3
              ExplicitTop = 3
            end
            inherited btnPrev: TSpeedButton
              Top = 3
              ExplicitTop = 3
            end
            inherited btnNext: TSpeedButton
              Top = 3
              ExplicitTop = 3
            end
            inherited btnQuik: TSpeedButton
              Top = 3
              ExplicitTop = 3
            end
            inherited Label3: TLabel
              Top = 29
              ExplicitTop = 29
            end
            inherited eDateFrom: TOvcPictureField
              Top = 3
              Epoch = 0
              ExplicitTop = 3
              RangeHigh = {25600D00000000000000}
              RangeLow = {00000000000000000000}
            end
            inherited eDateTo: TOvcPictureField
              Top = 29
              Epoch = 0
              ExplicitTop = 29
              RangeHigh = {25600D00000000000000}
              RangeLow = {00000000000000000000}
            end
            inherited pmDates: TPopupMenu
              Top = 27
            end
            inherited OvcController1: TOvcController
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
              Top = 27
            end
          end
        end
      end
      object pnlSelectTransaction: TPanel
        Left = 0
        Top = 209
        Width = 881
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object GroupBox1: TGroupBox
          Left = 4
          Top = 4
          Width = 438
          Height = 120
          Caption = 'Select Transactions'
          TabOrder = 0
          object rbSytemTransactionType: TRadioButton
            Left = 16
            Top = 32
            Width = 113
            Height = 17
            Caption = 'Transaction type'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = rbSytemTransactionTypeClick
          end
          object rbSytemTransactionID: TRadioButton
            Left = 16
            Top = 64
            Width = 113
            Height = 17
            Caption = 'Transaction ID'
            TabOrder = 1
            OnClick = rbSytemTransactionTypeClick
          end
          object cbTransactionType: TComboBox
            Left = 145
            Top = 30
            Width = 263
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
          end
          object eTransactionID: TEdit
            Left = 145
            Top = 62
            Width = 93
            Height = 21
            TabOrder = 3
            OnKeyPress = eTransactionIDKeyPress
          end
          object cbIncludeChildren: TCheckBox
            Left = 145
            Top = 89
            Width = 172
            Height = 21
            Caption = 'Include child transactions'
            TabOrder = 4
          end
        end
      end
      object pnlButtons: TPanel
        Left = 0
        Top = 338
        Width = 881
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        ExplicitTop = 340
        object Button1: TButton
          Left = 366
          Top = 5
          Width = 75
          Height = 25
          Cancel = True
          Caption = 'Cancel'
          ModalResult = 2
          TabOrder = 0
          OnClick = Button1Click
        end
        object btnPrint: TButton
          Left = 285
          Top = 5
          Width = 75
          Height = 25
          Caption = '&Print'
          TabOrder = 1
        end
        object btnFile: TButton
          Left = 85
          Top = 5
          Width = 75
          Height = 25
          Caption = 'Fil&e'
          TabOrder = 2
          OnClick = btnFileClick
        end
        object btnPreview: TButton
          Left = 4
          Top = 5
          Width = 75
          Height = 25
          Caption = 'Previe&w'
          Default = True
          TabOrder = 3
          OnClick = btnPreviewClick
        end
      end
      object pnlSelectClient: TPanel
        Left = 0
        Top = 0
        Width = 881
        Height = 102
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBox6: TGroupBox
          Left = 6
          Top = 6
          Width = 438
          Height = 94
          Caption = 'Select Level'
          TabOrder = 0
          object rbSystem: TRadioButton
            Left = 16
            Top = 24
            Width = 113
            Height = 14
            Caption = '&System'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = rbSystemClick
          end
          object rbClient: TRadioButton
            Left = 16
            Top = 58
            Width = 113
            Height = 14
            Caption = '&Client'
            TabOrder = 1
            OnClick = rbSystemClick
          end
          object cbClientFileCodes: TComboBox
            Left = 143
            Top = 54
            Width = 263
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
          end
        end
      end
    end
    object tsClient: TTabSheet
      Caption = 'Client File Audit Report'
      ImageIndex = 1
      inline ClientSelect: TFmeClientSelect
        Left = 0
        Top = 166
        Width = 629
        Height = 142
        TabOrder = 0
        Visible = False
        ExplicitTop = 166
        inherited grpSettings: TGroupBox
          Left = 3
          Top = 5
          ExplicitLeft = 3
          ExplicitTop = 5
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 3
        Width = 621
        Height = 102
        Caption = 'Select Date Range'
        TabOrder = 1
        inline fmeDateSelector1: TfmeDateSelector
          Left = 16
          Top = 28
          Width = 276
          Height = 70
          TabOrder = 0
          TabStop = True
          ExplicitLeft = 16
          ExplicitTop = 28
          inherited Label2: TLabel
            Top = 3
            ExplicitTop = 3
          end
          inherited btnPrev: TSpeedButton
            Top = 3
            ExplicitTop = 3
          end
          inherited btnNext: TSpeedButton
            Top = 3
            ExplicitTop = 3
          end
          inherited btnQuik: TSpeedButton
            Top = 3
            ExplicitTop = 3
          end
          inherited Label3: TLabel
            Top = 29
            ExplicitTop = 29
          end
          inherited eDateFrom: TOvcPictureField
            Top = 3
            Epoch = 0
            ExplicitTop = 3
            RangeHigh = {25600D00000000000000}
            RangeLow = {00000000000000000000}
          end
          inherited eDateTo: TOvcPictureField
            Top = 29
            Epoch = 0
            ExplicitTop = 29
            RangeHigh = {25600D00000000000000}
            RangeLow = {00000000000000000000}
          end
          inherited pmDates: TPopupMenu
            Top = 27
          end
          inherited OvcController1: TOvcController
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
            Top = 27
          end
        end
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 311
        Width = 621
        Height = 106
        Caption = 'Select Transactions'
        TabOrder = 2
        object RadioButton3: TRadioButton
          Left = 16
          Top = 32
          Width = 113
          Height = 17
          Caption = 'Transaction type'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RadioButton4: TRadioButton
          Left = 16
          Top = 64
          Width = 113
          Height = 17
          Caption = 'Transaction ID'
          TabOrder = 1
        end
        object ComboBox2: TComboBox
          Left = 154
          Top = 30
          Width = 263
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
        end
        object Edit2: TEdit
          Left = 154
          Top = 62
          Width = 121
          Height = 21
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 107
        Width = 621
        Height = 53
        Caption = 'Select Level'
        TabOrder = 3
        Visible = False
        object RadioButton5: TRadioButton
          Left = 16
          Top = 24
          Width = 113
          Height = 17
          Caption = 'Client'
          TabOrder = 0
        end
        object RadioButton6: TRadioButton
          Left = 154
          Top = 24
          Width = 113
          Height = 17
          Caption = 'Transaction'
          TabOrder = 1
        end
      end
      object Button2: TButton
        Left = 5
        Top = 423
        Width = 75
        Height = 25
        Caption = 'Previe&w'
        Default = True
        TabOrder = 4
        OnClick = btnPreviewClick
      end
      object Button3: TButton
        Left = 86
        Top = 423
        Width = 75
        Height = 25
        Caption = 'Fil&e'
        TabOrder = 5
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 285
        Top = 423
        Width = 75
        Height = 25
        Caption = '&Print'
        TabOrder = 6
      end
      object Button5: TButton
        Left = 366
        Top = 423
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 7
      end
    end
    object tsTesting: TTabSheet
      Caption = 'Testing'
      ImageIndex = 2
      DesignSize = (
        881
        496)
      object Label11: TLabel
        Left = 16
        Top = 13
        Width = 83
        Height = 13
        Caption = 'Transaction Type'
      end
      object Label12: TLabel
        Left = 16
        Top = 45
        Width = 70
        Height = 13
        Caption = 'Transaction ID'
      end
      object ListView5: TListView
        Left = 10
        Top = 76
        Width = 863
        Height = 386
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'ID'
            Width = 30
          end
          item
            Caption = 'Transaction Type'
            Width = 150
          end
          item
            Caption = 'Parent ID'
            Width = 90
          end
          item
            Caption = 'Transaction ID'
            Width = 90
          end
          item
            Caption = 'Action'
            Width = 60
          end
          item
            Caption = 'User Code'
            Width = 75
          end
          item
            Caption = 'Date/Time'
            Width = 120
          end
          item
            AutoSize = True
            Caption = 'Values'
          end>
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object cbAuditTypes: TComboBox
        Left = 136
        Top = 10
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object btnByTxnType: TButton
        Left = 351
        Top = 8
        Width = 43
        Height = 25
        Caption = 'Go'
        TabOrder = 2
        OnClick = btnByTxnTypeClick
      end
      object Edit7: TEdit
        Left = 136
        Top = 42
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object btnByTxnID: TButton
        Left = 265
        Top = 40
        Width = 43
        Height = 25
        Caption = 'Go'
        TabOrder = 4
        OnClick = btnByTxnIDClick
      end
      object btnSaveToCSV: TButton
        Left = 8
        Top = 468
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Save to CSV'
        TabOrder = 5
        OnClick = btnSaveToCSVClick
      end
      object btnCancel: TButton
        Left = 796
        Top = 468
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = 'Close'
        ModalResult = 2
        TabOrder = 6
      end
    end
  end
end
