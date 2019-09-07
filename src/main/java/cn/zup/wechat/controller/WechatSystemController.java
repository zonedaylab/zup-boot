package cn.zup.wechat.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;
import cn.zup.wechat.entity.WechatTemplate;
import cn.zup.wechat.service.BindWechatService;

import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/rest/wechat/wechatSystemController")
public class WechatSystemController {
	
	@Resource
	private BindWechatService bindService;
	
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("wechat/wechatSystemManage");
	}
	
	@RequestMapping("/getweChatSystemList")
	@ResponseBody
	public String getSystemList(WechatSystem wsys, Integer rows, Integer page){
		JSONObject json = new JSONObject();
		MiniDaoPage<WechatSystem> list = bindService.getSystemList(wsys, rows, page);
		json.put("rows", rows);
		json.put("page", list.getPages());
		json.put("total",list.getTotal());
		json.put("data", list.getResults());
		return json.toString();
	}
	
	@RequestMapping("/addWechatSystem")
	@ResponseBody
	public String addWechatSystem(WechatSystem wsys){
		JSONObject json = new JSONObject();
		int re = bindService.addSystem(wsys);
		json.put("data", re);
		return json.toString();
	}
	/** 
	 *删除公众号系统
	 *
	 * @date 2017-7-15 14:24:32 
	 */
	@RequestMapping("/delWechatSystem")
	@ResponseBody
	public String delWechatSystem(@RequestParam("actionIds[]") String[] companyIds){
		JSONObject json = new JSONObject();
		for(int i=0; i<companyIds.length; i++){	
			WechatSystem wsys = new WechatSystem();
			wsys.setCompany_Id(Integer.parseInt(companyIds[i]));
			bindService.deleteSystem(wsys);
			json.put("result", "success");		
		}
		return json.toString();
	}
	
	/** 
	 * 公众号系统详情页面
	 *
	 *@date 
	*/
	@RequestMapping("/getWechatSystem")
	@ResponseBody
	public String getWechatSystem(WechatSystem wsys){
		JSONObject json = new JSONObject();
		WechatSystem wsysRe = bindService.getSystemInfo(wsys);
		json.put("data", wsysRe);
		return json.toString();
	}

	/** 
	 * 公众号系统编辑更新
	 *
	 *@param post  岗位实体
	 *@date 2016-7-29 10:58:27
	*/
	@RequestMapping("/editWechatSystem")
	@ResponseBody
	public String editWechatSystem(WechatSystem wsys){
		JSONObject json = new JSONObject();
		int re = bindService.updateSystem(wsys);
		json.put("data", re);
		return json.toString();
	}
	/** 
	 * 公众号系统详情页面
	 *
	 *@date 
	*/
	@RequestMapping("/getAllService")
	@ResponseBody
	public String getAllService(){
		JSONObject json = new JSONObject();
		List<WechatServer> wserList = bindService.getAllService();
		json.put("data", wserList);
		return json.toString();
	}
}
