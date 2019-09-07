package cn.zup.framework.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Base {
	/**
	 * 
	 * MD5加码  生成32位md5码
	 * @author 谢炎
	 * @date 2016-9-26 10:08:02
	 * 
	 * */
	public static String md5AddCode(String SourceStr){
		// 拿到一个MD5转换器（如果想要SHA1参数换成”SHA1”）  
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		}
		 // 输入的字符串转换成字节数组  
		char[] charArr = SourceStr.toCharArray();
		byte[] byteArr= new byte[charArr.length];
		//charArr是输入字符串转换得到的字节数组
		for (int i = 0; i < charArr.length; i++) {
			byteArr[i] = (byte) charArr[i];
		}
		// 转换并返回结果，也是字节数组，包含16个元素  
		byte[] md5Bytes = md5.digest(byteArr);
		StringBuffer hexValue = new StringBuffer();
		for (int j = 0; j < md5Bytes.length; j++) {
			int val = ((int)md5Bytes[j])&0xff;
			if(val < 16){
				hexValue.append("0");
			}
			hexValue.append(Integer.toHexString(val));
		}
		 // 字符数组转换成字符串返回  
		return hexValue.toString();
	}
	
	/**
	 * 
	 * 加密解密算法  执行一次加密，两次解密
	 * @author 谢炎
	 * @date 2016-9-26 10:09:11
	 * 
	 * */
	public static String convertMD5(String str){
		char[] chars = str.toCharArray();
		for (int i = 0; i < chars.length; i++) {
			chars[i] = (char)(chars[i]^'t');
		}
		String s = new String(chars);
		return s;
		
	}
}
