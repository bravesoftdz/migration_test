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
	/// BK - MemorisationDetail class
	/// </summary>
	public partial class BKMemorisationDetail 
	{


		/// <summary>
		/// SequenceNo property
		/// </summary>
		[XmlAttribute("SequenceNo", DataType = "int")]
		public Int32 SequenceNo { get; set; }



		/// <summary>
		/// Type property
		/// </summary>
		[XmlAttribute("Type", DataType = "unsignedByte")]
		public byte Type { get; set; }



		/// <summary>
		/// Amount property
		/// </summary>
		[XmlAttribute("Amount", DataType = "long")]
		public Int64 Amount { get; set; }



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
		/// OtherParty property
		/// </summary>
		[XmlAttribute("OtherParty", DataType = "string")]
		public String OtherParty { get; set; }



		/// <summary>
		/// StatementDetails property
		/// </summary>
		[XmlAttribute("StatementDetails", DataType = "string")]
		public String StatementDetails { get; set; }



		/// <summary>
		/// MatchonAmount property
		/// </summary>
		[XmlAttribute("MatchonAmount", DataType = "unsignedByte")]
		public byte MatchonAmount { get; set; }



		/// <summary>
		/// MatchonAnalysis property
		/// </summary>
		[XmlAttribute("MatchonAnalysis", DataType = "boolean")]
		public bool MatchonAnalysis { get; set; }



		/// <summary>
		/// MatchonOtherParty property
		/// </summary>
		[XmlAttribute("MatchonOtherParty", DataType = "boolean")]
		public bool MatchonOtherParty { get; set; }



		/// <summary>
		/// MatchonNotes property
		/// </summary>
		[XmlAttribute("MatchonNotes", DataType = "boolean")]
		public bool MatchonNotes { get; set; }



		/// <summary>
		/// MatchonParticulars property
		/// </summary>
		[XmlAttribute("MatchonParticulars", DataType = "boolean")]
		public bool MatchonParticulars { get; set; }



		/// <summary>
		/// MatchonRefce property
		/// </summary>
		[XmlAttribute("MatchonRefce", DataType = "boolean")]
		public bool MatchonRefce { get; set; }



		/// <summary>
		/// MatchOnStatementDetails property
		/// </summary>
		[XmlAttribute("MatchOnStatementDetails", DataType = "boolean")]
		public bool MatchOnStatementDetails { get; set; }



		/// <summary>
		/// PayeeNumber property
		/// </summary>
		[XmlAttribute("PayeeNumber", DataType = "int")]
		public Int32 PayeeNumber { get; set; }



		/// <summary>
		/// FromMasterList property
		/// </summary>
		[XmlAttribute("FromMasterList", DataType = "boolean")]
		public bool FromMasterList { get; set; }



		/// <summary>
		/// Notes property
		/// </summary>
		[XmlAttribute("Notes", DataType = "string")]
		public String Notes { get; set; }



		/// <summary>
		/// DateLastApplied property
		/// </summary>
		[XmlAttribute("DateLastApplied", DataType = "int")]
		public Int32 DateLastApplied { get; set; }



		/// <summary>
		/// UseAccountingSystem property
		/// </summary>
		[XmlAttribute("UseAccountingSystem", DataType = "boolean")]
		public bool UseAccountingSystem { get; set; }



		/// <summary>
		/// AccountingSystem property
		/// </summary>
		[XmlAttribute("AccountingSystem", DataType = "unsignedByte")]
		public byte AccountingSystem { get; set; }



		/// <summary>
		/// FromDate property
		/// </summary>
		[XmlAttribute("FromDate", DataType = "int")]
		public Int32 FromDate { get; set; }



		/// <summary>
		/// UntilDate property
		/// </summary>
		[XmlAttribute("UntilDate", DataType = "int")]
		public Int32 UntilDate { get; set; }



		/// <summary>
		/// AuditRecordID property
		/// </summary>
		[XmlAttribute("AuditRecordID", DataType = "int")]
		public Int32 AuditRecordID { get; set; }


		/// <summary>
		/// Class Begin Token
		/// </summary>
		public const byte BeginToken = 140;
		/// <summary>
		/// Class End Token
		/// </summary>
		public const byte EndToken = 141;
		/// <summary>
		/// Write to BKStream
		/// </summary>
		public void WriteBKStream(BankLinkTokenStreamWriter s)
		{
			s.WriteToken(140);
			s.WriteInt32Value(142, SequenceNo);
			s.WriteByteValue(143, Type);
			s.WriteMoneyValue(144, Amount);
			s.WriteShortStringValue(145, Reference);
			s.WriteShortStringValue(146, Particulars);
			s.WriteShortStringValue(147, Analysis);
			s.WriteShortStringValue(148, OtherParty);
			s.WriteShortStringValue(149, StatementDetails);
			s.WriteByteValue(150, MatchonAmount);
			s.WriteBooleanValue(151, MatchonAnalysis);
			s.WriteBooleanValue(152, MatchonOtherParty);
			s.WriteBooleanValue(153, MatchonNotes);
			s.WriteBooleanValue(154, MatchonParticulars);
			s.WriteBooleanValue(155, MatchonRefce);
			s.WriteBooleanValue(156, MatchOnStatementDetails);
			s.WriteInt32Value(157, PayeeNumber);
			s.WriteBooleanValue(158, FromMasterList);
			s.WriteShortStringValue(159, Notes);
			s.WriteInt32Value(160, DateLastApplied);
			s.WriteBooleanValue(161, UseAccountingSystem);
			s.WriteByteValue(162, AccountingSystem);
			s.WriteJulDateValue(163, FromDate);
			s.WriteJulDateValue(164, UntilDate);
			s.WriteInt32Value(165, AuditRecordID);
			s.WriteToken(141);
		}

		/// <summary>
		/// Default Constructor 
		/// </summary>
		public BKMemorisationDetail ()
		{}
		/// <summary>
		/// Construct from BKStreamReader
		/// </summary>
		public BKMemorisationDetail (BankLinkTokenStreamReader s)
		{
			var token = BeginToken;
			while (token != EndToken)
			{
				switch (token)
				{
			case 142 :
				SequenceNo = s.ReadInt32Value("SequenceNo");
				break;
			case 143 :
				Type = s.ReadByteValue("Type");
				break;
			case 144 :
				Amount = s.ReadMoneyValue("Amount");
				break;
			case 145 :
				Reference = s.ReadShortStringValue("Reference");
				break;
			case 146 :
				Particulars = s.ReadShortStringValue("Particulars");
				break;
			case 147 :
				Analysis = s.ReadShortStringValue("Analysis");
				break;
			case 148 :
				OtherParty = s.ReadShortStringValue("OtherParty");
				break;
			case 149 :
				StatementDetails = s.ReadShortStringValue("StatementDetails");
				break;
			case 150 :
				MatchonAmount = s.ReadByteValue("MatchonAmount");
				break;
			case 151 :
				MatchonAnalysis = s.ReadBooleanValue("MatchonAnalysis");
				break;
			case 152 :
				MatchonOtherParty = s.ReadBooleanValue("MatchonOtherParty");
				break;
			case 153 :
				MatchonNotes = s.ReadBooleanValue("MatchonNotes");
				break;
			case 154 :
				MatchonParticulars = s.ReadBooleanValue("MatchonParticulars");
				break;
			case 155 :
				MatchonRefce = s.ReadBooleanValue("MatchonRefce");
				break;
			case 156 :
				MatchOnStatementDetails = s.ReadBooleanValue("MatchOnStatementDetails");
				break;
			case 157 :
				PayeeNumber = s.ReadInt32Value("PayeeNumber");
				break;
			case 158 :
				FromMasterList = s.ReadBooleanValue("FromMasterList");
				break;
			case 159 :
				Notes = s.ReadShortStringValue("Notes");
				break;
			case 160 :
				DateLastApplied = s.ReadInt32Value("DateLastApplied");
				break;
			case 161 :
				UseAccountingSystem = s.ReadBooleanValue("UseAccountingSystem");
				break;
			case 162 :
				AccountingSystem = s.ReadByteValue("AccountingSystem");
				break;
			case 163 :
				FromDate = s.ReadJulDateValue("FromDate");
				break;
			case 164 :
				UntilDate = s.ReadJulDateValue("UntilDate");
				break;
			case 165 :
				AuditRecordID = s.ReadInt32Value("AuditRecordID");
				break;
			case BeginToken :
			case EndToken :
				break;
			default:
				throw new Exception(string.Format("unexpected Code: {0} reading MemorisationDetail",token) );
				}
			token = s.ReadToken();
			}
		}


	}


}


