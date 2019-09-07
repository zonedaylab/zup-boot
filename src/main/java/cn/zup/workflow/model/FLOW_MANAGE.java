package cn.zup.workflow.model;
	/// <summary>
	/// 实体类FLOW_MANAGE 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class FLOW_MANAGE
	{
		public FLOW_MANAGE()
		{}
		private Integer FLOW_ID;
		private Integer SYSTEM_ID;
		private String FLOW_NAME;
		private String FLOW_TYPE;
		private Byte FLOW_STATE;
		private String FLOW_STATE_NAME;
		private String SYSTEM_NAME;
		public String getSYSTEM_NAME() {
			return SYSTEM_NAME;
		}
		public void setSYSTEM_NAME(String sYSTEMNAME) {
			SYSTEM_NAME = sYSTEMNAME;
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
		public void  setFLOW_NAME(String FLOW_NAME)
		{
			this.FLOW_NAME=FLOW_NAME;
		}
		public  String getFLOW_NAME()
		{
			 return FLOW_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setFLOW_TYPE(String FLOW_TYPE)
		{
			this.FLOW_TYPE=FLOW_TYPE;
		}
		public  String getFLOW_TYPE()
		{
			 return FLOW_TYPE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setFLOW_STATE(Byte FLOW_STATE)
		{
			this.FLOW_STATE=FLOW_STATE;
		}
		public  Byte getFLOW_STATE()
		{
			 return FLOW_STATE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setFLOW_STATE_NAME(String FLOW_STATE_NAME)
		{
			this.FLOW_STATE_NAME=FLOW_STATE_NAME;
		}
		public  String getFLOW_STATE_NAME()
		{
			 return FLOW_STATE_NAME;
		}

	}

