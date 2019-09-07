package cn.zup.workflow.structure;
import java.io.Serializable;

import cn.zup.rbac.entity.UserSession;


public class FlowParameter implements Serializable
{
	/** 
	 流程ID
	 
	*/
	private int privateFlowID;
	public final int getFlowID()
	{
		return privateFlowID;
	}
	public final void setFlowID(int value)
	{
		privateFlowID = value;
	}


	/** 
	 业务主键
	 
	*/
	private String privateMainBizKey;
	public final String getMainBizKey()
	{
		return privateMainBizKey;
	}
	public final void setMainBizKey(String value)
	{
		privateMainBizKey = value;
	}


	/** 
	 工作ID
	 
	*/
	private int privateWorkID;
	public final int getWorkID()
	{
		return privateWorkID;
	}
	public final void setWorkID(int value)
	{
		privateWorkID = value;
	}


	/** 
	 活动ID
	 
	*/
	private int privateActivityID;
	public final int getActivityID()
	{
		return privateActivityID;
	}
	public final void setActivityID(int value)
	{
		privateActivityID = value;
	}


	/** 
	 工作名称
	 
	*/
	private String privateWorkName;
	public final String getWorkName()
	{
		return privateWorkName;
	}
	public final void setWorkName(String value)
	{
		privateWorkName = value;
	}


	/** 
	 操作者信息
	 
	*/
	private UserSession privateCurrentHandler;
	public final UserSession getCurrentHandler()
	{
		return privateCurrentHandler;
	}
	public final void setCurrentHandler(UserSession value)
	{
		privateCurrentHandler = value;
	}

	/** 
	 签字信息
	 
	*/
	private cn.zup.workflow.structure.SignInfo privateSignInfo;
	public final  cn.zup.workflow.structure.SignInfo  getSignInfo()
	{
		return privateSignInfo;
	}
	public final void setSignInfo( cn.zup.workflow.structure.SignInfo  value)
	{
		privateSignInfo = value.clone();
	}

	/** 
	 活动操作者列表
	 
	*/
	private java.util.List< cn.zup.workflow.structure.ActivityHandler> privateActivityHandlerList;
	public final java.util.List< cn.zup.workflow.structure.ActivityHandler> getActivityHandlerList()
	{
		return privateActivityHandlerList;
	}
	public final void setActivityHandlerList(java.util.List< cn.zup.workflow.structure.ActivityHandler> value)
	{
		privateActivityHandlerList = value;
	}

	/** 
	 附件列表
	 
	*/
	private java.util.ArrayList<Integer> privateAttachList;
	public final java.util.ArrayList<Integer> getAttachList()
	{
		return privateAttachList;
	}
	public final void setAttachList(java.util.ArrayList<Integer> value)
	{
		privateAttachList = value;
	}
}
