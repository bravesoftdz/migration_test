object dlgEditAccount: TdlgEditAccount
  Left = 332
  Top = 251
  BorderStyle = bsDialog
  Caption = 'Edit Account'
  ClientHeight = 403
  ClientWidth = 621
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgAccountDetails: TPageControl
    Left = 8
    Top = 8
    Width = 601
    Height = 347
    ActivePage = tsDetails
    TabOrder = 1
    object tsDetails: TTabSheet
      Caption = ' De&tails '
      object lblDivision: TLabel
        Left = 16
        Top = 216
        Width = 36
        Height = 13
        Caption = 'Division'
      end
      object Label3: TLabel
        Left = 16
        Top = 148
        Width = 65
        Height = 13
        Caption = '&Report Group'
        FocusControl = cmbGroup
      end
      object lblGST: TLabel
        Left = 18
        Top = 112
        Width = 47
        Height = 13
        Caption = '&GST Class'
        FocusControl = cmbGST
      end
      object Label5: TLabel
        Left = 16
        Top = 52
        Width = 53
        Height = 13
        Caption = '&Description'
        FocusControl = eDesc
      end
      object Label1: TLabel
        Left = 16
        Top = 20
        Width = 25
        Height = 13
        Caption = '&Code'
        FocusControl = eCode
      end
      object lblSubGroup: TLabel
        Left = 16
        Top = 181
        Width = 49
        Height = 13
        Caption = '&Sub group'
        FocusControl = cmbSubGroup
      end
      object lblAltCodeName: TLabel
        Left = 312
        Top = 19
        Width = 81
        Height = 13
        Caption = 'Alternative Code'
      end
      object cmbGroup: TComboBox
        Left = 124
        Top = 144
        Width = 290
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
        OnChange = cmbGroupChange
      end
      object cmbGST: TComboBox
        Left = 124
        Top = 108
        Width = 290
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnChange = cmbGSTChange
        OnDropDown = cmbGSTDropDown
      end
      object chkPosting: TCheckBox
        Left = 124
        Top = 83
        Width = 133
        Height = 17
        Caption = '&Posting Allowed'
        TabOrder = 2
      end
      object eDesc: TEdit
        Left = 124
        Top = 48
        Width = 437
        Height = 21
        Ctl3D = True
        MaxLength = 60
        ParentCtl3D = False
        TabOrder = 1
        Text = 'eDesc'
      end
      object eCode: TEdit
        Left = 124
        Top = 16
        Width = 145
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        OnChange = eCodeChange
      end
      object cmbSubGroup: TComboBox
        Left = 124
        Top = 177
        Width = 290
        Height = 21
        Style = csDropDownList
        DropDownCount = 10
        ItemHeight = 13
        TabOrder = 7
      end
      object tgDivisions: TtsGrid
        Left = 123
        Top = 216
        Width = 438
        Height = 92
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 2
        ColSelectMode = csNone
        DefaultRowHeight = 16
        ExportDelimiter = ','
        GridLines = glVertLines
        HeadingHorzAlignment = htaLeft
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingHeight = 19
        HeadingParentFont = False
        HeadingVertAlignment = vtaCenter
        MaskDefs = tsMaskDefs1
        PrintTotals = False
        RowBarOn = False
        RowMoving = False
        Rows = 4
        RowSelectMode = rsNone
        TabOrder = 8
        Version = '2.20.26'
        WantTabs = False
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellLoaded = tgDivisionsCellLoaded
        OnComboGetValue = tgDivisionsComboGetValue
        OnComboInit = tgDivisionsComboInit
        OnEndCellEdit = tgDivisionsEndCellEdit
        ColProperties = <
          item
            DataCol = 1
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clWindowText
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.Heading = 'ID'
            Col.MaskName = 'sysShortInteger'
            Col.ParentFont = False
          end
          item
            DataCol = 2
            Col.DropDownStyle = ddDropDownList
            Col.Heading = 'Division Name'
            Col.Width = 345
          end>
      end
      object chkBasic: TCheckBox
        Left = 268
        Top = 83
        Width = 146
        Height = 17
        Caption = 'Show in &Basic Chart'
        TabOrder = 3
      end
      object eAltCode: TEdit
        Left = 416
        Top = 16
        Width = 145
        Height = 21
        Enabled = False
        TabOrder = 9
      end
      object chkInactive: TCheckBox
        Left = 429
        Top = 83
        Width = 148
        Height = 17
        Caption = '&Inactive'
        TabOrder = 4
        OnClick = chkInactiveClick
      end
    end
    object tsLinkedAccounts: TTabSheet
      Caption = ' &Linked Accounts '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlLinkForStockOnHand: TPanel
        Left = 8
        Top = 9
        Width = 593
        Height = 280
        TabOrder = 0
        object Label6: TLabel
          Left = 8
          Top = 9
          Width = 77
          Height = 13
          Caption = 'Linked Accounts'
        end
        object lblLinkAccount1: TLabel
          Left = 40
          Top = 47
          Width = 73
          Height = 13
          Caption = 'lblLinkAccount1'
          FocusControl = edtLinkedAccount1
        end
        object lblLinkAccount1_Desc: TLabel
          Left = 392
          Top = 47
          Width = 185
          Height = 16
          AutoSize = False
          Caption = 'lblLinkAccount1_Desc'
        end
        object lblLinkAccount2: TLabel
          Left = 40
          Top = 79
          Width = 73
          Height = 13
          Caption = 'lblLinkAccount2'
          FocusControl = edtLinkedAccount2
        end
        object lblLinkAccount2_Desc: TLabel
          Left = 392
          Top = 79
          Width = 185
          Height = 16
          AutoSize = False
          Caption = 'lblLinkAccount2_Desc'
        end
        object sbtnChart1: TSpeedButton
          Left = 357
          Top = 44
          Width = 24
          Height = 22
          Flat = True
          OnClick = sbtnChart1Click
        end
        object sbtnChart2: TSpeedButton
          Left = 358
          Top = 75
          Width = 24
          Height = 22
          Flat = True
          OnClick = sbtnChart2Click
        end
        object edtLinkedAccount1: TEdit
          Left = 200
          Top = 43
          Width = 153
          Height = 21
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          Text = 'edtLinkedAccount1'
          OnChange = edtLinkedAccount1Change
          OnKeyDown = edtLinkedAccount1KeyDown
          OnKeyPress = edtLinkedAccount1KeyPress
          OnKeyUp = edtLinkedAccount1KeyUp
        end
        object edtLinkedAccount2: TEdit
          Left = 200
          Top = 75
          Width = 153
          Height = 21
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 1
          Text = 'edtLinkedAccount2'
          OnChange = edtLinkedAccount1Change
          OnKeyDown = edtLinkedAccount1KeyDown
          OnKeyPress = edtLinkedAccount2KeyPress
          OnKeyUp = edtLinkedAccount2KeyUp
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 358
    Width = 621
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      621
      45)
    object btnOK: TButton
      Left = 444
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 532
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object tsMaskDefs1: TtsMaskDefs
    Masks = <
      item
        Name = 'Mask0'
      end
      item
        Name = 'sysShortInteger'
        Picture = '*3[#]'
      end>
    Left = 80
    Top = 280
  end
end
