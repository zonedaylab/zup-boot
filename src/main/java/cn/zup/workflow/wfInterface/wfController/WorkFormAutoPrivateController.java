package cn.zup.workflow.wfInterface.wfController;

import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import cn.zup.framework.aop.service.BusLog;
import cn.zup.rbac.service.ResourceService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowFormAuto;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.biz.SampleReceiveRegisterService;

/**
 * 内控系统调用工作流，
 * 只用作页面跳转使用
 * @date 2018-4-2 10:21:05
 * 
 * */
@Controller
@RequestMapping("/rest/workflow/WorkFormAutoPrivateController")
public class WorkFormAutoPrivateController {
	@Resource
	ResourceService resourceServie;
	@Resource
	private IWorkFlowFormAuto formAuto; 
	@Resource
	private IWorkFlowConfig iWorkFlowConfig;
	@Resource
	private SampleReceiveRegisterService demoSampleReceiveRegisterService;
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private WorkflowDispatchService workflowDispatchService;	
	@Autowired
	private BusLog busLog;
	
	@RequestMapping("")
	public ModelAndView index(FlowRequest flowRequest,Integer flowId,HttpServletRequest request) throws SQLException, Exception{
		if(!"".equals(flowRequest.getWorkID()) && flowRequest.getWorkID() != null){
			flowRequest = demoSampleReceiveRegisterService.getWorkItemActivety(flowRequest.getWorkID(), "1");
		}
		String mainBizKey=workflowDispatchService.getMainBizKey(flowRequest);
		List<WF_ACTIVITY> listActivity=configService.listActivity(flowId);
		//通过流程id获取节点
		if(listActivity.size()>0){
			int formID = listActivity.get(0).getFORM_ID();
			//通过表单id获取表单信息
			String content = configService.getFormAuto(formID);
			String  ControllAddress="privateContr/AutoForm";
			ModelAndView mv = new ModelAndView(ControllAddress);
			mv.addObject("formID", formID);
			mv.addObject("mainBizKey", mainBizKey);
			mv.addObject("html", content);
			mv.addObject("flowRequest", flowRequest);
			return mv;	
		}else{
			busLog.addInfoLog("没有获取到流程"+flowId+"对应的节点", "configService.ActivityList("+flowId+")");
			throw new Exception("@没有获取到流程"+flowId+"对应的节点。请重新配置流程节点并在菜单管理重新设置菜单与流程的对应的关系。");
		}
	}
}
