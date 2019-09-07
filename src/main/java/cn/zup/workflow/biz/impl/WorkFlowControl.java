package cn.zup.workflow.biz.impl;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.biz.IWorkFlowControl;
import cn.zup.workflow.biz.component.*;
import cn.zup.workflow.config.*;
import cn.zup.workflow.model.WF_WORK;
import cn.zup.workflow.structure.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


/** 
 工作流控制服务接口实现类
 
*/
@Repository("controler")
public class WorkFlowControl implements IWorkFlowControl{
	@Autowired
	private cn.zup.workflow.dal.WF_WORK workDal;
	@Autowired
	private cn.zup.workflow.dal.WF_ACTIVITY activityDal;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_ACTIVITY workActivityDal;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_ITEM item;
	@Autowired
	private cn.zup.workflow.dal.WF_ATTACH attachDal;
	@Autowired
	private cn.zup.workflow.dal.WF_LOG logDal;
	@Autowired
	private WorkService workService;
	@Autowired
	private WorkActivityService workActivityService;

	@Autowired
	private FlowService flowService;
	/** 
	 工作暂停
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	//1
	public  boolean updateWorkPause(int workID) throws SQLException{
		try{
			workDal.WorkPause(workID);
			return true;
		}catch (RuntimeException ex){
			logDal.LogAdd(ex);
			return false;
		}
	}
	/** 	 	
	 重启暂停工作	 
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	//2
	public  boolean updateWorkRelaunch(int workID) throws SQLException{
		try{
			workDal.WorkRelaunch(workID);
			return true;
		}catch (RuntimeException ex){
			logDal.LogAdd(ex);
			return false;
		}
	}

	/** 
	  发起修改流程 
	 @param oriFlowID 原流程ID
	 @param oriMainBizKey 原业务主键
	 @param flowID 流程ID
	 @param mainBizKey 业务主键
	 @param signOpinion 签字意见
	 @param workName 工作名称
	 * @throws Exception 
	*/
	//3
	public  void updateWorkRedo(int oriFlowID, String oriMainBizKey, int flowID, String mainBizKey, SignInfo signOpinion, String workName) throws Exception{
		List<cn.zup.workflow.model.WF_WORK> workList = workDal.WorkList(flowID, mainBizKey); //获取相同业务主键未完成的工作
		boolean bInprogress=false;
		for (cn.zup.workflow.model.WF_WORK item :workList){
			if(item.getWORK_STATE()==WorkState.InProgress.getValue()){
				bInprogress=true;
				break;
			}
		}			
		if(bInprogress==false){
			try{
				int workID = 0;
				//1-获取原流程工作的操作者
				cn.zup.workflow.model.WF_WORK workModal=workDal.WorkList(oriFlowID, oriMainBizKey).get(0); //获取原工作信息
				UserSession tempVar = new UserSession();
				tempVar.setUserId( workModal.getSPONSOR_ID());
				tempVar.setRealName(workModal.getSPONSOR_NAME());
				UserSession currentHandler = tempVar;
				//2-初始工作并保存
				Work work=new Work(flowID, workID, 0, mainBizKey, workName, 
						currentHandler, signOpinion,null, null, 0, 0, flowService.getFlow(flowID));	
				workService.WorkSave(work);
			}catch (RuntimeException ex){
				logDal.LogAdd(ex);
				throw new RuntimeException("创建流程失败：" + ex.getMessage());
			}
		}else if (workName.equals(workList.get(0).getWORK_NAME())){
			throw new RuntimeException("已经发起过修改流程，不允许再次发起");
		}else{
			throw new RuntimeException("该流程下有未结束的工作，不允许修改");
		}
	}

	/** 
	 强制终止工作，返回true工作强制结束成功
	 @param workID 工作ID
	*/
	//4
	public  boolean updateWorkTerminate(int workID){
		try{
			workDal.WorkTerminate(workID); //强制结束工作流程信息
			return true;
		}catch (java.lang.Exception e){
			return false;
		}
	}

	/** 
	 工作保存
	 @param flowID 流程ID
	 @param mainBizkey 业务主键
	 @param workID 工作ID，发起节点传参为0
	 @param activityID 活动ID，发起节点传参为0
	 @param workName 工作名称
	 @param currentHandler 操作者类型列表
	 @param signOpinion 签字意见
	 @param attachList 附件上传
	 @return 
	 * @throws Exception 
	*/
	//5
	public CommitFlag saveWorkSave(int flowID, int workID, int activityID, String mainBizkey, String workName, UserSession currentHandler, SignInfo signOpinion, java.util.List<Integer> attachList) throws Exception{
		Work work=new Work(flowID, workID, activityID, mainBizkey, workName, currentHandler, 
				signOpinion, attachList, new java.util.ArrayList<ActivityHandler>(), 0, 0,flowService.getFlow(flowID));
		workService.WorkSave(work);
		return CommitFlag.Success;
	}

	/** 
	 工作提交
	 @param flowID 流程ID
	 @param mainBizkey 业务主键
	 @param workID 工作ID，发起节点传参为0
	 @param activityID 活动ID，发起节点传参为0
	 @param workName 工作名称
	 @param currentHandler 操作者类型列表
	 @param signOpinion 签字意见
	 * @throws Exception 
	*/
	//6
	public  CommitFlag saveWorkCommit(int flowID, int workID, int activityID, String mainBizkey, String workName, UserSession currentHandler, SignInfo signOpinion, java.util.List<Integer> attachList, java.util.List<ActivityHandler> actHandlerList) throws Exception{
		try{
			Work work=new Work(flowID, workID, activityID, mainBizkey, workName, 
					currentHandler, signOpinion, attachList,actHandlerList, 0, 0,flowService.getFlow(flowID));
			workService.WorkCommit(work);
			return CommitFlag.Success;
		}catch (RuntimeException ex){
			System.err.println(ex);
			/*logDal.LogAdd(ex);
			if (ex.getMessage().equals("当前经办人工作已经完成，请勿重复提交！"))
			{
				return CommitFlag.Repeat;
			}
			else
			{
				return CommitFlag.Fail;
			}*/
		}
		return null;
	}

	/** 
	 工作驳回
	 @param flowID 流程ID
	 @param workID 工作ID
	 @param activityID 活动ID
	 @param currentHandler 操作者信息
	 @param signInfo 签字信息
	 * @throws SQLException 
	*/
	//7
	public  void getWorkReject(int flowID, int workID, int activityID, UserSession currentHandler, SignInfo signInfo) throws SQLException{
		//获取正在办理的工作项
		cn.zup.workflow.model.WF_WORK_ITEM workItemModel = item.WorkItemInfoByReciver(workID, activityID, currentHandler);
		if (workItemModel == null){
			return;
		}
		Connection conn=null;
		try{			
			try{
				//1-获取需要驳回到（激活）的活动节点
				List<cn.zup.workflow.model.WF_ACTIVITY> actList = activityDal.RejectTargetList(activityID, workID);
				//2-获取驳回（激活）节点的操作者列表
				List<ActivityHandler> actHandlerList = new ArrayList<ActivityHandler>();
				for (cn.zup.workflow.model.WF_ACTIVITY act : actList){   //（实体）
					ActivityHandler ActHandler = new ActivityHandler();
					java.util.List<cn.zup.workflow.model.WF_HANDLER> handlerList = workActivityDal.WorkActivityHandlerList(workID, act.getACTIVITY_ID());
					ActHandler.setActivityID(act.getACTIVITY_ID()) ;
					ActHandler.setHanderList(handlerList);
					actHandlerList.add(ActHandler);
				}
				//3-需要置为驳回的活动节点
				String rejectActivityIDs = activityDal.RejectActivityID(flowID, actList);
				//4-更新工作项信息
				workItemModel.setRESPONSIBLE_ID(signInfo.getSignUserID());
				workItemModel.setSIGN_NAME ( signInfo.getSignUserName());
				workItemModel.setSIGN_OPINION ( signInfo.getSignOpinion());
				workItemModel.setSIGN_DATE ( signInfo.getSignDatetime());
				workItemModel.setWORK_ITEM_DATETIME (new java.sql.Date(System.currentTimeMillis()));
				item.update(workItemModel);
				//5-将需要驳回的工作活动及工作项置为驳回状态（事务）
				workActivityDal.ActivityReject(workID, rejectActivityIDs);
				//6-激活驳回目标节点（事务）
				for (ActivityHandler actHandler : actHandlerList){
					workActivityService.getWorkActivity(workID, actHandler.getActivityID(), actHandler.getHanderList(), 
							null, new SignInfo(),new java.util.ArrayList<Integer>());					
				}				
				conn.commit();
			}catch (RuntimeException ex){
				logDal.LogAdd(ex);
				throw new RuntimeException(ex.getMessage());
			}
		}finally{
			conn.close();
		}
	}

	/** 
	 删除发起的工作
	 
	 @param workID
	 * @throws SQLException 
	*/
	//8
	public  void deleteWork(int workID) throws SQLException{
		workDal.Delete(workID);
	}
	/** 
	 强制完成某节点及其下属工作项
	 @param workID 工作ID
	 @param activityID 活动ID
	 * @throws SQLException 
	*/
	//9
	public  boolean updateWorkActivityTerminate(int workID, int activityID) throws SQLException{
		Connection conn=null;
		try{
			try{
				cn.zup.workflow.model.WF_WORK_ACTIVITY workActivityModel = workActivityDal.GetModel(workID, activityID);
				//1-更新工作活动
				workActivityModel.setWORK_ACTIVITY_STATE (WorkActivityState.NormalEnd.getValue());
				workActivityModel.setNEXT_ACTIVITY_CODES ( "");
				java.util.Date curDate = new java.util.Date();
				java.sql.Date date=new java.sql.Date(curDate.getTime());
				workActivityModel.setFINISHED_DATETIME (date);
				workActivityDal.Update(workActivityModel);
				//2-更新工作项
				List<cn.zup.workflow.model.WF_WORK_ITEM> workItemList = 
						item.ActivityWorkItemList(workActivityModel.getWORK_ACTIVITY_ID());
				for (cn.zup.workflow.model.WF_WORK_ITEM model : workItemList){
					model.setWORK_ITEM_STATE(Byte.parseByte(String.valueOf( WorkItemState.NormalEnd.getValue())));
					item.update(model);
				}
				conn.commit(); //提交事务
				return true;
			}catch (RuntimeException ex){
				logDal.LogAdd(ex);
				return false;
			}
		}finally{
			conn.close();
		}
	}
	/** 
	 激活活动
	 @param workID 工作ID
	 @param activityID 活动ID
	 * @throws SQLException 
	*/
	//10
	public void getWorkNewActivity(int workID, int activityID) throws SQLException{
		try{
			java.util.List<cn.zup.workflow.model.WF_HANDLER> handlerList = workActivityDal.WorkNewActivityHandlerList(workID, activityID); //获取节点实际操作者列表
			SignInfo signInfo = new SignInfo(); //签字信息
			workActivityService.getWorkActivity(workID, activityID, handlerList, new java.util.ArrayList<ActivityHandler>(), signInfo, new java.util.ArrayList<Integer>());
		}catch (RuntimeException ex){
			logDal.LogAdd(ex);
			throw new RuntimeException(ex.getMessage());
		}
	}

	/** 
	 设置工作结束
	 @param workID
	*/
	//11
	public  void updateWorkFinish(int workID){
		try {
			workDal.WorkFinish(workID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/** 
	 保存附件
	 @param attach 附件实体
	 * @throws SQLException 
	*/
	//12
	public  void saveAttach(cn.zup.workflow.model.WF_ATTACH attach) throws SQLException{
		attachDal.Add(attach);
	}

	/** 
	 删除附件
	 @param attachID 上传附件ID
	 * @throws SQLException 
	*/
	//13
	public  void deleteAttach(int attachID) throws SQLException{
		attachDal.Delete(attachID);
	}
	/**
	 * 根据流程id获取所有的工作，删除流程时，级联删除所有的工作使用
	 * lixin
	 * 2017-9-14 11:09:32
	 * @param flowId
	 * @return
	 */
	//14
	@Override
	public List<WF_WORK> listWork(Integer flowId) {
		 List<WF_WORK> list=new ArrayList<WF_WORK>();
		try {
			list= workDal.WorkList(flowId, null);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 根据流程id删除所有的工作
	 * lixin
	 * 2017-9-14 11:13:14
	 * @param flowId
	 * @return
	 */
	//15
	@Override
	public void deleteWorkList(int flowId) {
		workDal.deleteWorkList(flowId);
	}
}
