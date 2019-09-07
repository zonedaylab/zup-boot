package cn.zup.workflow.model;

import java.util.Date;




	/// <summary>
	/// ʵ����WF_WORK_DEALT ��(����˵���Զ���ȡ��ݿ��ֶε�������Ϣ)
	/// </summary>
	
	public class WF_WORK_DEALT
	{
		public WF_WORK_DEALT()
		{}
		private Integer HANDLER_ID;
		private Integer WORK_ITEM_ID;
		private String MAIN_BIZ_KEY;
		private Integer ACTIVITY_ID;
		private Integer ACTIVITY_CODE;
		private Integer WORK_STATE;
		private String WORK_NAME;
		private Integer SYSTEM_ID;
		private String ACTIVITY_NAME;
		private Integer HANDLER;
		private Integer HANDLER_TYPE;
		private Date WORK_ITEM_DATETIME;
		private String PRE_ACTIVITYINFO;
		private String WORK_STATE_NAME;
		/// <summary>
		/// 
		/// </summary>
		public void  setHANDLER_ID(Integer HANDLER_ID)
		{
			this.HANDLER_ID=HANDLER_ID;
		}
		public  Integer getHANDLER_ID()
		{
			 return HANDLER_ID;
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
		public void  setACTIVITY_ID(Integer ACTIVITY_ID)
		{
			this.ACTIVITY_ID=ACTIVITY_ID;
		}
		public  Integer getACTIVITY_ID()
		{
			 return ACTIVITY_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setACTIVITY_CODE(Integer ACTIVITY_CODE)
		{
			this.ACTIVITY_CODE=ACTIVITY_CODE;
		}
		public  Integer getACTIVITY_CODE()
		{
			 return ACTIVITY_CODE;
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
		public void  setSYSTEM_ID(Integer SYSTEM_ID)
		{
			this.SYSTEM_ID=SYSTEM_ID;
		}
		public  Integer getSYSTEM_ID()
		{
			 return SYSTEM_ID;
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
		public void  setHANDLER(Integer HANDLER)
		{
			this.HANDLER=HANDLER;
		}
		public  Integer getHANDLER()
		{
			 return HANDLER;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setHANDLER_TYPE(Integer HANDLER_TYPE)
		{
			this.HANDLER_TYPE=HANDLER_TYPE;
		}
		public  Integer getHANDLER_TYPE()
		{
			 return HANDLER_TYPE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_ITEM_DATETIME(Date WORK_ITEM_DATETIME)
		{
			this.WORK_ITEM_DATETIME=WORK_ITEM_DATETIME;
		}
		public  Date getWORK_ITEM_DATETIME()
		{
			 return WORK_ITEM_DATETIME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setPRE_ACTIVITYINFO(String PRE_ACTIVITYINFO)
		{
			this.PRE_ACTIVITYINFO=PRE_ACTIVITYINFO;
		}
		public  String getPRE_ACTIVITYINFO()
		{
			 return PRE_ACTIVITYINFO;
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
	
	}

