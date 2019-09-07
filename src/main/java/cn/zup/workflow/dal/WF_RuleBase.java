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

import cn.zup.workflow.model.ACTIVITY_RULE;
/// <summary>
/// 数据访问类WF_RULE
/// </summary>
@Repository
public class WF_RuleBase{

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_RULE model) throws SQLException{
		return AddOracle(model);
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddCommon(cn.zup.workflow.model.WF_RULE model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_RULE(");
		strSql.append("ACTIVITY_ID,GOTO_ACTIVITY,CONTROL_ID,CONDITIONS,JUDGE_BASIS)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4})", 
				model.getACTIVITY_ID()+"", model.getGOTO_ACTIVITY()+"", model.getCONTROL_ID()+"",
				model.getCONDITIONS()+"", "'"+model.getJUDGE_BASIS()+"'"));
		strSql.append(";select @@IDENTITY");
		int id = jdbcTemplate_workflow.update(strSql.toString());
		return id;
	}

	/**
    * @UpdateInfo 增加一条数据
    * @UpdateDate 2017-2-27 18:15:22
    * @UpdatePerson xieyan
    * */
	public int AddOracle(cn.zup.workflow.model.WF_RULE model) throws SQLException{
		String sql = "SELECT MAX(RULE_ID) FROM WF_RULE";
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_RULE(");
		strSql.append("RULE_ID,ACTIVITY_ID,GOTO_ACTIVITY,CONTROL_ID,CONDITIONS,JUDGE_BASIS)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5})", incID+"", 
				model.getACTIVITY_ID()+"", model.getGOTO_ACTIVITY()+"", "'"+model.getJUDGE_BASIS()+"'",
				model.getCONTROL_ID()+"", model.getCONDITIONS()+""));
		jdbcTemplate_workflow.update(strSql.toString());
		return incID;
	}
	
	/**
	    * @UpdateInfo 更新一条数据
	    * @UpdateDate 2017-2-27 18:15:22
	    * @UpdatePerson xieyan
	    * */
	public void Update(cn.zup.workflow.model.WF_RULE model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_RULE set ");
		strSql.append("ACTIVITY_ID="+model.getACTIVITY_ID()); 
		strSql.append(",GOTO_ACTIVITY="+model.getGOTO_ACTIVITY()); 
		strSql.append(",CONTROL_ID="+model.getCONTROL_ID()); 
		strSql.append(",CONDITIONS="+model.getCONDITIONS()); 
		strSql.append(",JUDGE_BASIS="+model.getJUDGE_BASIS());
		strSql.append(" where RULE_ID="+model.getRULE_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/**
	    * @UpdateInfo 删除一条数据
	    * @UpdateDate 2017-2-27 18:15:22
	    * @UpdatePerson xieyan
	    * */
	public void Delete(int RULE_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_RULE ");
		strSql.append(" where RULE_ID="+RULE_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/**
	    * @UpdateInfo 得到一个对象实体
	    * @UpdateDate 2017-2-27 18:15:22
	    * @UpdatePerson xieyan
	    * */
	public cn.zup.workflow.model.WF_RULE GetModel(int RULE_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select RULE_ID,ACTIVITY_ID,GOTO_ACTIVITY,CONTROL_ID,CONDITIONS,JUDGE_BASIS from WF_RULE  ");
		strSql.append(" where RULE_ID="+RULE_ID);
		
		cn.zup.workflow.model.WF_RULE model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_RULE>(){

					@Override
					public cn.zup.workflow.model.WF_RULE extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						cn.zup.workflow.model.WF_RULE model = new cn.zup.workflow.model.WF_RULE();
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
	public List<cn.zup.workflow.model.WF_RULE> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select RULE_ID,ACTIVITY_ID,GOTO_ACTIVITY,CONTROL_ID,CONDITIONS,JUDGE_BASIS ");
		strSql.append(" FROM WF_RULE ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_RULE> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_RULE>>(){

					@Override
					public List<cn.zup.workflow.model.WF_RULE> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						List<cn.zup.workflow.model.WF_RULE> list = new ArrayList<cn.zup.workflow.model.WF_RULE>();
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
	public List<cn.zup.workflow.model.WF_RULE> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select RULE_ID,ACTIVITY_ID,GOTO_ACTIVITY,CONTROL_ID,CONDITIONS,JUDGE_BASIS ");
		strSql.append(" FROM WF_RULE for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_RULE> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_RULE>>(){

					@Override
					public List<cn.zup.workflow.model.WF_RULE> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						List<cn.zup.workflow.model.WF_RULE> list = new ArrayList<cn.zup.workflow.model.WF_RULE>();
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
	public cn.zup.workflow.model.WF_RULE ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_RULE model=new cn.zup.workflow.model.WF_RULE();
		model.setRULE_ID(rs.getInt("RULE_ID"));
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setGOTO_ACTIVITY(rs.getInt("GOTO_ACTIVITY"));
		model.setCONTROL_ID(rs.getInt("CONTROL_ID"));
		model.setCONDITIONS(rs.getInt("CONDITIONS"));
		model.setJUDGE_BASIS(rs.getString("JUDGE_BASIS"));
		return model;
	}

}

