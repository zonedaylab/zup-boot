package cn.zup.workflow.model;

import java.util.Date;
	/// <summary>
	/// 实体类WORK_MSG 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WORK_MSG
	{
		public WORK_MSG()
		{}
		private Integer WORK_MSG_ID;
		private Integer WORK_ACTIVITY_ID;
		private Integer RECEIVER_TYPE;
		private Integer RECEIVER_ID;
		private String RECEIVER_NAME;
		private String SEND_CONTENT;
		private Date SEND_DATE;
		private Date RECEIVER_DATE;
		private Integer RECEIVER_FLAG;
		private String RECEIVER_FLAG_NAME;
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_MSG_ID(Integer WORK_MSG_ID)
		{
			this.WORK_MSG_ID=WORK_MSG_ID;
		}
		public  Integer getWORK_MSG_ID()
		{
			 return WORK_MSG_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setWORK_ACTIVITY_ID(Integer WORK_ACTIVITY_ID)
		{
			this.WORK_ACTIVITY_ID=WORK_ACTIVITY_ID;
		}
		public  Integer getWORK_ACTIVITY_ID()
		{
			 return WORK_ACTIVITY_ID;
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
		public void  setSEND_CONTENT(String SEND_CONTENT)
		{
			this.SEND_CONTENT=SEND_CONTENT;
		}
		public  String getSEND_CONTENT()
		{
			 return SEND_CONTENT;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSEND_DATE(Date SEND_DATE)
		{
			this.SEND_DATE=SEND_DATE;
		}
		public  Date getSEND_DATE()
		{
			 return SEND_DATE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECEIVER_DATE(Date RECEIVER_DATE)
		{
			this.RECEIVER_DATE=RECEIVER_DATE;
		}
		public  Date getRECEIVER_DATE()
		{
			 return RECEIVER_DATE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECEIVER_FLAG(Integer RECEIVER_FLAG)
		{
			this.RECEIVER_FLAG=RECEIVER_FLAG;
		}
		public  Integer getRECEIVER_FLAG()
		{
			 return RECEIVER_FLAG;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECEIVER_FLAG_NAME(String RECEIVER_FLAG_NAME)
		{
			this.RECEIVER_FLAG_NAME=RECEIVER_FLAG_NAME;
		}
		public  String getRECEIVER_FLAG_NAME()
		{
			 return RECEIVER_FLAG_NAME;
		}

	}

