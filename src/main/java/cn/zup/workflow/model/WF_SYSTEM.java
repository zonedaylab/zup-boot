package cn.zup.workflow.model;

import java.sql.Date;

	/// <summary>
	/// WF_SYSTEM 
	/// </summary>
	public class WF_SYSTEM
	{
		public WF_SYSTEM()
		{}
		private Integer SYSTEM_ID;
		private String SYSTEM_NAME;
		private Date CREATE_DATE;
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
		public void  setSYSTEM_NAME(String SYSTEM_NAME)
		{
			this.SYSTEM_NAME=SYSTEM_NAME;
		}
		public  String getSYSTEM_NAME()
		{
			 return SYSTEM_NAME;
		}
		/// <summary>
		/// 
		/// </summary>
		public void  setCREATE_DATE(Date CREATE_DATE)
		{
			this.CREATE_DATE=CREATE_DATE;
		}
		public  Date getCREATE_DATE()
		{
			 return CREATE_DATE;
		}

	}
