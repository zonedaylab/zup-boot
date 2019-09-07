package cn.zup.workflow.dal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;
/// <summary>
/// 数据访问类WF_LOG
/// </summary>
@Repository
public class WF_LogBase{

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_LOG model) throws SQLException{
		return AddOracle(model);
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddOracle(cn.zup.workflow.model.WF_LOG model) throws SQLException{
		String sql = "SELECT MAX(WF_LOG_ID) FROM WF_LOG";
	    int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
	      
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_LOG(");
		strSql.append("ID,ERROR_NUMBER,ERROR_SEVERITY,ERROR_STATE,ERROR_PROCEDURE,ERROR_LINE,ERROR_MESSAGE,HAPPEN_DATE)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5},{6})", incID+"",
				model.getERROR_NUMBER()+"",model.getERROR_SEVERITY()+"", "'"+model.getERROR_STATE()+"'", 
				"'"+model.getERROR_PROCEDURE()+"'","'"+model.getERROR_MESSAGE()+"'", "to_date('"+model.getHAPPEN_DATE()+"', 'yyyy-MM-dd)'"));
		jdbcTemplate_workflow.update(strSql.toString());
		return incID;
	}
	
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_LOG model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_LOG set ");
		strSql.append(MessageFormat.format("ERROR_NUMBER={0},", model.getERROR_NUMBER()+"")); 
		strSql.append(MessageFormat.format("ERROR_SEVERITY={0},", model.getERROR_SEVERITY()+"")); 
		strSql.append(MessageFormat.format("ERROR_STATE={0},", "'"+model.getERROR_STATE()+"'")); 
		strSql.append(MessageFormat.format("ERROR_PROCEDURE={0},", "'"+model.getERROR_PROCEDURE()+"'")); 
		strSql.append(MessageFormat.format("ERROR_LINE={0},", model.getERROR_LINE()+"")); 
		strSql.append(MessageFormat.format("ERROR_MESSAGE={0},", "'"+model.getERROR_MESSAGE()+"'")); 
		strSql.append(MessageFormat.format("HAPPEN_DATE={0}", "to_date('"+model.getHAPPEN_DATE()+"', 'yyyy-MM-dd)'"));
		strSql.append(MessageFormat.format(" where ID={0}", model.getID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_LOG ");
		strSql.append(" where ID="+ ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_LOG GetModel(int ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ID,ERROR_NUMBER,ERROR_SEVERITY,ERROR_STATE,ERROR_PROCEDURE,ERROR_LINE,ERROR_MESSAGE,HAPPEN_DATE from WF_LOG  ");
		strSql.append(" where ID="+ID);
		
		cn.zup.workflow.model.WF_LOG model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_LOG>(){

			@Override
			public cn.zup.workflow.model.WF_LOG extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_LOG model = new cn.zup.workflow.model.WF_LOG();
				if(rs.next())
					model=ReaderBind(rs);
				return model;
			}
			
		});
		
		return model;
	}

	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_LOG> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ID,ERROR_NUMBER,ERROR_SEVERITY,ERROR_STATE,ERROR_PROCEDURE,ERROR_LINE,ERROR_MESSAGE,HAPPEN_DATE ");
		strSql.append(" FROM WF_LOG ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_LOG> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_LOG>>(){

			@Override
			public List<cn.zup.workflow.model.WF_LOG> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_LOG> list = new ArrayList<cn.zup.workflow.model.WF_LOG>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}
	
	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_LOG> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ID,ERROR_NUMBER,ERROR_SEVERITY,ERROR_STATE,ERROR_PROCEDURE,ERROR_LINE,ERROR_MESSAGE,HAPPEN_DATE ");
		strSql.append(" FROM WF_LOG for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_LOG> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_LOG>>(){

			@Override
			public List<cn.zup.workflow.model.WF_LOG> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_LOG> list = new ArrayList<cn.zup.workflow.model.WF_LOG>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}

	/// <summary>
	/// 对象实体绑定数据
	/// </summary>
	public cn.zup.workflow.model.WF_LOG ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_LOG model=new cn.zup.workflow.model.WF_LOG();
		model.setID(rs.getInt("ID"));
		model.setERROR_NUMBER(rs.getInt("ERROR_NUMBER"));
		model.setERROR_SEVERITY(rs.getInt("ERROR_SEVERITY"));
		model.setERROR_STATE(rs.getString("ERROR_STATE"));
		model.setERROR_PROCEDURE(rs.getString("ERROR_PROCEDURE"));
		model.setERROR_LINE(rs.getInt("ERROR_LINE"));
		model.setERROR_MESSAGE(rs.getString("ERROR_MESSAGE"));
		model.setHAPPEN_DATE(rs.getDate("HAPPEN_DATE"));
		return model;
	}

}

