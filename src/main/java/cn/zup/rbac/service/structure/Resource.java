package cn.zup.rbac.service.structure;

public final class Resource
{
	private int resourceType;
	/** 
	 资源类型
	 
	*/
	public int getResourceType()
	{
		return resourceType;
	}
	public void setResourceType(int value)
	{
		resourceType = value;
	}

	private String resourceCode;
	/** 
	 资源编号，可以是ID的string型
	 
	*/
	public String getResourceCode()
	{
		return resourceCode;
	}
	public void setResourceCode(String value)
	{
		resourceCode = value;
	}

	public Resource clone()
	{
		Resource varCopy = new Resource();

		varCopy.resourceType = this.resourceType;
		varCopy.resourceCode = this.resourceCode;

		return varCopy;
	}
}
