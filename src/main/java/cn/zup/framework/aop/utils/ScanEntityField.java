package cn.zup.framework.aop.utils;

import java.lang.reflect.Field;

import net.sf.json.JSONObject;

/**
 * 扫描传入的实体然后进行反射出字段和字段值
 * @author Andot
 * @date 2017-12-21 13:48:47
 * 
 * 
 * */
public class ScanEntityField {
	
	/**
	 * 根据传入的实体，进行反射出实体的字段和字段值，连接成json字符串返回
	 * @author Andot
	 * @date 2017-12-21 13:49:32
	 * @param obj 实体对象
	 * @return json字符串
	 * 
	 * */
	public static String getFieldValue(Object obj){
		JSONObject json = new JSONObject();
		Class<?> c = obj.getClass();
		Field[] fields = c.getDeclaredFields();
		for (Field field : fields) {   
	        field.setAccessible(true);   // 如果不为空，设置可见性，然后返回   
	        try {   
	           // 设置字段可见，即可用get方法获取属性值。   
	           if(field.get(obj) != null){
	        	   json.put(field.getName(), field.get(obj));
	           }
	        } catch (Exception e) {   
	           System.err.println("method name: getFieldValue; error--------.Reason is:"+e.getMessage());   
	        }
		}
        return json.toString();
	}
	
}
