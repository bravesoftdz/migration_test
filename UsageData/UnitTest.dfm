object TestForm: TTestForm
  Left = 0
  Top = 0
  Caption = 'Usage Service Code Test App'
  ClientHeight = 290
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblReportProgress: TLabel
    Left = 272
    Top = 238
    Width = 274
    Height = 13
    AutoSize = False
  end
  object btnStop: TButton
    Left = 471
    Top = 257
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 0
    OnClick = btnStopClick
  end
  object btnStart: TButton
    Left = 390
    Top = 257
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnRunUsageReports: TButton
    Left = 272
    Top = 257
    Width = 112
    Height = 25
    Caption = 'Run Usage Reports'
    TabOrder = 2
    OnClick = btnRunUsageReportsClick
  end
end
