package cn.zup.workflow.model;

import java.sql.Date;



/// <summary>
/// ʵ����WF_WORK_INIT ��(����˵���Զ���ȡ��ݿ��ֶε�������Ϣ)
/// </summary>
public class WF_WORK_INIT
{
	public WF_WORK_INIT()
	{}
	private Integer WORK_ID;
	private String MAIN_BIZ_KEY;
	private String WORK_NAME;
	private Integer WORK_STATE;
	private String WORK_STATE_NAME;
	private Integer HANDLER_ID;
	private Date CREATE_DATETIME;
	private Integer FLOW_ID;
	private Integer HANDLER;
	private Integer HANDLER_TYPE;
	private String FLOW_NAME;
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
	public void  setMAIN_BIZ_KEY(String MAIN_BIZ_KEY)
	{
		this.MAIN_BIZ_KEY=MAIN_BIZ_KEY;
	}
	public  String getMAIN_BIZ_KEY()
	{
		 return MAIN_BIZ_KEY;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setWORK_NAME(String WORK_NAME)
	{
		this.WORK_NAME=WORK_NAME;
	}
	public  String getWORK_NAME()
	{
		 return WORK_NAME;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setWORK_STATE(Integer WORK_STATE)
	{
		this.WORK_STATE=WORK_STATE;
	}
	public  Integer getWORK_STATE()
	{
		 return WORK_STATE;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setWORK_STATE_NAME(String WORK_STATE_NAME)
	{
		this.WORK_STATE_NAME=WORK_STATE_NAME;
	}
	public  String getWORK_STATE_NAME()
	{
		 return WORK_STATE_NAME;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setHANDLER_ID(Integer HANDLER_ID)
	{
		this.HANDLER_ID=HANDLER_ID;
	}
	public  Integer getHANDLER_ID()
	{
		 return HANDLER_ID;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setCREATE_DATETIME(Date CREATE_DATETIME)
	{
		this.CREATE_DATETIME=CREATE_DATETIME;
	}
	public  Date getCREATE_DATETIME()
	{
		 return CREATE_DATETIME;
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
	public void  setHANDLER(Integer HANDLER)
	{
		this.HANDLER=HANDLER;
	}
	public  Integer getHANDLER()
	{
		 return HANDLER;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setHANDLER_TYPE(Integer HANDLER_TYPE)
	{
		this.HANDLER_TYPE=HANDLER_TYPE;
	}
	public  Integer getHANDLER_TYPE()
	{
		 return HANDLER_TYPE;
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

}
