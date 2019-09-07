package cn.zup.wechat.controller;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;
import cn.zup.wechat.quartz.QuartzJob;
import cn.zup.wechat.service.BindWechatService;
import cn.zup.wechat.service.WechatServerService;

import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/rest/wechat/wechatServiceManageController")
public class WechatServiceManageController {
	
	@Resource
	private WechatServerService wechatServerService;
	@Resource
	private BindWechatService bindService;
	
	@RequestMapping("")
	public ModelAndView index(){
		return new ModelAndView("wechat/wechatServiceManage");
	}
	
	@RequestMapping("/getWechatList")
	@ResponseBody
	public String getWechatList(WechatServer ws, Integer rows, Integer page){
		JSONObject json = new JSONObject();
		ws.setValidFlagStr(ConfigSetting.ValigFlag.getValue()+"");
		MiniDaoPage<WechatServer> list = wechatServerService.getWechatServiceListByPage(ws, rows, page);
		json.put("rows", rows);
		json.put("page", list.getPages());
		json.put("total",list.getTotal());
		json.put("data", list.getResults());
		return json.toString();
	}
	
	@RequestMapping("/addWechatService")
	@ResponseBody
	public String addWechatService(WechatServer ws){
		JSONObject json = new JSONObject();
		int re = wechatServerService.addWechatService(ws);
		json.put("data", re);
		return json.toString();
	}
	
	/** 
	 *删除公众号
	 *
	 * @date 2017-7-15 14:24:32 
	 */
	@RequestMapping("/delWechatService")
	@ResponseBody
	public String delWechatService(@RequestParam("actionIds[]") String[] serviceIDs){
		JSONObject json = new JSONObject();
		for(int i=0; i<serviceIDs.length; i++){	
			WechatServer ws = new WechatServer();
			ws.setService_ID(Integer.parseInt(serviceIDs[i]));
			wechatServerService.deleteWechatService(ws);
			json.put("result", "success");		
		}
		return json.toString();
	}
	
	/** 
	 * 公众号详情页面
	 *
	 *@date 
	*/
	@RequestMapping("/getWechatService")
	@ResponseBody
	public String getWechatService(WechatServer ws){
		JSONObject json = new JSONObject();
		WechatServer wsRe = wechatServerService.getWechatService(ws);
		json.put("data", wsRe);
		return json.toString();
	}

	/** 
	 * 公众号编辑更新
	 *
	 *@param post  岗位实体
	 *@date 2016-7-29 10:58:27
	*/
	@RequestMapping("/editWechatService")
	@ResponseBody
	public String editWechatService(WechatServer ws){
		JSONObject json = new JSONObject();
		int re = wechatServerService.updateWechatService(ws);
		json.put("data", re);
		return json.toString();
	}
	
	/** 
	 * 公众号编辑更新
	 *
	 *@param post  岗位实体
	 *@date 2016-7-29 10:58:27
	*/
	@RequestMapping("/getWechatSystem")
	@ResponseBody
	public String getWechatSystem(WechatSystem wsys){
		JSONObject json = new JSONObject();
		List<WechatSystem> list = bindService.getAllSystem();
		json.put("data", list);
		return json.toString();
	}
	
	/** 
	 * 公众号编辑更新
	 *
	 *@param post  岗位实体
	 *@date 2016-7-29 10:58:27
	*/
	@RequestMapping("/getWechatServiceLists")
	@ResponseBody
	public String getWechatServiceLists(){
		JSONObject json = new JSONObject();
		List<WechatServer> list = wechatServerService.getWechatServiceList(new WechatServer());
		json.put("data", list);
		return json.toString();
	}
	
	/** 
	 * 公众号获取token
	 *
	 * @param post  岗位实体
	 * @date 2016-7-29 10:58:27
	*/
	@RequestMapping("/getWechatServiceToken")
	@ResponseBody
	public String getWechatServiceToken(){
		JSONObject json = new JSONObject();
		QuartzJob qj = new QuartzJob();
		json.put("data", qj.getToken(wechatServerService));
		return json.toString();
	}
}
