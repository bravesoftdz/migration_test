unit ClientReportScheduleDlg;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
{
  Title:   Setup Screen for Clients Schedule Reporting Options

  Written:
  Authors:

  Purpose:

  Notes:

  Last Reviewed: 20 May 2003 by MH
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
interface

uses
  ECodingExportFme,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ComCtrls,
  bkOKCancelDlg, clObj32, ScheduledCodingReportDlg, ECodingOptionsFrm,
  AccountSelectorFme, Dialogs, ExtCtrls, ImgList, CodingRepDlg;

type
  TCrsOption = (
    crsDontUpdateClientSpecificFields     //used when setting at global level
  );
  TCrsOptions = set of TCrsOption;

type
  TdlgClientReportSchedule = class(TbkOKCancelDlgForm)
    PageControl1: TPageControl;
    tbsOptions: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cmbPeriod: TComboBox;
    cmbStarts: TComboBox;
    grpSelect: TGroupBox;
    chkCodingReport: TCheckBox;
    chkChartReport: TCheckBox;
    chkPayeeReport: TCheckBox;
    btnReportSettings: TButton;
    lvReports: TListView;
    gbDestination: TGroupBox;
    rbToPrinter: TRadioButton;
    rbToFax: TRadioButton;
    rbToEMail: TRadioButton;
    rbToECoding: TRadioButton;
    cmbEmailFormat: TComboBox;
    btnECodingSetup: TButton;
    gbDetails: TGroupBox;
    Label6: TLabel;
    lblAddress: TLabel;
    eFaxNo: TEdit;
    eMail: TEdit;
    tbsMessage: TTabSheet;
    memMessage: TMemo;
    lblMessage: TLabel;
    Label3: TLabel;
    eCCeMail: TEdit;
    rbToWebX: TRadioButton;
    btnWebXSetup: TButton;
    rbCheckOut: TRadioButton;
    tbsAdvanced: TTabSheet;
    fmeAccountSelector1: TfmeAccountSelector;
    rbBusinessProducts: TRadioButton;
    cmbBusinessProducts: TComboBox;
    tbsAttachments: TTabSheet;
    lblAttach: TLabel;
    lvAttach: TListView;
    btnAttach: TButton;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    Image1: TImage;
    GroupBox1: TGroupBox;
    chkUseCustomDoc: TCheckBox;
    cmbCustomDocList: TComboBox;
    chkJobReport: TCheckBox;

    procedure lvReportsEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetUpHelp;
    procedure cmbPeriodChange(Sender: TObject);
    procedure chkEmailReportsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rbClientClick(Sender: TObject);
    procedure chkCodingReportClick(Sender: TObject);
    procedure btnReportSettingsClick(Sender: TObject);
    procedure btnECodingSetupClick(Sender: TObject);
    procedure rbToPrinterClick(Sender: TObject);
    procedure rbCSVExportClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnWebXSetupClick(Sender: TObject);
    procedure btnAttachClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvAttachKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkUseCustomDocClick(Sender: TObject);
    procedure cmbCustomDocListDropDown(Sender: TObject);

  private
    { Private declarations }
    FScheduleCodingRepSettings : TCodingReportSettings;
    FCustomCodingRepSettings : WideString;
    ECodingOptions            : TEcOptions;
    FClientToUse: TClientObj;
    FOptions: TCrsOptions;
    FAttachmentList : TStringList;

    procedure DisplayPeriods;
    procedure UpdateControlsOnForm;
    procedure SetClientToUse(const Value: TClientObj);
    procedure SetOptions(const Value: TCrsOptions);
    procedure AddFileToAttachmentListView(FileName: string);
    procedure LoadCustomDocuments;
  public
    { Public declarations }
    procedure AddCommaListOfAttachments(FileNames: string);
    property ClientToUse : TClientObj read FClientToUse write SetClientToUse;
    property Options : TCrsOptions read FOptions write SetOptions;

  end;

  function SetupClientSchedule(aClient : TClientObj; ContextID : Integer) : Boolean;

  //this routines have been added so that the settings can be read/set in the
  //globals setup routines
  procedure ReadClientSchedule (aClient: TClientObj; MyDlg : TdlgClientReportSchedule);
  procedure WriteClientSchedule(aClient: TClientObj; MyDlg : TdlgClientReportSchedule);

//******************************************************************************
implementation

uses
  admin32,
  bkConst,
  BKHelp,
  bkXPThemes,
  ovcDate,
  stDatest,
  globals,
  glConst,
  InfoMoreFrm,
  Imagesfrm,
  ClientHomePagefrm,
  ShellAPI,
  ErrorMoreFrm,
  SysObj32,
  BKDEFS,
  SYDEFS,
  BAObj32,
  StDate,
  ReportDefs,
  CustomDocEditorFrm, UBatchBase;

{$R *.DFM}

//const
//  TO_STAFF_MEMBER = 0;
//  TO_CLIENT       = 1;

//------------------------------------------------------------------------------
function SetupClientSchedule(aClient : TClientObj; ContextID : Integer) : Boolean;
var
  MyDlg : TdlgClientReportSchedule;
begin
   Result := False;
   if not Assigned(aClient) then exit;

   MyDlg := TdlgClientReportSchedule.Create(Application.MainForm);
   try
     BKHelpSetUp(MyDlg, ContextID);
     MyDlg.ClientToUse := aClient;
     ReadClientSchedule(aClient, MyDlg);
     if MyDlg.ShowModal = mrOK then
     begin
       WriteClientSchedule(aClient, MyDlg);
       Result := true;
       RefreshHomepage ([HPR_Client]);
     end;
   finally
     MyDlg.Free;
   end;
end;
//------------------------------------------------------------------------------
procedure ReadClientSchedule(aClient : TClientObj; MyDlg : TdlgClientReportSchedule);
var
  d,m,y : integer;
  ACustomDoc: TReportBase;
begin
  //load settings from client
  with MyDlg, aClient.clFields do begin
    if clReporting_Period in [roMin..roMax] then
      cmbPeriod.ItemIndex := clReporting_Period;

    if clReport_Start_Date <= 0 then
      clReport_Start_Date := clFinancial_Year_Starts;
    stDatetoDMY(clReport_Start_Date,d,m,y);

    if m in [moMin+1..moMax] then
      cmbStarts.ItemIndex := m-1;

    if clEmail_Report_Format in [rfCSV, rfFixedWidth, rfPDF, rfExcel] then
       cmbEmailFormat.ItemIndex := cmbEmailFormat.Items.IndexOfObject(TObject(clEmail_Report_Format));

    if clBusiness_Products_Report_Format in [bpOFXV1, bpOFXV2, bpQIF] then
       cmbBusinessProducts.ItemIndex := cmbBusinessProducts.Items.IndexOfObject(TObject(clBusiness_Products_Report_Format));

    DisplayPeriods;

    //coding report should always be selected, otherwise there is no
    //sense in producing scheduled reports
    chkCodingReport.Checked    := clSend_Coding_Report;
    chkChartReport.checked     := clSend_Chart_of_Accounts;
    chkPayeeReport.checked     := clSend_Payee_List;
    chkJobReport.checked       := aClient.clExtra.ceSend_Job_List;
    //Only allow one custom doc for now
    chkUseCustomDoc.Checked    := aClient.clExtra.ceSend_Custom_Documents;
    if (aClient.clExtra.ceSend_Custom_Documents_List[1] <> '') then begin
       ACustomDoc := CustomDocManager.GetReportByGUID(aClient.clExtra.ceSend_Custom_Documents_List[1]);
       cmbCustomDocList.ItemIndex := cmbCustomDocList.Items.IndexOfObject(ACustomDoc);
    end else
       cmbCustomDocList.ItemIndex := -1;

    //disable if coding report no selected
    chkChartReport.Enabled     := chkCodingReport.Checked;
    chkPayeeReport.Enabled     := chkCodingReport.Checked;
    chkJobReport.Enabled       := chkCodingReport.Checked;    
    chkUseCustomDoc.Enabled    := chkCodingReport.Checked;
    cmbCustomDocList.Enabled   := chkCodingReport.Checked
                               and chkUseCustomDoc.Checked;
    //set destination rb
    rbToPrinter.checked        := true;
    rbToEmail.checked          := clEmail_Scheduled_Reports;
    rbToFax.checked            := clFax_Scheduled_Reports;
    rbToECoding.checked        := clECoding_Export_Scheduled_Reports;
    rbToWebX.Checked           := clWebX_Export_Scheduled_Reports;
    rbCheckOut.Checked         := clCheckOut_Scheduled_Reports;
    rbBusinessProducts.Checked := clBusiness_Products_Scheduled_Reports;



    if not ( crsDontUpdateClientSpecificFields in FOptions) then
    begin
      eFaxNo.Text     := clFax_No;
      eMail.Text      := clClient_EMail_Address;
      memMessage.Text := clScheduled_Client_Note_Message;
      eCCeMail.Text  := clClient_CC_EMail_Address;
    end
    else
    begin
      gbDetails.Visible := false;
      tbsMessage.TabVisible := false;
      tbsAdvanced.TabVisible := False;
    end;

    //load scheduled report settings
    with FScheduleCodingRepSettings do begin
       Style             := clScheduled_Coding_Report_Style;
       Sort              := clScheduled_Coding_Report_Sort_Order;
       Include           := clScheduled_Coding_Report_Entry_Selection;
       Leave             := clScheduled_Coding_Report_Blank_Lines;
       Rule              := clScheduled_Coding_Report_Rule_Line;
       TaxInvoice        := clScheduled_Coding_Report_Print_TI;
       ShowOtherParty    := clScheduled_Coding_Report_Show_OP;
       WrapNarration     := clScheduled_Coding_Report_Wrap_Narration;
       RuleLineBetweenColumns := aClient.clExtra.ceCoding_Report_Column_Line;
    end;

    //Read custom coding report settings
    FCustomCodingRepSettings := aClient.clExtra.ceScheduled_Custom_CR_XML;

    //load ecoding options
    with ECodingOptions do
    begin
      Code           := clCode;   
      Include        := clECoding_Entry_Selection;
      IncludeChart   := not clECoding_Dont_Send_Chart;
      IncludePayees  := not clECoding_Dont_Send_Payees;
      IncludeJobs    := not aClient.clExtra.ceECoding_Dont_Send_Jobs;
      AllowUPIs      := not clECoding_Dont_Allow_UPIs;
      ShowAccount    := not clECoding_Dont_Show_Account;
      ShowQuantity   := not clECoding_Dont_Show_Quantity;
      ShowPayees     := not clECoding_Dont_Send_Payees;
      ShowGST        := not clECoding_Dont_Show_GST;
      ShowTaxInvoice := not clECoding_Dont_Show_TaxInvoice;
      ShowSuperFields := clECoding_Send_Superfund; 
      WebSpace       := clECoding_Webspace;
      WebNotify      := clTemp_FRS_From_Date; //Temp Via NewClientWiz
      
      if clWeb_Export_Format = 255 then
         WebFormat := wfDefault
      else
         WebFormat := clWeb_Export_Format;



      if not ( crsDontUpdateClientSpecificFields in FOptions) then
        Password := clECoding_Default_Password
      else
        HideClientSpecific := true;

      //Attachments    := clECoding_File_Attachments
    end;
    MyDlg.AddCommaListOfAttachments(clScheduled_File_Attachments);

    //load lists
    fmeAccountSelector1.LoadAccounts( ClientToUse, BKCONST.SchedRepSet, True);
    UpdateControlsOnForm;
  end;
end;

//------------------------------------------------------------------------------
procedure WriteClientSchedule(aClient : TClientObj; MyDlg : TdlgClientReportSchedule);
var
  i, d,m,y : integer;
  TempXMLStr: WideString;
begin
  with MyDlg, aClient.clFields do begin
    //save settings back
    if cmbPeriod.ItemIndex in [roMin..roMax] then
      clReporting_Period := cmbPeriod.ItemIndex;

    if (cmbStarts.ItemIndex+1) in [moMin+1..moMax] then
    begin
      //the month is used from the report start date to determine which
      //month the report is for, so just set the day and year using the
      //current fin year starts
      StDateToDMY(  clFinancial_Year_Starts, d, m, y);
      //get the month from the combo
      m := cmbStarts.ItemIndex+1;
      clReport_Start_Date := DMYtostDate(d,m,y,BKDATEEPOCH);
    end;

    clEmail_Report_Format := Integer(cmbEmailFormat.Items.Objects[cmbEmailFormat.ItemIndex]);
    clBusiness_Products_Report_Format := Integer(cmbBusinessProducts.Items.Objects[cmbBusinessProducts.ItemIndex]);
    clSend_Coding_report      := chkCodingReport.Checked;
    clSend_Chart_of_Accounts  := chkChartReport.Checked and chkCodingReport.Checked;
    clSend_Payee_List         := chkPayeeReport.Checked and chkCodingReport.Checked;
    aClient.clExtra.ceSend_Job_List := chkJobReport.Checked and chkCodingReport.Checked;
    aClient.clExtra.ceSend_Custom_Documents := chkUseCustomDoc.Checked and chkCodingReport.Checked;
    //Only allow one custom doc for now
    aClient.clExtra.ceSend_Custom_Documents_List[1] := '';
    if (cmbCustomDocList.ItemIndex <> -1) and chkCodingReport.Checked then
      aClient.clExtra.ceSend_Custom_Documents_List[1] :=
        TReportBase(cmbCustomDocList.Items.Objects[cmbCustomDocList.ItemIndex]).GetGUID;

    //only allow email reports if being sent to client
    clEmail_Scheduled_Reports := rbToEmail.Checked;
    clFax_Scheduled_Reports   := rbToFax.checked;
    clEcoding_Export_Scheduled_Reports := rbToEcoding.checked;
    clCSV_Export_Scheduled_Reports     := false;
    clWebX_Export_Scheduled_Reports := rbToWebX.Checked;
    clCheckOut_Scheduled_Reports := rbCheckOut.Checked;
    clBusiness_Products_Scheduled_Reports := rbBusinessProducts.Checked;

    if not ( crsDontUpdateClientSpecificFields in Options) then
    begin
      if (clFax_No <> eFaxNo.Text) or
         (clClient_EMail_Address <> Trim( eMail.Text)) then
      begin
        // Set flag to force update cache on save
        clContact_Details_Edit_Date := StDate.CurrentDate;
        clContact_Details_Edit_Time := StDate.CurrentTime;
      end;

      clFax_No                  := eFaxNo.Text;
      clClient_EMail_Address    := Trim( eMail.Text);
      clClient_CC_EMail_Address := Trim( eCCeMail.Text);

      clScheduled_Client_Note_Message := memMessage.Text;

      clExclude_From_Scheduled_Reports := '';
      for i := 0 to Pred(fmeAccountSelector1.AccountCheckBox.Count) do
      begin
        if not fmeAccountSelector1.AccountCheckBox.Checked[i] then
          clExclude_From_Scheduled_Reports := clExclude_From_Scheduled_Reports +
            TBank_Account(fmeAccountSelector1.AccountCheckBox.Items.Objects[i]).baFields.baBank_Account_Number + ',';
      end;
    end;

    with FScheduleCodingRepSettings do
    begin
      if (Style = rsCustom) then begin
        TempXMLStr := '';
        SaveCustomReportXML(TempXMLStr);
        aClient.clExtra.ceScheduled_Custom_CR_XML := TempXMLStr;
      end;
      clScheduled_Coding_Report_Style           := Style;
      clScheduled_Coding_Report_Sort_Order      := Sort;
      clScheduled_Coding_Report_Entry_Selection := Include;
      clScheduled_Coding_Report_Blank_Lines     := Leave;
      clScheduled_Coding_Report_Rule_Line       := Rule;
      clScheduled_Coding_Report_Print_TI        := TaxInvoice;
      clScheduled_Coding_Report_Show_OP         := ShowOtherParty;
      clScheduled_Coding_Report_Wrap_Narration  := WrapNarration;
      aClient.clExtra.ceCoding_Report_Column_Line := RuleLineBetweenColumns;
    end;

    with ECodingOptions do
    begin
      clECoding_Entry_Selection      := Include;
      clECoding_Dont_Send_Chart      := not IncludeChart;
      clECoding_Dont_Send_Payees     := not IncludePayees;
      aClient.clExtra.ceECoding_Dont_Send_Jobs := not IncludeJobs;
      clECoding_Dont_Allow_UPIs      := not AllowUPIs;
      clECoding_Dont_Show_Account    := not ShowAccount;
      clECoding_Dont_Show_Quantity   := not ShowQuantity;
      clECoding_Dont_Show_Payees     := not ShowPayees;
      clECoding_Dont_Show_GST        := not ShowGST;
      clECoding_Dont_Show_TaxInvoice := not ShowTaxInvoice;
      clECoding_Send_Superfund       := ShowSuperFields;
      clTemp_FRS_From_Date           := WebNotify;

      if not ( crsDontUpdateClientSpecificFields in FOptions) then
      begin
        clECoding_Webspace             := Webspace;
        clECoding_Default_Password     := Password;
      end;
      //clECoding_File_Attachments     := Attachments;
      clWeb_Export_Format := WebFormat;
    end;
    clScheduled_File_Attachments := FAttachmentList.CommaText;

  end; //with
end;
//------------------------------------------------------------------------------
procedure TdlgClientReportSchedule.lvAttachKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i, SelectedNo  : Integer;
begin { TfrmMail.lvAttachKeyUp }
  if (Key = VK_DELETE) then
  begin
    if (lvAttach.SelCount = 0) or (lvAttach.Items.Count = 0) then
      //don't allow deletes if nothing is selected or only the client file is attached
      exit;

    SelectedNo := -1;
    i := 0;
    while (i <= (lvAttach.items.Count - 1)) do
    begin
       if lvAttach.items[i].Selected then
       begin
         SelectedNo := i;
         FAttachmentList.Delete(SelectedNo);
         lvAttach.items[SelectedNo].Delete;
       end else
         Inc(i);
    end; { (i <= (lvAttach.items.Count - 1)) };
    if (SelectedNo <> -1) then
    begin
      if (lvAttach.Items.Count > i) then
        lvAttach.Items[SelectedNo].Selected := True
      else
        if (lvAttach.Items.Count > 0) then
          lvAttach.Items[lvAttach.Items.Count - 1].Selected := True;
    end;
  end; { Key = VK_DELETE };
end;

procedure TdlgClientReportSchedule.lvReportsEnter(Sender: TObject);
begin
  inherited;
  cmbStarts.SetFocus;
end;
//------------------------------------------------------------------------------
procedure TdlgClientReportSchedule.FormCreate(Sender: TObject);
var
  i : integer;
begin
  inherited;
  PageControl1.ActivePage := tbsOptions;
  //load combo boxes
  cmbStarts.Clear;     //start with jan, skip the N/A option
  for i := moMin+1 to moMax do cmbstarts.items.add(moNames[i]);

  cmbPeriod.Clear;
  for i := roMin to roMax do cmbPeriod.items.add(roNames[i]);

  cmbEmailFormat.Clear;
  cmbEmailFormat.items.AddObject( rfNames[ rfCSV], TObject( rfCSV));
  cmbEmailFormat.items.AddObject( rfNames[ rfFixedWidth], TObject( rfFixedWidth));
  cmbEmailFormat.items.AddObject( rfNames[ rfPDF], TObject( rfPDF));
  cmbEmailFormat.items.AddObject( rfNames[ rfExcel], TObject( rfExcel));

  cmbBusinessProducts.Clear;
  for i := bpMin to bpMax do
    cmbBusinessProducts.items.AddObject( bpNames[i], TObject(i));

  if cmbStarts.Items.Count > 0 then cmbStarts.ItemIndex := 0;
  if cmbPeriod.Items.Count > 0 then cmbPeriod.ItemIndex := 0;
  SetUpHelp;

  rbToEcoding.Caption := '&' + glConst.ECODING_APP_NAME;
  btnECodingSetup.caption  := glConst.ECODING_APP_NAME + ' Op&tions';

  rbToWebX.Caption := '&' + glConst.WEBX_GENERIC_APP_NAME + ' File';
  btnWebXSetup.Caption :=  glConst.WEBX_GENERIC_APP_NAME + ' Opt&ions';

  FAttachmentList := TStringList.Create;
  lvAttach.Clear;

  ClientToUse := nil;
  LoadCustomDocuments;
end;

//------------------------------------------------------------------------------
procedure TdlgClientReportSchedule.FormDestroy(Sender: TObject);
begin
  if Assigned(FScheduleCodingRepSettings) then
    FScheduleCodingRepSettings.Free;
  FAttachmentList.Free;

  inherited;
end;

procedure TdlgClientReportSchedule.LoadCustomDocuments;
var
  i: integer;
  CustomDoc: TReportBase;
begin
  cmbCustomDocList.Clear;
  CustomDocManager.Refresh;
  for i := 0 to Pred(CustomDocManager.ReportList.Count) do begin
     CustomDoc := TReportBase(CustomDocManager.ReportList.Items[i]);
     cmbCustomDocList.Items.AddObject(CustomDoc.Name, CustomDoc);
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TdlgClientReportSchedule.SetUpHelp;
begin
   Self.ShowHint    := INI_ShowFormHints;
   Self.HelpContext := 0;
   //Components
   cmbPeriod.Hint       :=
                        'Select how often the Reports to be produced|' +
                        'Select  how often you want to produce the selected Reports';
   cmbStarts.Hint       :=
                        'Select the month to start producing the Reports from|' +
                        'Select the month you want to start producing the Reports from';
   chkCodingReport.Hint :=
                        'Produce the Coding Report automatically|' +
                        'Produce the Coding Report automatically';
   chkChartReport.Hint  :=
                        'Produce the Chart Of Accounts Report automatically|' +
                        'Produce the Chart Of Accounts Report automatically';
   chkPayeeReport.Hint  :=
                        'Produce the Payee List Report automatically|' +
                        'Produce the Payee List Report automatically';
   chkJobReport.Hint  :=
                        'Produce the Job List Report automatically|' +
                        'Produce the Job List Report automatically';
   rbToEmail.Hint :=
                        'Send any reports generated via E-mail|'+
                        'Send any reports generated via E-mail';
   eMail.Hint           :=
                        'Enter the Client''s E-mail address|' +
                        'Enter the Client''s E-mail address';
   eCCeMail.Hint         :=
                        'Enter the CC Client''s E-mail address|' +
                        'Enter the CC Client''s E-mail address';
   chkUseCustomDoc.Hint :=
                        'Produce a selected custom document automatically|' +
                        'Produce a selected custom document  automatically';
end;
//------------------------------------------------------------------------------
procedure TdlgClientReportSchedule.cmbCustomDocListDropDown(Sender: TObject);
begin
  //Set the width of the list to 300
  cmbCustomDocList.Perform(CB_SETDROPPEDWIDTH, 300, 0);
end;

procedure TdlgClientReportSchedule.cmbPeriodChange(Sender: TObject);
begin
  inherited;
  DisplayPeriods;
end;
//------------------------------------------------------------------------------
procedure TdlgClientReportSchedule.chkEmailReportsClick(Sender: TObject);
begin
  inherited;

end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TdlgClientReportSchedule.DisplayPeriods;
var
  ListItem: TListItem;
  i, m : integer;
  tempDate : tStDate;
begin
   lvReports.Items.Clear;
   lblMessage.Caption := '';

   if (cmbPeriod.itemIndex <=0) or (cmbStarts.itemIndex= -1) then exit;

   tempDate := dmyToStdate(1,cmbStarts.ItemIndex+1,90,BKDATEEPOCH);

   case cmbPeriod.ItemIndex of
     roSendEveryMonth: {monthly}
       for i := 0 to 11 do
       begin
         ListItem := lvReports.Items.Add;
         ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i,0),true);
       end;

     roSendEveryTwoMonths: {two monthly}
       for i := 0 to 5 do
       begin
         ListItem := lvReports.Items.Add;
         ListItem.Caption := inttostr(i+1)+'. '+
                             StDatetoDateString('nnn',IncDate(tempDate,0,i*2,0),true)
                             +'-'+StDatetoDateString('nnn',IncDate(tempDate,0,i*2+1,0),true);
       end;

     roSendEveryThreeMonths: {three monthly}
       for i := 0 to 3 do
       begin
         ListItem := lvReports.Items.Add;
         ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i*3,0),true)
                             +'-'+StDatetoDateString('nnn',IncDate(tempDate,0,i*3+2,0),true);
       end;

     roSendEveryFourMonths: {four monthly}
       for i := 0 to 2 do
       begin
         ListItem := lvReports.Items.Add;
         ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i*4,0),true)
                             +'-'+StDatetoDateString('nnn',IncDate(tempDate,0,i*4+3,0),true);
       end;

     roSendEverySixMonths: {six monthly}
       for i := 0 to 1 do
       begin
         ListItem := lvReports.Items.Add;
         ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i*6,0),true)
                             +'-'+StDatetoDateString('nnn',IncDate(tempDate,0,i*6+5,0),true);
       end;
     roSendAnnually: {annually}
       begin
         ListItem := lvReports.Items.Add;
         ListItem.caption := '1. '+stDateToDateString('nnn',tempDate,true)+' - '+stDateToDateString('nnn',IncDate(tempDate,0,11,0),true);
       end;
     roSendEveryMonthQuarter: {month and quarter}
       begin
         for i := 0 to 11 do
         begin
           ListItem := lvReports.Items.Add;
           if ((i mod 3) = 2) then
             ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i-2,0),true)+
               '-' + StDatetoDateString('nnn',IncDate(tempDate,0,i,0),true) + '*'
           else
             ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i,0),true);
         end;
         lblMessage.Caption := '* These periods will include all transactions in the date range';
       end;

     roSendEveryMonthTwoMonths: {month and 2 months}
       begin
         for i := 0 to 11 do
         begin
           ListItem := lvReports.Items.Add;
           if ((i mod 2) = 1) then
             ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i-1,0),true)+
               '-' + StDatetoDateString('nnn',IncDate(tempDate,0,i,0),true) + '*'
           else
             ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i,0),true);
         end;
         lblMessage.Caption := '* These periods will include all transactions in the date range';
       end;

     roSendEveryTwoMonthsMonth: {2 months and month}
       begin
         m := 0;
         for i := 0 to 7 do
         begin
           ListItem := lvReports.Items.Add;
           if ((i mod 2) = 1) then
             ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i+m,0),true)
           else
           begin
             ListItem.Caption := inttostr(i+1)+'. '+StDatetoDateString('nnn',IncDate(tempDate,0,i+m,0),true)+
               '-' + StDatetoDateString('nnn',IncDate(tempDate,0,i+m+1,0),true);
             Inc(m);
           end;
         end;
       end;
   end; {case}
end;
//------------------------------------------------------------------------------

procedure TdlgClientReportSchedule.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i: Integer;
  Selected: Boolean;
begin
  inherited;

  if ( ModalResult = mrOK) then begin

     if not ( crsDontUpdateClientSpecificFields in Options) then
     begin
       //verify that an email address is specified if Email Reports is checked
       if (    (rbToEmail.checked)
            or (rbToECoding.checked)
            or (rbBusinessProducts.Checked)
            or (rbCheckOut.Checked)
            or (rbToWebX.Checked and (ECodingOptions.WebFormat = wfWebNotes))
          )
       and (Trim( eMail.Text) = '') then begin
         HelpfulErrorMsg( 'You must specify an E-mail address.', 0);
         CanClose := false;
         PageControl1.ActivePage := tbsOptions;
         eMail.SetFocus;
         exit;
       end;

       if ( rbToFax.Checked) and ( Trim( eFaxNo.Text) = '') then begin
         HelpfulErrorMsg( 'You must specify a fax number.', 0);
         CanClose := false;
         PageControl1.ActivePage := tbsOptions;
         eFaxNo.SetFocus;
         exit;
       end;

       //check if any accounts have been selected
       if (not ( crsDontUpdateClientSpecificFields in FOptions)) and
          (fmeAccountSelector1.AccountCheckBox.Items.Count > 0) then
         with fmeAccountSelector1 do
         begin
           Selected := False;
           i := 0;
           while (i < AccountCheckBox.Items.Count) and (not Selected) do
           begin
             if (AccountCheckBox.Checked[i]) then
               Selected := True;
             Inc(i);
           end;
           if (not Selected) then
           begin
             HelpfulErrorMsg('No accounts have been selected.',0);
             CanClose := false;
             PageControl1.ActivePage := tbsAdvanced;
             chkAccounts.SetFocus;
             Exit;
           end;
         end;

     end;
  end;
end;
//------------------------------------------------------------------------------

procedure TdlgClientReportSchedule.rbClientClick(Sender: TObject);
begin

end;
//------------------------------------------------------------------------------

procedure TdlgClientReportSchedule.chkCodingReportClick(Sender: TObject);
begin
  chkChartReport.Enabled := chkCodingReport.Checked;
  chkPayeeReport.Enabled := chkCodingReport.Checked;
  chkJobReport.Enabled   := chkCodingReport.Checked;
  chkUseCustomDoc.Enabled := chkCodingReport.Checked;
  cmbCustomDocList.Enabled := chkCodingReport.Checked
                           and  chkUseCustomDoc.Checked;
end;
//------------------------------------------------------------------------------

procedure TdlgClientReportSchedule.btnReportSettingsClick(Sender: TObject);
begin
   SetupScheduledCodingReport( FClientToUse, FScheduleCodingRepSettings, FCustomCodingRepSettings);
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TdlgClientReportSchedule.btnAttachClick(Sender: TObject);
var
  FileName: string;
begin
  if OpenDialog1.Execute then
  begin
    FileName := OpenDialog1.FileName;
    if (ExtractFilePath(FileName) = DataDir) and (Uppercase(ExtractFileExt(FileName)) = '.BK5') then
      HelpfulErrorMsg('Sorry, client files cannot be attached in this manner.',0)
    else
    begin
      FAttachmentList.Add(FileName);
      AddFileToAttachmentListView(FileName);
    end;
  end;
  //make sure all relative paths are relative to data dir after browse
  SysUtils.SetCurrentDir( Globals.DataDir);
end;

procedure TdlgClientReportSchedule.AddCommaListOfAttachments(FileNames: string);
var
  I: Integer;
begin
  FAttachmentList.CommaText := FileNames;
  for I := 0 to FAttachmentList.Count - 1 do
    AddFileToAttachmentListView(FAttachmentList[i]);
end;

procedure TdlgClientReportSchedule.AddFileToAttachmentListView(FileName: string);
var
  aSHFi: TSHFileInfo;
  NewItem : TListItem;
begin
  //causes the icon to be retrieved
  SHGetFileInfo(PChar(FileName), 0, aSHFi, sizeOf(aSHFi), SHGFI_ICON );
  Image1.Picture.Icon.Handle := aSHFi.hIcon;
  ImageList1.AddIcon(Image1.Picture.Icon);

  NewItem            := lvAttach.Items.Add;
  NewItem.Caption    := ExtractFilename(FileName);
  NewItem.ImageIndex := ImageList1.Count-1;
end;

procedure TdlgClientReportSchedule.btnECodingSetupClick(Sender: TObject);
begin
   SetECodingOptions( ECodingOptions, FClientToUse.clFields.clCountry, ecDestFile, FClientToUse.clFields.clAccounting_System_Used);
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TdlgClientReportSchedule.rbToPrinterClick(Sender: TObject);
begin
  UpdateControlsOnForm;
end;
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TdlgClientReportSchedule.UpdateControlsOnForm;
var
  AttachmentsEnabled : Boolean;
begin
  //set enabled status of all other controls
  grpSelect.Enabled := rbToPrinter.checked or
                      rbToFax.checked or
                      rbToEMail.checked;

  if grpSelect.Enabled then
  begin
    chkCodingReport.Enabled := True;
    chkChartReport.Enabled := chkCodingReport.Checked;
    chkPayeeReport.Enabled := chkCodingReport.Checked;
    chkJobReport.Enabled := chkCodingReport.Checked;
  end else
  begin
    chkCodingReport.Enabled := False;
    chkCodingReport.Checked := True;
    chkChartReport.Enabled := false;
    chkPayeeReport.Enabled := false;
    chkJobReport.Enabled := false;
  end;


  cmbCustomDocList.Enabled := chkUseCustomDoc.Enabled
                           and chkUseCustomDoc.Checked;

  //Disable Attachments for non-email destinations
  AttachmentsEnabled := rbToEmail.Checked
                     or rbToECoding.Checked
                     or rbCheckOut.Checked
                     or (rbToWebX.Checked and (ECodingOptions.WebFormat = wfWebNotes));
  // Disabeling the Tabsheet, does not sop you to get in.
  // It Does disable the controls, but they don't show gray.
  // We could hide it altogether (TabVisible) but that is not a good UI practice
  lblAttach.Enabled := AttachmentsEnabled;
  lvAttach.Enabled  := AttachmentsEnabled;
  btnAttach.Enabled := AttachmentsEnabled;

  btnReportSettings.Enabled := grpSelect.Enabled;
  cmbEmailFormat.Enabled    := rbToEMail.Checked;
  cmbBusinessProducts.Enabled := rbBusinessProducts.Checked;
  btnECodingSetup.Enabled   := rbToECoding.Checked;
  btnWebXSetup.Enabled      := rbToWebX.Checked;

  if rbCheckOut.Checked then
   fmeAccountSelector1.btnSelectAllAccounts.Click;
  fmeAccountSelector1.btnSelectAllAccounts.Enabled := not rbCheckOut.Checked;
  fmeAccountSelector1.btnClearAllAccounts.Enabled := not rbCheckOut.Checked;
  fmeAccountSelector1.chkAccounts.Enabled := not rbCheckOut.Checked;
end;

procedure TdlgClientReportSchedule.rbCSVExportClick(Sender: TObject);
begin
  UpdateControlsOnForm;
end;

procedure TdlgClientReportSchedule.SetClientToUse(const Value: TClientObj);
begin
  FClientToUse := Value;
  if Assigned(FClientToUse) then begin
    if Assigned(FScheduleCodingRepSettings) then
      FScheduleCodingRepSettings.Free;
    FScheduleCodingRepSettings := TCodingReportSettings.Create(ord(Report_Coding),
                                                               FClientToUse, nil);
  end;
end;

procedure TdlgClientReportSchedule.SetOptions(const Value: TCrsOptions);
begin
  FOptions := Value;
end;

procedure TdlgClientReportSchedule.PageControl1Change(Sender: TObject);
begin
  if (TPageControl(Sender).ActivePage = tbsMessage) then
    memMessage.SetFocus;
end;


procedure TdlgClientReportSchedule.btnWebXSetupClick(Sender: TObject);
begin
   if ECodingOptions.WebFormat = wfNone then begin
       HelpfulInfoMsg( 'Please select a Web export format,'#13'under Other Functions, Accounting System, first', 0);
   end else
      SetECodingOptions( ECodingOptions, FClientToUse.clFields.clCountry, ecDestWebX, FClientToUse.clFields.clAccounting_System_Used);
end;

procedure TdlgClientReportSchedule.chkUseCustomDocClick(Sender: TObject);
begin
  cmbCustomDocList.Enabled := chkUseCustomDoc.Checked
                           and chkUseCustomDoc.Enabled; // How could it not be..
end;

end.
