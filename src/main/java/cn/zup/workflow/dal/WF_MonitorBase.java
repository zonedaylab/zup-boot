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
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.model.WF_MONITOR;
/// <summary>
/// 数据访问类WF_MONITOR
/// </summary>
@Repository
public class WF_MonitorBase{

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/**
     * @UpdateInfo 增加数据
     * @UpdateDate 2017-3-3 14:12:44
     * @UpdatePerson xieyan
     * */
	public int Add(cn.zup.workflow.model.WF_MONITOR model) throws SQLException{
		return AddOracle(model);
	}

	/**
     * @UpdateInfo 增加数据
     * @UpdateDate 2017-3-3 14:12:31
     * @UpdatePerson xieyan
     * */
	public int AddCommon(cn.zup.workflow.model.WF_MONITOR model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_MONITOR(");
		strSql.append("FLOW_ID,MONITOR,MONITOR_TYPE)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2})", model.getFLOW_ID()+"",
				model.getMONITOR()+"", model.getMONITOR_TYPE()+""));
		strSql.append(";select @@IDENTITY");
		return jdbcTemplate_workflow.update(strSql.toString());
	}

	/**
     * @UpdateInfo 增加数据
     * @UpdateDate 2017-2-27 16:09:32
     * @UpdatePerson xieyan
     * */
	public int AddOracle(cn.zup.workflow.model.WF_MONITOR model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_MONITOR(");
		strSql.append("FLOW_ID,MONITOR,MONITOR_TYPE)");
		strSql.append(MessageFormat.format(" values({0},{1},{2})",
				model.getFLOW_ID()+"", model.getMONITOR()+"", model.getMONITOR_TYPE()+""));
		System.out.println(strSql);
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sqlid = "SELECT max(MONITOR_ID) FROM WF_MONITOR ";
		int incID = jdbcTemplate_workflow.queryForObject(sqlid, Integer.class);
		return incID;
	}

	/**
     * @UpdateInfo 更新一条数据
     * @UpdateDate 2017-2-27 16:09:32
     * @UpdatePerson xieyan
     * */
	public void Update(cn.zup.workflow.model.WF_MONITOR model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_MONITOR set ");
		strSql.append(MessageFormat.format("FLOW_ID={0},", model.getFLOW_ID()+"")); 
		strSql.append(MessageFormat.format("MONITOR={0},", model.getMONITOR()+"")); 
		strSql.append(MessageFormat.format("MONITOR_TYPE={0}", model.getMONITOR_TYPE()+""));
		strSql.append(MessageFormat.format(" where MONITOR_ID={0} ",model.getMONITOR_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/**
     * @UpdateInfo 删除一条数据
     * @UpdateDate 2017年3月3日14:11:55
     * @UpdatePerson xieyan
     * */
	public void Delete(int MONITOR_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_MONITOR ");
		strSql.append(" where MONITOR_ID="+ MONITOR_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/**
     * @UpdateInfo 获取一条数据
     * @UpdateDate 2017年3月3日14:11:55
     * @UpdatePerson xieyan
     * */
	public cn.zup.workflow.model.WF_MONITOR GetModel(int MONITOR_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select MONITOR_ID,FLOW_ID,MONITOR,MONITOR_TYPE from WF_MONITOR  ");
		strSql.append(" where MONITOR_ID="+MONITOR_ID);
		
		cn.zup.workflow.model.WF_MONITOR model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_MONITOR>(){
			@Override
			public cn.zup.workflow.model.WF_MONITOR extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_MONITOR model = new cn.zup.workflow.model.WF_MONITOR();
				if(rs.next())
					model=ReaderBind(rs);
				return model;
			}
		});
		
		return model;
	}

	/**
     * @UpdateInfo 获取流程下的监控者
     * @UpdateDate 2017-2-27 14:32:06
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_MONITOR> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select MONITOR_ID,FLOW_ID,MONITOR,MONITOR_TYPE ");
		strSql.append(" FROM WF_MONITOR ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_MONITOR> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MONITOR>>(){
			
			@Override
			public List<WF_MONITOR> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_MONITOR> list = new ArrayList<cn.zup.workflow.model.WF_MONITOR>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
		});
		return list;
	}

	/**
     * @UpdateInfo 查询一条数据
     * @UpdateDate 2017-2-27 16:09:32
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_MONITOR> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select MONITOR_ID,FLOW_ID,MONITOR,MONITOR_TYPE ");
		strSql.append(" FROM WF_MONITOR for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_MONITOR> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MONITOR>>(){
			
			@Override
			public List<cn.zup.workflow.model.WF_MONITOR> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_MONITOR> list = new ArrayList<cn.zup.workflow.model.WF_MONITOR>();
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
	public cn.zup.workflow.model.WF_MONITOR ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_MONITOR model=new cn.zup.workflow.model.WF_MONITOR();
		model.setMONITOR_ID(rs.getInt("MONITOR_ID"));
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		model.setMONITOR(rs.getInt("MONITOR"));
		model.setMONITOR_TYPE(rs.getInt("MONITOR_TYPE"));
		return model;
	}

}

