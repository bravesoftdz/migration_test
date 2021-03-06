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
	/// BK - JobHeading class
	/// </summary>
	public partial class BKJobHeading 
	{


		/// <summary>
		/// Heading property
		/// </summary>
		[XmlAttribute("Heading", DataType = "string")]
		public String Heading { get; set; }



		/// <summary>
		/// LRN property
		/// </summary>
		[XmlAttribute("LRN", DataType = "int")]
		public Int32 LRN { get; set; }



		/// <summary>
		/// DateCompleted property
		/// </summary>
		[XmlAttribute("DateCompleted", DataType = "int")]
		public Int32 DateCompleted { get; set; }



		/// <summary>
		/// Code property
		/// </summary>
		[XmlAttribute("Code", DataType = "string")]
		public String Code { get; set; }



		/// <summary>
		/// AuditRecordID property
		/// </summary>
		[XmlAttribute("AuditRecordID", DataType = "int")]
		public Int32 AuditRecordID { get; set; }


		/// <summary>
		/// Class Begin Token
		/// </summary>
		public const byte BeginToken = 210;
		/// <summary>
		/// Class End Token
		/// </summary>
		public const byte EndToken = 211;
		/// <summary>
		/// Write to BKStream
		/// </summary>
		public void WriteBKStream(BankLinkTokenStreamWriter s)
		{
			s.WriteToken(210);
			s.WriteShortStringValue(212, Heading);
			s.WriteInt32Value(213, LRN);
			s.WriteJulDateValue(214, DateCompleted);
			s.WriteShortStringValue(215, Code);
			s.WriteInt32Value(216, AuditRecordID);
			s.WriteToken(211);
		}

		/// <summary>
		/// Default Constructor 
		/// </summary>
		public BKJobHeading ()
		{}
		/// <summary>
		/// Construct from BKStreamReader
		/// </summary>
		public BKJobHeading (BankLinkTokenStreamReader s)
		{
			var token = BeginToken;
			while (token != EndToken)
			{
				switch (token)
				{
			case 212 :
				Heading = s.ReadShortStringValue("Heading");
				break;
			case 213 :
				LRN = s.ReadInt32Value("LRN");
				break;
			case 214 :
				DateCompleted = s.ReadJulDateValue("DateCompleted");
				break;
			case 215 :
				Code = s.ReadShortStringValue("Code");
				break;
			case 216 :
				AuditRecordID = s.ReadInt32Value("AuditRecordID");
				break;
			case BeginToken :
			case EndToken :
				break;
			default:
				throw new Exception(string.Format("unexpected Code: {0} reading JobHeading",token) );
				}
			token = s.ReadToken();
			}
		}


	}


}


