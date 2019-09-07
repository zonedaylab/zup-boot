package cn.zup.workflow.dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;
import java.util.ArrayList;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.Role;
import cn.zup.workflow.model.FLOW_MANAGE;
import cn.zup.workflow.model.WF_FLOW;

/**
 * 数据访问类wf_flow
 * 
 * 
 * */
@Repository
public class WF_FlowBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	public WF_FlowBase(){}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int addCommon(cn.zup.workflow.model.WF_FLOW model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_FLOW(");
		strSql.append("SYSTEM_ID,FLOW_NAME,FLOW_TYPE,FLOW_STATE)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3})", model.getSYSTEM_ID()+"",
				"'"+model.getFLOW_NAME()+"'", model.getFLOW_TYPE()+"", model.getFLOW_STATE()+""));
		int id = jdbcTemplate_workflow.update(strSql.toString());
		return id;
	}

	/**
     * @UpdateInfo 增加一条流程数据
     * @UpdateDate 2017-2-27 14:32:06
     * @UpdatePerson xieyan
     * */
	public int add(cn.zup.workflow.model.WF_FLOW model) throws SQLException{
		
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_FLOW(SYSTEM_ID,FLOW_NAME,FLOW_TYPE,FLOW_STATE)");
		strSql.append(MessageFormat.format(" values({0},{1},{2},{3})", model.getSYSTEM_ID()+"", 
				"'"+model.getFLOW_NAME()+"'", "'"+model.getFLOW_TYPE()+"'", model.getFLOW_STATE()));
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sqlid = "SELECT max(FLOW_ID) FROM WF_FLOW";
		int incID = jdbcTemplate_workflow.queryForObject(sqlid, Integer.class);
		return incID;
	}
	
	/**
     * @UpdateInfo 更新一条流程数据
     * @UpdateDate 2017-2-27 14:32:06
     * @UpdatePerson xieyan
     * */
	public void update(cn.zup.workflow.model.WF_FLOW model) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_flow set ");
		strSql.append("SYSTEM_ID=?,"); 
		strSql.append("FLOW_NAME=?,"); 
		strSql.append("FLOW_TYPE=?,"); 
		strSql.append("FLOW_STATE=?");
		strSql.append(" where FLOW_ID=? ");
		
		Object args[] = {model.getSYSTEM_ID(), model.getFLOW_NAME(), 
				model.getFLOW_TYPE(), model.getFLOW_STATE(), model.getFLOW_ID()};
		jdbcTemplate_workflow.update(strSql.toString(), args);
	}


	/**
     * @UpdateInfo 根据流程id删除流程
     * @UpdateDate 2017-2-27 14:32:06
     * @UpdatePerson xieyan
     * */
	public void Delete(int FLOW_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_flow ");
		strSql.append(" where FLOW_ID="+FLOW_ID);
		
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/**
     * @UpdateInfo 根据流程id获取流程信息
     * @UpdateDate 2017-2-27 14:32:06
     * @UpdatePerson xieyan
     * */
	public cn.zup.workflow.model.WF_FLOW GetModel(int FLOW_ID) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FLOW_ID,SYSTEM_ID,FLOW_NAME,FLOW_TYPE,FLOW_STATE from wf_flow  ");
		strSql.append(" where FLOW_ID="+FLOW_ID);
		
		cn.zup.workflow.model.WF_FLOW model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_FLOW>(){

			@Override
			public WF_FLOW extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_FLOW model=null;
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
	public List<cn.zup.workflow.model.WF_FLOW> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FLOW_ID,SYSTEM_ID,FLOW_NAME,FLOW_TYPE,FLOW_STATE ");
		strSql.append(" FROM wf_flow ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_FLOW> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_FLOW>>(){

			@Override
			public List<cn.zup.workflow.model.WF_FLOW> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_FLOW> list = new ArrayList<cn.zup.workflow.model.WF_FLOW>();
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
	public List<cn.zup.workflow.model.WF_FLOW> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FLOW_ID,SYSTEM_ID,FLOW_NAME,FLOW_TYPE,FLOW_STATE ");
		strSql.append(" FROM wf_flow for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}

		List<cn.zup.workflow.model.WF_FLOW> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_FLOW>>(){

			@Override
			public List<cn.zup.workflow.model.WF_FLOW> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_FLOW> list = new ArrayList<cn.zup.workflow.model.WF_FLOW>();
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
	public cn.zup.workflow.model.WF_FLOW ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_FLOW model=new cn.zup.workflow.model.WF_FLOW();
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		model.setSYSTEM_ID(rs.getInt("SYSTEM_ID"));
		model.setFLOW_NAME(rs.getString("FLOW_NAME"));
		model.setFLOW_TYPE(rs.getString("FLOW_TYPE"));
		model.setFLOW_STATE(rs.getByte("FLOW_STATE"));
		return model;
	}

}

