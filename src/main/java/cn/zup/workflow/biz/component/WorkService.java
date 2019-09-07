package cn.zup.workflow.biz.component;
import cn.zup.workflow.dal.WF_WORK;
import cn.zup.workflow.model.WF_HANDLER;
import cn.zup.workflow.util.StringHelper;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("workService")
public class WorkService{
	public WorkService(){};
	/**
	 * 工作数据操作
	 */
	@Autowired
	private WF_WORK workDal;
	
	@Autowired
	private WorkActivityService workActivityService;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_MSG wfWorkMsg;
	
	/**
	 * 保存工作
	 * @throws Exception 
	 */
	public void WorkSave( Work work) throws Exception {	
		try {
			init(work);
			workActivityService.WorkActivitySave(work.getCurrentWorkActivity());
		}catch (RuntimeException ex) {
			throw new RuntimeException(ex.getMessage());
		}
	
	}
	/**
	 * 提交工作
	 * @throws Exception 
	 */
	public void WorkCommit(Work work) throws Exception {
		try {
			init(work);			
			workActivityService.WorkActivityCommit(work.getCurrentWorkActivity());
			// 生成通知
			Flow m_flow=work.getM_flow();
			if( m_flow.getFirstActivity().getActivityModel().getACTIVITY_TYPE()==cn.zup.workflow.config.WorkActivityState.NormalEnd.getValue()){
				wfWorkMsg.WorkMsgSave(work.getCurrentWorkActivity().getWorkActivityModel().getWORK_ACTIVITY_ID(),								
					 m_flow.getFirstActivity().getActivityModel().getACTIVITY_ID(),
					work.getWorkName(),
					 m_flow.getFirstActivity().getActivityModel().getACTIVITY_NAME()								
				);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new RuntimeException(ex.getMessage());
		} 
	}
	private void init(Work work) throws Exception{	
		
			cn.zup.workflow.model.WF_WORK workModel=null;			
			if(work.getWorkID()!=0)
				workModel = workDal.GetModel(work.getWorkID()); // 初始化实例
			else if(work.getMainBizKey()!="" && !work.getMainBizKey().isEmpty()){
				workModel= workDal.GetModel(work.getMainBizKey(),work.getFlowID());	
				if (workModel != null) work.setWorkID(workModel.getWORK_ID());				
			}		
			
			if (workModel != null){ // 若没有工作则新建工作	
			
				if (!StringHelper.isNullOrEmpty(work.getWorkName()))
					workModel.setWORK_NAME(work.getWorkName()); // 替换为最新的工作名
				else
					work.setWorkName(workModel.getWORK_NAME());
				workDal.Update(workModel);				
			}	
			else
				WorkNew(work);				
			//实体
			List<cn.zup.workflow.model.WF_HANDLER> currentHandlerList = new ArrayList<cn.zup.workflow.model.WF_HANDLER>();
			cn.zup.workflow.model.WF_HANDLER handlerItem = new cn.zup.workflow.model.WF_HANDLER();  //实体
			handlerItem.setHANDLER_TYPE(cn.zup.workflow.config.HandlerAndMonitorType.User.getValue());
			handlerItem.setHANDLER(work.getCurrentHandler().getUserId());
			handlerItem.setHANDLER_NAME(work.getCurrentHandler().getRealName());
			currentHandlerList.add(handlerItem);
			WorkActivity currentWorkActivity=
				workActivityService.getWorkActivity(work.getWorkID(),
					work.getActivityID(), currentHandlerList,work.getNextActivitiesHandler() ,
					work.getSignInfo().clone(),work.getAttachList() ); // 初始化当前节点信息,准备保存
			work.setCurrentWorkActivity(currentWorkActivity);
	}
	
	
	private void WorkNew(Work work) throws Exception {
		// /#region 获取开始节点信息及真实操作者信息
		cn.zup.workflow.model.WF_HANDLER sponsor =null;
		Integer handlerUserID = null;
		List<WF_HANDLER> listHandler=  work.getM_flow().getFirstActivity().getHandler();
		if(listHandler.size()==0)
			throw new Exception("创建新工作时发现发起人为空");		
		cn.zup.workflow.config.HandlerAndMonitorType monitorType=cn.zup.workflow.config.HandlerAndMonitorType.forValue(listHandler.get(0).getHANDLER_TYPE());
		switch (monitorType) {
		case User:			 
			handlerUserID = work.getCurrentHandler().getUserId();
			break;
		case Position:
			handlerUserID = work.getCurrentHandler().getPostId();
			break;
		case Department:
			handlerUserID = work.getCurrentHandler().getOrganId();
			break;
		default:
			break;
		}
		if(handlerUserID==null)
			throw new RuntimeException("该操作者没有对应的用户（岗位/部门）！");
			
		for (cn.zup.workflow.model.WF_HANDLER item : listHandler) {
			if (item.getHANDLER() == handlerUserID) {
				sponsor = item;
				break;
			}
		}
		if (sponsor == null) {
			throw new RuntimeException("该操作者不在经办人队列，不允许发起工作！");
		}
		// 保存工作  （实体）
		cn.zup.workflow.model.WF_WORK workModel=new cn.zup.workflow.model.WF_WORK();
		workModel.setFLOW_ID(work.getFlowID());
		workModel.setMAIN_BIZ_KEY(work.getMainBizKey());
		workModel.setWORK_NAME(work.getWorkName());
		workModel.setWORK_STATE((byte) cn.zup.workflow.config.WorkState.InProgress.getValue());
		workModel.setSPONSOR_ID(sponsor.getHANDLER_ID());
		workModel.setSPONSOR_NAME(work.getCurrentHandler().getRealName());
		workModel.setPARENT_WORK_ID(work.getParentWorkID());
		workModel.setPARENT_ACTIVITY_ID(work.getParentActivityID());
		java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
		workModel.setCREATE_DATETIME(currentDate);
		int workID = workDal.add(workModel);
		
		int activityID=work.getM_flow().getFirstActivity().getActivityModel().getACTIVITY_ID();
		work.setActivityID(activityID);
		work.setWorkID(workID);
		
	}
	
}
