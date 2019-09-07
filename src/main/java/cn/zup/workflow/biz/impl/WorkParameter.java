package cn.zup.workflow.biz.impl;
/** 
工作生存所需参数

*/
public class WorkParameter
{
	private String workName;
	/** 
	 工作名称
	 
	*/
	public  String getWorkName()
	{
		return workName;
	}
	public  void setWorkName(String value)
	{
		workName = value;
	}

	private String bizKey;
	/** 
	 业务主键信息
	 
	*/
	public  String getBizKey()
	{
		return bizKey;
	}
	public  void setBizKey(String value)
	{
		bizKey = value;
	}
}