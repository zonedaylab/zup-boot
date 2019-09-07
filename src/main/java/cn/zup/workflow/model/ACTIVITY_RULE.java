package cn.zup.workflow.model;
	/// <summary>
	/// 实体类ACTIVITY_RULE 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class ACTIVITY_RULE
	{
		public ACTIVITY_RULE()
		{}
		private Integer RULE_ID;
		private Integer ACTIVITY_ID;
		private Integer GOTO_ACTIVITY;
		private Integer GOTO_ACTIVITY_CODE;
		private String GOTO_ACTIVITY_NAME;
		private Integer CONTROL_ID;
		private String CONTROL_NAME;
		private String CONTROL_TEXT;
		private Integer CONDITIONS;
		private String CONDITIONS_NAME;
		private String JUDGE_BASIS;
		/// <summary>
		/// 
		/// </summary>
		public void  setRULE_ID(Integer RULE_ID)
		{
			this.RULE_ID=RULE_ID;
		}
		public  Integer getRULE_ID()
		{
			 return RULE_ID;
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
		public void  setGOTO_ACTIVITY(Integer GOTO_ACTIVITY)
		{
			this.GOTO_ACTIVITY=GOTO_ACTIVITY;
		}
		public  Integer getGOTO_ACTIVITY()
		{
			 return GOTO_ACTIVITY;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setGOTO_ACTIVITY_CODE(Integer GOTO_ACTIVITY_CODE)
		{
			this.GOTO_ACTIVITY_CODE=GOTO_ACTIVITY_CODE;
		}
		public  Integer getGOTO_ACTIVITY_CODE()
		{
			 return GOTO_ACTIVITY_CODE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setGOTO_ACTIVITY_NAME(String GOTO_ACTIVITY_NAME)
		{
			this.GOTO_ACTIVITY_NAME=GOTO_ACTIVITY_NAME;
		}
		public  String getGOTO_ACTIVITY_NAME()
		{
			 return GOTO_ACTIVITY_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCONTROL_ID(Integer CONTROL_ID)
		{
			this.CONTROL_ID=CONTROL_ID;
		}
		public  Integer getCONTROL_ID()
		{
			 return CONTROL_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCONTROL_NAME(String CONTROL_NAME)
		{
			this.CONTROL_NAME=CONTROL_NAME;
		}
		public  String getCONTROL_NAME()
		{
			 return CONTROL_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCONTROL_TEXT(String CONTROL_TEXT)
		{
			this.CONTROL_TEXT=CONTROL_TEXT;
		}
		public  String getCONTROL_TEXT()
		{
			 return CONTROL_TEXT;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCONDITIONS(Integer CONDITIONS)
		{
			this.CONDITIONS=CONDITIONS;
		}
		public  Integer getCONDITIONS()
		{
			 return CONDITIONS;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCONDITIONS_NAME(String CONDITIONS_NAME)
		{
			this.CONDITIONS_NAME=CONDITIONS_NAME;
		}
		public  String getCONDITIONS_NAME()
		{
			 return CONDITIONS_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setJUDGE_BASIS(String JUDGE_BASIS)
		{
			this.JUDGE_BASIS=JUDGE_BASIS;
		}
		public  String getJUDGE_BASIS()
		{
			 return JUDGE_BASIS;
		}

	}

