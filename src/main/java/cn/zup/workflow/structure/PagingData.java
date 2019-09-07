package cn.zup.workflow.structure;
import java.io.Serializable;
import java.util.List;

import cn.zup.workflow.database.SystemConfig;



/** 
 分页数据
 
 <typeparam name="T"></typeparam>
*/

public class PagingData<T > implements Serializable
{
	private int amount;
	/** 
	 数据总数	 
	*/
	public final int getAmount()
	{
		return amount;
	}
	public final void setAmount(int value)
	{
		amount = value;
	}
	private List<T> data;
	/** 
	 分页后数据
	 
	*/
	public final List<T> getData()
	{
		return data;
	}
	public final void setData(List<T> value)
	{
		data = value;
	}
	
}
