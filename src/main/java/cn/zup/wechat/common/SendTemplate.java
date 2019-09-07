package cn.zup.wechat.common;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;
import cn.zup.wechat.util.CommonUtil;

public class SendTemplate {
	public static Map<String, String> sendTemplateMsg(String token, Template template) {

		Map<String, String> map = new HashMap<String, String>();

		String requestUrl = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", token);

		JSONObject jsonResult = CommonUtil.httpRequest(requestUrl, "POST",
				template.toJSON());
		if (jsonResult != null) {
			int errorCode = jsonResult.getInt("errcode");
			String errorMessage = jsonResult.getString("errmsg");
			if (errorCode == 0) {
				map.put("result", "true");
			} else {
				System.out.println("模板消息发送失败:" + errorCode + "," + errorMessage);
				map.put("result", "false");
				map.put("data", "模板消息发送失败:" + errorCode + "," + errorMessage);
			}
		}
		return map;

	}
	
	
}
