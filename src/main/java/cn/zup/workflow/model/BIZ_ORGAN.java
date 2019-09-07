package cn.zup.workflow.model;
	/// <summary>
	/// 实体类BIZ_ORGAN 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class BIZ_ORGAN
	{
		public BIZ_ORGAN()
		{}
		private int OrganID;
		private int ParentOrganID;
		private String OrganCode;
		private String OrganName;
		private String ShortName;
		private int OrderCode;
		private byte OrganType;
		private String Governor;
		private byte ValidFlag;
		private int IsParent;
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
		public void  setParentOrganID(int ParentOrganID)
		{
			this.ParentOrganID=ParentOrganID;
		}
		public  int getParentOrganID()
		{
			 return ParentOrganID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setOrganCode(String OrganCode)
		{
			this.OrganCode=OrganCode;
		}
		public  String getOrganCode()
		{
			 return OrganCode;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setOrganName(String OrganName)
		{
			this.OrganName=OrganName;
		}
		public  String getOrganName()
		{
			 return OrganName;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setShortName(String ShortName)
		{
			this.ShortName=ShortName;
		}
		public  String getShortName()
		{
			 return ShortName;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setOrderCode(int OrderCode)
		{
			this.OrderCode=OrderCode;
		}
		public  int getOrderCode()
		{
			 return OrderCode;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setOrganType(byte OrganType)
		{
			this.OrganType=OrganType;
		}
		public  byte getOrganType()
		{
			 return OrganType;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setGovernor(String Governor)
		{
			this.Governor=Governor;
		}
		public  String getGovernor()
		{
			 return Governor;
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
		/// <summary>
		/// 
		/// </summary>
		public void  setIsParent(int IsParent)
		{
			this.IsParent=IsParent;
		}
		public  int getIsParent()
		{
			 return IsParent;
		}

	}

