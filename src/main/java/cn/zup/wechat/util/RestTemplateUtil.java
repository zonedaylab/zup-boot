package cn.zup.wechat.util;

import javax.imageio.ImageIO;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import cn.zup.wechat.entity.TicketInTokenEntity;
import net.sf.json.JSONObject;

/**
 * Rest风格的API接口请求工具类
 * 
 * */
@Configuration
public class RestTemplateUtil {
	
	
	@Bean
	public RestTemplate getRestTemplate() {
	    return new RestTemplate();
	}
	
	/**
	 * 通过token获取Ticket
	 * @throws Exception 
	 * 
	 * */
	public String postRequestTokenInTicket(String token, Integer scene_Id, String scene_Str) throws Exception {
		String url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+token;
		TicketInTokenEntity request = new TicketInTokenEntity();
		TicketInTokenEntity.ActionInfo action_Info = request.new ActionInfo();
		TicketInTokenEntity.Scene scene = request.new Scene();
		if(scene_Str != null) {
			request.setAction_name("QR_LIMIT_STR_SCENE");
		}
		scene.setScene_id(scene_Id);
		scene.setScene_str(scene_Str);
		action_Info.setScene(scene);
		request.setAction_info(action_Info);
		HttpHeaders headers = new HttpHeaders();
		MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
		headers.setContentType(type);
		headers.add("Accept", MediaType.APPLICATION_JSON.toString());
		JSONObject jsonObj = JSONObject.fromObject(request);
		System.err.println(jsonObj);
		HttpEntity<String> formEntity = new HttpEntity<String>(jsonObj.toString(), headers);
		JSONObject result = getRestTemplate().postForObject(url, formEntity, JSONObject.class);
		if(result.get("ticket") == null) {
			throw new Exception("微信获取票据出现问题，请联系管理员说明："+result.get("errmsg"));
		}
		return result.get("ticket").toString();
	}
	
	/**
	 * 通过Ticket获取二维码
	 * 
	 * */
	public String postRequestTicketInQRCodeUrl(String ticket) {
		String url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="+ticket;
		return url;
	}

}
