package cn.zup.wechat.quartz;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import cn.zup.rbac.service.settings.ValigFlag;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.service.WechatServerService;
import cn.zup.wechat.util.GlobalConstants;


public class QuartzJob{
	private static Logger logger = Logger.getLogger(QuartzJob.class);
	
	@Resource
	private WechatServerService wechatServerService;
	
	/**
	 * @Description: 任务执行获取token
	 * @author han
	 */
	public void workForToken() {
		try {
			WeChatTask.getToken_Test();
			WechatServer ws = new WechatServer();
			ws.setValidFlag(ValigFlag.yes.getValue());
			try {
				int systemId = Integer.parseInt(GlobalConstants.getString("systemId"));
				ws.setSystem_Id(systemId);
			} catch (Exception e) {
				ws.setSystem_Id(null);
				logger.error("你没有在配置文件中设置系统id，微信自动加载token，微信获取token会加载所有token！");
			}
			List<WechatServer>  list = wechatServerService.getWechatServiceList(ws);
			for (WechatServer wechatServer : list) {
				WeChatTask timer = new WeChatTask();
				timer.getToken_getTicket(wechatServer);
			}
		} catch (Exception e) {
			logger.error(e, e);
		}
	}
	
	/**
	 * @Description: 任务执行获取token
	 * @author han
	 */
	public String getToken(WechatServerService wss) {
		try {
			WeChatTask.getToken_Test();
			WechatServer ws = new WechatServer();
			ws.setValidFlag(ValigFlag.yes.getValue());
			try {
				int systemId = Integer.parseInt(GlobalConstants.getString("systemId"));
				ws.setSystem_Id(systemId);
			} catch (Exception e) {
				ws.setSystem_Id(null);
				logger.error("你没有在配置文件中设置系统id，微信自动加载token，微信获取token会加载所有token！");
			}
			List<WechatServer>  list = wss.getWechatServiceList(ws);
			for (WechatServer wechatServer : list) {
				WeChatTask timer = new WeChatTask();
				timer.getToken_getTicket(wechatServer);
			}
			return "success";
		} catch (Exception e) {
			logger.error(e, e);
			return "error";
		}
	}


}
