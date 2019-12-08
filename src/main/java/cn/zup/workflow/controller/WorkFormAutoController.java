package cn.zup.workflow.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.formdesign.entity.FormControl;
import cn.zup.framework.aop.service.BusLog;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.ResourceService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowFormAuto;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.biz.impl.WorkParameter;
import cn.zup.workflow.model.ACTIVITY_POPEDOM;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_FORMAUTO_JOB;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.structure.FormAutoParameter;
import cn.zup.workflow.structure.SignInfo;
import cn.zup.workflow.util.Event;
import cn.zup.workflow.util.SaveAutoFormFile;
import cn.zup.workflow.biz.SampleReceiveRegisterService;

/**
 * 表单工作流测试
 * @author 谢炎
 * @date 2016-8-25 22:28:52
 * 
 * */
@Controller
@RequestMapping("/rest/workflow/workFormAutoController")
public class WorkFormAutoController {
	@Resource
	ResourceService resourceServie;
	@Resource
	private IWorkFlowFormAuto formAuto; 
	@Resource
	private SampleReceiveRegisterService demoSampleReceiveRegisterService;
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private WorkflowDispatchService workflowDispatchService;	
	
	@Resource
	private IWorkFlowMonitor monitorService;	
	
	@Autowired
	private BusLog busLog;
	
	@RequestMapping("")
	public ModelAndView index(FlowRequest flowRequest,HttpServletRequest request) throws SQLException, Exception{
		String menuId = request.getParameter("menuid");
		if("".equals(flowRequest.getFlowID()) || flowRequest.getFlowID() == null){
			if(!"".equals(menuId) && menuId != null){
				Menu menu = resourceServie.getMenuInfo(Integer.parseInt(menuId));
				flowRequest.setFlowID(menu.getFlowId().toString());
			}
		}
		if(!"".equals(flowRequest.getWorkItemID()) && flowRequest.getWorkItemID() != null){
			flowRequest = monitorService.getCurrentWorkFlow(flowRequest.getWorkItemID(), "1");
		}
		
		String mainBizKey=workflowDispatchService.getMainBizKey(flowRequest);
		List<WF_ACTIVITY> listActivity=configService.listActivity(Integer.parseInt(flowRequest.getFlowID()));
		//通过流程id获取节点
		if(listActivity.size()>0){
			int formID = listActivity.get(0).getFORM_ID();
			String content = configService.getFormAuto(formID);
			if(content.length() == 0){
				ModelAndView mv=workflowDispatchService.getBizForm(flowRequest);
				mv.addObject("formID", formID);
				mv.addObject("mainBizKey", mainBizKey);
				mv.addObject("flowRequest", flowRequest);
				mv.addObject("actionNames", getActivityFormControlPopedom(flowRequest));
				return mv;	
			}else{
				ModelAndView mv = new ModelAndView("workflow/wfWorkFormAuto");
				mv.addObject("formID", formID);
				mv.addObject("mainBizKey", mainBizKey);
				mv.addObject("html", content);
				mv.addObject("flowRequest", flowRequest);
				return mv;	
			}
		}else{
			busLog.addInfoLog("没有获取到流程"+flowRequest.getFlowID()+"对应的节点", "configService.ActivityList("+flowRequest.getFlowID()+")");
			throw new Exception("@没有获取到流程"+flowRequest.getFlowID()+"对应的节点。请重新配置流程节点并在菜单管理重新设置菜单与流程的对应的关系。");
		}
	}
	
	/**
	 * 通过当前登录用户id获取该用户具有的权限的组件名称
	 * @author antsdot
	 * @date 2016-12-1 09:45:42
	 * @return List<String>
	 * @throws Exception 
	 * */
	public List<ACTIVITY_POPEDOM> getActivityFormControlPopedom(FlowRequest flowRequest) throws Exception{
		int activityId = 0;
		if(flowRequest.getActivityID() == null){
			activityId =  configService.getFirstActivitys(Integer.parseInt(flowRequest.getFlowID())).getACTIVITY_ID();
		}else{
			activityId = Integer.parseInt(flowRequest.getActivityID());
		}
		return configService.listActivityPopedom(activityId);
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
	@RequestMapping("/saveFormAutoInfo")
	@ResponseBody
	public String myBizWorkflow(String actionType,FlowRequest flowRequest,String mainBizKey,int formID, @RequestParam("inputName") String[] inputNames, @RequestParam("inputValue") String[] inputValues, SignInfo signInfo,@RequestParam("upFile") CommonsMultipartFile mFile,HttpServletResponse response, HttpServletRequest request) throws SQLException, Exception
	{	
		
		String formName = configService.getForm(formID).getFORM_NAME();
		
		if("".equals(flowRequest.getWorkID())){
			flowRequest.setWorkID("0");
		}
		if("".equals(flowRequest.getWorkItemID())){
			flowRequest.setWorkItemID("0");
		}
		
		response.setCharacterEncoding("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
        String savePath =  request.getSession().getServletContext().getRealPath("/")+"upload\\";
        String fileName = mFile.getFileItem().getName();
        boolean fileSaveState = SaveAutoFormFile.saveFile(mFile.getInputStream(), savePath, fileName);
		//当控件名称为upFile时就为文件，值就替换为地址
		for (int i = 0; i < inputNames.length; i++) {
			if(inputNames[i].equals("upFile")){
				inputValues[i] = "upload\\"+fileName;
			}
		}
		
		HttpSession session=request.getSession();		
		UserSession currentHandler=(UserSession)(session.getAttribute("usersession"));
		
		FormAutoParameter formAutoParameter = new FormAutoParameter();
		formAutoParameter.setFormID(formID);
		formAutoParameter.setInputNames(inputNames);
		formAutoParameter.setInputValues(inputValues);
		formAutoParameter.setFormName(formName);
		formAutoParameter.setRealName(currentHandler.getRealName());
		formAutoParameter.setUserID(currentHandler.getUserId());
		formAutoParameter.setMainBizKey(mainBizKey);
		
		//设置业务执行函数,myBizSave对应具体的业务函数，请根据情况进行修改
		Event event=new Event();
		event.setMethodName("myBizSave");
		event.setObject(this);
		event.setParam(formAutoParameter);
		//workflowDispatchService.setBizSaveEvent(event);		
		List<Event> listEvent=new ArrayList<Event>();
		listEvent.add(event);
		event=new Event();
		event.setMethodName("myBizRollbak");
		event.setObject(this);		
		//workflowDispatchService.setBizRollbackEvent(event);		
		listEvent.add(event);
				
		
		flowRequest.setCurrentHandler(currentHandler);		
		String s=workflowDispatchService.saveWorkflowDispatch(actionType,flowRequest, signInfo,listEvent);	
		System.out.println("------------------------");
		System.out.println(s);
		return s;
//		mv.addObject("flowRequest", flowRequest);
//        return mv;
	}
	
	/**
	 * 提交自定义表单(没有附件)
	 * @Auht   谢炎
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
	@RequestMapping("/saveFormAutoInfoNoFile")
	@ResponseBody
	public String saveBizWorkflow(String actionType, String mainBizKey, FlowRequest flowRequest,int formID, @RequestParam("inputName[]") String[] inputNames, @RequestParam("inputValue[]") String[] inputValues,SignInfo signInfo,HttpServletResponse response, HttpServletRequest request) throws SQLException, Exception
	{	
		String formName = configService.getForm(formID).getFORM_NAME();
		if("".equals(flowRequest.getWorkID())){
			flowRequest.setWorkID("0");
		}
		if("".equals(flowRequest.getWorkItemID())){
			flowRequest.setWorkItemID("0");
		}
		response.setCharacterEncoding("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session=request.getSession();		
		UserSession currentHandler=(UserSession)(session.getAttribute("usersession"));
		
		FormAutoParameter formAutoParameter = new FormAutoParameter();
		formAutoParameter.setFormID(formID);
		formAutoParameter.setInputNames(inputNames);
		formAutoParameter.setInputValues(inputValues);
		formAutoParameter.setFormName(formName);
		formAutoParameter.setRealName(currentHandler.getRealName());
		formAutoParameter.setUserID(currentHandler.getUserId());
		formAutoParameter.setMainBizKey(mainBizKey);
		
		//设置业务执行函数,myBizSave对应具体的业务函数，请根据情况进行修改
		Event event=new Event();
		event.setMethodName("myBizSave");
		event.setObject(this);
		event.setParam(formAutoParameter);
		List<Event> listEvent=new ArrayList<Event>();
		listEvent.add(event);
		event=new Event();
		event.setMethodName("myBizRollbak");
		event.setObject(this);		
		listEvent.add(event);
		flowRequest.setCurrentHandler(currentHandler);		
		String s=workflowDispatchService.saveWorkflowDispatch(actionType,flowRequest, signInfo,listEvent);	
		System.out.println("------------------------");
		System.out.println(s);
		return s;
	}
	
	/**
	 * 业务处理函数
	 * @author liuxf
	 * @Date 2016.07.29 
	 * @return
	 */	
	@SuppressWarnings("unused")
	public WorkParameter myBizSave(FormAutoParameter formAutoParameter) throws SQLException
	{		
		/**书写自己的业务函数
		 * 
		 */
		//业务主键写入工作流
		WF_FORMAUTO_JOB job = new WF_FORMAUTO_JOB();
		job.setDATA_NAME(formAutoParameter.getFormName());
		job.setFORM_ID(formAutoParameter.getFormID());
		job.setUSER_ID(formAutoParameter.getUserID());
		job.setUSER_NAME(formAutoParameter.getRealName());
		
		int mainBizKey = 0;
		
		if(formAutoParameter.getMainBizKey().length() > 1){
			mainBizKey = Integer.parseInt(formAutoParameter.getMainBizKey());
			//写入表单数据的生成业务主键之后，用业务主键去存入表单的控件数据
			for(int i=0; i<formAutoParameter.getInputNames().length; i++){
				if(i>0 && formAutoParameter.getInputNames()[i].equals(formAutoParameter.getInputNames()[i-1])){
					continue;
				}
				List<Integer> controlIds = formAuto.getFormControl(formAutoParameter.getFormID(), formAutoParameter.getInputNames()[i]);
				for (int j = 0; j < controlIds.size(); j++) {
					WF_FORMAUTO_JOB_DATA formAutoJobData = new WF_FORMAUTO_JOB_DATA();
					formAutoJobData.setJOB_ID(mainBizKey);
					formAutoJobData.setCONTROL_ID(controlIds.get(j));   //插入区分
					formAutoJobData.setVALUE(formAutoParameter.getInputValues()[i]);
					formAutoJobData.setCONTROL_NAME(formAutoParameter.getInputNames()[i]);
					formAuto.updateFormAutoJobData(formAutoJobData, mainBizKey);
				}
			}
		}else{
			mainBizKey = formAuto.saveFormAutoJob(job);
			//写入表单数据的生成业务主键之后，用业务主键去存入表单的控件数据
			for(int i=0; i<formAutoParameter.getInputNames().length; i++){
				if(i>0 && formAutoParameter.getInputNames()[i].equals(formAutoParameter.getInputNames()[i-1])){
					continue;
				}
				List<Integer> controlIds = formAuto.getFormControl(formAutoParameter.getFormID(), formAutoParameter.getInputNames()[i]);
				for (int j = 0; j < controlIds.size(); j++) {
					WF_FORMAUTO_JOB_DATA formAutoJobData = new WF_FORMAUTO_JOB_DATA();
					formAutoJobData.setJOB_ID(mainBizKey);
					formAutoJobData.setCONTROL_ID(controlIds.get(j));   //插入区分
					formAutoJobData.setVALUE(formAutoParameter.getInputValues()[i]);
					formAutoJobData.setCONTROL_NAME(formAutoParameter.getInputNames()[i]);
					formAuto.saveFormAutoJobData(formAutoJobData);
				}
			}
		}
		
		
		
		/**
		 * 返回参数
		 */
		WorkParameter workParam=new WorkParameter();
		workParam.setBizKey(mainBizKey+"");
		String workName="自定义表单工作流测试"+mainBizKey;
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
	 * 获取自定义表单内容
	 * @param formId
	 * @return 
	 * @throws Exception 
	 * @throws  
	*/
	@RequestMapping("/getFormAutoInfo")
	public ModelAndView getFormAutoInfo(String formID,HttpServletRequest request) throws  Exception
	{
		String content = configService.getFormAuto(Integer.parseInt(formID));
		ModelAndView mv=new ModelAndView();	
		request.setAttribute("content", content);
		//mv.addObject("formID", formID);
		return new ModelAndView("workflow/wfFormAuto");
	}
	
	/** 
	 * 修改自定义表单内容
	 * @param formId
	 * @return 
	 * @throws Exception 
	 * @throws  
	*/
	@RequestMapping("/FormAutoEdit")
	@ResponseBody
	public String FormAutoEdit(String formID,@RequestParam("parse_form") String html) throws  Exception
	{
		JSONObject jsonObj =  JSONObject.fromObject(html);
		String form = jsonObj.get("template").toString();
		
		String data = jsonObj.get("data").toString();
		JSONArray jsonarray = JSONArray.fromObject(data);  
        List<FormControl> list = (List)JSONArray.toList(jsonarray,FormControl.class);
        
        //删除对应formid的formcontrol
        formAuto.deleteFormControlByFormId(Integer.parseInt(formID));
        byte b = 2;
        //新增formcontrol
        for(int i=0; i<list.size(); i++){
        	FormControl fc = list.get(i);
        	WF_FORM_CONTROL wfc = new WF_FORM_CONTROL();
        	wfc.setCONTROL_MEANING(b);
        	wfc.setCONTROL_NAME(fc.getName());
        	wfc.setCONTROL_TEXT(fc.getTitle());
        	wfc.setCONTROL_TYPE(b);
        	wfc.setDEFAULT_LENGTH(0);
        	wfc.setFORM_ID(Integer.parseInt(formID));
        	wfc.setNULL_PERMIT(b);
        	wfc.setUSER_CONTROL_NAME(fc.getName());
        	configService.saveFormControl(wfc);
        }
        
		System.out.println(form);
		formAuto.updateFormAuto(formID, form);
		JSONObject json = new JSONObject();
		json.put("result","success");
		return json.toString();	
	}
	
	/**
	 * 
	 * 通过业务主键 获取业务数据
	 * @author 谢炎 
	 * @throws Exception 
	 * @date 2016-08-31
	 * 
	 * */
	@RequestMapping("/getMainBizInfo")
	@ResponseBody 
	public String getMainBizInfo(String mainBizKey) throws Exception{
		List<WF_FORMAUTO_JOB_DATA> formAutoInfo = new ArrayList<WF_FORMAUTO_JOB_DATA>();
		if(mainBizKey != "")
			formAutoInfo = formAuto.getFormAuto(mainBizKey);
		JSONObject json = new JSONObject();
		JSONArray jsonarr = JSONArray.fromObject(formAutoInfo); 
		json.put("formAutoInfo", jsonarr);
		
		return json.toString();
	}
	
	/**
	 * 
	 * 通过ajaxUploadFile上传自定义表单附件
	 * @author 谢炎 
	 * @throws Exception 
	 * @date 2016-9-26 17:21:33
	 * 
	 * */
	@RequestMapping("/upLoadFile")
	@ResponseBody 
	public String upLoadFile(@RequestParam("upFile") CommonsMultipartFile mFile,HttpServletResponse response, HttpServletRequest request) throws Exception{
		JSONObject json = new JSONObject();
		response.setCharacterEncoding("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
        String savePath =  request.getSession().getServletContext().getRealPath("/")+"upload\\";
        String fileName = mFile.getFileItem().getName();
        boolean fileSaveState = SaveAutoFormFile.saveFile(mFile.getInputStream(), savePath, fileName);
        
        return "upload\\" + fileName;//json.toString();
	}
	
}
