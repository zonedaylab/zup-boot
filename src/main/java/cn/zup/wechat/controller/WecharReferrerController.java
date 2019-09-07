package cn.zup.wechat.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thoughtworks.xstream.XStream;

import cn.zup.wechat.entity.InputMsgEntity;
import cn.zup.wechat.entity.ReferrerEntity;
import cn.zup.wechat.service.ReferrerService;
import cn.zup.wechat.util.SerializeXmlUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/rest/wechat/qrCodeCallBackController")
public class WecharReferrerController {
	
	@Resource
	private ReferrerService referrerService;
	
	public static Logger log = Logger.getLogger(WecharReferrerController.class);
	
	/**
	 * 通过被关注人openid获取二维码
	 * @author Andot
	 * @date 2018年10月13日22:39:37
	 * @since 2.0
	 * @param openId 被推荐人id
	 * @return String 被推人二维码地址
	 * */
	@RequestMapping("/getQRCodeByReferralOpenid")
	@ResponseBody
	public String getQRCodeByReferralOpenid(String openId) {
		ReferrerEntity referrerEntity = new ReferrerEntity();
		referrerEntity.setReferral_Openid(openId);
		ReferrerEntity entity = referrerService.getRefrrer(referrerEntity);
		if(entity != null) {
			return entity.getReferral_QRCode();
		} else {
			throw new NullPointerException("该微信用户不存在");
		}
	}
	
	/**
	 * 通过被关注人openid获取二维码
	 * @author Andot
	 * @date 2018年10月13日22:39:37
	 * @since 2.0
	 * @param openId 推荐人id
	 * */
	@RequestMapping("/getReferralListByrReferrerOpenid")
	@ResponseBody
	public String getReferralListByrReferrerOpenid(String openId) {
		JSONObject json = new JSONObject();
		ReferrerEntity referrerEntity = new ReferrerEntity();
		referrerEntity.setReferrer_Openid(openId);
		List<ReferrerEntity> list = referrerService.getRefrrerList(referrerEntity);
		if(list != null) {
			json.put("data", list);
		} else {
			throw new NullPointerException("该推荐人没有推荐过用户");
		}
		json.put("msg", "直接重定向路径即可");
		return json.toString();
	}
	
	/**
	 * @throws IOException 
	 * 
	 * 
	 * */
	@RequestMapping("/unBindQRCodeReferrer")
	@ResponseBody
	public void unBindQRCodeReferrer(String openid, HttpServletResponse response, HttpServletRequest request) throws IOException {
		ReferrerEntity entity = new ReferrerEntity();
		entity.setReferral_Openid(openid);
		response.setContentType("text/html;charset=GBK");
		try {
			referrerService.deleteRefrrer(entity);
            response.getWriter().write(new String("<h1>解绑成功!</h1>".getBytes(), "UTF-8"));
		} catch (Exception e) {
			StringBuffer url = request.getRequestURL();  
			String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
			String msg = "<h1>抱歉，解绑失败，请重试!\n<a href='"+tempContextUrl+"/rest/wechat/qrCodeCallBackController/unBindQRCodeReferrer?openid="+openid+"'>解绑</a></h1>";
			response.getWriter().write(new String(msg.getBytes(), "UTF-8"));
		}
		
	}
	
	/**
	 * 推荐人自己自定义自己的欢迎语
	 * @author Andot
	 * @date 2018年10月13日
	 * @since 2.0
	 * @param openId 当前用户openId
	 * @param welang 欢迎语
	 * */
	@RequestMapping("/addReferrerWelang")
	@ResponseBody
	public String addReferrerWelang(String openId, String welang) {
		JSONObject json = new JSONObject();
		ReferrerEntity referrerEntity = new ReferrerEntity();
		referrerEntity.setReferral_Openid(openId);
		referrerEntity.setReferrer_Welong(welang);
		List<ReferrerEntity> list = referrerService.getRefrrerList(referrerEntity);
		if(list != null) {
			json.put("data", "success");
		} else {
			throw new NullPointerException("该推荐人没有推荐过用户");
		}
		json.put("msg", "添加成功");
		return json.toString();
	}
	
	/**
	 * 测试微信推送消息事件
	 * 
	 * */
	@RequestMapping("/testFoucsEvent")
	@ResponseBody
	public String foucs(HttpServletRequest request) {
		// 处理接收消息  
        ServletInputStream in = null;
		try {
			in = request.getInputStream();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
        // 将POST流转换为XStream对象  
        XStream xs = SerializeXmlUtil.createXstream();  
        xs.processAnnotations(InputMsgEntity.class);  
        // 将指定节点下的xml节点数据映射为对象  
        xs.alias("xml", InputMsgEntity.class);  
        // 将流转换为字符串  
        StringBuilder xmlMsg = new StringBuilder();  
        byte[] b = new byte[4096];  
        try {
        	for (int n; (n = in.read(b)) != -1;) {  
                xmlMsg.append(new String(b, 0, n, "UTF-8"));  
            } 
		} catch (Exception e) {
			// TODO: handle exception
		}
         
        // 将xml内容转换为InputMessage对象  
        InputMsgEntity inputMsg = (InputMsgEntity) xs.fromXML(xmlMsg.toString());
        JSONObject json = new JSONObject();
        json.put("data", inputMsg);
        return json.toString();
	}
}
