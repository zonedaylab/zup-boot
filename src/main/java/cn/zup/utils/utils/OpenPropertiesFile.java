package cn.zup.utils.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class OpenPropertiesFile {
	public static Map<String, String> getProValue(String fileName){
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		Properties props = new Properties();
		InputStream in = null;
		Map<String, String> map = new HashMap<String, String>();
		try {
			in = cl.getResourceAsStream(fileName);
			props.load(in);
			for(Object key : props.keySet()){
				map.put(key.toString(), props.get(key).toString());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(in!=null){
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return map;
	}
}
