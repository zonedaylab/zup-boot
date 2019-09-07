package cn.zup.workflow.model;
	/// <summary>
	/// 实体类BIZ_POST 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class BIZ_POST
	{
		public BIZ_POST()
		{}
		private int PostID;
		private int OrganID;
		private String PostName;
		private String PostDuty;
		private int StandardNumber;
		private byte ValidFlag;
		/// <summary>
		/// 
		/// </summary>
		public void  setPostID(int PostID)
		{
			this.PostID=PostID;
		}
		public  int getPostID()
		{
			 return PostID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setOrganID(int OrganID)
		{
			this.OrganID=OrganID;
		}
		public  int getOrganID()
		{
			 return OrganID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setPostName(String PostName)
		{
			this.PostName=PostName;
		}
		public  String getPostName()
		{
			 return PostName;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setPostDuty(String PostDuty)
		{
			this.PostDuty=PostDuty;
		}
		public  String getPostDuty()
		{
			 return PostDuty;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setStandardNumber(int StandardNumber)
		{
			this.StandardNumber=StandardNumber;
		}
		public  int getStandardNumber()
		{
			 return StandardNumber;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setValidFlag(byte ValidFlag)
		{
			this.ValidFlag=ValidFlag;
		}
		public  byte getValidFlag()
		{
			 return ValidFlag;
		}

	}

