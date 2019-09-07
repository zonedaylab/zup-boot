package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

//import org.omg.CORBA.Environment;

import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.util.StringHelper;

@Repository("logDal")
public class WF_LOG extends WF_LogBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/** 
	 增加一条数据
	 
	*/
	public int LogAdd(RuntimeException ex){
		//这个类不会改
		int result;
		result=1;
		//String[] stackTrace = ex.StackTrace.split(new String[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
		//String[] stackTrace = ex.getStackTrace();
		//String[] StackTrace =ex.getStackTrace().split(new String[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
		//String stackInfo = stackTrace[stackTrace.Count() - 1];
		//String stackInfo = ex.getStackTrace( - 1);
		cn.zup.workflow.model.WF_LOG model = new cn.zup.workflow.model.WF_LOG();
		//model.ERROR_MESSAGE = ex.getMessage();
		//model.ERROR_PROCEDURE = stackInfo;
		//model.HAPPEN_DATE = new java.util.Date();
		//result=Add(model);
		//result=Add(model);
		return result;
	}

	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public PagingData<cn.zup.workflow.model.WF_LOG> LogList(String startDate, String endDate, int pageIndex, int pageSize) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select ID,ERROR_NUMBER,ERROR_SEVERITY,ERROR_STATE,ERROR_PROCEDURE,ERROR_LINE,ERROR_MESSAGE,HAPPEN_DATE ");
		strSql.append(" FROM WF_LOG ");
		strSql.append(" where  1=1");
		if (!StringHelper.isNullOrEmpty(startDate)){
			strSql.append(" and HAPPEN_DATE >'"+startDate+"'");
		}
		if (!StringHelper.isNullOrEmpty(endDate)){
			strSql.append(" and HAPPEN_DATE <'" + endDate + "'");
		}
		//获取分页sql
		String pagingSql = new cn.zup.workflow.dal.PagingService().GetPagingSql(
				strSql.toString(), "ID", "HAPPEN_DATE desc", pageIndex,
				pageSize);
		
		List<cn.zup.workflow.model.WF_LOG> list = new ArrayList<cn.zup.workflow.model.WF_LOG>();
		
		ResultSet rs = jdbcTemplate_workflow.query(pagingSql.toString(), 
				new ResultSetExtractor<ResultSet>(){

			@Override
			public ResultSet extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				return rs;
			}
			
		});
		
		while (rs.next()){
			list.add(ReaderBind(rs));
		}
			
		//获取总记录数
		//int totalAmount = db.ExecuteDataSet(CommandType.getText(), strSql.toString()).Tables[0].Rows.size();
		int totalAmount = rs.getRow();
		PagingData<cn.zup.workflow.model.WF_LOG> result = new PagingData<cn.zup.workflow.model.WF_LOG>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}
}