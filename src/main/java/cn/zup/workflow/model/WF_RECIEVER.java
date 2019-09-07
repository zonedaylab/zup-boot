package cn.zup.workflow.model;
	/// <summary>
	/// 实体类WF_RECIEVER 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WF_RECIEVER
	{
		public WF_RECIEVER()
		{}
		private Integer RECIEVER_ID;
		private String ACTIVITY_ID;
		private Integer RECIEVER;
		private Integer RECIEVER_TYPE;
		/// <summary>
		/// 
		/// </summary>
		public void  setRECIEVER_ID(Integer RECIEVER_ID)
		{
			this.RECIEVER_ID=RECIEVER_ID;
		}
		public  Integer getRECIEVER_ID()
		{
			 return RECIEVER_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setACTIVITY_ID(String ACTIVITY_ID)
		{
			this.ACTIVITY_ID=ACTIVITY_ID;
		}
		public  String getACTIVITY_ID()
		{
			 return ACTIVITY_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECIEVER(Integer RECIEVER)
		{
			this.RECIEVER=RECIEVER;
		}
		public  Integer getRECIEVER()
		{
			 return RECIEVER;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setRECIEVER_TYPE(Integer RECIEVER_TYPE)
		{
			this.RECIEVER_TYPE=RECIEVER_TYPE;
		}
		public  Integer getRECIEVER_TYPE()
		{
			 return RECIEVER_TYPE;
		}

	}

