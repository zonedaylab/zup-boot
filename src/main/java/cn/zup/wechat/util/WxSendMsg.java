package cn.zup.wechat.util;

import java.util.List;
import java.util.Map;

import cn.zup.wechat.common.SendTemplate;
import cn.zup.wechat.common.Template;
import cn.zup.wechat.common.TemplateParam;

public class WxSendMsg {
	
	/**
	 * @param token 获取token，示例：String principal_access_token=GlobalConstants.getString("principal_access_token");
	 * @param openid 当前登录用户的openid
	 * @param paras 需要传入的值，格式如下：
				 	List<TemplateParam> paras=new ArrayList<TemplateParam>();  
					paras.add(new TemplateParam("first","你好，微OA有新任务: )","#FF3333"));  
					paras.add(new TemplateParam("keyword1","报销单等待审批","#0044BB"));  
					paras.add(new TemplateParam("keyword2","测试，韩圣传发送","#0044BB"));  
					paras.add(new TemplateParam("remark","请尽快进行处理","#AAAAAA")); 
	 * @param url　点击内容的展示页面，没有页面链接可赋值：url = ""
	 * @return boolean 发送成功返回true，发送失败返回false
	 */
	public static Map<String, String> sendmsg(String token,String openid,List<TemplateParam> paras,String url, String tempId, String color) {
		
		Template tem=new Template();  
		tem.setTemplateId(tempId);  //"snv9qa_ms8x0rkd0pNBAJzZzanqV8LRi1uxgNP33ZfE"
		tem.setTopColor(color);  
		tem.setToUser(openid);  
		tem.setUrl(url);  
		          
		tem.setTemplateParamList(paras);
		
		System.out.println();
		
		Map<String, String> result=SendTemplate.sendTemplateMsg(token,tem);  
		System.out.println(result);
		
		return result;
		
		//以下注释为调试与第二种方法代码
		
//		Template tem=new Template();  
//		tem.setTemplateId("9cUKRnTu0RUL38Sh3h7_EJWVzVy-2XtNaEJSKi_-MxQ");  
//		tem.setTopColor("#00DD00");  
//		tem.setToUser("oWKbcwQM00EpHBqcyQmQLmf4g1kg");  
//		tem.setUrl("");  
//		          
//		List<TemplateParam> paras=new ArrayList<TemplateParam>();  
//		paras.add(new TemplateParam("first","你好，微OA有新任务: )","#FF3333"));  
//		paras.add(new TemplateParam("keyword1","报销单等待审批","#0044BB"));  
//		paras.add(new TemplateParam("keyword2","测试，韩圣传发送","#0044BB"));  
//		paras.add(new TemplateParam("remark","请尽快进行处理","#AAAAAA"));  
//		          
//		tem.setTemplateParamList(paras);
//		
//		System.out.println(GlobalConstants.getString("access_token"));
//		
//		boolean result=SendTemplate.sendTemplateMsg("dGXosyiA0nX2BsepfFNWY-kpPMPNV4N4LJHKhcdf0taTa5WMdebjUBg6esO7a7YbfzGorGbQ2cU7fIa4ILAQxRZOwFUR1NQ5xwemr1cCPxkhAj9f21PSscHmAH9FD1E0JXGiAFAYMV",tem);  
//		System.out.println(result);
		
		
		
//		WxTemplate t = new WxTemplate();  
//        t.setUrl("http://weixin.qq.com/download");  
//        t.setTouser("oZGIxwA53DwipZGxGrasxnaCenPg");  
//        //t.setTouser("oWKbcwQM00EpHBqcyQmQLmf4g1kg");
//        t.setTopcolor("#000000");  
//        t.setTemplate_id("snv9qa_ms8x0rkd0pNBAJzZzanqV8LRi1uxgNP33ZfE");  
//        Map<String,TemplateData> m = new HashMap<String,TemplateData>();  
//        TemplateData first = new TemplateData();  
//        first.setColor("#000000");  
//        first.setValue("***标题***");  
//        m.put("first", first);  
//        
//        TemplateData name = new TemplateData();  
//        name.setColor("#000000");  
//        name.setValue("***名称***");  
//        m.put("keyword1", name);  
//        
//        TemplateData keyword2 = new TemplateData();  
//        keyword2.setColor("#000000");  
//        keyword2.setValue("***名称***");  
//        m.put("keyword2", keyword2);  
//        
//        TemplateData remark = new TemplateData();  
//        remark.setColor("blue");  
//        remark.setValue("***备注说明***");  
//        m.put("remark", remark);  
//        
//        t.setData(m); 
//        
//        String s = JSONObject.fromObject(t).toString();
//        
//        s=s.replaceAll("null", "\"{{}}\"");
//        
//        System.out.println(s);
//        
//        JSONObject jsonobj = CommonUtil.httpRequest
//        ("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=dGXosyiA0nX2BsepfFNWY-kpPMPNV4N4LJHKhcdf0taTa5WMdebjUBg6esO7a7YbfzGorGbQ2cU7fIa4ILAQxRZOwFUR1NQ5xwemr1cCPxkhAj9f21PSscHmAH9FD1E0JXGiAFAYMV", 
//        		"POST",s); 
//        
//        System.out.println(jsonobj.toString());
	}
}
