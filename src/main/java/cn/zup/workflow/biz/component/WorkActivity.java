package cn.zup.workflow.biz.component;
import java.util.List;

import cn.zup.workflow.structure.ActivityHandler;
public class WorkActivity{


	private Activity activity;
	public Activity getActivity() {
		return activity;
	}
	public void setActivity(Activity activity) {
		this.activity = activity;
	}
	public java.util.List<ActivityHandler> getNextActivitiesHandler() {
		return nextActivitiesHandler;
	}
	public void setNextActivitiesHandler(
			java.util.List<ActivityHandler> nextActivitiesHandler) {
		this.nextActivitiesHandler = nextActivitiesHandler;
	}
	public cn.zup.workflow.structure.SignInfo getSignInfo() {
		return signInfo;
	}
	public void setSignInfo(cn.zup.workflow.structure.SignInfo signInfo) {
		this.signInfo = signInfo;
	}
	
	//当前工作活动工作项（实例包括工作项列表）
	WorkItem workItem;

	

	public WorkItem getWorkItem() {
		return workItem;
	}
	public void setWorkItem(WorkItem workItem) {
		this.workItem = workItem;
	}

	// 工作活动数据信息  实体
	private cn.zup.workflow.model.WF_WORK_ACTIVITY workActivityModel;
	
	
	public cn.zup.workflow.model.WF_WORK_ACTIVITY getWorkActivityModel() {
		return workActivityModel;
	}
	public void setWorkActivityModel(
			cn.zup.workflow.model.WF_WORK_ACTIVITY workActivityModel) {
		this.workActivityModel = workActivityModel;
	}
		 
	//下步工作活动
	private java.util.List<ActivityHandler> nextActivitiesHandler;
	cn.zup.workflow.structure.SignInfo signInfo;
	

	
}
