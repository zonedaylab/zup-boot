package cn.zup.wechat.controller;

import java.util.Date;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.wechat.entity.WechatRegister;
import cn.zup.wechat.service.BindWechatService;

@Controller
@RequestMapping("/rest/wechat/wechatBindUserController")
public class WechatBindUserController {
	
	@Resource
	private BindWechatService bindService;
	
	/**
	 * 微信绑定统计查看页面
	 * 
	 * */
	@RequestMapping("")
	@ResponseBody
	public ModelAndView wechatIndex() {
		return new ModelAndView("wechat/bindWechatInfo");
	}
	
	/**
	 * 微信绑定统计查看页面
	 * 
	 * */
	@RequestMapping("/wechatBindList")
	@ResponseBody
	public String getWechatBindList(WechatRegister wr, int rows, int page) {
		if(wr.getRegisterName().equals(""))
			wr.setRegisterName(null);
		if(wr.getRegisterPwd().equals(""))
			wr.setRegisterPwd(null);
		MiniDaoPage<WechatRegister> list = bindService.getRegisterList(wr, rows, page);
		JSONObject json = new JSONObject();
		json.put("rows", rows); 
		json.put("page", list.getPages());
		json.put("total",list.getTotal());		
		//日期类型转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONArray jsonArray = JSONArray.fromObject(list.getResults(),jsonConfig);
		json.put("data", jsonArray);
		return json.toString();
	}
	
	/**
	 * 微信绑定统计查看页面
	 * 
	 * */
	@RequestMapping("/closeBind")
	@ResponseBody
	public String closeBind(WechatRegister wr) {
		WechatRegister info = bindService.getRegister(wr);
		int result = bindService.delRegister(info);
		JSONObject json = new JSONObject();
		//判断用户输入的加密的密码和用户的真实密码是否相同
		if(result > 0){
			json.put("info", "success");
			System.err.println("删除成功");
		}
		else{
			json.put("info", "error");
		}
		return json.toString();
	}
}
