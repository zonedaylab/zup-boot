package cn.zup.workflow.structure;
import java.io.Serializable;

public final class QueryParameter implements Serializable
{
	/** 
	 系统ID
	 
	*/
	private Integer privateSystemID;
	public Integer getSystemID()
	{
		return privateSystemID;
	}
	public void setSystemID(Integer value)
	{
		privateSystemID = value;
	}
	/** 
	 流程名称
	 
	*/
	private String privateFlowName;
	public String getFlowName()
	{
		return privateFlowName;
	}
	public void setFlowName(String value)
	{
		privateFlowName = value;
	}

	/** 
	 流程状态	 
	*/
	private int privateFlowState;
	public int getFlowState()
	{
		return privateFlowState;
	}
	public void setFlowState(int value)
	{
		privateFlowState = value;
	}
	/** 
	 工作名称
	 
	*/
	private String privateWorkName;
	public String getWorkName()
	{
		return privateWorkName;
	}
	public void setWorkName(String value)
	{
		privateWorkName = value;
	}
	/** 
	 活动名称	 
	*/
	private String privateActivityName;
	public String getActivityName()
	{
		return privateActivityName;
	}
	public void setActivityName(String value)
	{
		privateActivityName = value;
	}

	/** 
	 发起人
	 
	*/
	private String privateSponsorName;
	public String getSponsorName()
	{
		return privateSponsorName;
	}
	public void setSponsorName(String value)
	{
		privateSponsorName = value;
	}

	/** 
	 接收者
	 
	*/
	private String privateReceiverName;
	public String getReceiverName()
	{
		return privateReceiverName;
	}
	public void setReceiverName(String value)
	{
		privateReceiverName = value;
	}

	/** 
	 经办人
	 
	*/
	private String privateResponsibleName;
	public String getResponsibleName()
	{
		return privateResponsibleName;
	}
	public void setResponsibleName(String value)
	{
		privateResponsibleName = value;
	}

	/** 
	 起始时间
	 
	*/
	private String privateFromDate;
	public String getFromDate()
	{
		return privateFromDate;
	}
	public void setFromDate(String value)
	{
		privateFromDate = value;
	}

	/** 
	 目标时间
	 
	*/
	private String privateToDate;
	public String getToDate()
	{
		return privateToDate;
	}
	public void setToDate(String value)
	{
		privateToDate = value;
	}

	/** 
	 工作状态
	 
	*/
	private int privateWorkState;
	public int getWorkState()
	{
		return privateWorkState;
	}
	public void setWorkState(int value)
	{
		privateWorkState = value;
	}

	/** 
	 接收标志
	 
	*/
	private Integer privateReceiverFlag;
	public Integer getReceiverFlag()
	{
		return privateReceiverFlag;
	}
	public void setReceiverFlag(Integer value)
	{
		privateReceiverFlag = value;
	}

	/** 
	 委托人
	 
	*/
	private String privateEntrustPeople;
	public String getEntrustPeople()
	{
		return privateEntrustPeople;
	}
	public void setEntrustPeople(String value)
	{
		privateEntrustPeople = value;
	}

	/** 
	 受委托人
	 
	*/
	private String privateTrustPeople;
	public String getTrustPeople()
	{
		return privateTrustPeople;
	}
	public void setTrustPeople(String value)
	{
		privateTrustPeople = value;
	}

	/** 
	 委托状态
	 
	*/
	private Integer privateEntrustState;
	public Integer getEntrustState()
	{
		return privateEntrustState;
	}
	public void setEntrustState(Integer value)
	{
		privateEntrustState = value;
	}
}
