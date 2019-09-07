package cn.zup.workflow.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.ResourceService;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.biz.impl.WorkParameter;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.structure.SignInfo;
import cn.zup.workflow.util.Event;
import cn.zup.workflow.biz.SampleReceiveRegisterService;
import cn.zup.workflow.model.SampleReceiveRegister;

/**
 * 测试样品登记页面控制器
 * @author 谢炎
 * @date 2016-8-17 09:40:25
 * 
 * */
@Controller
@RequestMapping("/rest/workflowdemo/sampleReceiveRegister")
public class SampleReceiveRegisterController {
	@Resource
	ResourceService resourceServie;
	@Resource
	private SampleReceiveRegisterService demoSampleReceiveRegisterService; 
	@Resource
	private WorkflowDispatchService workflowDispatchService;	
	
	/**
	 
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
	@RequestMapping("/saveSampleInfo")
	@ResponseBody
	public String myBizWorkflow(String actionType,String mainBizKey, FlowRequest flowRequest,SampleReceiveRegister demoSampleReceiveRegister, SignInfo signInfo, HttpServletRequest request) throws SQLException, Exception
	{	
		//执行判断，为flowRequest为空赋值为0
		if("".equals(flowRequest.getWorkID())){
			flowRequest.setWorkID("0");
		}
		if("".equals(flowRequest.getWorkItemID())){
			flowRequest.setWorkItemID("0");
		}
		demoSampleReceiveRegister.setMainBizkey(mainBizKey);
		//设置业务执行函数,myBizSave对应具体的业务函数，请根据情况进行修改
		Event event=new Event();
		event.setMethodName("myBizSave");
		event.setObject(this);
		event.setParam(demoSampleReceiveRegister);
		List<Event> listEvent=new ArrayList<Event>();
		listEvent.add(event);
		event=new Event();
		event.setMethodName("myBizRollbak");
		event.setObject(this);		
		listEvent.add(event);
		HttpSession session=request.getSession();		
		UserSession currentHandler=(UserSession)(session.getAttribute("usersession"));
		flowRequest.setCurrentHandler(currentHandler);		
		String result=workflowDispatchService.saveWorkflowDispatch(actionType,flowRequest, signInfo,listEvent);	
		
		System.out.println("------------------------");
		System.out.println(result);
		
		return result;
	}
	
	
	/**
	 * 业务处理函数
	 * @author liuxf
	 * @Date 2016.07.29 
	 * @return
	 */	
	@SuppressWarnings("unused")
	public WorkParameter myBizSave(SampleReceiveRegister demoSampleReceiveRegister) throws SQLException
	{		
		/**书写自己的业务函数
		 * 
		 */
		//业务主键写入工作流
		int mainBizKey = 0;
		if(demoSampleReceiveRegister.getMainBizkey().length() > 1 ){
			mainBizKey = demoSampleReceiveRegisterService.UpdateSamleInfo(demoSampleReceiveRegister, demoSampleReceiveRegister.getMainBizkey());
		}else{
			mainBizKey = demoSampleReceiveRegisterService.SaveSamleInfo(demoSampleReceiveRegister);
		}
		/**
		 * 返回参数
		 */
		WorkParameter workParam=new WorkParameter();
		workParam.setBizKey(mainBizKey+"");
		String workName="工作流测试"+mainBizKey;
		workParam.setWorkName(workName);		 
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
	
	/**
	 * 
	 * 通过业务主键 获取业务数据
	 * @author 谢炎 
	 * @throws Exception 
	 * @date 2016-08-30
	 * 
	 * */
	@RequestMapping("/getMainBizInfo")
	@ResponseBody 
	public String getMainBizInfo(String mainBizKey) throws Exception{
		SampleReceiveRegister demo = demoSampleReceiveRegisterService.getSamleInfo(mainBizKey);
		JSONObject json = new JSONObject();
		JSONArray jsonarr = JSONArray.fromObject(demo); 
		json.put("demo", jsonarr);
		
		return json.toString();
	}
}
