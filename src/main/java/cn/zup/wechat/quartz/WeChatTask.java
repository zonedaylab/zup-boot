package cn.zup.wechat.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import net.sf.json.JSONObject;

import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.util.GlobalConstants;
import cn.zup.wechat.util.HttpUtils;

/**
 * @Description: 微信两小时定时任务体（定时器）
 * @author han
 */
public class WeChatTask {
	
	private static Logger logger = Logger.getLogger(WeChatTask.class);

	/**
	 * 获取主号access_token
	 * 
	 * */
	public void getToken_getTicket(WechatServer wechatServer) throws Exception {
		//以上是获取微信公众号测试号，一下获取公众号主号access_token 并缓存
		logger.info("<=================公众号主号==============================>");
		Map<String, String> principalParams = new HashMap<String, String>();
		principalParams.put("grant_type", "client_credential");
		
		logger.info("appid:"+wechatServer.getAppid());
		logger.info("principalAppid:"+wechatServer.getAppsecret());
		
		
		principalParams.put("appid", wechatServer.getAppid());
		principalParams.put("secret", wechatServer.getAppsecret());
		String principalJstoken = HttpUtils.sendGet(GlobalConstants.getString("tokenUrl"), principalParams);
		
		logger.info("principalJstoken："+principalJstoken);
		String principal_access_token = "";
		try {
			principal_access_token = JSONObject.fromObject(principalJstoken).getString("access_token"); // 获取到token并赋值保存
			GlobalConstants.interfaceUrlProperties.put(wechatServer.getToken_Name(), principal_access_token);
		} catch (Exception e) {
			logger.info("principalJstoken公众号主号的token获取失败："+e.getMessage());
		}
		System.err.println(wechatServer.getToken_Name()+"看看有没有把accosstoken保存在配置文件中成功：====》"+GlobalConstants.getString(wechatServer.getToken_Name()));
		logger.info("principalJstoken公众号主号的token为："+principalJstoken);
	}
	/**
	 * 获取测试公众号access_token
	 * 
	 * */
	public static void getToken_Test() throws Exception {
		logger.info("<=================公众号测试号==============================>");
		Map<String, String> params = new HashMap<String, String>();
		//获取token执行体
		params.put("grant_type", "client_credential");
		params.put("appid", GlobalConstants.getString("appid"));
		params.put("secret", GlobalConstants.getString("AppSecret"));
		String jstoken = HttpUtils.sendGet(GlobalConstants.getString("tokenUrl"), params);
		String access_token = "";
		try {
			access_token = JSONObject.fromObject(jstoken).getString("access_token"); // 获取到token并赋值保存
			GlobalConstants.interfaceUrlProperties.put("access_token", access_token);
		} catch (Exception e) {
			logger.info("principalJstoken公众号主号的token获取失败："+e.getMessage());
		}
		//获取jsticket的执行体
		params.clear();
		params.put("access_token", access_token);
		params.put("type", "jsapi");
		String jsticket = HttpUtils.sendGet(GlobalConstants.getString("ticketUrl"), params);
		String jsapi_ticket = JSONObject.fromObject(jsticket).getString("ticket"); 
		GlobalConstants.interfaceUrlProperties.put("jsapi_ticket", jsapi_ticket); // 获取到js-SDK的ticket并赋值保存
		
		//时间戳
		GlobalConstants.interfaceUrlProperties.put("timestamp", Long.toString(System.currentTimeMillis() / 1000)); // 获取到js-SDK的ticket并赋值保存
		
		logger.info("jsapi_ticket================================================" + jsapi_ticket);
		logger.info(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"token为=============================="+access_token);

	}

}
