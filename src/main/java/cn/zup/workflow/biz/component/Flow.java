package cn.zup.workflow.biz.component;

public class Flow{
	/** 
	 流程数据操作
	*/	
	
	//实体
	private cn.zup.workflow.model.WF_FLOW flowModel = new cn.zup.workflow.model.WF_FLOW();
	/** 
	 流程数据信息
	 
	*/
	protected cn.zup.workflow.model.WF_FLOW getFlowModel()
	{
		return flowModel;
	}
	protected void setFlowModel(cn.zup.workflow.model.WF_FLOW value)
	{
		flowModel = value;
	}

	private Activity firstActivity;
	/** 
	 第一个节点（开始节点）
	 
	*/
	protected Activity getFirstActivity()
	{
		return firstActivity;
	}
	protected void setFirstActivity(Activity value)
	{
		firstActivity = value;
	}
}
