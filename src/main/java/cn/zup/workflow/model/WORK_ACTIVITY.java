package cn.zup.workflow.model;

import java.util.Date;
	/// <summary>
	/// 实体类WORK_ACTIVITY 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WORK_ACTIVITY
	{
		public WORK_ACTIVITY()
		{}
		private Integer FLOW_ID;
		private Integer WORK_ACTIVITY_ID;
		private Integer WORK_ID;
		private Date FINISHED_DATETIME;
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
		public void  setFINISHED_DATETIME(Date FINISHED_DATETIME)
		{
			this.FINISHED_DATETIME=FINISHED_DATETIME;
		}
		public  Date getFINISHED_DATETIME()
		{
			 return FINISHED_DATETIME;
		}

	}

