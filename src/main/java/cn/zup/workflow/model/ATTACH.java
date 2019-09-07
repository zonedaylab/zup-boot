package cn.zup.workflow.model;

import java.util.Date;
	/// <summary>
	/// 实体类ATTACH 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class ATTACH
	{
		public ATTACH()
		{}
		private Integer ATTACH_ID;
		private Integer WORK_ITEM_ID;
		private String ACTIVITY_NAME;
		private String ATTACH_NAME;
		private String ATTACH_PATH;
		private String HANDLER_NAME;
		private Date UPLOAD_DATETIME;
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
		public void  setWORK_ITEM_ID(Integer WORK_ITEM_ID)
		{
			this.WORK_ITEM_ID=WORK_ITEM_ID;
		}
		public  Integer getWORK_ITEM_ID()
		{
			 return WORK_ITEM_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setACTIVITY_NAME(String ACTIVITY_NAME)
		{
			this.ACTIVITY_NAME=ACTIVITY_NAME;
		}
		public  String getACTIVITY_NAME()
		{
			 return ACTIVITY_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setATTACH_NAME(String ATTACH_NAME)
		{
			this.ATTACH_NAME=ATTACH_NAME;
		}
		public  String getATTACH_NAME()
		{
			 return ATTACH_NAME;
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
		public void  setHANDLER_NAME(String HANDLER_NAME)
		{
			this.HANDLER_NAME=HANDLER_NAME;
		}
		public  String getHANDLER_NAME()
		{
			 return HANDLER_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setUPLOAD_DATETIME(Date UPLOAD_DATETIME)
		{
			this.UPLOAD_DATETIME=UPLOAD_DATETIME;
		}
		public  Date getUPLOAD_DATETIME()
		{
			 return UPLOAD_DATETIME;
		}

	}


