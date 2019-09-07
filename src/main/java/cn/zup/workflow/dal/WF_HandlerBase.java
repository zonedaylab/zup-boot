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

import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_HANDLER;
/// <summary>
/// 数据访问类WF_HANDLER
/// </summary>
@Repository
public class WF_HandlerBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/**
     * @updateInfo 增加一条数据
     * @updateDate 2017-3-3 09:05:58
     * @updatePerson xieyan
     * */
	public int Add(cn.zup.workflow.model.WF_HANDLER model) throws SQLException{
			return AddOracle(model);
	}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public  int AddOracle(cn.zup.workflow.model.WF_HANDLER model) throws SQLException{
		String sql = "SELECT max(HANDLER_ID) FROM  WF_HANDLER";
		
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_HANDLER(");
		strSql.append(" ACTIVITY_ID,HANDLER,HANDLER_TYPE,HANDLER_NAME)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3})",
				model.getACTIVITY_ID()+"", model.getHANDLER()+"", model.getHANDLER_TYPE()+"",
				"'"+model.getHANDLER_NAME()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
		
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	
	/**
     * @UpdateInfo 更新数据列
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public void Update(cn.zup.workflow.model.WF_HANDLER model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_HANDLER set ");
		strSql.append("ACTIVITY_ID="+model.getACTIVITY_ID()); 
		strSql.append(",HANDLER="+model.getHANDLER()); 
		strSql.append(",HANDLER_TYPE="+model.getHANDLER_TYPE()); 
		strSql.append(",HANDLER_NAME="+model.getHANDLER_NAME());
		strSql.append(" where HANDLER_ID="+model.getHANDLER_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/**
     * @UpdateInfo 删除数据列
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public void Delete(int HANDLER_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_HANDLER ");
		strSql.append(" where HANDLER_ID="+HANDLER_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/**
     * @updateInfo 获取一个实体
     * @updateDate 2017-3-3 09:05:58
     * @updatePerson xieyan
     * */
	public cn.zup.workflow.model.WF_HANDLER GetModel(int HANDLER_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select HANDLER_ID,ACTIVITY_ID,HANDLER,HANDLER_TYPE,HANDLER_NAME from WF_HANDLER  ");
		strSql.append(" where HANDLER_ID="+HANDLER_ID);
		
		cn.zup.workflow.model.WF_HANDLER model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_HANDLER>(){

					@Override
					public cn.zup.workflow.model.WF_HANDLER extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						cn.zup.workflow.model.WF_HANDLER model = new cn.zup.workflow.model.WF_HANDLER();
						if(rs.next())
							model=ReaderBind(rs);
						return model;
		}});
		
		return model;
	}

	/**
     * @UpdateInfo 获取数据列
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_HANDLER> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select HANDLER_ID,ACTIVITY_ID,HANDLER,HANDLER_TYPE,HANDLER_NAME ");
		strSql.append(" FROM WF_HANDLER ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_HANDLER> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_HANDLER>>(){

			@Override
			public List<cn.zup.workflow.model.WF_HANDLER> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_HANDLER> list = new ArrayList<cn.zup.workflow.model.WF_HANDLER>();
				while(rs.next())
					list.add(ReaderBind(rs));
				return list;
			}
			
		});
		return list;
	}
	
	/** 
	 *获取当前登录用户是否有权限
	 *@author 谢炎
	 *@date 2016-11-23 20:10:48
	 *@param activityID 活动ID
	 *@return 操作者对象实体列表
	 * @throws SQLException 
	 *@update 2017-3-3 09:04:57
	*/
	public List<Integer> getMenuFlowId(int handle, int handleType) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select f.flow_id from wf_handler h inner join wf_activity a on a.activity_id =  h.activity_id inner join wf_flow f on f.flow_id = a.flow_id where 1=1 ");
		if(handle != 0){
			strSql.append(" and h.handler = "+handle+" and h.handler_type="+handleType);
		}
		strSql.append(" and a.activity_type = 1 group by f.flow_id");
		
		List<Integer> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<Integer>>(){

			@Override
			public List<Integer> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<Integer> list = new ArrayList<Integer>();
				while (rs.next()){
					list.add(Integer.parseInt(rs.getString("FLOW_ID")));
				}
				return list;
			}
			
		});
		
		return list;
	}
	
	/**
     * @updateInfo 获取数据列
     * @updateDate 2017-3-3 09:12:09
     * @updatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_HANDLER> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select HANDLER_ID,ACTIVITY_ID,HANDLER,HANDLER_TYPE,HANDLER_NAME ");
		strSql.append(" FROM WF_HANDLER for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_HANDLER> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_HANDLER>>(){

			@Override
			public List<cn.zup.workflow.model.WF_HANDLER> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_HANDLER> list = new ArrayList<cn.zup.workflow.model.WF_HANDLER>();
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
	public cn.zup.workflow.model.WF_HANDLER ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_HANDLER model=new cn.zup.workflow.model.WF_HANDLER();
		model.setHANDLER_ID(rs.getInt("HANDLER_ID"));
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setHANDLER(rs.getInt("HANDLER"));
		model.setHANDLER_TYPE(rs.getInt("HANDLER_TYPE"));
		model.setHANDLER_NAME(rs.getString("HANDLER_NAME"));
		return model;
	}

}

