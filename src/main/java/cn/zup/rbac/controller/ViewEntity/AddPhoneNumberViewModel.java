package cn.zup.rbac.controller.ViewEntity;

public class AddPhoneNumberViewModel
{
	private String privateNumber;
	public final String getNumber()
	{
		return privateNumber;
	}
	public final void setNumber(String value)
	{
		privateNumber = value;
	}
}
