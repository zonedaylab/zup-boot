package cn.zup.rbac.controller.ViewEntity;


public class VerifyPhoneNumberViewModel
{

	private String privateCode;
	public final String getCode()
	{
		return privateCode;
	}
	public final void setCode(String value)
	{
		privateCode = value;
	}
	private String privatePhoneNumber;
	public final String getPhoneNumber()
	{
		return privatePhoneNumber;
	}
	public final void setPhoneNumber(String value)
	{
		privatePhoneNumber = value;
	}
}
