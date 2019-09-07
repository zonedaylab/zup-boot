package cn.zup.workflow.model;

import java.util.Date;
	/// <summary>
	/// 实体类WORK_HISTORY 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WORK_HISTORY
	{
		public WORK_HISTORY()
		{}
		private Integer WORK_ITEM_ID;
		private Integer ACTIVITY_ID;
		private String ACTIVITY_NAME;
		private Integer RECEIVER_TYPE;
		private Integer RECEIVER_ID;
		private String RECEIVER_NAME;
		private Integer RESPONSIBLE_ID;
		private String SIGN_NAME;
		private String SIGN_OPINION;
		private Date CREATE_DATETIME;
		private Date FINISHED_DATETIME;
		private Integer WORK_ITEM_STATE;
		private String WORK_ITEM_STATE_NAME;
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
		public void  setRECEIVER_TYPE(Integer RECEIVER_TYPE)
		{
			this.RECEIVER_TYPE=RECEIVER_TYPE;
		}
		public  Integer getRECEIVER_TYPE()
		{
			 return RECEIVER_TYPE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECEIVER_ID(Integer RECEIVER_ID)
		{
			this.RECEIVER_ID=RECEIVER_ID;
		}
		public  Integer getRECEIVER_ID()
		{
			 return RECEIVER_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECEIVER_NAME(String RECEIVER_NAME)
		{
			this.RECEIVER_NAME=RECEIVER_NAME;
		}
		public  String getRECEIVER_NAME()
		{
			 return RECEIVER_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRESPONSIBLE_ID(Integer RESPONSIBLE_ID)
		{
			this.RESPONSIBLE_ID=RESPONSIBLE_ID;
		}
		public  Integer getRESPONSIBLE_ID()
		{
			 return RESPONSIBLE_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSIGN_NAME(String SIGN_NAME)
		{
			this.SIGN_NAME=SIGN_NAME;
		}
		public  String getSIGN_NAME()
		{
			 return SIGN_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSIGN_OPINION(String SIGN_OPINION)
		{
			this.SIGN_OPINION=SIGN_OPINION;
		}
		public  String getSIGN_OPINION()
		{
			 return SIGN_OPINION;
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
		public void  setFINISHED_DATETIME(Date FINISHED_DATETIME)
		{
			this.FINISHED_DATETIME=FINISHED_DATETIME;
		}
		public  Date getFINISHED_DATETIME()
		{
			 return FINISHED_DATETIME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_ITEM_STATE(Integer WORK_ITEM_STATE)
		{
			this.WORK_ITEM_STATE=WORK_ITEM_STATE;
		}
		public  Integer getWORK_ITEM_STATE()
		{
			 return WORK_ITEM_STATE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_ITEM_STATE_NAME(String WORK_ITEM_STATE_NAME)
		{
			this.WORK_ITEM_STATE_NAME=WORK_ITEM_STATE_NAME;
		}
		public  String getWORK_ITEM_STATE_NAME()
		{
			 return WORK_ITEM_STATE_NAME;
		}

	}

