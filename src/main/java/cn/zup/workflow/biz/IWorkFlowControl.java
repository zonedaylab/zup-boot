package cn.zup.workflow.biz;
import java.sql.SQLException;
import java.util.List;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.config.*;
import cn.zup.workflow.model.WF_WORK;
import cn.zup.workflow.structure.*;



/** 
 工作流控制服务接口
 
*/


public interface IWorkFlowControl{
	/** 
	 工作暂停
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	//1
	boolean updateWorkPause(int workID) throws SQLException;

	/** 
	 重启暂停工作
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	//2
	boolean updateWorkRelaunch(int workID) throws SQLException;

	/** 
	  发起修改流程
	 @param oriFlowID 原流程ID
	 @param oriMainBizKey 原业务主键
	 @param flowID 流程ID
	 @param mainBizKey 业务主键
	 @param signOpinion 签字意见
	 @param workName 工作名称
	 * @throws SQLException 
	 * @throws Exception 
	*/
	//3
	void updateWorkRedo(int oriFlowID, String oriMainBizKey, int flowID, String mainBizKey, SignInfo signOpinion, String workName) throws SQLException, Exception;
	/** 
	 强制终止工作
	 @param workID 工作ID
	*/
	//4
	boolean updateWorkTerminate(int workID);
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
	 * @throws SQLException 
	 * @throws Exception 
	*/
	//5
	CommitFlag saveWorkSave(int flowID, int workID, int activityID, String mainBizkey, String workName, UserSession currentHandler, SignInfo signOpinion, java.util.List<Integer> attachList) throws SQLException, Exception;
	/** 
	 工作提交
	 @param flowID 流程ID
	 @param mainBizkey 业务主键
	 @param workID 工作ID，发起节点传参为0
	 @param activityID 活动ID，发起节点传参为0
	 @param workName 工作名称
	 @param currentHandler 操作者类型列表
	 @param signOpinion 签字意见
	 @param attachList 附件上传
	 @return 
	 * @throws SQLException 
	 * @throws Exception 
	*/
	//6
	CommitFlag saveWorkCommit(int flowID, int workID, int activityID, String mainBizkey, String workName, UserSession currentHandler, SignInfo signOpinion, java.util.List<Integer> attachList, java.util.List<ActivityHandler> actHandlerList) throws SQLException, Exception;
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
	void getWorkReject(int flowID, int workID, int activityID, UserSession currentUser, SignInfo signInfo) throws SQLException;
	/** 
	 删除发起的工作
	 @param workID
	 * @throws SQLException 
	*/
	//8
	void deleteWork(int workID) throws SQLException;
	/** 
	 强制完成某节点及其下属工作项
	 @param workID 工作ID
	 @param activityID 活动ID
	 * @throws SQLException 
	*/
	//9
	boolean updateWorkActivityTerminate(int workID, int activityID) throws SQLException;
	/** 
	 激活活动
	 @param workID 工作ID
	 @param activityID 活动ID
	 * @throws SQLException 
	*/
	//10
	void getWorkNewActivity(int workID, int activityID) throws SQLException;
	/** 
	 设置工作结束
	 @param workID
	*/
	//11
	void updateWorkFinish(int workID);
	/** 
	 保存附件
	 @param attach
	 * @throws SQLException 
	*/
	//12
	void saveAttach(cn.zup.workflow.model.WF_ATTACH attach) throws SQLException;
	/** 
	 删除附件
	 @param attachID
	 * @throws SQLException 
	*/
	//13
	void deleteAttach(int attachID) throws SQLException;
	/**
	 * 根据流程id获取所有的工作，删除流程时，级联删除所有的工作使用
	 * lixin
	 * 2017-9-14 11:09:32
	 * @param flowId
	 * @return
	 */
	//14
	List<WF_WORK> listWork(Integer flowId);
	/**
	 * 根据流程id删除所有的工作
	 * 李欣
	 * 2017-9-14 11:13:14
	 * @param flowId
	 * @return
	 */
	//15
	void deleteWorkList(int flowId);
}
