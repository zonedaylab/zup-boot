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
/// 数据访问类WF_ATTACH
/// </summary>
@Repository
public class WF_AttachBase{

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_ATTACH model) throws SQLException{
		return AddOracle(model);
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddOracle(cn.zup.workflow.model.WF_ATTACH model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_ATTACH(");
		strSql.append("WORK_ITEM_ID,ATTACH_NAME,ATTACH_PATH,HANDLER_NAME,UPLOAD_DATETIME)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4})",
				model.getWORK_ITEM_ID()+"", "'"+model.getATTACH_NAME()+"'",
				"'"+model.getATTACH_PATH()+"'", "'"+model.getHANDLER_NAME()+"'",
				"to_date('"+model.getUPLOAD_DATETIME()+"', 'yyyy-MM-dd')"));
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sql = "SELECT max(ATTACH_ID) FROM WF_ATTACH";
	    int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_ATTACH model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_ATTACH set ");
		strSql.append(MessageFormat.format("WORK_ITEM_ID={0},", model.getWORK_ITEM_ID()+"")); 
		strSql.append(MessageFormat.format("ATTACH_NAME={0},", "'"+model.getATTACH_NAME()+"'")); 
		strSql.append(MessageFormat.format("ATTACH_PATH={0},", "'"+model.getATTACH_PATH()+"'")); 
		strSql.append(MessageFormat.format("HANDLER_NAME={0},", "'"+model.getHANDLER_NAME()+"'")); 
		strSql.append(MessageFormat.format("UPLOAD_DATETIME={0}", "to_date('"+model.getUPLOAD_DATETIME()+"', 'yyyy-MM-dd')"));
		strSql.append(MessageFormat.format(" where ATTACH_ID={0} ", model.getATTACH_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ATTACH_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_ATTACH ");
		strSql.append(" where ATTACH_ID="+ATTACH_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_ATTACH GetModel(int ATTACH_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ATTACH_ID,WORK_ITEM_ID,ATTACH_NAME,ATTACH_PATH,HANDLER_NAME,UPLOAD_DATETIME from WF_ATTACH  ");
		strSql.append(" where ATTACH_ID="+ATTACH_ID);
		
		cn.zup.workflow.model.WF_ATTACH model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ATTACH>(){

			@Override
			public cn.zup.workflow.model.WF_ATTACH extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_ATTACH model = new cn.zup.workflow.model.WF_ATTACH();
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
	public List<cn.zup.workflow.model.WF_ATTACH> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ATTACH_ID,WORK_ITEM_ID,ATTACH_NAME,ATTACH_PATH,HANDLER_NAME,UPLOAD_DATETIME ");
		strSql.append(" FROM WF_ATTACH ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ATTACH> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ATTACH>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ATTACH> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_ATTACH> list = new ArrayList<cn.zup.workflow.model.WF_ATTACH>();
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
	public List<cn.zup.workflow.model.WF_ATTACH> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ATTACH_ID,WORK_ITEM_ID,ATTACH_NAME,ATTACH_PATH,HANDLER_NAME,UPLOAD_DATETIME ");
		strSql.append(" FROM WF_ATTACH for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ATTACH> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ATTACH>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ATTACH> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_ATTACH> list = new ArrayList<cn.zup.workflow.model.WF_ATTACH>();
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
	public cn.zup.workflow.model.WF_ATTACH ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_ATTACH model=new cn.zup.workflow.model.WF_ATTACH();
		model.setATTACH_ID(rs.getInt("ATTACH_ID"));
		model.setWORK_ITEM_ID(rs.getInt("WORK_ITEM_ID"));
		model.setATTACH_NAME(rs.getString("ATTACH_NAME"));
		model.setATTACH_PATH(rs.getString("ATTACH_PATH"));
		model.setHANDLER_NAME(rs.getString("HANDLER_NAME"));
		model.setUPLOAD_DATETIME(rs.getDate("UPLOAD_DATETIME"));
		return model;
	}

}

