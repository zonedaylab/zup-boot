package cn.zup.workflow.model;

import java.util.Date;
	/// <summary>
	/// 实体类WORK_MONITOR 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WORK_MONITOR
	{
		public WORK_MONITOR()
		{}
		private Integer WORK_ID;
		private String MAIN_BIZ_KEY;
		private String WORK_NAME;
		private Integer WORK_STATE;
		private String WORK_STATE_NAME;
		private Integer SPONSOR_ID;
		private String SPONSOR_NAME;
		private Date CREATE_DATETIME;
		private Integer FLOW_ID;
		private String FLOW_NAME;
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_ID(Integer WORK_ID)
		{
			this.WORK_ID=WORK_ID;
		}
		public  Integer getWORK_ID()
		{
			 return WORK_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setMAIN_BIZ_KEY(String MAIN_BIZ_KEY)
		{
			this.MAIN_BIZ_KEY=MAIN_BIZ_KEY;
		}
		public  String getMAIN_BIZ_KEY()
		{
			 return MAIN_BIZ_KEY;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_NAME(String WORK_NAME)
		{
			this.WORK_NAME=WORK_NAME;
		}
		public  String getWORK_NAME()
		{
			 return WORK_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_STATE(Integer WORK_STATE)
		{
			this.WORK_STATE=WORK_STATE;
		}
		public  Integer getWORK_STATE()
		{
			 return WORK_STATE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_STATE_NAME(String WORK_STATE_NAME)
		{
			this.WORK_STATE_NAME=WORK_STATE_NAME;
		}
		public  String getWORK_STATE_NAME()
		{
			 return WORK_STATE_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSPONSOR_ID(Integer SPONSOR_ID)
		{
			this.SPONSOR_ID=SPONSOR_ID;
		}
		public  Integer getSPONSOR_ID()
		{
			 return SPONSOR_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSPONSOR_NAME(String SPONSOR_NAME)
		{
			this.SPONSOR_NAME=SPONSOR_NAME;
		}
		public  String getSPONSOR_NAME()
		{
			 return SPONSOR_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCREATE_DATETIME(Date CREATE_DATETIME)
		{
			this.CREATE_DATETIME=CREATE_DATETIME;
		}
		public  Date getCREATE_DATETIME()
		{
			 return CREATE_DATETIME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setFLOW_ID(Integer FLOW_ID)
		{
			this.FLOW_ID=FLOW_ID;
		}
		public  Integer getFLOW_ID()
		{
			 return FLOW_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setFLOW_NAME(String FLOW_NAME)
		{
			this.FLOW_NAME=FLOW_NAME;
		}
		public  String getFLOW_NAME()
		{
			 return FLOW_NAME;
		}

	}

