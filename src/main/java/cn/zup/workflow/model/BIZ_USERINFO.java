package cn.zup.workflow.model;
	/// <summary>
	/// 实体类BIZ_USERINFO 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class BIZ_USERINFO
	{
		public BIZ_USERINFO()
		{}
		private int UserID;
		private int OrganID;
		private int PostID;
		private String RealName;
		/// <summary>
		/// 
		/// </summary>
		public void  setUserID(int UserID)
		{
			this.UserID=UserID;
		}
		public  int getUserID()
		{
			 return UserID;
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
		public void  setRealName(String RealName)
		{
			this.RealName=RealName;
		}
		public  String getRealName()
		{
			 return RealName;
		}

	}

