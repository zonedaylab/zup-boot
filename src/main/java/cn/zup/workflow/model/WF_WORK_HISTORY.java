package cn.zup.workflow.model;
import java.sql.Date;


public class WF_WORK_HISTORY
{
	public WF_WORK_HISTORY()
	{}
	private Integer WORK_ITEM_ID;
	private Integer ACTIVITY_ID;
	private String ACTIVITY_NAME;
	private Integer HANDLER_ID;
	private Integer HANDLER;
	private String SIGN_OPINION;
	private Date CREATE_DATETIME;
	private String FINISHED_DATETIME;
	private String WORK_ITEM_STATE;
	/// <summary>
	/// 
	/// </summary>
	public void  setWORK_ITEM_ID(Integer WORK_ITEM_ID)
	{
		this.WORK_ITEM_ID=WORK_ITEM_ID;
	}
	public  Integer getWORK_ITEM_ID()
	{
		 return WORK_ITEM_ID;
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
	public void  setSIGN_OPINION(String SIGN_OPINION)
	{
		this.SIGN_OPINION=SIGN_OPINION;
	}
	public  String getSIGN_OPINION()
	{
		 return SIGN_OPINION;
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
	public void  setFINISHED_DATETIME(String FINISHED_DATETIME)
	{
		this.FINISHED_DATETIME=FINISHED_DATETIME;
	}
	public  String getFINISHED_DATETIME()
	{
		 return FINISHED_DATETIME;
	}
	/// <summary>
	/// 
	/// </summary>
	public void  setWORK_ITEM_STATE(String WORK_ITEM_STATE)
	{
		this.WORK_ITEM_STATE=WORK_ITEM_STATE;
	}
	public  String getWORK_ITEM_STATE()
	{
		 return WORK_ITEM_STATE;
	}

}
