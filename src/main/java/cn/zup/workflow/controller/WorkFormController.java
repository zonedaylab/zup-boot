package cn.zup.workflow.controller;


import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowMonitor;
import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.model.ACTIVITY_POPEDOM;
import cn.zup.workflow.model.FORM_CONTROL;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_ACTIVITY_POPEDOM;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.model.WORK_SIGN;
import cn.zup.workflow.util.StringHelper;

@Scope("prototype")
@Controller
@RequestMapping("rest/workflow/workForm")
public class WorkFormController{
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private IWorkFlowMonitor monitorService;
	
	/**
	 * 表单字段管理
	 * Author：韩圣传
	 * Date:2016.8.8
	 * @param 
	 **/
	@RequestMapping("/formControl")
	public ModelAndView formControl(HttpServletRequest request) {  
	    return new ModelAndView("workflow/wfFormControlManage");
	}
	
	/**
	 * 表单管理页面
	 * @author 谢炎
	 * @data:2016-8-10 14:23:53
	 * @param 
	 **/
	@RequestMapping("/FormManageControl")
	public ModelAndView index(HttpServletRequest request) {  
	    return new ModelAndView("workflow/wfFormManage");
	}

	/** 
	 获取表单信息
	 
	 @param fromid
	 @return 
	 * @throws Exception 
	 * @throws  
	*/
	
	@RequestMapping("/FormInfo")
	@ResponseBody
	public String FormInfo(String formid) throws  Exception{
		WF_FORM form = configService.getForm(Integer.parseInt(formid));
		JSONObject json = new JSONObject();
		JSONArray jsonarr = JSONArray.fromObject(form); 
		json.put("wfform", jsonarr);
		return json.toString();
	}
	
	/**
	 * 获取表单树
	 * @param node
	 * @param systemID
	 * @return
	 */
	@RequestMapping("/WorkFormTree")
	@ResponseBody
	public String WorkFormTree(String node, String systemID){
		JSONObject json = new JSONObject();
		json.put("result", "error");
		return json.toString();		
	}

	/**
	 * 表单树
	 * Author：韩圣传
	 * Date:2016.8.9
	 * @param parentMenuId 菜单ID，systemId 系统ID
	 **/
	@RequestMapping("/getChildNode")//getSonNode
	@ResponseBody
	private String getChildNode(int parentMenuId, int systemId) throws SQLException{
		JSONObject json = new JSONObject();
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentMenuId == -1){
			TreeView treeParent = new TreeView();
			treeParent.setId(0);
			treeParent.setName("表单列表");
			treeParent.setType("folder");
			treeList.add(treeParent);
		}else{
			treeList.clear();
			List<WF_FORM> wfforms = configService.listFormSub(systemId, parentMenuId);
			for(WF_FORM  form : wfforms){
				TreeView tree = new TreeView();
				tree.setId(form.getFORM_ID());
				tree.setName(form.getFORM_NAME());
				List<WF_FORM> childList = configService.listFormSub(systemId, form.getFORM_ID());
				if(childList.size() <= 0){
					tree.setType("item");
				}else{
					tree.setType("folder");
				}
				treeList.add(tree); 
			}
		}
		json.put("data", treeList);
		String s = json.toString();
		s=s.replace('_','-');
		
		return s;
	}
	
	/** 
	 * 获取表单信息
	 * @param formId
	 * @return 
	 * @throws Exception 
	 * @throws  
	*/
	@RequestMapping("/getFormInfo")
	@ResponseBody
	public String getFormInfo(String formId) throws  Exception{
		WF_FORM form = configService.getForm(Integer.parseInt(formId));
		JSONObject json = new JSONObject();
		json.put("wfform", form);
		return json.toString();
	}
	
	/** 
	 * 表单添加
	 *
	 * @param formModel表单实体
	 * @return 
	 * @throws SQLException 
	*/
	@RequestMapping("/addWorkForm")
	@ResponseBody
	public String addForm(WF_FORM formModel) throws SQLException{
		int result = configService.saveForm(formModel);
		JSONObject json = new JSONObject();
		if(result > 0){
			json.put("result", "success");	
		}
		return json.toString();
	}

	/** 
	 * 表单编辑
	 *
	 * @param formModel表单实体
	 * @return 
	 * @throws SQLException 
	*/
	@RequestMapping("/WorkFormEdit")
	@ResponseBody
	public String WorkFormEdit(WF_FORM formModel) throws NumberFormatException, SQLException{
		int result = configService.saveForm(formModel);
		JSONObject json = new JSONObject();
		if(result == 0){
			json.put("result", "success");	
		}else{
			json.put("result", "error");
			json.put("error", formModel.getFORM_ID());
		}
		return json.toString();	
	}
	
	/** 
	 表单删除
	 
	 @param formId
	 @return 
	 * @throws Exception 
	*/
	@RequestMapping("/WorkFormDelete")
	@ResponseBody
	public String WorkFormDelete(String formId) throws Exception{
		JSONObject json = new JSONObject();
		String result = null;
		try{
			configService.deleteForm(Integer.parseInt(formId));
			result = "success";
		}catch(Exception ex){
			result = "error，删除失败fromId为："+formId;
			json.put("error", ex);
		}
		json.put("result", result);
		return json.toString();
	}
	
	/** 
	 表单保存
	 
	 @param form
	 @param strForm
	 @return 
	 * @throws SQLException 
	*/
	@RequestMapping("/workFormSave")
	@ResponseBody
	public String WorkFormSave(WF_FORM form, String strForm) throws SQLException{
		JSONObject json = new JSONObject();
		configService.saveForm(form);
		json.put("result", "success");		
		return json.toString();			
	}

	/** 
	 绑定组件类型
	 
	 @return 
	 * @throws Exception 
	*/
	@RequestMapping("/controlTypeBind")
	@ResponseBody
	public  String ControlTypeBind() throws Exception{
		List<WF_CONFIG> flowStateList = configService.listConfig(ConfigList.ControlType.getValue());
		JSONObject json = new JSONObject();
		json.put("data", flowStateList);
		json.put("result","success");
		return json.toString();		
	}
	/** 
	 绑定为空标识
	 
	 @return 
	 * @throws Exception 
	*/
	@RequestMapping("/nullPermitBind")
	@ResponseBody
	public String NullPermitBind() throws Exception{
		List<WF_CONFIG> flowStateList = configService.listConfig(ConfigList.NullPermit.getValue());
		JSONObject json = new JSONObject();
		json.put("data", flowStateList);	
		json.put("result","success");
		return json.toString();				
	}
	/** 
	 绑定控件含义
	 
	 @return 
	 * @throws Exception 
	*/
	@RequestMapping("/controlMeaningBind")
	@ResponseBody
	public String ControlMeaningBind() throws Exception{
		List<WF_CONFIG> flowStateList = configService.listConfig(ConfigList.ControlMeaning.getValue());
		JSONObject json = new JSONObject();
		json.put("result","success");
		json.put("data", flowStateList);		
		return json.toString();		
	}

	/** 
	 获取FormId对应的Grid
	 @return 
	 * @throws Exception 
	*/
	@RequestMapping("/controlListQuery")
	@ResponseBody
	public String ControlListQuery( String ControlName, String ControlType, String FormID) throws Exception{
		int controlTypeParam = StringHelper.isNullOrEmpty(ControlType) ? 0 : Integer.parseInt(ControlType);
		int formIDParam = StringHelper.isNullOrEmpty(FormID) ? 0 : Integer.parseInt(FormID);
		List<FORM_CONTROL> controlList= configService.listFormControl(formIDParam);
		JSONObject json = new JSONObject();
		
		//经刘老师确认，此处无需分页，所以页数写死
		json.put("rows", 10);
		json.put("page", 1);
		json.put("total",controlList.size());

		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
		//实体类类型json转换
		JSONArray jsonArray = JSONArray.fromObject(controlList, jsonConfig);  
		json.put("data", jsonArray);
		return json.toString();		
	}

	@RequestMapping("/FormControlAdd")	
	public ModelAndView FormControlAdd(String FormID){
		WF_FORM_CONTROL entity = new WF_FORM_CONTROL();
		entity.setFORM_ID (Integer.parseInt(FormID));		
		ModelAndView mv=new ModelAndView("FormControlSet");
		mv.addObject("data",entity);
		return mv;
	}
	
	/**
	 * 编辑填充表单字段和活动权限表
	 * 
	 * 
	 * 
	 * */
	@RequestMapping("/formControlSee")
	@ResponseBody
	public String FormControlSee(int formControlID) throws NumberFormatException, SQLException{
		JSONObject json = new JSONObject();
		WF_FORM_CONTROL entity= configService.getFormControl(formControlID);
		List<WF_ACTIVITY> list = configService.getActivityListByFormId(entity.getFORM_ID());
		List<WF_ACTIVITY_POPEDOM> aplist = new ArrayList<WF_ACTIVITY_POPEDOM>();
		for (int i = 0; i < list.size(); i++) {
			WF_ACTIVITY_POPEDOM ap = configService.getActivityPopedom(list.get(i).getACTIVITY_ID(), formControlID);
			if(ap != null)
				aplist.add(ap);
		}
		json.put("activityPopedom", aplist);
		JSONArray jsonarr = JSONArray.fromObject(entity); 
		json.put("data",jsonarr);
		json.put("result", "success");
		return json.toString();
	}
	
	/**
	 * 编辑表单字段和活动权限表
	 * 
	 * 
	 * 
	 * */
	@RequestMapping("/formControlEdit")
	@ResponseBody
	public String FormControlEdit(WF_FORM_CONTROL formControl,WF_ACTIVITY_POPEDOM activityPopedomModel, HttpServletRequest request) throws NumberFormatException, SQLException{
		//存储组件表，返回组件id
		int cid = configService.saveFormControl(formControl);
		String[] acIds = request.getParameterValues("acId");
		//存储活动权限表
		if(request.getParameterValues("acId").length > 0){
			//先删除
			for (int i = 0; i < acIds.length; i++) {
				configService.deleteActivityPopedom(Integer.parseInt(acIds[i]), cid);
			}
			//再添加
			for (int i = 0; i < acIds.length; i++) {
				activityPopedomModel.setACTIVITY_ID(Integer.parseInt(acIds[i]));
				activityPopedomModel.setCONTROL_ID(cid);
				configService.saveActivityPopedom(activityPopedomModel);
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();
	}
	/**
	 * 保存表单字段和活动权限表
	 * 
	 * 
	 * 
	 * */
	@RequestMapping("/formControlSave")
	@ResponseBody
	public  String FormControlSave(WF_FORM_CONTROL formControl,WF_ACTIVITY_POPEDOM activityPopedomModel, HttpServletRequest request) throws Exception{	
		//存储组件表，返回组件id
		int cid = configService.saveFormControl(formControl);
		String[] acIds = request.getParameterValues("acId");
		//存储活动权限表
		if(request.getParameterValues("acId").length > 0){
			for (int i = 0; i < acIds.length; i++) {
				activityPopedomModel.setACTIVITY_ID(Integer.parseInt(acIds[i]));
				activityPopedomModel.setCONTROL_ID(cid);
				configService.saveActivityPopedom(activityPopedomModel);
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();
	}

	@RequestMapping("/formControlDelete")
	@ResponseBody
	public String  FormControlDelete(@RequestParam("Ids[]") int[] controlIDs) throws Exception{		
		for (int i = 0; i < controlIDs.length; i++){
			configService.deleteFormControl(controlIDs[i]);
		}
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();
	}
	
	/**
	 * 
	 * 获取工作的历史签名记录
	 * @author 谢炎
	 * @date 2016-9-2 14:29:08
	 * @param  workId  工作id
	 * */
	@RequestMapping("/WorkSignList")
	@ResponseBody
	public String WorkSignList(int workId){
		List<WORK_SIGN> workSignList = monitorService.listWorkSign(workId);
		JSONObject json = new JSONObject();
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonarray = JSONArray.fromObject(workSignList, jsonConfig);
		json.put("data", jsonarray);
		return json.toString();
	}
	
	/**
	 * 
	 * 获取活动name
	 * @author 谢炎
	 * @date 2016-12-1 11:11:00
	 * @param formId
	 * @throws SQLException 
	 * */
	@RequestMapping("/getActiveInfo")
	@ResponseBody
	public String getActiveInfo(int formId) throws SQLException{
		List<WF_ACTIVITY> acList = configService.getActivityListByFormId(formId);
		JSONObject json = new JSONObject();
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonarray = JSONArray.fromObject(acList, jsonConfig);
		json.put("data", jsonarray);
		return json.toString();
	}
	/**
	 * 
	 * 获取活动name
	 * @author 谢炎
	 * @date 2016-12-1 11:11:00
	 * @param formId
	 * @throws SQLException 
	 * */
	@RequestMapping("/getActiveState")
	@ResponseBody
	public String getActiveState() throws SQLException{
		List<WF_CONFIG> activeStateList = configService.listConfig(ConfigList.ControlState.getValue());
		JSONObject json = new JSONObject();
		json.put("data", activeStateList);
		return json.toString();
	}
	
}
