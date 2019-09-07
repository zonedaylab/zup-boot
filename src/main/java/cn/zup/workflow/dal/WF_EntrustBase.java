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
/// 数据访问类WF_ENTRUST
/// </summary>
@Repository
public class WF_EntrustBase{

	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	
	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_ENTRUST model) throws SQLException{
		return AddOracle(model);
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddOracle(cn.zup.workflow.model.WF_ENTRUST model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_ENTRUST(");
		strSql.append("ENTRUST_PEOPLE_ID,ENTRUST_PEOPLE_NAME,TRUST_PEOPLE_ID,TRUST_PEOPLE_NAME,TIME,STATE)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5})", 
				model.getENTRUST_PEOPLE_ID()+"", "'"+model.getENTRUST_PEOPLE_NAME()+"'",
				model.getTRUST_PEOPLE_ID()+"", "'"+model.getTRUST_PEOPLE_NAME()+"'",
				"to_date('"+model.getTIME()+"', 'yyyy-MM-dd')", model.getSTATE()+""));
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sql = "SELECT  max(ENTRUST_ID) FROM WF_ENTRUST";
	    int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public  void Update(cn.zup.workflow.model.WF_ENTRUST model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_ENTRUST set ");
		strSql.append(MessageFormat.format("ENTRUST_PEOPLE_ID={0}," , model.getENTRUST_PEOPLE_ID()+"")); 
		strSql.append(MessageFormat.format("ENTRUST_PEOPLE_NAME={0},","'"+model.getENTRUST_PEOPLE_NAME()+"'")); 
		strSql.append(MessageFormat.format("TRUST_PEOPLE_ID={0},",model.getTRUST_PEOPLE_ID()+"")); 
		strSql.append(MessageFormat.format("TRUST_PEOPLE_NAME={0},","'"+model.getTRUST_PEOPLE_NAME()+"'")); 
		strSql.append(MessageFormat.format("TIME={0},","to_date('"+model.getTIME()+"', 'yyyy-MM-dd')")); 
		strSql.append(MessageFormat.format("STATE={0}", model.getSTATE()+""));
		strSql.append(MessageFormat.format(" where ENTRUST_ID={0} ",model.getENTRUST_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ENTRUST_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_ENTRUST ");
		strSql.append(" where ENTRUST_ID="+ENTRUST_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_ENTRUST GetModel(int ENTRUST_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ENTRUST_ID,ENTRUST_PEOPLE_ID,ENTRUST_PEOPLE_NAME,TRUST_PEOPLE_ID,TRUST_PEOPLE_NAME,TIME,STATE from WF_ENTRUST  ");
		strSql.append(" where ENTRUST_ID=? ");

		cn.zup.workflow.model.WF_ENTRUST model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ENTRUST>(){

			@Override
			public cn.zup.workflow.model.WF_ENTRUST extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_ENTRUST model = null;
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
	public List<cn.zup.workflow.model.WF_ENTRUST> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ENTRUST_ID,ENTRUST_PEOPLE_ID,ENTRUST_PEOPLE_NAME,TRUST_PEOPLE_ID,TRUST_PEOPLE_NAME,TIME,STATE ");
		strSql.append(" FROM WF_ENTRUST ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_ENTRUST> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ENTRUST>>(){
			@Override
			public List<cn.zup.workflow.model.WF_ENTRUST> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_ENTRUST> list = new ArrayList<cn.zup.workflow.model.WF_ENTRUST>();
				while (rs.next()) {
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
	public List<cn.zup.workflow.model.WF_ENTRUST> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ENTRUST_ID,ENTRUST_PEOPLE_ID,ENTRUST_PEOPLE_NAME,TRUST_PEOPLE_ID,TRUST_PEOPLE_NAME,TIME,STATE ");
		strSql.append(" FROM WF_ENTRUST for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_ENTRUST> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ENTRUST>>(){
			@Override
			public List<cn.zup.workflow.model.WF_ENTRUST> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_ENTRUST> list = new ArrayList<cn.zup.workflow.model.WF_ENTRUST>();
				while (rs.next()) {
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
	public cn.zup.workflow.model.WF_ENTRUST ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_ENTRUST model=new cn.zup.workflow.model.WF_ENTRUST();
		model.setENTRUST_ID(rs.getInt("ENTRUST_ID"));
		model.setENTRUST_PEOPLE_ID(rs.getInt("ENTRUST_PEOPLE_ID"));
		model.setENTRUST_PEOPLE_NAME(rs.getString("ENTRUST_PEOPLE_NAME"));
		model.setTRUST_PEOPLE_ID(rs.getInt("TRUST_PEOPLE_ID"));
		model.setTRUST_PEOPLE_NAME(rs.getString("TRUST_PEOPLE_NAME"));
		model.setTIME(rs.getDate("TIME"));
		model.setSTATE(rs.getInt("STATE"));
		return model;
	}

}

