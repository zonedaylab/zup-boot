package cn.zup.workflow.model;
	/// <summary>
	/// 实体类WF_ATTACH_AUTH 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WF_ATTACH_AUTH
	{
		public WF_ATTACH_AUTH()
		{}
		private Integer ACTIVITY_ID;
		private Integer ALLOT_ACTIVITY_ID;
		private Integer OPER_TYPE;
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
		public void  setALLOT_ACTIVITY_ID(Integer ALLOT_ACTIVITY_ID)
		{
			this.ALLOT_ACTIVITY_ID=ALLOT_ACTIVITY_ID;
		}
		public  Integer getALLOT_ACTIVITY_ID()
		{
			 return ALLOT_ACTIVITY_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setOPER_TYPE(Integer OPER_TYPE)
		{
			this.OPER_TYPE=OPER_TYPE;
		}
		public  Integer getOPER_TYPE()
		{
			 return OPER_TYPE;
		}

	}