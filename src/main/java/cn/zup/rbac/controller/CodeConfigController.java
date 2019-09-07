package cn.zup.rbac.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.framework.util.DateUtil;
import cn.zup.rbac.entity.CodeConfig;
import cn.zup.rbac.entity.Post;

import cn.zup.rbac.service.CodeConfigService;


@Controller
@RequestMapping("/rest/rbac/codeconfig")
public class CodeConfigController {

	@Resource
	private CodeConfigService codeconfigService;
	
	@RequestMapping("")
	@ResponseBody 
	public ModelAndView index() {
		return new ModelAndView("rbac/CodeConfigManage");
	}
	
	@RequestMapping("/gird")
	@ResponseBody 
	public String getgrid(CodeConfig codeconfig,Integer page,Integer rows,HttpServletRequest request) {
		
		MiniDaoPage<CodeConfig> pageopers = codeconfigService.getCodeConfigList(codeconfig, page, rows);
		
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageopers.getPages());
		json.put("total",pageopers.getTotal());
	
		
		JSONArray jsonarray = JSONArray.fromObject(pageopers.getResults());  
		json.put("data", jsonarray);
		
		return json.toString();  
	}
	
	/** 
	 编码规则添加
	 @param codeconfig
	 @return 
	*/
	@RequestMapping("/addCode")
	@ResponseBody
	public String CodeAdd(CodeConfig codeconfig)
	{
		JSONObject json = new JSONObject();
		codeconfigService.addCodeConfig(codeconfig);
		json.put("add", "yes");
		return json.toString();
		
	}
	/**
	 * 获取编码
	 * @param codeconfig
	 * @return
	 */
	@RequestMapping("/getCodeConfig")
	@ResponseBody
	public String getCodeConfig(CodeConfig codeconfig)
	{
		
		JSONObject json = new JSONObject();
		List<String> codeParams=new ArrayList<String>(){
			{ 
				add("01");
			    add("20161002");
			    add("0001");
			 }
		};
		for(int i=0;i<5;i++){
			String codeConfig=codeconfigService.getCodeInfo(3,codeParams);
			System.err.println("========================"+codeConfig);
		}
		
		
		
		//json.put("data", codeConfig);
		return json.toString();
		
	}
	
}
