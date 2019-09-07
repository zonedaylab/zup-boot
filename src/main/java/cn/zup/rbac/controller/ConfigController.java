package cn.zup.rbac.controller;

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
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.service.ConfigurationService;


@Controller
@RequestMapping("/rest/rbac/configController")
public class ConfigController {
	@Resource
	private ConfigurationService configurationService;
	
	/**
	 * 进入任务页面
	 */
	@RequestMapping("")
	public ModelAndView index(){
		return new ModelAndView("rbac/configManage");
	}
	
	/**
	 * 进入任务表格
	 */
	@RequestMapping("/getConfigList")
	@ResponseBody
	public String testConfig(Config config, int page, int rows,HttpServletRequest request) {
		MiniDaoPage<Config> configList = configurationService.getConfigList(config, page,rows);
		List<Config> configResults = configList.getResults();
		
		configList.setResults(configResults);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", configList.getPages());
		json.put("total", configList.getTotal());
		// 日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		JSONArray jsonArray = JSONArray.fromObject(configList.getResults(),jsonConfig);
		json.put("data", jsonArray);
		return json.toString();
	}
	
	/**
	 * 添加CONFIG
	 */
	@RequestMapping("/addConfig")
	@ResponseBody
	public String addTask(Config config,HttpServletRequest request){		
		JSONObject result = new JSONObject();
		Config configs = new Config();
		configs.setConfigid(config.getConfigid());
		configs.setSubid(config.getSubid());
		if(configurationService.getConfigInfo(configs).size()==0){
			configs.setSubname(config.getSubname());
			if(configurationService.getConfigInfo(configs).size()==0){
				try {
					configurationService.addConfig(config);
					result.put("result", "success");
				} catch (Exception e) {
					result.put("result", "error");	
				}
			}else{
				result.put("result", "subName");
			}
		}else{
			result.put("result", "info");
		}
		return result.toString();
	}
	/**
	 * 删除CONFIG
	 */
	@RequestMapping("/deleteConfig")
	@ResponseBody
	public String deleteConfig(Integer configid){		
		configurationService.deleteConfig(configid);
		JSONObject result = new JSONObject();
		result.put("result", true);
		return result.toString();
	}
}
