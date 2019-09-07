package cn.zup.workflow.tool;

import java.util.UUID;

public class ZFUUID {
	/**
	 * 获取UUID
	 * @return
	 */
	public static String getUUID(){
		UUID uuid = UUID.randomUUID();
		return uuid.toString();
	}
	/**
	 * 获取指定长度的uuid
	 * @return
	 */
	public static String getUUID4Length(int length){
		UUID uuid = UUID.randomUUID();
		return uuid.toString().substring(0,length);
	}
	
}
