object frmPracticeDetails: TfrmPracticeDetails
  Left = 392
  Top = 300
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Practice Details'
  ClientHeight = 431
  ClientWidth = 632
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    632
    431)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 464
    Top = 401
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 548
    Top = 401
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 617
    Height = 387
    ActivePage = tbsDetails
    TabOrder = 0
    object tbsDetails: TTabSheet
      Caption = 'Details'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        609
        359)
      object Label1: TLabel
        Left = 8
        Top = 10
        Width = 27
        Height = 13
        Caption = '&Name'
        FocusControl = ePracName
      end
      object Label9: TLabel
        Left = 8
        Top = 38
        Width = 30
        Height = 13
        Caption = 'P&hone'
        FocusControl = edtPhone
      end
      object Label7: TLabel
        Left = 8
        Top = 66
        Width = 28
        Height = 13
        Caption = '&E-mail'
        FocusControl = ePracEmail
      end
      object Label10: TLabel
        Left = 8
        Top = 120
        Width = 85
        Height = 13
        Caption = '&Web Site Address'
        FocusControl = edtWebSite
      end
      object Label15: TLabel
        Left = 8
        Top = 150
        Width = 83
        Height = 13
        Caption = '&Practice Logo File'
        FocusControl = edtLogoBitmapFilename
      end
      object btnBrowseLogoBitmap: TSpeedButton
        Left = 534
        Top = 148
        Width = 24
        Height = 24
        Anchors = [akLeft, akBottom]
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = btnBrowseLogoBitmapClick
      end
      object lblLogoBitmapNote: TLabel
        Left = 152
        Top = 174
        Width = 376
        Height = 35
        AutoSize = False
        Caption = 
          'Note: This image will added to BNotes and BankLink 5 offsite cli' +
          'ent files'
        WordWrap = True
      end
      object lblCountry: TLabel
        Left = 580
        Top = -1
        Width = 26
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'NZ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object imgPracticeLogo: TImage
        Left = 152
        Top = 205
        Width = 377
        Height = 101
        Center = True
        Proportional = True
        Stretch = True
      end
      object Label2: TLabel
        Left = 8
        Top = 94
        Width = 46
        Height = 13
        Caption = '&Signature'
        FocusControl = btnEdit
      end
      object ePracName: TEdit
        Left = 152
        Top = 8
        Width = 377
        Height = 22
        BorderStyle = bsNone
        MaxLength = 60
        TabOrder = 0
        Text = 'ePracName'
      end
      object edtPhone: TEdit
        Left = 152
        Top = 36
        Width = 209
        Height = 22
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 1
        Text = 'Phone No'
      end
      object ePracEmail: TEdit
        Left = 152
        Top = 64
        Width = 377
        Height = 22
        BorderStyle = bsNone
        MaxLength = 80
        TabOrder = 2
        Text = 'ePracEmail'
      end
      object edtWebSite: TEdit
        Left = 152
        Top = 120
        Width = 377
        Height = 22
        BorderStyle = bsNone
        TabOrder = 3
        Text = 'Web Site'
      end
      object gbxDownLoad: TGroupBox
        Left = 0
        Top = 311
        Width = 593
        Height = 45
        TabOrder = 5
        object lblConnect: TLabel
          Left = 11
          Top = 17
          Width = 25
          Height = 13
          Caption = '&Code'
          FocusControl = eBCode
        end
        object Label3: TLabel
          Left = 296
          Top = 17
          Width = 122
          Height = 13
          Caption = 'Last Download Processe&d'
          FocusControl = txtLastDiskID
        end
        object eBCode: TEdit
          Left = 161
          Top = 14
          Width = 121
          Height = 22
          BorderStyle = bsNone
          CharCase = ecUpperCase
          MaxLength = 8
          TabOrder = 0
          Text = 'EBCODE'
        end
        object txtLastDiskID: TEdit
          Left = 464
          Top = 14
          Width = 113
          Height = 22
          BorderStyle = bsNone
          CharCase = ecUpperCase
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          TabOrder = 1
          Text = '000'
          OnChange = txtLastDiskIDChange
        end
      end
      object edtLogoBitmapFilename: TEdit
        Left = 152
        Top = 148
        Width = 378
        Height = 24
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 4
        OnChange = edtLogoBitmapFilenameChange
      end
      object btnEdit: TButton
        Left = 152
        Top = 92
        Width = 91
        Height = 22
        Caption = 'Edit'
        TabOrder = 6
        OnClick = btnEditClick
      end
    end
    object tbsInterfaces: TTabSheet
      Caption = 'Accounting System'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbxClientDefault: TGroupBox
        Left = 8
        Top = 4
        Width = 569
        Height = 147
        TabOrder = 0
        object Label4: TLabel
          Left = 16
          Top = 20
          Width = 62
          Height = 13
          Caption = 'System &Used'
          FocusControl = cmbSystem
        end
        object lblLoad: TLabel
          Left = 16
          Top = 83
          Width = 80
          Height = 13
          Caption = '&Load Chart From'
          FocusControl = eLoad
        end
        object lblSave: TLabel
          Left = 16
          Top = 115
          Width = 75
          Height = 13
          Caption = '&Save Entries To'
          FocusControl = eSave
        end
        object btnLoadFolder: TSpeedButton
          Left = 442
          Top = 79
          Width = 25
          Height = 24
          ParentShowHint = False
          ShowHint = True
          OnClick = btnLoadFolderClick
        end
        object btnSaveFolder: TSpeedButton
          Left = 442
          Top = 111
          Width = 25
          Height = 24
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSaveFolderClick
        end
        object lblMask: TLabel
          Left = 16
          Top = 51
          Width = 66
          Height = 13
          Caption = 'Account &Mask'
          FocusControl = eMask
        end
        object cmbSystem: TComboBox
          Left = 144
          Top = 16
          Width = 316
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          Sorted = True
          TabOrder = 0
          OnChange = cmbSystemChange
        end
        object eLoad: TEdit
          Left = 144
          Top = 80
          Width = 297
          Height = 22
          BorderStyle = bsNone
          MaxLength = 128
          TabOrder = 2
          Text = 'eLoad'
        end
        object eSave: TEdit
          Left = 144
          Top = 112
          Width = 297
          Height = 22
          BorderStyle = bsNone
          MaxLength = 128
          TabOrder = 3
          Text = 'eSave'
        end
        object eMask: TEdit
          Left = 144
          Top = 48
          Width = 121
          Height = 22
          BorderStyle = bsNone
          MaxLength = 10
          TabOrder = 1
          Text = 'eMask'
        end
      end
      object gbxWebExport: TGroupBox
        Left = 8
        Top = 243
        Width = 569
        Height = 50
        TabOrder = 2
        object Label11: TLabel
          Left = 16
          Top = 20
          Width = 94
          Height = 13
          Caption = '&Web Export Format'
          FocusControl = cmbWebFormats
        end
        object cmbWebFormats: TComboBox
          Left = 144
          Top = 16
          Width = 322
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          Sorted = True
          TabOrder = 0
          OnChange = cmbTaxInterfaceChange
        end
      end
      object gbxTaxInterface: TGroupBox
        Left = 8
        Top = 156
        Width = 569
        Height = 82
        TabOrder = 1
        object Label5: TLabel
          Left = 16
          Top = 20
          Width = 93
          Height = 13
          Caption = '&Tax Interface Used'
          FocusControl = cmbTaxInterface
        end
        object Label8: TLabel
          Left = 16
          Top = 50
          Width = 87
          Height = 13
          Caption = 'E&xport Tax File To'
          FocusControl = edtSaveTaxTo
        end
        object btnTaxFolder: TSpeedButton
          Left = 442
          Top = 46
          Width = 25
          Height = 24
          ParentShowHint = False
          ShowHint = True
          OnClick = btnTaxFolderClick
        end
        object cmbTaxInterface: TComboBox
          Left = 144
          Top = 16
          Width = 322
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          Sorted = True
          TabOrder = 0
          OnChange = cmbTaxInterfaceChange
        end
        object edtSaveTaxTo: TEdit
          Left = 144
          Top = 47
          Width = 297
          Height = 22
          BorderStyle = bsNone
          MaxLength = 128
          TabOrder = 1
        end
      end
    end
    object tsSuperFundSystem: TTabSheet
      Caption = 'Superfund System'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbxSuperSystem: TGroupBox
        Left = 8
        Top = 4
        Width = 569
        Height = 147
        TabOrder = 0
        object lblSuperfundSystem: TLabel
          Left = 16
          Top = 20
          Width = 62
          Height = 13
          Caption = 'System &Used'
          FocusControl = cmbSuperSystem
        end
        object lblSuperLoad: TLabel
          Left = 16
          Top = 83
          Width = 80
          Height = 13
          Caption = '&Load Chart From'
          FocusControl = eSuperLoad
        end
        object lblSuperSave: TLabel
          Left = 16
          Top = 115
          Width = 75
          Height = 13
          Caption = '&Save Entries To'
          FocusControl = eSuperSave
        end
        object btnSuperLoadFolder: TSpeedButton
          Left = 442
          Top = 79
          Width = 25
          Height = 24
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSuperLoadFolderClick
        end
        object btnSuperSaveFolder: TSpeedButton
          Left = 442
          Top = 111
          Width = 25
          Height = 24
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSuperSaveFolderClick
        end
        object lblSuperMask: TLabel
          Left = 16
          Top = 51
          Width = 66
          Height = 13
          Caption = 'Account &Mask'
          FocusControl = eSuperMask
        end
        object cmbSuperSystem: TComboBox
          Left = 144
          Top = 16
          Width = 316
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          Sorted = True
          TabOrder = 0
          OnChange = cmbSuperSystemChange
        end
        object eSuperLoad: TEdit
          Left = 144
          Top = 80
          Width = 297
          Height = 22
          BorderStyle = bsNone
          MaxLength = 128
          TabOrder = 2
          Text = 'eSuperLoad'
        end
        object eSuperSave: TEdit
          Left = 144
          Top = 112
          Width = 297
          Height = 22
          BorderStyle = bsNone
          MaxLength = 128
          TabOrder = 3
          Text = 'eSuperSave'
        end
        object eSuperMask: TEdit
          Left = 144
          Top = 48
          Width = 121
          Height = 22
          BorderStyle = bsNone
          MaxLength = 10
          TabOrder = 1
          Text = 'eSuperMask'
        end
      end
    end
    object tbsPracticeManagementSystem: TTabSheet
      Caption = 'Practice Management System'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbxPracticeManagementSystem: TGroupBox
        Left = 8
        Top = 4
        Width = 569
        Height = 147
        TabOrder = 0
        object lblPracticeManagementSystem: TLabel
          Left = 16
          Top = 20
          Width = 62
          Height = 13
          Caption = 'System &Used'
          FocusControl = cmbPracticeManagementSystem
        end
        object cmbPracticeManagementSystem: TComboBox
          Left = 144
          Top = 16
          Width = 316
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          Sorted = True
          TabOrder = 0
          OnChange = cmbSuperSystemChange
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
    Left = 48
    Top = 392
  end
  object OpenPictureDlg: TOpenPictureDialog
    Filter = 
      'All (*.jpg;*.jpeg;*.bmp;)|*.jpg;*.jpeg;*.bmp;|JPEG Image File (*' +
      '.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bm' +
      'p'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 16
    Top = 392
  end
end
