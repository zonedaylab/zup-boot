package cn.zup.wechat.controller;

import java.io.IOException;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.zup.rbac.service.settings.ValigFlag;
import cn.zup.wechat.entity.InputMsgEntity;
import cn.zup.wechat.entity.ReferrerEntity;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.service.ReferrerService;
import cn.zup.wechat.service.WechatServerService;
import cn.zup.wechat.util.GlobalConstants;
import cn.zup.wechat.util.RestTemplateUtil;
import cn.zup.wechat.util.SignUtil;
import cn.zup.wechat.util.WechatXmlUtil;

@Controller
@RequestMapping("/wechatController")
public class WechatController {

	public static Logger log = Logger.getLogger(WechatController.class);
	
	@Resource
	private WechatServerService wechatServerService;
	@Autowired
	private RestTemplateUtil restTemplateUtil;
	@Resource
	private ReferrerService referrerService;
	
	/**
	 * 微信服务器验证 和接受消息
	 * @throws Exception 
	 * 
	 * */
	@RequestMapping("")
	public void wechatGet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean isGet = request.getMethod().toLowerCase().equals("get");
		if(isGet) {
			log.debug("微信进行服务器认证");
			String signature = request.getParameter("signature");  
            String timestamp = request.getParameter("timestamp");  
            String nonce = request.getParameter("nonce");  
            String echostr = request.getParameter("echostr");
			if (SignUtil.checkSignature("jcnywx", signature,
					timestamp, nonce)) {
				try {
					response.getWriter().print(echostr);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}else {
			log.debug("微信进行消息事件推送");
			try {
				WechatXmlUtil<InputMsgEntity> wechatXmlUtil = new WechatXmlUtil<InputMsgEntity>();
				ServletInputStream in = null;
				try {
					in = (ServletInputStream)request.getInputStream();
				} catch (IOException e) {
					log.error("类转换异常，微信消息接受出现流转换异常，具体信息为："+e.getMessage());
				}
				InputMsgEntity inputMsgEntity = new InputMsgEntity();
				InputMsgEntity ime = wechatXmlUtil.xmlTransObject(inputMsgEntity, in);
				if(ime.getEvent() != null) {
					if(ime.getEvent().equals("subscribe") || ime.getEvent().equals("SCAN")) {
						WechatServer ws = new WechatServer();
						ws.setOriginal_ID(ime.getToUserName());
						ws.setValidFlag(ValigFlag.yes.getValue());
						WechatServer wsResult = wechatServerService.getWechatService(ws);
						String accessToken = GlobalConstants.getString(wsResult.getToken_Name());
						String ticket = restTemplateUtil.postRequestTokenInTicket(accessToken, null, ime.getFromUserName());
						String qrcodeUrl = restTemplateUtil.postRequestTicketInQRCodeUrl(ticket);
						System.err.println(ime.getFromUserName());
						StringBuffer str = new StringBuffer();  
						String message = "";
						ReferrerEntity entity = new ReferrerEntity();
						entity.setReferral_Openid(ime.getFromUserName());
						if(referrerService.getRefrrer(entity).getReferrer_Id() != null) {
							StringBuffer url = request.getRequestURL();  
							String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
							message = "你已经绑定推荐人了，是否需要解绑？\n<a href=\""+tempContextUrl+"/rest/wechat/qrCodeCallBackController/unBindQRCodeReferrer?openid="+ime.getFromUserName()+"\">解绑</a>";
							//referrerService.deleteRefrrer(entity);
						}else { 
							//TODO 这里需要把推荐人换成中文名称，需要先用openid获取账户，如果账户获取不到提示推荐人未绑定账户，如果存在获取用户名返回
							ReferrerEntity entityGet = new ReferrerEntity();
							entityGet.setReferral_Openid(ime.getEventKey().replaceAll("qrscene_", ""));
							entityGet = referrerService.getRefrrer(entityGet);
							String rName = "无";
							if(referrerService.getRefrrer(entityGet).getReferralName() != null) {
								rName = entityGet.getReferralName();
							}else {
								rName = "推荐您的用户未注册平台，未查询到名称！";
							}
							String wel = "感谢你的关注!你的推荐人是:"+rName+" \n";
							if(entityGet.getReferrer_Welong() != null) {
								wel = entityGet.getReferrer_Welong()+" \n";
							}
							message = wel + "<a href=\""+qrcodeUrl+"\">点击这里获取你的专属二维码</a>";
							entity.setReferrer_Openid(ime.getEventKey().replaceAll("qrscene_", ""));
							entity.setReferral_QRCode(qrcodeUrl);
							referrerService.addRefrrer(entity);
						}
			            str.append("<xml>");
			            str.append("<ToUserName><![CDATA[" + ime.getFromUserName() + "]]></ToUserName>");  
			            str.append("<FromUserName><![CDATA[" + ime.getToUserName() + "]]></FromUserName>");  
			            str.append("<CreateTime>" + Calendar.getInstance().getTime().getTime() + "</CreateTime>");  
			            str.append("<MsgType><![CDATA[text]]></MsgType>");  
			            str.append("<Content><![CDATA["+new String(message.getBytes(), "ISO-8859-1")+"]]></Content>");  
			            str.append("</xml>");  
			            response.getWriter().write(str.toString());
					} else if(ime.getEvent().equals("unsubscribe")) {
						return;
					} 
				} else {
					if(ime.getContent().indexOf("二维码") > -1){
						ReferrerEntity entity = new ReferrerEntity();
						entity.setReferral_Openid(ime.getFromUserName());
						ReferrerEntity rentity = referrerService.getRefrrer(entity);
						if(rentity.getReferrer_Id() != null) {
							StringBuffer str = new StringBuffer();  
							String message = "点击这里获取你的专属 <a href='"+rentity.getReferral_QRCode()+"'>二维码</a>";
							str.append("<xml>");
				            str.append("<ToUserName><![CDATA[" + ime.getFromUserName() + "]]></ToUserName>");  
				            str.append("<FromUserName><![CDATA[" + ime.getToUserName() + "]]></FromUserName>");  
				            str.append("<CreateTime>" + Calendar.getInstance().getTime().getTime() + "</CreateTime>");  
				            str.append("<MsgType><![CDATA[text]]></MsgType>");  
				            str.append("<Content><![CDATA["+new String(message.getBytes(), "ISO-8859-1")+"]]></Content>");  
				            str.append("</xml>");  
				            response.getWriter().write(str.toString());
						} else {
							StringBuffer str = new StringBuffer();  
							String message = "抱歉，你还没有预留信息，无法为您提供二维码，需要点击绑定或者扫描二维码关注后才可以，或者重新关注！";
							str.append("<xml>");
				            str.append("<ToUserName><![CDATA[" + ime.getFromUserName() + "]]></ToUserName>");  
				            str.append("<FromUserName><![CDATA[" + ime.getToUserName() + "]]></FromUserName>");  
				            str.append("<CreateTime>" + Calendar.getInstance().getTime().getTime() + "</CreateTime>");  
				            str.append("<MsgType><![CDATA[text]]></MsgType>");  
				            str.append("<Content><![CDATA["+new String(message.getBytes(), "ISO-8859-1")+"]]></Content>");  
				            str.append("</xml>");  
				            response.getWriter().write(str.toString());
						}
						
					}
				}
			} catch (Exception e) {
				throw new Exception("微信触发事件异常，具体异常信息："+e.getMessage());
			}
		}
	}

}
