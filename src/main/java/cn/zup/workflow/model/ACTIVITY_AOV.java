package cn.zup.workflow.model;


	/// <summary>
	/// 实体类ACTIVITY_AOV 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>



	public class ACTIVITY_AOV
	{
		public ACTIVITY_AOV()
		{}
		private Integer FLOW_ID;
		private Integer ACTIVITY_ID;
		private Integer ACTIVITY_CODE;
		private Integer ACTIVITY_PROPERTY;
		private Integer ACTIVITY_TYPE;
		private Integer NEXT_ACTIVITY_CODE;
		private Integer REJECT_ACTIVITY_CODE;
		private String REAL_NEXT_ACTIVITY_CODES;
		private String REAL_NEXT_HANDLERS;
		private Integer WORK_ACTIVITY_ID;
		private Integer FINISH_FLAG;
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
		public void  setACTIVITY_PROPERTY(Integer ACTIVITY_PROPERTY)
		{
			this.ACTIVITY_PROPERTY=ACTIVITY_PROPERTY;
		}
		public  Integer getACTIVITY_PROPERTY()
		{
			 return ACTIVITY_PROPERTY;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setACTIVITY_TYPE(Integer ACTIVITY_TYPE)
		{
			this.ACTIVITY_TYPE=ACTIVITY_TYPE;
		}
		public  Integer getACTIVITY_TYPE()
		{
			 return ACTIVITY_TYPE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setNEXT_ACTIVITY_CODE(Integer NEXT_ACTIVITY_CODE)
		{
			this.NEXT_ACTIVITY_CODE=NEXT_ACTIVITY_CODE;
		}
		public  Integer getNEXT_ACTIVITY_CODE()
		{
			 return NEXT_ACTIVITY_CODE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setREJECT_ACTIVITY_CODE(Integer REJECT_ACTIVITY_CODE)
		{
			this.REJECT_ACTIVITY_CODE=REJECT_ACTIVITY_CODE;
		}
		public  Integer getREJECT_ACTIVITY_CODE()
		{
			 return REJECT_ACTIVITY_CODE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setREAL_NEXT_ACTIVITY_CODES(String REAL_NEXT_ACTIVITY_CODES)
		{
			this.REAL_NEXT_ACTIVITY_CODES=REAL_NEXT_ACTIVITY_CODES;
		}
		public  String getREAL_NEXT_ACTIVITY_CODES()
		{
			 return REAL_NEXT_ACTIVITY_CODES;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setREAL_NEXT_HANDLERS(String REAL_NEXT_HANDLERS)
		{
			this.REAL_NEXT_HANDLERS=REAL_NEXT_HANDLERS;
		}
		public  String getREAL_NEXT_HANDLERS()
		{
			 return REAL_NEXT_HANDLERS;
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
		public void  setFINISH_FLAG(Integer FINISH_FLAG)
		{
			this.FINISH_FLAG=FINISH_FLAG;
		}
		public  Integer getFINISH_FLAG()
		{
			 return FINISH_FLAG;
		}

	}

