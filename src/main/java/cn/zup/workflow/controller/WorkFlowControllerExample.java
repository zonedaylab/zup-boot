package cn.zup.workflow.controller;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.biz.impl.WorkParameter;
import cn.zup.workflow.util.Event;

import cn.zup.workflow.structure.FlowRequest;

//工作流页面服务，在控制器中或者业务服务中使用
@Controller
@RequestMapping("rest/myBiz")
public class WorkFlowControllerExample{		
	
	@Resource
	private WorkflowDispatchService workflowDispatchService;	

	
	@RequestMapping("")
	public ModelAndView myBizLoad(FlowRequest flowRequest,HttpServletRequest request) throws SQLException, Exception
	{		
		String mainBizKey=workflowDispatchService.getMainBizKey(flowRequest);
		
		//请根据业务主键进行数据的加载
		
		
		
		
		
		//----------------end here-----------------------------		
		
		ModelAndView mv=workflowDispatchService.getBizForm(flowRequest);
		return mv;		
	}
	
	/**
	 * 具体业务流程例子
	 * @Auht   liuxf
	 * @Data   2016.07.29
	 * @param actionType 
	 * 					操作类型
	 * 				    save 工作流保存 
	 * 					Commit 工作流提交 
	 * 					Reject 工作流驳回
	 
	 * @param flowRequest  请求对象,需要传递的参数包括
	 * 					FLOW_ID			流程ID
	 * 					WORK_ID			工作ID
	 * 					ACTIVITY_ID		活动类型
	 * 					WORK_ITEM_ID	工作项ID
	 * 					POPEDOM_TYPE  	 页面权限类型
	 * @return
	 * @throws SQLException
	 * @throws Exception
	 */
	@RequestMapping("myBizWorkflow")
	public ModelAndView myBizWorkflow(String actionType,FlowRequest flowRequest,HttpServletRequest request) throws SQLException, Exception
	{			
		//设置业务执行函数,myBizSave对应具体的业务函数，请根据情况进行修改
		Event event=new Event();
		event.setMethodName("myBizSave");
		event.setObject(this);
		event.setParam("test");
		List<Event> listEvent=new ArrayList<Event>();
		listEvent.add(event);
		event=new Event();
		event.setMethodName("myBizRollbak");
		event.setObject(this);	
		listEvent.add(event);
		//workflowDispatchService.setBizRollbackEvent(event);		
		
				
		HttpSession session=request.getSession();		
		UserSession currentHandler=(UserSession)(session.getAttribute("usersession"));
		flowRequest.setCurrentHandler(currentHandler);		
//		ModelAndView mv=workflowDispatchService.workflowDispatch(actionType,flowRequest,listEvent);	
//		
//        return mv;     
		return null;
	}
	/**
	 * 业务处理函数
	 * @author liuxf
	 * @Date 2016.07.29 
	 * @return
	 */	
	@SuppressWarnings("unused")
	private WorkParameter myBizSave(String param)
	{		
		/**书写自己的业务函数
		 * 
		 */
		
		
		
		/**
		 * 返回参数
		 */
		WorkParameter workParam=new WorkParameter();
		workParam.setBizKey("1");
		workParam.setWorkName("嗅和味与可见物-检验编号20160729");		 
		return workParam;		
	} 	
	
	/**
	 * 业务回滚
	 * @param mainBizKey
	 */
	@SuppressWarnings("unused")
	private void myBizRollbak(String mainBizKey)
	{
		
	}
}

