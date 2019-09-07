package cn.zup.workflow.biz.component;

import cn.zup.workflow.dal.WF_WORK_ACTIVITY;
import cn.zup.workflow.structure.ActivityHandler;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("workActivityService")
public class WorkActivityService{
	// 工作活动数据操作
	@Autowired
	private WF_WORK_ACTIVITY workActivityDal;	
	//当前工作活动工作项（实例包括工作项列表）
	@Autowired
	private WorkItemService workItemService;	
	@Autowired
	private ActivityService wfActivityService;
	/** 
	 构造函数,获取工作的对应活动的工作活动
	 @param workID 工作ID
	 @param activityID 活动ID
	*/
	
	public WorkActivity getWorkActivity(int workID, int activityID, java.util.List<cn.zup.workflow.model.WF_HANDLER> currentHandlerList, 
			java.util.List<ActivityHandler> nextActivitiesHandler,cn.zup.workflow.structure.SignInfo signInfo,java.util.List<Integer> attachList) throws SQLException
	{
		WorkActivity workActivity =new WorkActivity();
		
		workActivity.setActivity(wfActivityService.getActivity(activityID, true));		
		workActivity.setSignInfo(signInfo);	
	
		workActivity.setNextActivitiesHandler(nextActivitiesHandler);
		workActivity.setWorkActivityModel( workActivityDal.GetModel(workID, activityID));
		
		//若没有工作活动或没有正常结束的则新建  
		if (workActivity.getWorkActivityModel() == null || 
				workActivity.getWorkActivityModel().getWORK_ACTIVITY_STATE() == 
					cn.zup.workflow.config.WorkActivityState.Reject.getValue()) //若没有正在办理的工作活动则新建
		{
			//WorkActivityInit	 实体		
			cn.zup.workflow.model.WF_WORK_ACTIVITY workActivityModel = new cn.zup.workflow.model.WF_WORK_ACTIVITY();
			workActivityModel.setWORK_ID(workID);
			workActivityModel.setACTIVITY_ID(activityID);
			java.util.Date curDate = new java.util.Date();
			java.sql.Date date=new java.sql.Date(curDate.getTime());
			workActivityModel.setCREATE_DATETIME(date);
			workActivityModel.setPRE_ACTIVITY_INFO("");
			workActivityModel.setWORK_ACTIVITY_STATE(cn.zup.workflow.config.WorkActivityState.InProgress.getValue());
			int workActivityID = workActivityDal.add(workActivityModel);
			workActivityModel.setWORK_ACTIVITY_ID(workActivityID); //缓存工作活动iD
			workActivity.setWorkActivityModel(workActivityModel);
		}
		//驳回新建
		else if (workActivity.getWorkActivityModel().getWORK_ACTIVITY_STATE() == cn.zup.workflow.config.WorkActivityState.NormalEnd.getValue())
		{
			throw new RuntimeException("当前经办人工作已经完成，请勿重复提交！"+"workID=["+workID+"]ActivityID=["+activityID+"]");
		}			
		
		int workActivityID = workActivity.getWorkActivityModel().getWORK_ACTIVITY_ID();
		int reviewType = workActivity.getActivity().getActivityModel().getREVIEW_TYPE();		
		WorkItem workItem=workItemService.getWorkItem(
				 workActivityID, currentHandlerList, signInfo.clone(), reviewType);
		workActivity.setWorkItem(workItem);
		return workActivity;
	}
	/** 
	 保存工作节点
	 * @throws Exception 
	 
	*/
	public void WorkActivitySave(WorkActivity workActivity) throws Exception
	{		
		workItemService.WorkItemSave(workActivity.getWorkItem());
	}

	/** 
	 提交工作节点
	 * @throws Exception 
	 
	*/
	public void WorkActivityCommit(WorkActivity workActivity) throws Exception
	{
		
		//更新工作项		
		boolean commitFlag = workItemService.WorkItemCommit(workActivity.getWorkItem());
		//更新工作活动
		if (commitFlag) //如果该工作活动下的工作项全部通过，则更新活动为完成
		{
			String nextActHandler="";
			String nextActCodes="";
			for (ActivityHandler act : workActivity.getNextActivitiesHandler())
			{
				for (cn.zup.workflow.model.WF_HANDLER handler : act.getHanderList())
					nextActHandler+="," + handler.getHANDLER();//下一活动经办者					
				//下一活动序号
				nextActCodes+= "," + act.getActivityCode();
			}
			if (!cn.zup.workflow.util.StringHelper.isNullOrEmpty(nextActCodes))
			{
				workActivity.getWorkActivityModel().setNEXT_ACTIVITY_HANDLERS(nextActHandler.substring(1)); //下一活动经办人,去掉逗号
				workActivity.getWorkActivityModel().setNEXT_ACTIVITY_CODES(nextActCodes.substring(1)); //实际选择的下一活动序号，去掉逗号
			}
			workActivity.getWorkActivityModel().setWORK_ACTIVITY_STATE(cn.zup.workflow.config.WorkActivityState.NormalEnd.getValue());
			
			java.util.Date curDate = new java.util.Date();
			java.sql.Date date=new java.sql.Date(curDate.getTime());
			workActivity.getWorkActivityModel().setFINISHED_DATETIME(date);
			workActivityDal.Update(workActivity.getWorkActivityModel());
		}
		else //否则，返回，不继续提交下一工作
		{
			return;
		}

		//开始提交下一工作
		if (workActivity.getNextActivitiesHandler().size() > 0) //选择了经办人
		{
			for (ActivityHandler next : workActivity.getNextActivitiesHandler()) //遍历生成
			{
				NextActivityInit(workActivity,next.getActivityID(), next.getActivityCode(), next.getHanderList());
			}
		}
		else //没选择经办人则采用默认
		{			
			for (Activity next : workActivity.getActivity().getNextActivities())
			{
				NextActivityInit(workActivity,next.getActivityModel().getACTIVITY_ID(), (int)next.getActivityModel().getACTIVITY_CODE(), next.getHandler());
			}
		}
	}
	/** 
	 初始化下个活动和工作项
	 
	 @param activityID 活动ID
	 @param handlerList 活动经办人列表
	 * @throws Exception 
	*/
	private void NextActivityInit(WorkActivity workActivity,int activityID, int activityCode, java.util.List<cn.zup.workflow.model.WF_HANDLER> handlerList) throws Exception{
		boolean finishedCheck = workActivityDal.PreAcitvityList(
				workActivity.getActivity().getActivityModel().getFLOW_ID(), 
				workActivity.getWorkActivityModel().getWORK_ID(), activityCode);
		if (finishedCheck){ //若有未完成的工作活动，则不再进行提交该活动
			this.getWorkActivity(workActivity.getWorkActivityModel().getWORK_ID(), activityID, handlerList, new java.util.ArrayList<ActivityHandler>(), new cn.zup.workflow.structure.SignInfo(),new ArrayList<Integer>());
		}
	}
}













