package cn.zup.workflow.biz.component;

import cn.zup.workflow.dal.WF_ACTIVITY;
import cn.zup.workflow.dal.WF_HANDLER;
import cn.zup.workflow.util.StringHelper;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("wfActivityService")
public class ActivityService{
	/** 
	 活动数据操作
	 
	*/
	@Autowired
	private WF_ACTIVITY activityDal;

	/** 
	 活动经办者操作
	 
	*/
	@Autowired
	private WF_HANDLER handlerDal;


	/** 
	 无参构造函数
	 
	*/
	public ActivityService(){}

	/** 
	 根据流程id初始化
	 
	 @param flowID
	*/
	public Activity getActivityFlow(int flowID) throws SQLException
	{
		//当前节点为开始节点		
		cn.zup.workflow.model.WF_ACTIVITY wfActivityModel=activityDal.FirstActivityInfo(flowID);
		if(wfActivityModel==null)		
			throw new RuntimeException("流程[ID="+flowID+"]没有配置开始节点！");		
		int firstCode = wfActivityModel.getACTIVITY_CODE();
		if (firstCode == 0)
		{
			throw new RuntimeException("该流程没有配置开始节点！");
		}
		Activity thisActivity = new Activity();
		//Todo:此处逻辑不清晰，需要重写! liuxf
		NextActivityList(thisActivity, flowID, firstCode); //获取下个活动信息
		//重载第一个空节点
		if (thisActivity.getNextActivities().size() > 0)
		{
			thisActivity.setActivityModel(thisActivity.getNextActivities().get(0).getActivityModel());
			thisActivity.setHandler(thisActivity.getNextActivities().get(0).getHandler());
			thisActivity.setNextActivities(thisActivity.getNextActivities().get(0).getNextActivities());
		}
		return thisActivity;
	}

	/** 
	 受保护的构造函数
	 
	 @param acitivityID 活动ID
	 @param activityFlag 活动标识（仅与flowID的构造函数区分开）
	*/
	public Activity getActivity(int acitivityID, boolean activityFlag) throws SQLException
	{
		Activity thisActivity = new Activity();
		thisActivity.setActivityModel(activityDal.GetModel(acitivityID));
		//获取活动经办人列表
		thisActivity.setHandler((ArrayList<cn.zup.workflow.model.WF_HANDLER>) handlerDal.ActivityHandlerList(acitivityID)); 
		NextActivityList(thisActivity, thisActivity.getActivityModel().getFLOW_ID(), (int)thisActivity.getActivityModel().getACTIVITY_CODE()); //获取下个活动信息
		
		//重载第一个空节点
		if (thisActivity.getNextActivities().size() > 0)
		{
			thisActivity.setActivityModel(thisActivity.getNextActivities().get(0).getActivityModel());
			thisActivity.setHandler(thisActivity.getNextActivities().get(0).getHandler());
			thisActivity.setNextActivities(thisActivity.getNextActivities().get(0).getNextActivities());
		}
		return thisActivity;
	}

	/** 
	 获取全部的后续节点
	 
	 @param preActivity
	 @param flowID
	 @param activityCode 
	*/
	private void NextActivityList(Activity preActivity, int flowID, int activityCode) throws SQLException
	{
		Activity thisActivity = new Activity();
		thisActivity.setActivityModel(activityDal.GetModel(flowID, activityCode)); //获取活动信息
		if (thisActivity == null)
		{
			throw new RuntimeException("流程没有配置编号为：" + activityCode + "的节点");
		}
		thisActivity.setHandler((ArrayList<cn.zup.workflow.model.WF_HANDLER>) handlerDal.ActivityHandlerList(thisActivity.getActivityModel().getACTIVITY_ID())); //获取活动经办人列表
		//开始获取下一活动
		if(!StringHelper.isNullOrEmpty(thisActivity.getActivityModel().getNEXT_ACTIVITY_CODE()))
		{			
			String[] nextActivityCodeArray = thisActivity.getActivityModel().getNEXT_ACTIVITY_CODE().split(",", -1);
			for (String nextActivityCode : nextActivityCodeArray)
			{
				if(StringHelper.isNullOrEmpty(nextActivityCode))
				{
					continue;
				}
				NextActivityList(thisActivity, flowID, Integer.parseInt(nextActivityCode)); //获取下个活动信息
			}
		}
		preActivity.getNextActivities().add(thisActivity); //把当前活动加入前一活动的后续活动列表中
	}
	private void NextActivityList(Activity preActivity, int flowID) throws SQLException
	{							
		//开始获取下一活动
		List<Activity> listActivity=new ArrayList<Activity>(); 
		if(!StringHelper.isNullOrEmpty(preActivity.getActivityModel().getNEXT_ACTIVITY_CODE()))
		{			
			String[] nextActivityCodeArray = preActivity.getActivityModel().getNEXT_ACTIVITY_CODE().split(",", -1);
			for (String nextActivityCode : nextActivityCodeArray)
			{
				if(StringHelper.isNullOrEmpty(nextActivityCode))
					continue;
				Activity thisActivity = new Activity();
				thisActivity.setActivityModel(activityDal.GetModel(flowID, Integer.parseInt(nextActivityCode))); //获取活动信息			
				thisActivity.setHandler((ArrayList<cn.zup.workflow.model.WF_HANDLER>) handlerDal.ActivityHandlerList(thisActivity.getActivityModel().getACTIVITY_ID())); //获取活动经办人列表
				NextActivityList(thisActivity, flowID); //获取下个活动信息
				listActivity.add(thisActivity);
			}
		}
		preActivity.getNextActivities().addAll(listActivity); //把当前活动加入前一活动的后续活动列表中
	}
}