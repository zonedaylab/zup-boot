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

import cn.zup.workflow.model.WF_LINE;


/**
 * @UpdateInfo 数据访问类WF_LINE
 * @UpdateDate 2017-2-27 17:12:02
 * @UpdatePerson xieyan
 * */
@Repository
public class WF_LineBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/**
     * @UpdateInfo 增加一条线
     * @UpdateDate 2017-2-27 14:32:06
     * @UpdatePerson xieyan
     * */
	public int Add(cn.zup.workflow.model.WF_LINE model) throws SQLException{
		return AddOracle(model);
	}

	/**
     * @UpdateInfo 增加一条流程图线数据
     * @UpdateDate 2017-2-27 18:09:14
     * @UpdatePerson xieyan
     * */
	public int AddOracle(cn.zup.workflow.model.WF_LINE model) throws SQLException{
		String sql = "SELECT max(LINE_ID) FROM WF_LINE ";
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_LINE(");
		strSql.append("FLOW_ID,BEGIN_CODE,END_CODE,LINE_CONTENT,LINE_INFLECTION,LINE_CODE,LINE_NAME)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5},{6})", model.getFLOW_ID()+"", 
				model.getBEGIN_CODE()+"", model.getEND_CODE()+"","'"+model.getLINE_CONTENT()+"'", 
				"'"+model.getLINE_INFLECTION()+"'", "'"+model.getLINE_CODE()+"'", "'"+model.getLINE_NAME()+"'"));

		jdbcTemplate_workflow.update(strSql.toString());
		
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}

	/**
     * @UpdateInfo 更新一条流程图线数据
     * @UpdateDate 2017-2-27 18:09:14
     * @UpdatePerson xieyan
     * */
	public  void Update(cn.zup.workflow.model.WF_LINE model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_LINE set ");
		strSql.append("FLOW_ID="+model.getFLOW_ID()+""); 
		strSql.append(",BEGIN_CODE="+model.getBEGIN_CODE()+""); 
		strSql.append(",END_CODE="+model.getEND_CODE()+""); 
		strSql.append(",LINE_CONTENT="+"'"+model.getLINE_CONTENT()+"'"); 
		strSql.append(",LINE_INFLECTION="+"'"+model.getLINE_INFLECTION()+"'"); 
		strSql.append(",LINE_CODE="+"'"+model.getLINE_CODE()+"'"); 
		strSql.append(",LINE_NAME="+"'"+model.getLINE_NAME()+"'");
		strSql.append(" where LINE_ID="+model.getLINE_ID()+"");
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/**
     * @UpdateInfo 删除一条流程图线
     * @UpdateDate 2017-3-3 14:18:35
     * @UpdatePerson xieyan
     * */
	public void Delete(int LINE_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_LINE ");
		strSql.append(" where LINE_ID="+LINE_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/**
     * @UpdateInfo 得到一个对象实体
     * @UpdateDate 2017-3-3 14:18:35
     * @UpdatePerson xieyan
     * */
	public cn.zup.workflow.model.WF_LINE GetModel(int LINE_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select LINE_ID,FLOW_ID,BEGIN_CODE,END_CODE,LINE_CONTENT,LINE_INFLECTION,LINE_CODE,LINE_NAME from WF_LINE  ");
		strSql.append(" where LINE_ID="+LINE_ID);
		
		cn.zup.workflow.model.WF_LINE model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_LINE>(){
			@Override
			public cn.zup.workflow.model.WF_LINE extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_LINE model = new cn.zup.workflow.model.WF_LINE();
				if(rs.next())
					model=ReaderBind(rs);
				return model;
			}
		});
		
		return model;
	}

	/**
     * @UpdateInfo 获取数据列
     * @UpdateDate 2017-2-27 17:12:02
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_LINE> GetListArray(String strWhere) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select LINE_ID,FLOW_ID,BEGIN_CODE,END_CODE,LINE_CONTENT,LINE_INFLECTION,LINE_CODE,LINE_NAME ");
		strSql.append(" FROM WF_LINE ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_LINE> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_LINE>>(){

			@Override
			public List<WF_LINE> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_LINE> list = new ArrayList<cn.zup.workflow.model.WF_LINE>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
		});
		return list;
	}

	/**
     * @UpdateInfo 获取数据列
     * @UpdateDate 2017-2-27 17:12:02
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_LINE> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select LINE_ID,FLOW_ID,BEGIN_CODE,END_CODE,LINE_CONTENT,LINE_INFLECTION,LINE_CODE,LINE_NAME ");
		strSql.append(" FROM WF_LINE for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_LINE> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_LINE>>(){

			@Override
			public List<WF_LINE> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_LINE> list = new ArrayList<cn.zup.workflow.model.WF_LINE>();
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
	public cn.zup.workflow.model.WF_LINE ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_LINE model=new cn.zup.workflow.model.WF_LINE();
		model.setLINE_ID(rs.getInt("LINE_ID"));
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		model.setBEGIN_CODE(rs.getInt("BEGIN_CODE"));
		model.setEND_CODE(rs.getInt("END_CODE"));
		model.setLINE_CONTENT(rs.getString("LINE_CONTENT"));
		model.setLINE_INFLECTION(rs.getString("LINE_INFLECTION"));
		model.setLINE_CODE(rs.getString("LINE_CODE"));
		model.setLINE_NAME(rs.getString("LINE_NAME"));
		return model;
	}

}

