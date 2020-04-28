package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Page;
import cn.zup.bi.entity.BiMenu;
import cn.zup.bi.service.BIPageService;
import cn.zup.bi.service.settings.MgeidsConfig;
import cn.zup.framework.common.vo.CommonResult;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.service.ConfigurationService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/rest/bi/biPageController")
public class BIPageController {
	
	@Resource
	private BIPageService biPageService;
	@Resource
	private ConfigurationService configurationService;

	/**
	 * 返回首页
	 * @author 谢炎
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("bi/biReportPageManage");
	}
	
	/**
	 * 保存报表显示页面
	 * @author 谢炎
	 * */
	@RequestMapping("/savePage")
	@ResponseBody
	public String savePage(BI_Page bi_Page) {
		JSONObject json = new JSONObject();
		int b = biPageService.updatePageInfo(bi_Page);
		if (b == 1){
			json.put("data", "success");
		} else {
			json.put("data", "fial");
		}
		return json.toString();
	}
	
	/**
	 * 更新报表显示页面
	 * @author 谢炎
	 * */
	@RequestMapping("/updatePage")
	@ResponseBody
	public String updatePage(BI_Page bi_Page) {
		JSONObject json = new JSONObject();
		int b = biPageService.updatePageInfo(bi_Page);
		if (b == 1) {
			json.put("data", "success");
		} else {
			json.put("data", "fial");
		}
		return json.toString();
	}
	
	/**
	 * 删除报表显示页面
	 * @author 谢炎
	 * */
	@RequestMapping("/deletePage")
	@ResponseBody
	public String deletePage(@RequestParam("bi_Page_Ids[]") Integer[] bi_Page_Ids){
		String ids = "";
		JSONObject json = new JSONObject();
		for (int i = 0; i < bi_Page_Ids.length; i++) {
			int b = biPageService.deletePageInfo(bi_Page_Ids[i]);
			if(b == 0){
				ids += bi_Page_Ids[i] + ", ";
				json.put("data", "fail:"+ids);
			}else {
				json.put("data", "success");
			}
		}
		json.put("msg", ids);
		return json.toString();
	}
	
	/**
	 * 获取报表信息
	 * @author 谢炎
	 * */
	@RequestMapping("/getPageInfo")
	@ResponseBody
	public String getPageInfo(BI_Page bi_Page){
		BI_Page biPageResult = biPageService.getBiPage(bi_Page);
		JSONObject json = new JSONObject();
		json.put("data", biPageResult);
		return json.toString();
	}
	
	/**
	 * 页面列表
	 * @author 谢炎
	 * */
	@RequestMapping("/getPageList")
	@ResponseBody
	public String getPageList(BI_Page bi_Page){
		List<BI_Page> list = biPageService.getBiPageList(bi_Page);
		JSONObject json = new JSONObject();
		json.put("data", list);
		return json.toString();
	}
	
	/**
	 * 更新报表页面分页列表
	 * @author 谢炎
	 * */
	@RequestMapping("/getPageListByPage")
	@ResponseBody
	public CommonResult getPageListByPage(BI_Page bi_Page, int rows, int page){
		bi_Page.setPageTypeStr(MgeidsConfig.Page_Type.getValue()+"");
		List<BI_Page> list = biPageService.getBIPageListPage(bi_Page, page, rows);
		return CommonResult.successPage(list, page, rows);
	}
	
	/**
	 * 获取页面类型
	 * @author 谢炎
	 * */
	@RequestMapping("/getPageType")
	@ResponseBody
	public String getPageType(){
		Config config = new  Config();
		config.setConfigid(MgeidsConfig.Page_Type.getValue());
		List<Config> fieldType = configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", fieldType);
		return json.toString();
	}
	
	/**
	 * 
	 * 获取rbac菜单
	 * @author 谢炎
	 * */
	@RequestMapping("/getMenu")
	@ResponseBody
	public String getMenu(Integer accountId){
		Menu menu = new Menu();
		menu.setUrlAddress("@bi");
		List<BiMenu> list = biPageService.getMenuList(accountId);
		JSONObject json = new JSONObject();
		json.put("data", list);
		return json.toString();
	}
	
	/**
	 * 
	 * 获取页面模板
	 * @author 谢炎
	 * */
	@RequestMapping("/getTemplateUrl")
	@ResponseBody
	public String getTemplateUrl(){
		Config config = new  Config();
		config.setConfigid(MgeidsConfig.Template_Url.getValue());
		List<Config> fieldType = configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", fieldType);
		return json.toString();
	}
}
