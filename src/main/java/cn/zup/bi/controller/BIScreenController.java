package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Screen;
import cn.zup.bi.service.BIScreenService;
import cn.zup.framework.common.vo.CommonResult;
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
@RequestMapping("/rest/bi/biScreenController")
public class BIScreenController {
	
	@Resource
	private BIScreenService biScreenService;
	
	/**
	 * 返回首页
	 * @author 谢炎
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		//需要优化pageId为空
		String pageId = request.getParameter("pageId");
		ModelAndView mv = new ModelAndView("bi/biScreenManage");
		mv.addObject("pageId", pageId);
		return mv;
		//return new ModelAndView("bi/biScreenManage");
	}
	
	/**
	 * 保存报表显示页面
	 * @author 谢炎
	 * */
	@RequestMapping("/saveScreen")
	@ResponseBody
	public String saveScreen(BI_Screen bi_Screen){
		JSONObject json = new JSONObject();
		int b = biScreenService.updateScreenInfo(bi_Screen);
		if(b==1) {
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
	@RequestMapping("/updateScreen")
	@ResponseBody
	public String updateScreen(BI_Screen bi_Screen){
		JSONObject json = new JSONObject();
		int b = biScreenService.updateScreenInfo(bi_Screen);
		if(b==1) {
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
	@RequestMapping("/deleteScreen")
	@ResponseBody
	public String deleteScreen(@RequestParam("screen_Ids[]") Integer[] bi_Screen_Ids){
		String ids = "";
		JSONObject json = new JSONObject();
		for (int i = 0; i < bi_Screen_Ids.length; i++) {
			int b = biScreenService.deleteScreenInfo(bi_Screen_Ids[i]);
			if(b == 0){
				ids += bi_Screen_Ids[i] + ", ";
				json.put("data", "fial");
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
	@RequestMapping("/getScreenInfo")
	@ResponseBody
	public String getScreenInfo(BI_Screen bi_Screen){
		BI_Screen biScreenResult = biScreenService.getBiScreen(bi_Screen);
		JSONObject json = new JSONObject();
		json.put("data", biScreenResult);
		return json.toString();
	}
	
	/**
	 * 更新报表页面分页列表
	 * @author 谢炎
	 * */
	@RequestMapping("/getScreenListByPage")
	@ResponseBody
	public CommonResult getPageListByPage(BI_Screen bi_Screen, int rows, int page){
		List<BI_Screen> list = biScreenService.getBIScreenListPage(bi_Screen, page, rows);
		return CommonResult.successPage(list, page, rows);
	}
	
}
