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
//import com.mn886.frame.tool.ZFUUID;
/// <summary>
/// 数据访问类WF_WorkBase
/// </summary>
@Repository
public class WF_WorkBase{
	
	public WF_WorkBase(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int add(cn.zup.workflow.model.WF_WORK model) throws SQLException{
		String sql = "SELECT max(WORK_ID) FROM WF_WORK ";
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_WORK(");
		strSql.append("FLOW_ID,WORK_NAME,WORK_STATE,SPONSOR_ID,SPONSOR_NAME,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},now(),{5},{6},{7})", 
				model.getFLOW_ID()+"", "'"+model.getWORK_NAME()+"'", model.getWORK_STATE()+"", model.getSPONSOR_ID()+"", 
				"'"+model.getSPONSOR_NAME()+"'", "'"+model.getMAIN_BIZ_KEY()+"'", model.getPARENT_WORK_ID()+"",
				model.getPARENT_ACTIVITY_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
		
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_WORK model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_WORK set ");
		strSql.append(MessageFormat.format("FLOW_ID={0},", model.getFLOW_ID()+"")); 
		strSql.append(MessageFormat.format("WORK_NAME={0},", "'"+model.getWORK_NAME()+"'")); 
		strSql.append(MessageFormat.format("WORK_STATE={0},", model.getWORK_STATE()+"")); 
		strSql.append(MessageFormat.format("SPONSOR_ID={0},", model.getSPONSOR_ID()+"")); 
		strSql.append(MessageFormat.format("SPONSOR_NAME={0},", "'"+model.getSPONSOR_NAME()+"'")); 
		strSql.append(MessageFormat.format("MAIN_BIZ_KEY={0},", "'"+model.getMAIN_BIZ_KEY()+"'")); 
		strSql.append(MessageFormat.format("PARENT_WORK_ID={0},", model.getPARENT_WORK_ID()+"")); 
		strSql.append(MessageFormat.format("PARENT_ACTIVITY_ID={0}", model.getPARENT_ACTIVITY_ID()+""));
		strSql.append(MessageFormat.format(" where WORK_ID={0} ", model.getWORK_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int WORK_ID) throws SQLException{
		delWorkItem(WORK_ID);
		delWorkActivity(WORK_ID);
		delWork(WORK_ID);
	}
	/**
	 * 删除这条工作中的delWork表中的数据
	 * @谢炎
	 * @2016年11月17日16:45:43
	 * */
	public void delWork(int WORK_ID){
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_WORK ");
		strSql.append(" where WORK_ID="+ WORK_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/**
	 * 删除这条工作中的delWorkActivity表中的数据
	 * @谢炎
	 * @2016年11月17日16:45:43
	 * */
	public void delWorkActivity(int WORK_ID){
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_work_activity ");
		strSql.append(" where work_id ="+WORK_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/**
	 * 删除这条工作中的workitem表中的数据
	 * @谢炎
	 * @2016年11月17日16:45:43
	 * */
	public void delWorkItem(int WORK_ID){
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_work_item  ");
		strSql.append(" where work_activity_id in(select work_activity_id from wf_work_activity where work_id="+WORK_ID+" )" );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_WORK GetModel(int WORK_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ID,FLOW_ID,WORK_NAME,WORK_STATE,SPONSOR_ID,SPONSOR_NAME,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID from WF_WORK  ");
		strSql.append(" where WORK_ID="+WORK_ID);
		
		cn.zup.workflow.model.WF_WORK model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK>(){

			@Override
			public cn.zup.workflow.model.WF_WORK extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_WORK model=null;
				if(rs.next())
					model=ReaderBind(rs);
				return model;
			}
		});
		
		return model;
	}

	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_WORK GetModel(String mainBizKey,int flowID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ID,FLOW_ID,WORK_NAME,WORK_STATE,SPONSOR_ID,SPONSOR_NAME,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID from WF_WORK  ");
		strSql.append(" where MAIN_BIZ_KEY='"+mainBizKey+"' and FLOW_ID="+flowID);
		cn.zup.workflow.model.WF_WORK model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK>(){

			@Override
			public cn.zup.workflow.model.WF_WORK extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_WORK model=null;
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
	public List<cn.zup.workflow.model.WF_WORK> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ID,FLOW_ID,WORK_NAME,WORK_STATE,SPONSOR_ID,SPONSOR_NAME,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID ");
		strSql.append(" FROM WF_WORK ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK>>(){

			@Override
			public List<cn.zup.workflow.model.WF_WORK> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK> list = new ArrayList<cn.zup.workflow.model.WF_WORK>();
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
	public List<cn.zup.workflow.model.WF_WORK> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ID,FLOW_ID,WORK_NAME,WORK_STATE,SPONSOR_ID,SPONSOR_NAME,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID ");
		strSql.append(" FROM WF_WORK for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK>>(){

			@Override
			public List<cn.zup.workflow.model.WF_WORK> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK> list = new ArrayList<cn.zup.workflow.model.WF_WORK>();
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
	public cn.zup.workflow.model.WF_WORK ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_WORK model=new cn.zup.workflow.model.WF_WORK();
		model.setWORK_ID(rs.getInt("WORK_ID"));
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		model.setWORK_NAME(rs.getString("WORK_NAME"));
		model.setWORK_STATE(rs.getByte("WORK_STATE"));
		model.setSPONSOR_ID(rs.getInt("SPONSOR_ID"));
		model.setSPONSOR_NAME(rs.getString("SPONSOR_NAME"));
		model.setCREATE_DATETIME(rs.getDate("CREATE_DATETIME"));
		model.setMAIN_BIZ_KEY(rs.getString("MAIN_BIZ_KEY"));
		model.setPARENT_WORK_ID(rs.getInt("PARENT_WORK_ID"));
		model.setPARENT_ACTIVITY_ID(rs.getInt("PARENT_ACTIVITY_ID"));
		return model;
	}


}

