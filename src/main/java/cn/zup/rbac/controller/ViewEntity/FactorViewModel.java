package cn.zup.rbac.controller.ViewEntity;

public class FactorViewModel
{
	private String privatePurpose;
	public final String getPurpose()
	{
		return privatePurpose;
	}
	public final void setPurpose(String value)
	{
		privatePurpose = value;
	}
}
