package cn.zup.workflow.model;
	/// <summary>
	/// 实体类WF_ATTACH_MODIFY 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WF_ATTACH_MODIFY
	{
		public WF_ATTACH_MODIFY()
		{}
		private Integer ATTACH_ID;
		private Integer USER_ID;
		private String ATTACH_PATH;
		private Integer UPLOAD_ID;
		/// <summary>
		/// 
		/// </summary>
		public void  setATTACH_ID(Integer ATTACH_ID)
		{
			this.ATTACH_ID=ATTACH_ID;
		}
		public  Integer getATTACH_ID()
		{
			 return ATTACH_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setUSER_ID(Integer USER_ID)
		{
			this.USER_ID=USER_ID;
		}
		public  Integer getUSER_ID()
		{
			 return USER_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setATTACH_PATH(String ATTACH_PATH)
		{
			this.ATTACH_PATH=ATTACH_PATH;
		}
		public  String getATTACH_PATH()
		{
			 return ATTACH_PATH;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setUPLOAD_ID(Integer UPLOAD_ID)
		{
			this.UPLOAD_ID=UPLOAD_ID;
		}
		public  Integer getUPLOAD_ID()
		{
			 return UPLOAD_ID;
		}

	}

