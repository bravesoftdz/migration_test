// **********************************************************
// This file is Auto generated by DBGen
// Any changes will be lost when the file is regenerated
// **********************************************************
using System;
using BankLink.Practice.Common.Entities;
using System.Xml.Serialization;


namespace BankLink.Practice.BooksIO
{
	/// <summary>
	/// BK - Transaction class
	/// </summary>
	public partial class BKTransaction 
	{


		/// <summary>
		/// SequenceNo property
		/// </summary>
		[XmlAttribute("SequenceNo", DataType = "int")]
		public Int32 SequenceNo { get; set; }



		/// <summary>
		/// LRNNOWUNUSED property
		/// </summary>
		[XmlAttribute("LRNNOWUNUSED", DataType = "int")]
		public Int32 LRNNOWUNUSED { get; set; }



		/// <summary>
		/// Type property
		/// </summary>
		[XmlAttribute("Type", DataType = "unsignedByte")]
		public byte Type { get; set; }



		/// <summary>
		/// Source property
		/// </summary>
		[XmlAttribute("Source", DataType = "unsignedByte")]
		public byte Source { get; set; }



		/// <summary>
		/// DatePresented property
		/// </summary>
		[XmlAttribute("DatePresented", DataType = "int")]
		public Int32 DatePresented { get; set; }



		/// <summary>
		/// DateEffective property
		/// </summary>
		[XmlAttribute("DateEffective", DataType = "int")]
		public Int32 DateEffective { get; set; }



		/// <summary>
		/// DateTransferred property
		/// </summary>
		[XmlAttribute("DateTransferred", DataType = "int")]
		public Int32 DateTransferred { get; set; }



		/// <summary>
		/// Amount property
		/// </summary>
		[XmlAttribute("Amount", DataType = "long")]
		public Int64 Amount { get; set; }



		/// <summary>
		/// GSTClass property
		/// </summary>
		[XmlAttribute("GSTClass", DataType = "unsignedByte")]
		public byte GSTClass { get; set; }



		/// <summary>
		/// GSTAmount property
		/// </summary>
		[XmlAttribute("GSTAmount", DataType = "long")]
		public Int64 GSTAmount { get; set; }



		/// <summary>
		/// HasBeenEdited property
		/// </summary>
		[XmlAttribute("HasBeenEdited", DataType = "boolean")]
		public bool HasBeenEdited { get; set; }



		/// <summary>
		/// Quantity property
		/// </summary>
		[XmlAttribute("Quantity", DataType = "long")]
		public Int64 Quantity { get; set; }



		/// <summary>
		/// ChequeNumber property
		/// </summary>
		[XmlAttribute("ChequeNumber", DataType = "int")]
		public Int32 ChequeNumber { get; set; }



		/// <summary>
		/// Reference property
		/// </summary>
		[XmlAttribute("Reference", DataType = "string")]
		public String Reference { get; set; }



		/// <summary>
		/// Particulars property
		/// </summary>
		[XmlAttribute("Particulars", DataType = "string")]
		public String Particulars { get; set; }



		/// <summary>
		/// Analysis property
		/// </summary>
		[XmlAttribute("Analysis", DataType = "string")]
		public String Analysis { get; set; }



		/// <summary>
		/// OrigBB property
		/// </summary>
		[XmlAttribute("OrigBB", DataType = "string")]
		public String OrigBB { get; set; }



		/// <summary>
		/// OtherParty property
		/// </summary>
		[XmlAttribute("OtherParty", DataType = "string")]
		public String OtherParty { get; set; }



		/// <summary>
		/// OldNarration property
		/// </summary>
		[XmlAttribute("OldNarration", DataType = "string")]
		public String OldNarration { get; set; }



		/// <summary>
		/// Account property
		/// </summary>
		[XmlAttribute("Account", DataType = "string")]
		public String Account { get; set; }



		/// <summary>
		/// CodedBy property
		/// </summary>
		[XmlAttribute("CodedBy", DataType = "unsignedByte")]
		public byte CodedBy { get; set; }



		/// <summary>
		/// PayeeNumber property
		/// </summary>
		[XmlAttribute("PayeeNumber", DataType = "int")]
		public Int32 PayeeNumber { get; set; }



		/// <summary>
		/// Locked property
		/// </summary>
		[XmlAttribute("Locked", DataType = "boolean")]
		public bool Locked { get; set; }



		/// <summary>
		/// BankLinkID property
		/// </summary>
		[XmlAttribute("BankLinkID", DataType = "int")]
		public Int32 BankLinkID { get; set; }



		/// <summary>
		/// GSTHasBeenEdited property
		/// </summary>
		[XmlAttribute("GSTHasBeenEdited", DataType = "boolean")]
		public bool GSTHasBeenEdited { get; set; }



		/// <summary>
		/// MatchedItemID property
		/// </summary>
		[XmlAttribute("MatchedItemID", DataType = "int")]
		public Int32 MatchedItemID { get; set; }



		/// <summary>
		/// UPIState property
		/// </summary>
		[XmlAttribute("UPIState", DataType = "unsignedByte")]
		public byte UPIState { get; set; }



		/// <summary>
		/// OriginalReference property
		/// </summary>
		[XmlAttribute("OriginalReference", DataType = "string")]
		public String OriginalReference { get; set; }



		/// <summary>
		/// OriginalSource property
		/// </summary>
		[XmlAttribute("OriginalSource", DataType = "unsignedByte")]
		public byte OriginalSource { get; set; }



		/// <summary>
		/// OriginalType property
		/// </summary>
		[XmlAttribute("OriginalType", DataType = "unsignedByte")]
		public byte OriginalType { get; set; }



		/// <summary>
		/// OriginalChequeNumber property
		/// </summary>
		[XmlAttribute("OriginalChequeNumber", DataType = "int")]
		public Int32 OriginalChequeNumber { get; set; }



		/// <summary>
		/// OriginalAmount property
		/// </summary>
		[XmlAttribute("OriginalAmount", DataType = "long")]
		public Int64 OriginalAmount { get; set; }



		/// <summary>
		/// Notes property
		/// </summary>
		[XmlAttribute("Notes", DataType = "string")]
		public String Notes { get; set; }



		/// <summary>
		/// ECodingImportNotes property
		/// </summary>
		[XmlAttribute("ECodingImportNotes", DataType = "string")]
		public String ECodingImportNotes { get; set; }



		/// <summary>
		/// ECodingTransactionUID property
		/// </summary>
		[XmlAttribute("ECodingTransactionUID", DataType = "int")]
		public Int32 ECodingTransactionUID { get; set; }



		/// <summary>
		/// GLNarration property
		/// </summary>
		[XmlAttribute("GLNarration", DataType = "string")]
		public String GLNarration { get; set; }



		/// <summary>
		/// StatementDetails property
		/// </summary>
		[XmlAttribute("StatementDetails", DataType = "string")]
		public String StatementDetails { get; set; }



		/// <summary>
		/// TaxInvoiceAvailable property
		/// </summary>
		[XmlAttribute("TaxInvoiceAvailable", DataType = "boolean")]
		public bool TaxInvoiceAvailable { get; set; }



		/// <summary>
		/// SFImputedCredit property
		/// </summary>
		[XmlAttribute("SFImputedCredit", DataType = "long")]
		public Int64 SFImputedCredit { get; set; }



		/// <summary>
		/// SFTaxFreeDist property
		/// </summary>
		[XmlAttribute("SFTaxFreeDist", DataType = "long")]
		public Int64 SFTaxFreeDist { get; set; }



		/// <summary>
		/// SFTaxExemptDist property
		/// </summary>
		[XmlAttribute("SFTaxExemptDist", DataType = "long")]
		public Int64 SFTaxExemptDist { get; set; }



		/// <summary>
		/// SFTaxDeferredDist property
		/// </summary>
		[XmlAttribute("SFTaxDeferredDist", DataType = "long")]
		public Int64 SFTaxDeferredDist { get; set; }



		/// <summary>
		/// SFTFNCredits property
		/// </summary>
		[XmlAttribute("SFTFNCredits", DataType = "long")]
		public Int64 SFTFNCredits { get; set; }



		/// <summary>
		/// SFForeignIncome property
		/// </summary>
		[XmlAttribute("SFForeignIncome", DataType = "long")]
		public Int64 SFForeignIncome { get; set; }



		/// <summary>
		/// SFForeignTaxCredits property
		/// </summary>
		[XmlAttribute("SFForeignTaxCredits", DataType = "long")]
		public Int64 SFForeignTaxCredits { get; set; }



		/// <summary>
		/// SFCapitalGainsIndexed property
		/// </summary>
		[XmlAttribute("SFCapitalGainsIndexed", DataType = "long")]
		public Int64 SFCapitalGainsIndexed { get; set; }



		/// <summary>
		/// SFCapitalGainsDisc property
		/// </summary>
		[XmlAttribute("SFCapitalGainsDisc", DataType = "long")]
		public Int64 SFCapitalGainsDisc { get; set; }



		/// <summary>
		/// SFSuperFieldsEdited property
		/// </summary>
		[XmlAttribute("SFSuperFieldsEdited", DataType = "boolean")]
		public bool SFSuperFieldsEdited { get; set; }



		/// <summary>
		/// SFCapitalGainsOther property
		/// </summary>
		[XmlAttribute("SFCapitalGainsOther", DataType = "long")]
		public Int64 SFCapitalGainsOther { get; set; }



		/// <summary>
		/// SFOtherExpenses property
		/// </summary>
		[XmlAttribute("SFOtherExpenses", DataType = "long")]
		public Int64 SFOtherExpenses { get; set; }



		/// <summary>
		/// SFCGTDate property
		/// </summary>
		[XmlAttribute("SFCGTDate", DataType = "int")]
		public Int32 SFCGTDate { get; set; }



		/// <summary>
		/// ExternalGUID property
		/// </summary>
		[XmlAttribute("ExternalGUID", DataType = "string")]
		public String ExternalGUID { get; set; }



		/// <summary>
		/// DocumentTitle property
		/// </summary>
		[XmlAttribute("DocumentTitle", DataType = "string")]
		public String DocumentTitle { get; set; }



		/// <summary>
		/// DocumentStatusUpdateRequired property
		/// </summary>
		[XmlAttribute("DocumentStatusUpdateRequired", DataType = "boolean")]
		public bool DocumentStatusUpdateRequired { get; set; }



		/// <summary>
		/// BankLinkUID property
		/// </summary>
		[XmlAttribute("BankLinkUID", DataType = "string")]
		public String BankLinkUID { get; set; }



		/// <summary>
		/// NotesRead property
		/// </summary>
		[XmlAttribute("NotesRead", DataType = "boolean")]
		public bool NotesRead { get; set; }



		/// <summary>
		/// ImportNotesRead property
		/// </summary>
		[XmlAttribute("ImportNotesRead", DataType = "boolean")]
		public bool ImportNotesRead { get; set; }



		/// <summary>
		/// SpareString property
		/// </summary>
		[XmlAttribute("SpareString", DataType = "string")]
		public String SpareString { get; set; }



		/// <summary>
		/// SpareBoolean property
		/// </summary>
		[XmlAttribute("SpareBoolean", DataType = "boolean")]
		public bool SpareBoolean { get; set; }



		/// <summary>
		/// SFFranked property
		/// </summary>
		[XmlAttribute("SFFranked", DataType = "long")]
		public Int64 SFFranked { get; set; }



		/// <summary>
		/// SFUnfranked property
		/// </summary>
		[XmlAttribute("SFUnfranked", DataType = "long")]
		public Int64 SFUnfranked { get; set; }



		/// <summary>
		/// SFInterest property
		/// </summary>
		[XmlAttribute("SFInterest", DataType = "long")]
		public Int64 SFInterest { get; set; }



		/// <summary>
		/// SFCapitalGainsForeignDisc property
		/// </summary>
		[XmlAttribute("SFCapitalGainsForeignDisc", DataType = "long")]
		public Int64 SFCapitalGainsForeignDisc { get; set; }



		/// <summary>
		/// SFRent property
		/// </summary>
		[XmlAttribute("SFRent", DataType = "long")]
		public Int64 SFRent { get; set; }



		/// <summary>
		/// SFSpecialIncome property
		/// </summary>
		[XmlAttribute("SFSpecialIncome", DataType = "long")]
		public Int64 SFSpecialIncome { get; set; }



		/// <summary>
		/// SFOtherTaxCredit property
		/// </summary>
		[XmlAttribute("SFOtherTaxCredit", DataType = "long")]
		public Int64 SFOtherTaxCredit { get; set; }



		/// <summary>
		/// SFNonResidentTax property
		/// </summary>
		[XmlAttribute("SFNonResidentTax", DataType = "long")]
		public Int64 SFNonResidentTax { get; set; }



		/// <summary>
		/// SFMemberID property
		/// </summary>
		[XmlAttribute("SFMemberID", DataType = "string")]
		public String SFMemberID { get; set; }



		/// <summary>
		/// SFForeignCapitalGainsCredit property
		/// </summary>
		[XmlAttribute("SFForeignCapitalGainsCredit", DataType = "long")]
		public Int64 SFForeignCapitalGainsCredit { get; set; }



		/// <summary>
		/// SFMemberComponent property
		/// </summary>
		[XmlAttribute("SFMemberComponent", DataType = "unsignedByte")]
		public byte SFMemberComponent { get; set; }



		/// <summary>
		/// SFFundID property
		/// </summary>
		[XmlAttribute("SFFundID", DataType = "int")]
		public Int32 SFFundID { get; set; }



		/// <summary>
		/// SFMemberAccountID property
		/// </summary>
		[XmlAttribute("SFMemberAccountID", DataType = "int")]
		public Int32 SFMemberAccountID { get; set; }



		/// <summary>
		/// SFFundCode property
		/// </summary>
		[XmlAttribute("SFFundCode", DataType = "string")]
		public String SFFundCode { get; set; }



		/// <summary>
		/// SFMemberAccountCode property
		/// </summary>
		[XmlAttribute("SFMemberAccountCode", DataType = "string")]
		public String SFMemberAccountCode { get; set; }



		/// <summary>
		/// SFTransactionID property
		/// </summary>
		[XmlAttribute("SFTransactionID", DataType = "int")]
		public Int32 SFTransactionID { get; set; }



		/// <summary>
		/// SFTransactionCode property
		/// </summary>
		[XmlAttribute("SFTransactionCode", DataType = "string")]
		public String SFTransactionCode { get; set; }



		/// <summary>
		/// SFCapitalGainsFractionHalf property
		/// </summary>
		[XmlAttribute("SFCapitalGainsFractionHalf", DataType = "boolean")]
		public bool SFCapitalGainsFractionHalf { get; set; }



		/// <summary>
		/// AuditRecordID property
		/// </summary>
		[XmlAttribute("AuditRecordID", DataType = "int")]
		public Int32 AuditRecordID { get; set; }



		/// <summary>
		/// JobCode property
		/// </summary>
		[XmlAttribute("JobCode", DataType = "string")]
		public String JobCode { get; set; }



		/// <summary>
		/// SpareMoney1 property
		/// </summary>
		[XmlAttribute("SpareMoney1", DataType = "long")]
		public Int64 SpareMoney1 { get; set; }



		/// <summary>
		/// SpareMoney2 property
		/// </summary>
		[XmlAttribute("SpareMoney2", DataType = "long")]
		public Int64 SpareMoney2 { get; set; }



		/// <summary>
		/// CoreTransactionID property
		/// </summary>
		[XmlAttribute("CoreTransactionID", DataType = "int")]
		public Int32 CoreTransactionID { get; set; }



		/// <summary>
		/// TransferedToOnline property
		/// </summary>
		[XmlAttribute("TransferedToOnline", DataType = "boolean")]
		public bool TransferedToOnline { get; set; }



		/// <summary>
		/// CoreTransactionIDHigh property
		/// </summary>
		[XmlAttribute("CoreTransactionIDHigh", DataType = "int")]
		public Int32 CoreTransactionIDHigh { get; set; }



		/// <summary>
		/// IsOnlineTransaction property
		/// </summary>
		[XmlAttribute("IsOnlineTransaction", DataType = "boolean")]
		public bool IsOnlineTransaction { get; set; }



		/// <summary>
		/// SuggestedMemState property
		/// </summary>
		[XmlAttribute("SuggestedMemState", DataType = "unsignedByte")]
		public byte SuggestedMemState { get; set; }



		/// <summary>
		/// SuggestedMemIndex property
		/// </summary>
		[XmlAttribute("SuggestedMemIndex", DataType = "int")]
		public Int32 SuggestedMemIndex { get; set; }


		/// <summary>
		/// Class Begin Token
		/// </summary>
		public const byte BeginToken = 160;
		/// <summary>
		/// Class End Token
		/// </summary>
		public const byte EndToken = 161;
		/// <summary>
		/// Write to BKStream
		/// </summary>
		public void WriteBKStream(BankLinkTokenStreamWriter s)
		{
			s.WriteToken(160);
			s.WriteInt32Value(162, SequenceNo);
			s.WriteInt32Value(163, LRNNOWUNUSED);
			s.WriteByteValue(164, Type);
			s.WriteByteValue(165, Source);
			s.WriteJulDateValue(166, DatePresented);
			s.WriteJulDateValue(167, DateEffective);
			s.WriteJulDateValue(168, DateTransferred);
			s.WriteMoneyValue(169, Amount);
			s.WriteByteValue(170, GSTClass);
			s.WriteMoneyValue(171, GSTAmount);
			s.WriteBooleanValue(172, HasBeenEdited);
			s.WriteMoneyValue(173, Quantity);
			s.WriteInt32Value(174, ChequeNumber);
			s.WriteShortStringValue(175, Reference);
			s.WriteShortStringValue(176, Particulars);
			s.WriteShortStringValue(177, Analysis);
			s.WriteShortStringValue(178, OrigBB);
			s.WriteShortStringValue(179, OtherParty);
			s.WriteShortStringValue(180, OldNarration);
			s.WriteShortStringValue(181, Account);
			s.WriteByteValue(182, CodedBy);
			s.WriteInt32Value(183, PayeeNumber);
			s.WriteBooleanValue(184, Locked);
			s.WriteInt32Value(185, BankLinkID);
			s.WriteBooleanValue(186, GSTHasBeenEdited);
			s.WriteInt32Value(187, MatchedItemID);
			s.WriteByteValue(188, UPIState);
			s.WriteShortStringValue(189, OriginalReference);
			s.WriteByteValue(190, OriginalSource);
			s.WriteByteValue(191, OriginalType);
			s.WriteInt32Value(192, OriginalChequeNumber);
			s.WriteMoneyValue(193, OriginalAmount);
			s.WriteAnsiStringValue(194, Notes);
			s.WriteAnsiStringValue(195, ECodingImportNotes);
			s.WriteInt32Value(196, ECodingTransactionUID);
			s.WriteAnsiStringValue(197, GLNarration);
			s.WriteAnsiStringValue(198, StatementDetails);
			s.WriteBooleanValue(199, TaxInvoiceAvailable);
			s.WriteMoneyValue(200, SFImputedCredit);
			s.WriteMoneyValue(201, SFTaxFreeDist);
			s.WriteMoneyValue(202, SFTaxExemptDist);
			s.WriteMoneyValue(203, SFTaxDeferredDist);
			s.WriteMoneyValue(204, SFTFNCredits);
			s.WriteMoneyValue(205, SFForeignIncome);
			s.WriteMoneyValue(206, SFForeignTaxCredits);
			s.WriteMoneyValue(207, SFCapitalGainsIndexed);
			s.WriteMoneyValue(208, SFCapitalGainsDisc);
			s.WriteBooleanValue(209, SFSuperFieldsEdited);
			s.WriteMoneyValue(210, SFCapitalGainsOther);
			s.WriteMoneyValue(211, SFOtherExpenses);
			s.WriteInt32Value(212, SFCGTDate);
			s.WriteAnsiStringValue(213, ExternalGUID);
			s.WriteAnsiStringValue(214, DocumentTitle);
			s.WriteBooleanValue(215, DocumentStatusUpdateRequired);
			s.WriteAnsiStringValue(216, BankLinkUID);
			s.WriteBooleanValue(217, NotesRead);
			s.WriteBooleanValue(218, ImportNotesRead);
			s.WriteAnsiStringValue(219, SpareString);
			s.WriteBooleanValue(220, SpareBoolean);
			s.WriteMoneyValue(221, SFFranked);
			s.WriteMoneyValue(222, SFUnfranked);
			s.WriteMoneyValue(223, SFInterest);
			s.WriteMoneyValue(224, SFCapitalGainsForeignDisc);
			s.WriteMoneyValue(225, SFRent);
			s.WriteMoneyValue(226, SFSpecialIncome);
			s.WriteMoneyValue(227, SFOtherTaxCredit);
			s.WriteMoneyValue(228, SFNonResidentTax);
			s.WriteShortStringValue(229, SFMemberID);
			s.WriteMoneyValue(230, SFForeignCapitalGainsCredit);
			s.WriteByteValue(231, SFMemberComponent);
			s.WriteInt32Value(232, SFFundID);
			s.WriteInt32Value(233, SFMemberAccountID);
			s.WriteShortStringValue(234, SFFundCode);
			s.WriteShortStringValue(235, SFMemberAccountCode);
			s.WriteInt32Value(236, SFTransactionID);
			s.WriteAnsiStringValue(237, SFTransactionCode);
			s.WriteBooleanValue(238, SFCapitalGainsFractionHalf);
			s.WriteInt32Value(239, AuditRecordID);
			s.WriteShortStringValue(240, JobCode);
			s.WriteMoneyValue(242, SpareMoney1);
			s.WriteMoneyValue(244, SpareMoney2);
			s.WriteInt32Value(245, CoreTransactionID);
			s.WriteBooleanValue(246, TransferedToOnline);
			s.WriteInt32Value(247, CoreTransactionIDHigh);
			s.WriteBooleanValue(248, IsOnlineTransaction);
			s.WriteByteValue(249, SuggestedMemState);
			s.WriteInt32Value(250, SuggestedMemIndex);
			s.WriteToken(161);
		}

		/// <summary>
		/// Default Constructor 
		/// </summary>
		public BKTransaction ()
		{}
		/// <summary>
		/// Construct from BKStreamReader
		/// </summary>
		public BKTransaction (BankLinkTokenStreamReader s)
		{
			var token = BeginToken;
			while (token != EndToken)
			{
				switch (token)
				{
			case 162 :
				SequenceNo = s.ReadInt32Value("SequenceNo");
				break;
			case 163 :
				LRNNOWUNUSED = s.ReadInt32Value("LRNNOWUNUSED");
				break;
			case 164 :
				Type = s.ReadByteValue("Type");
				break;
			case 165 :
				Source = s.ReadByteValue("Source");
				break;
			case 166 :
				DatePresented = s.ReadJulDateValue("DatePresented");
				break;
			case 167 :
				DateEffective = s.ReadJulDateValue("DateEffective");
				break;
			case 168 :
				DateTransferred = s.ReadJulDateValue("DateTransferred");
				break;
			case 169 :
				Amount = s.ReadMoneyValue("Amount");
				break;
			case 170 :
				GSTClass = s.ReadByteValue("GSTClass");
				break;
			case 171 :
				GSTAmount = s.ReadMoneyValue("GSTAmount");
				break;
			case 172 :
				HasBeenEdited = s.ReadBooleanValue("HasBeenEdited");
				break;
			case 173 :
				Quantity = s.ReadMoneyValue("Quantity");
				break;
			case 174 :
				ChequeNumber = s.ReadInt32Value("ChequeNumber");
				break;
			case 175 :
				Reference = s.ReadShortStringValue("Reference");
				break;
			case 176 :
				Particulars = s.ReadShortStringValue("Particulars");
				break;
			case 177 :
				Analysis = s.ReadShortStringValue("Analysis");
				break;
			case 178 :
				OrigBB = s.ReadShortStringValue("OrigBB");
				break;
			case 179 :
				OtherParty = s.ReadShortStringValue("OtherParty");
				break;
			case 180 :
				OldNarration = s.ReadShortStringValue("OldNarration");
				break;
			case 181 :
				Account = s.ReadShortStringValue("Account");
				break;
			case 182 :
				CodedBy = s.ReadByteValue("CodedBy");
				break;
			case 183 :
				PayeeNumber = s.ReadInt32Value("PayeeNumber");
				break;
			case 184 :
				Locked = s.ReadBooleanValue("Locked");
				break;
			case 185 :
				BankLinkID = s.ReadInt32Value("BankLinkID");
				break;
			case 186 :
				GSTHasBeenEdited = s.ReadBooleanValue("GSTHasBeenEdited");
				break;
			case 187 :
				MatchedItemID = s.ReadInt32Value("MatchedItemID");
				break;
			case 188 :
				UPIState = s.ReadByteValue("UPIState");
				break;
			case 189 :
				OriginalReference = s.ReadShortStringValue("OriginalReference");
				break;
			case 190 :
				OriginalSource = s.ReadByteValue("OriginalSource");
				break;
			case 191 :
				OriginalType = s.ReadByteValue("OriginalType");
				break;
			case 192 :
				OriginalChequeNumber = s.ReadInt32Value("OriginalChequeNumber");
				break;
			case 193 :
				OriginalAmount = s.ReadMoneyValue("OriginalAmount");
				break;
			case 194 :
				Notes = s.ReadAnsiStringValue("Notes");
				break;
			case 195 :
				ECodingImportNotes = s.ReadAnsiStringValue("ECodingImportNotes");
				break;
			case 196 :
				ECodingTransactionUID = s.ReadInt32Value("ECodingTransactionUID");
				break;
			case 197 :
				GLNarration = s.ReadAnsiStringValue("GLNarration");
				break;
			case 198 :
				StatementDetails = s.ReadAnsiStringValue("StatementDetails");
				break;
			case 199 :
				TaxInvoiceAvailable = s.ReadBooleanValue("TaxInvoiceAvailable");
				break;
			case 200 :
				SFImputedCredit = s.ReadMoneyValue("SFImputedCredit");
				break;
			case 201 :
				SFTaxFreeDist = s.ReadMoneyValue("SFTaxFreeDist");
				break;
			case 202 :
				SFTaxExemptDist = s.ReadMoneyValue("SFTaxExemptDist");
				break;
			case 203 :
				SFTaxDeferredDist = s.ReadMoneyValue("SFTaxDeferredDist");
				break;
			case 204 :
				SFTFNCredits = s.ReadMoneyValue("SFTFNCredits");
				break;
			case 205 :
				SFForeignIncome = s.ReadMoneyValue("SFForeignIncome");
				break;
			case 206 :
				SFForeignTaxCredits = s.ReadMoneyValue("SFForeignTaxCredits");
				break;
			case 207 :
				SFCapitalGainsIndexed = s.ReadMoneyValue("SFCapitalGainsIndexed");
				break;
			case 208 :
				SFCapitalGainsDisc = s.ReadMoneyValue("SFCapitalGainsDisc");
				break;
			case 209 :
				SFSuperFieldsEdited = s.ReadBooleanValue("SFSuperFieldsEdited");
				break;
			case 210 :
				SFCapitalGainsOther = s.ReadMoneyValue("SFCapitalGainsOther");
				break;
			case 211 :
				SFOtherExpenses = s.ReadMoneyValue("SFOtherExpenses");
				break;
			case 212 :
				SFCGTDate = s.ReadInt32Value("SFCGTDate");
				break;
			case 213 :
				ExternalGUID = s.ReadAnsiStringValue("ExternalGUID");
				break;
			case 214 :
				DocumentTitle = s.ReadAnsiStringValue("DocumentTitle");
				break;
			case 215 :
				DocumentStatusUpdateRequired = s.ReadBooleanValue("DocumentStatusUpdateRequired");
				break;
			case 216 :
				BankLinkUID = s.ReadAnsiStringValue("BankLinkUID");
				break;
			case 217 :
				NotesRead = s.ReadBooleanValue("NotesRead");
				break;
			case 218 :
				ImportNotesRead = s.ReadBooleanValue("ImportNotesRead");
				break;
			case 219 :
				SpareString = s.ReadAnsiStringValue("SpareString");
				break;
			case 220 :
				SpareBoolean = s.ReadBooleanValue("SpareBoolean");
				break;
			case 221 :
				SFFranked = s.ReadMoneyValue("SFFranked");
				break;
			case 222 :
				SFUnfranked = s.ReadMoneyValue("SFUnfranked");
				break;
			case 223 :
				SFInterest = s.ReadMoneyValue("SFInterest");
				break;
			case 224 :
				SFCapitalGainsForeignDisc = s.ReadMoneyValue("SFCapitalGainsForeignDisc");
				break;
			case 225 :
				SFRent = s.ReadMoneyValue("SFRent");
				break;
			case 226 :
				SFSpecialIncome = s.ReadMoneyValue("SFSpecialIncome");
				break;
			case 227 :
				SFOtherTaxCredit = s.ReadMoneyValue("SFOtherTaxCredit");
				break;
			case 228 :
				SFNonResidentTax = s.ReadMoneyValue("SFNonResidentTax");
				break;
			case 229 :
				SFMemberID = s.ReadShortStringValue("SFMemberID");
				break;
			case 230 :
				SFForeignCapitalGainsCredit = s.ReadMoneyValue("SFForeignCapitalGainsCredit");
				break;
			case 231 :
				SFMemberComponent = s.ReadByteValue("SFMemberComponent");
				break;
			case 232 :
				SFFundID = s.ReadInt32Value("SFFundID");
				break;
			case 233 :
				SFMemberAccountID = s.ReadInt32Value("SFMemberAccountID");
				break;
			case 234 :
				SFFundCode = s.ReadShortStringValue("SFFundCode");
				break;
			case 235 :
				SFMemberAccountCode = s.ReadShortStringValue("SFMemberAccountCode");
				break;
			case 236 :
				SFTransactionID = s.ReadInt32Value("SFTransactionID");
				break;
			case 237 :
				SFTransactionCode = s.ReadAnsiStringValue("SFTransactionCode");
				break;
			case 238 :
				SFCapitalGainsFractionHalf = s.ReadBooleanValue("SFCapitalGainsFractionHalf");
				break;
			case 239 :
				AuditRecordID = s.ReadInt32Value("AuditRecordID");
				break;
			case 240 :
				JobCode = s.ReadShortStringValue("JobCode");
				break;
			case 242 :
				SpareMoney1 = s.ReadMoneyValue("SpareMoney1");
				break;
			case 244 :
				SpareMoney2 = s.ReadMoneyValue("SpareMoney2");
				break;
			case 245 :
				CoreTransactionID = s.ReadInt32Value("CoreTransactionID");
				break;
			case 246 :
				TransferedToOnline = s.ReadBooleanValue("TransferedToOnline");
				break;
			case 247 :
				CoreTransactionIDHigh = s.ReadInt32Value("CoreTransactionIDHigh");
				break;
			case 248 :
				IsOnlineTransaction = s.ReadBooleanValue("IsOnlineTransaction");
				break;
			case 249 :
				SuggestedMemState = s.ReadByteValue("SuggestedMemState");
				break;
			case 250 :
				SuggestedMemIndex = s.ReadInt32Value("SuggestedMemIndex");
				break;
			case BeginToken :
			case EndToken :
				break;
			default:
				throw new Exception(string.Format("unexpected Code: {0} reading Transaction",token) );
				}
			token = s.ReadToken();
			}
		}


	}


}


