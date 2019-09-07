package cn.zup.wechat.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.zup.wechat.common.JSSDK_Config;
import cn.zup.wechat.common.Message;
import cn.zup.wechat.quartz.WeChatTask;
import cn.zup.wechat.util.GlobalConstants;
import cn.zup.wechat.util.PicUtil;

/**
 * @Description: 前端用户微信配置获取
 * @author han
 */
@Controller
@RequestMapping("/rest/wechat/wechatController/wechatconfig")
public class JssdkWeChatController {
	private static Logger logger = Logger.getLogger(JssdkWeChatController.class);

	/**
	 * @Description: 前端获取微信JSSDK的配置参数
	 * @author han
	 */
	@RequestMapping("/jssdk")
	@ResponseBody
	public String JSSDK_config(
			@RequestParam(value = "url", required = true) String url) {
		try {
			Map<String, String> configMap = JSSDK_Config.jsSDK_Sign(url);
			Message m = Message.success(configMap);
			JSONObject json = new JSONObject();
			json.put("data", m);
			return json.toString();
		} catch (Exception e) {
			logger.error(e, e);
			Message m = Message.error();
			JSONObject json = new JSONObject();
			json.put("data", m);
			return json.toString();
		}

	}

	/**
	 * @Description: 下载微信服务器端的图片
	 * @author han
	 */
	@RequestMapping("/download")
	@ResponseBody
	public String download(HttpServletRequest request, Model model) {
		String media_id = request.getParameter("serverId");
		String path = request.getSession().getServletContext().getRealPath("/")+"upload\\" + media_id + ".jpg";
		System.out.println("media_id: " + media_id);
		String access_token=GlobalConstants.getString("access_token");
		System.out.println("path---"+path);
		System.out.println("access_token===="+access_token);
		
		PicUtil.downloadImg(media_id, access_token, path);
		return "true";
	}

}
