package cn.zup.workflow.model;

import java.util.Date;
	/// <summary>
	/// 实体类WORK_SIGN 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class WORK_SIGN
	{
		public WORK_SIGN()
		{}
		private String ACTIVITY_NAME;
		private String SIGN_NAME;
		private Date SIGN_DATE;
		private String SIGN_OPINION;
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
		public void  setSIGN_DATE(Date SIGN_DATE)
		{
			this.SIGN_DATE=SIGN_DATE;
		}
		public  Date getSIGN_DATE()
		{
			 return SIGN_DATE;
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

	}

