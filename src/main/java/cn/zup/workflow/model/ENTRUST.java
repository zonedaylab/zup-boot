package cn.zup.workflow.model;

import java.sql.Date;
	/// <summary>
	/// 实体类ENTRUST 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class ENTRUST
	{
		public ENTRUST()
		{}
		private Integer ENTRUST_ID;
		private Integer ENTRUST_PEOPLE_ID;
		private String ENTRUST_PEOPLE_NAME;
		private Integer TRUST_PEOPLE_ID;
		private String TRUST_PEOPLE_NAME;
		private Date TIME;
		private Byte STATE;
		private String STATE_NAME;
		/// <summary>
		/// 
		/// </summary>
		public void  setENTRUST_ID(Integer ENTRUST_ID)
		{
			this.ENTRUST_ID=ENTRUST_ID;
		}
		public  Integer getENTRUST_ID()
		{
			 return ENTRUST_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setENTRUST_PEOPLE_ID(Integer ENTRUST_PEOPLE_ID)
		{
			this.ENTRUST_PEOPLE_ID=ENTRUST_PEOPLE_ID;
		}
		public  Integer getENTRUST_PEOPLE_ID()
		{
			 return ENTRUST_PEOPLE_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setENTRUST_PEOPLE_NAME(String ENTRUST_PEOPLE_NAME)
		{
			this.ENTRUST_PEOPLE_NAME=ENTRUST_PEOPLE_NAME;
		}
		public  String getENTRUST_PEOPLE_NAME()
		{
			 return ENTRUST_PEOPLE_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setTRUST_PEOPLE_ID(Integer TRUST_PEOPLE_ID)
		{
			this.TRUST_PEOPLE_ID=TRUST_PEOPLE_ID;
		}
		public  Integer getTRUST_PEOPLE_ID()
		{
			 return TRUST_PEOPLE_ID;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setTRUST_PEOPLE_NAME(String TRUST_PEOPLE_NAME)
		{
			this.TRUST_PEOPLE_NAME=TRUST_PEOPLE_NAME;
		}
		public  String getTRUST_PEOPLE_NAME()
		{
			 return TRUST_PEOPLE_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setTIME(Date TIME)
		{
			this.TIME=TIME;
		}
		public  Date getTIME()
		{
			 return TIME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSTATE(Byte STATE)
		{
			this.STATE=STATE;
		}
		public  Byte getSTATE()
		{
			 return STATE;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setSTATE_NAME(String STATE_NAME)
		{
			this.STATE_NAME=STATE_NAME;
		}
		public  String getSTATE_NAME()
		{
			 return STATE_NAME;
		}

	}
