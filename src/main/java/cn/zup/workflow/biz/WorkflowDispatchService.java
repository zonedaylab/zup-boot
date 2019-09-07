package cn.zup.workflow.biz;
import java.sql.SQLException;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.entity.UserInfo;
import cn.zup.workflow.structure.FlowParameter;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.structure.SignInfo;
import cn.zup.workflow.util.*;
/** 
 工作流调度服务
 
*/

public interface WorkflowDispatchService{
	
	/**
	 * 设置请求参数
	 * @param flowRequest
	 */
	//1
	public String saveWorkflowDispatch(String actionType,FlowRequest flowRequest,SignInfo signInfo,List<Event> listEvent) throws  Exception;
	/**
	 * 保存操作者信息的工作流重载方法
	 * lixin
	 * 2016-12-20 10:27:24
	 * @param actionType
	 * @param flowRequest
	 * @param signInfo
	 * @param userList
	 * @return
	 * @throws Exception
	 * 保存工作，同时获取下一个节点的id，并设置下一个节点的操作者为userList
	 */
	//2
	public String saveWorkflowDispatch(String actionType,FlowRequest flowRequest,SignInfo signInfo,List<UserInfo> userList,Integer operateFlag,List<Event> listEvent) throws  Exception;
	
	/**
	 * 强制终止工作,同时进行业务操作	
	 * @param flowID
	 * @param workID
	 * @param deleteWorkFlow
	 * @return
	 * @throws SQLException
	 * @throws Exception
	 * 返回删除业务的URL
	 */
	//3
	public String deleteTerminationWork(int flowID, int workID,boolean deleteWorkFlow) throws  Exception;
	/** 
	    获取业务主键
	* @throws SQLException 
	*/
	//4
	public String getMainBizKey(FlowRequest flowRequest) throws SQLException;
	
	/**
	 * 加载业务表单
	 * @return
	 */
	//5
	public ModelAndView getBizForm(FlowRequest flowRequest) throws SQLException, Exception;
	
	/**
	 * 具体提交业务所调用的方法
	 * @param flowRequest
	 * @param flowParam
	 * @return
	 * @throws Exception
	 */
	//6
	public  ModelAndView saveCommitReal(FlowRequest flowRequest,FlowParameter flowParam) throws Exception;
	
}