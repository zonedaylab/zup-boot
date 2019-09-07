package cn.zup.workflow.junit;

import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.biz.impl.WorkParameter;
import cn.zup.workflow.biz.impl.WorkflowDispathServiceImpl;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.util.Event;

public class WorkFlowExamJunit {


	private WorkflowDispatchService workflowDispatchService = new WorkflowDispathServiceImpl();	

	/**
	 * 流程保存测试
	 * @author liuxf
	 * @throws Exception
	 */
	@Test
	public void WorkFlowSave() throws Exception{//测试增加账户	
		
	
		//设置业务执行函数,myBizSave对应具体的业务函数，请根据情况进行修改
		Event event=new Event();
		event.setMethodName("myBizSave");
		event.setObject(this);
		Integer num=5;
		
		cn.zup.workflow.model.WF_ACTIVITY model =new cn.zup.workflow.model.WF_ACTIVITY();
		model.setACTIVITY_CODE(1);
		model.setACTIVITY_NAME("paoduixinag ,同同同");
		event.setParam("this is biz para test",num,model);
		
		
		
		
		
		UserSession currentHandler=new UserSession();
		currentHandler.setAccountId(1);
		currentHandler.setSystemId(1);
		currentHandler.setUserId(1);
		
		String actionType="Save";
		actionType="Commit";
		FlowRequest flowRequest=new FlowRequest();
		flowRequest.setFlowID("1");
		flowRequest.setActivityID("1");
		flowRequest.setWorkID("1");
		flowRequest.setPopedomType("1");
		flowRequest.setCurrentHandler(currentHandler);		
		//ModelAndView mv=workflowDispatchService.workflowDispatch(actionType,flowRequest);			
		
		System.out.println("WorkFlowSave 测试完成,测试类型为："+actionType);

	}	
	
	/**
	 * 业务处理函数
	 * @author liuxf
	 * @Date 2016.07.29 
	 * @return
	 */	
	@SuppressWarnings("unused")
	public WorkParameter myBizSave(String obj,Integer number,cn.zup.workflow.model.WF_ACTIVITY model)
	{		
		/**书写自己的业务函数
		 * 
		 */
		String test=obj.toString();
		
		System.out.println("myBizSave param,string="+test);
		System.out.println("myBizSave param,number="+number);
		System.out.println("myBizSave param,model="+model.getACTIVITY_NAME());
		
		
		/**
		 * 返回参数
		 */
		WorkParameter workParam=new WorkParameter();
		workParam.setBizKey("1");
		workParam.setWorkName("嗅和味与可见物-检验编号20160729");		 
		return workParam;		
	} 	
	
}


