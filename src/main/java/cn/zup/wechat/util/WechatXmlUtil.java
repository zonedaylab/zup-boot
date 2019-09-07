package cn.zup.wechat.util;

import javax.servlet.ServletInputStream;
import com.thoughtworks.xstream.XStream;

/**
 * 微信XML转对象工具类
 * @author Andot
 * @Date 2018-10-11 08:44:14
 * 
 * */
public class WechatXmlUtil<T> {
	
	/**
	 * 微信通过留中解析XML文件并且转换为对象
	 * @author Andot
	 * @Date2018-10-11 08:43:14
	 * @since 2.0
	 * */
	public T xmlTransObject(T t,ServletInputStream in) { 
		// 处理接收消息  
	    // 将POST流转换为XStream对象  
	    XStream xs = SerializeXmlUtil.createXstream();  
	    xs.processAnnotations(t.getClass());
	    // 将指定节点下的xml节点数据映射为对象  
	    xs.alias("xml", t.getClass());  
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
	    @SuppressWarnings("unchecked")
		T msgEntity = (T) xs.fromXML(xmlMsg.toString());
	    return msgEntity;
	}
}
