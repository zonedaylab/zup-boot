package cn.zup.workflow.dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.util.Event;

public class PagingList<T> {
	
	public  PagingData<T> GetData(Connection conn,String bizSql, String primaryName, String fieldOrder, int pageIndex, int pageSize) throws Exception
	{		
		String pageSql=GetPagingSql(bizSql, primaryName, fieldOrder, pageIndex,	pageSize);
		
		List<T> list = new java.util.ArrayList<T>();		
		PreparedStatement ps =conn.prepareStatement(bizSql);
		int totalAmount = ps.getFetchSize();	
		
		ps =conn.prepareStatement(pageSql);
		ResultSet rs = ps.executeQuery();		
		while (rs.next())
		{		
			list.add(readerBind(rs));		
		}
		
		//获取总记录数	
		PagingData<T> result = new PagingData<T>();
		result.setData(list);
		result.setAmount(totalAmount);	
		return result;		
	}	
	/**
	 *  数据转换委托
	 */
	 
	private Event readerBindEvent;
	public void setReaderBindEvent(Event event)
	{
		readerBindEvent=event;				
	}
	
	@SuppressWarnings("unchecked")
	private  T readerBind(ResultSet rs) throws Exception
	{
		if(readerBindEvent==null)
			throw new RuntimeException("请进行readerBind业务委托！");		
		readerBindEvent.setParam(rs);
		T data =(T)readerBindEvent.invoke(); //保存业务数据			
		return data;	
	}
	/** 
	 获取分页SQL
	 
	 @param bizSql 数据源SQL
	 @param primaryName 主键名称
	 @param fieldOrder 排序列
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	private String GetPagingSql(String bizSql, String primaryName, String fieldOrder, int pageIndex, int pageSize){
		int fromRecord = (pageIndex - 1) * pageSize;
		int toRecord = fromRecord + pageSize + 1;
		if (cn.zup.workflow.util.StringHelper.isNullOrEmpty(fieldOrder))	
			fieldOrder = primaryName;							
		StringBuffer pagingSelect = new StringBuffer(2048);
		bizSql=bizSql+ " order by " + fieldOrder;
		pagingSelect.append("SELECT * FROM (SELECT tt.*, ROWNUM AS rowno ");
		pagingSelect.append("FROM (  SELECT t.* FROM ("  +  bizSql +" ) t ) tt"); 				
		pagingSelect.append(" WHERE ROWNUM < " +toRecord +  ") table_alias");
		pagingSelect.append(" WHERE table_alias.rowno > " +fromRecord);
		return pagingSelect.toString();		
	}
}
