package cn.zup.workflow.biz.component;


public class Activity{

	/** 
	 活动数据信息
	 
	*/
	private cn.zup.workflow.model.WF_ACTIVITY activityModel;
	public  cn.zup.workflow.model.WF_ACTIVITY getActivityModel(){
		return activityModel;
	}
	public  void setActivityModel(cn.zup.workflow.model.WF_ACTIVITY value){
		activityModel = value;
	}

	private java.util.ArrayList<cn.zup.workflow.model.WF_HANDLER> handler;
	/** 
	 活动经办人
	 
	*/
	public  java.util.ArrayList<cn.zup.workflow.model.WF_HANDLER> getHandler(){
		return handler;
	}
	public  void setHandler(java.util.ArrayList<cn.zup.workflow.model.WF_HANDLER> value){
		handler = value;
	}

	private java.util.ArrayList<Activity> nextActivities = new java.util.ArrayList<Activity>(); //初始化下一活动列表
	/** 
	 下步活动列表
	 
	*/
	public  java.util.ArrayList<Activity> getNextActivities(){
		return nextActivities;
	}
	public  void setNextActivities(java.util.ArrayList<Activity> value){
		nextActivities = value;
	}

}
