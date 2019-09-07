package cn.zup.workflow.dal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

@Repository
public class PagingService {

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/**
	 * 数据结果集
	 */
	private ResultSet resultSet; 
	public void setResultSet(ResultSet resultSet) {
		this.resultSet = resultSet;
	}
	public ResultSet getResultSet() {
		return resultSet;
	}
 
	/**
	 * 获取
	 * @param conn 数据库连接
		 @param bizSql 数据源SQL
		 @param primaryName 主键名称
		 @param fieldOrder 排序列
		 @param pageIndex 当前页码
		 @param pageSize 每页记录数
		 @return 
	 * @throws Exception 
	 */
	public int GetPagingData(String bizSql, String primaryName, String fieldOrder, int pageIndex, int pageSize) throws Exception{		
		String[]sqlist=bizSql.split("from");
		if(sqlist.length<2)
			throw new Exception("分页sql的from 字段需要小写");
		String countSql="select count(*) from "+sqlist[1];
		System.err.println(countSql.toString());
		
		int totalAmount = jdbcTemplate_workflow.query(countSql, new ResultSetExtractor<Integer>(){
			@Override
			public Integer extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				int totalAmount = 0;
				if (rs.next()){			
					totalAmount=rs.getInt(1);
				}	
				return totalAmount;
			}
		});
		
		return totalAmount;
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
	public String GetPagingSql(String bizSql, String primaryName, String fieldOrder, int pageIndex, int pageSize){
		int startRow = (pageIndex - 1) * pageSize;
		if (cn.zup.workflow.util.StringHelper.isNullOrEmpty(fieldOrder))	
			fieldOrder = primaryName;							
		StringBuffer pagingSelect = new StringBuffer(2048);
		bizSql=bizSql+ " order by " + fieldOrder;
		pagingSelect.append("SELECT *  FROM ( " +  bizSql +" ) table_alias LIMIT "+startRow+" , "+pageSize);
		return pagingSelect.toString();		
	}

}
