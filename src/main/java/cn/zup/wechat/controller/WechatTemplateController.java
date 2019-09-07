package cn.zup.wechat.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.wechat.common.TemplateParam;
import cn.zup.wechat.entity.CustomWxMsgEntity;
import cn.zup.wechat.entity.ServerTempView;
import cn.zup.wechat.entity.WechatRegister;
import cn.zup.wechat.entity.WechatSystem;
import cn.zup.wechat.entity.WechatTemplate;
import cn.zup.wechat.service.BindWechatService;
import cn.zup.wechat.service.WechatTemplateService;
import cn.zup.wechat.util.GlobalConstants;
import cn.zup.wechat.util.WxSendMsg;

import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/rest/wechat/wechatTemplateController")
public class WechatTemplateController {
	
	@Resource
	private WechatTemplateService wechatTemplateService;
	@Resource
	private BindWechatService bindWechatService;

	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("wechat/wechatTemplateManage");
	}
	
	@RequestMapping("/getWechatTemplateList")
	@ResponseBody
	public String getWechatList(WechatTemplate wsys, Integer rows, Integer page){
		JSONObject json = new JSONObject();
		MiniDaoPage<WechatTemplate> list = wechatTemplateService.getWechatTemplateListByPage(wsys, rows, page);
		json.put("rows", rows);
		json.put("page", list.getPages());
		json.put("total",list.getTotal());
		json.put("data", list.getResults());
		return json.toString();
	}
	
	@RequestMapping("/addWechatTemplate")
	@ResponseBody
	public String addWechatTemplate(WechatTemplate wsys){
		JSONObject json = new JSONObject();
		int re = wechatTemplateService.addWechatTemplate(wsys);
		json.put("data", re);
		return json.toString();
	}
	
	/** 
	 *删除公众号模板
	 *
	 * @date 2017-7-15 14:24:32 
	 */
	@RequestMapping("/delWechatTemplate")
	@ResponseBody
	public String delWechatTemplate(@RequestParam("actionIds[]") String[] TemplateIds){
		JSONObject json = new JSONObject();
		for(int i=0; i<TemplateIds.length; i++){	
			WechatTemplate wt = new WechatTemplate();
			wt.setTemp_Id(Integer.parseInt(TemplateIds[i]));
			wechatTemplateService.deleteWechatTemplate(wt);
			json.put("result", "success");		
		}
		return json.toString();
	}
	
	/** 
	 * 公众号模板详情页面
	 *
	 *@date 
	*/
	@RequestMapping("/getWechatTemplate")
	@ResponseBody
	public String getWechatTemplate(WechatTemplate wt){
		JSONObject json = new JSONObject();
		WechatTemplate wsysRe = wechatTemplateService.getWechatTemplate(wt);
		json.put("data", wsysRe);
		return json.toString();
	}

	/** 
	 * 公众号模板编辑更新
	 *
	 *@param post  岗位实体
	 *@date 2016-7-29 10:58:27
	*/
	@RequestMapping("/editWechatTemplate")
	@ResponseBody
	public String editWechatTemplate(WechatTemplate wt){
		JSONObject json = new JSONObject();
		int re = wechatTemplateService.updateWechatTemplate(wt);
		json.put("data", re);
		return json.toString();
	}
	
	/** 
	 * 公众号模板详情列表
	 *
	 *@date 
	*/
	@RequestMapping("/getWechatTempList")
	@ResponseBody
	public String getWechatTempList(){
		JSONObject json = new JSONObject();
		WechatTemplate wt = new WechatTemplate();
		List<WechatTemplate> wsysRe = wechatTemplateService.getWechatTemplateList(wt);
		json.put("data", wsysRe);
		return json.toString();
	}
	
	/** 
	 * 手动发送公众号
	 * @author Andot
	 * 
	*/
	@RequestMapping("/sendCustomWxMsg")
	@ResponseBody
	public String sendCustomWxMsg(CustomWxMsgEntity customWxMsgEntity) {
		JSONObject json = new JSONObject();
		//获取token名称是采用写死的key值，现在采用获取数据进行获取
		WechatSystem wsys = new WechatSystem();
		wsys.setRegion_Id(customWxMsgEntity.getRegionId());
		wsys.setRegion_Type(2);
		ServerTempView stv = bindWechatService.getServerTemp(wsys).get(0);
		WechatRegister wechatRegister=new WechatRegister();
		wechatRegister.setRegisterName(customWxMsgEntity.getAccountName());
		WechatRegister wechatRegisterTemp=bindWechatService.getRegister(wechatRegister);
		String wx_account= wechatRegisterTemp.getWxAccount();//获取微信账号
		String principal_access_token = GlobalConstants.getString(stv.getToken_Name());//获取微信tonken
		List<TemplateParam> paras=new ArrayList<TemplateParam>();  //获取告警记录有关的信息的模板
		//封装发送消息模板
		paras.add(new TemplateParam("first", customWxMsgEntity.getTitle(),"#FF3333"));  
		paras.add(new TemplateParam("keyword1",customWxMsgEntity.getSubTitle(),"#0044BB"));  
		paras.add(new TemplateParam("keyword2", customWxMsgEntity.getContent(),"#0044BB"));  
		paras.add(new TemplateParam("remark", customWxMsgEntity.getFooter(),"#AAAAAA"));
		try {
			Map<String, String> map = WxSendMsg.sendmsg(principal_access_token,wx_account, paras, "", stv.getTemplate_Id(), stv.getTop_Color());
			if(map.get("result") == "true"){
				json.put("data", "消息发送成功，"+map.get("data"));
			}else{
				json.put("data", "消息发送失败，失败原因为："+map.get("data"));
			}
		} catch (Exception e) {
			json.put("data", "微信发送消息异常，原因可能为：Token不存在；详细异常信息："+e);
		}
		return json.toString();
	}
}
