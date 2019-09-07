package cn.zup.workflow.dal;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA;
@Repository("wfFormAutoJob")
public class WF_FORMAUTO_JOB  extends WF_FormBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/// <summary>
	/// 更新表单中的表单内容
	/// </summary>
	public int FormAutoUpdate(String formID, String content) throws SQLException{
		Connection conn=null;
		PreparedStatement ps=null;
		String sql = "update WF_FORM set FORM_AUTO_CONTENT= ? where FORM_ID="+formID;
			try {
				conn = jdbcTemplate_workflow.getDataSource().getConnection();
				ps = conn.prepareStatement(sql);
				ps.setObject(1, content.getBytes());
				conn.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				ps.close();
				conn.close();
			}
		return ps.executeUpdate();
	}
	
	/// <summary>
	/// 插入保单控制器
	/// </summary>
	public int FormControlInsert(WF_FORM_CONTROL wfFormControl) throws SQLException, UnsupportedEncodingException{
		String sql = "select MAX(CONTROL_ID) FROM wf_form_control";
	    int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		
		StringBuffer strSql=new StringBuffer();
		strSql.append("insert into WF_FORM_CONTROL (CONTROL_ID, FORM_ID, CONTROL_NAME, CONTROL_TEXT, CONTROL_TYPE, NULL_PERMIT, DEFAULT_LENGTH, CONTROL_MEANING, USER_CONTROL_NAME");
		strSql.append(MessageFormat.format(") values ({0},{1},{2},{3},{4},{5},{5},{6},{7})",
				incID+"", wfFormControl.getFORM_ID()+"", "'"+wfFormControl.getCONTROL_NAME()+"'",
				"'"+wfFormControl.getCONTROL_TEXT()+"'", wfFormControl.getCONTROL_TYPE()+"",
				wfFormControl.getNULL_PERMIT()+"", wfFormControl.getDEFAULT_LENGTH()+"",
				wfFormControl.getCONTROL_MEANING()+"", "'"+wfFormControl.getUSER_CONTROL_NAME()+"'"));
		
		return jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/** 
	 插入自定义表单数据
	 
	 @param formAutoJob 自定义表单数据实体
	 @return jobId
	 * @throws SQLException 
	*/
	public int FormAutoJobSave(cn.zup.workflow.model.WF_FORMAUTO_JOB formAutoJob) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("insert into  WF_FORMAUTO_JOB(data_name, create_date, user_id, user_name, form_id) values");
		strSql.append(MessageFormat.format(" ({0},now(),{1},{2},{3}) ", 
				"'"+formAutoJob.getDATA_NAME()+"'", formAutoJob.getUSER_ID()+"",
				"'"+formAutoJob.getUSER_NAME()+"'", formAutoJob.getFORM_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sql = "SELECT max(JOBID) FROM WF_FORMAUTO_JOB";
		int jobID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return jobID;
	}
	
	/** 
	 插入自定义表单控件数据
	 
	 @param formAutoJobData 自定义表单控件数据实体
	 @return jobId
	 * @throws SQLException 
	*/
	public void FormAutoJobDataSave(cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA formAutoJobData) throws SQLException{
		StringBuilder strSql = new StringBuilder();
 		strSql.append("insert into  WF_FORMAUTO_JOB_DATA(JOB_ID, CONTROL_ID, VALUE, CONTROL_NAME) values");
		strSql.append( MessageFormat.format(" ({0}, {1}, {2}, {3}) ", formAutoJobData.getJOB_ID()+"",
				formAutoJobData.getCONTROL_ID()+"", "'"+formAutoJobData.getVALUE()+"'", "'"+formAutoJobData.getCONTROL_NAME()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/** 
	 更新自定义表单控件数据
	 
	 @param formAutoJobData 自定义表单控件数据实体
	 @return jobId
	 * @throws SQLException 
	*/
	public void FormAutoJobDataUpdate(cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA formAutoJobData, int mainBizKey) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append(" update  WF_FORMAUTO_JOB_DATA set VALUE='"+formAutoJobData.getVALUE()+"', CONTROL_NAME='"+formAutoJobData.getCONTROL_NAME()+"' where job_id="+mainBizKey+" and CONTROL_ID="+formAutoJobData.getCONTROL_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	
	/** 
	 * 根据formId删除表单组件配置
	 * @author 谢炎
	 * @date 2016-08-30
	 * @param formId 表单Id
	 * @throws SQLException 
	*/
	public void FormControlDelete(int formId) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_form_control ");
		strSql.append(" where FORM_ID="+ formId);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/** 
	 * 根据formId和name获取控件id
	 * @author 谢炎
	 * @date 2016-08-30
	 * @param formId 表单Id、 controlName 控件名称
	 * @throws SQLException 
	*/
	public List<Integer> FormControlInfo(int formId, String controlName) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select CONTROL_ID from wf_form_control where 1=1");
		strSql.append(MessageFormat.format(" and FORM_ID = {0} and CONTROL_NAME = {1} ", formId+"", "'"+controlName+"'"));
		List<Integer> list = jdbcTemplate_workflow.query(strSql.toString(), new RowMapper<Integer>(){
			@Override
			public Integer mapRow(ResultSet rs, int numag) throws SQLException {
				return rs.getInt("CONTROL_ID");
			}
		});
		
		return list;
	}
	
	/**
	 * 
	 * 通过业务主键 获取业务数据
	 * @author 谢炎 
	 * @throws Exception 
	 * @date 2016-08-31
	 * 
	 * */
	public List<WF_FORMAUTO_JOB_DATA> getFormAutoInfo(String mainBizKey) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select VALUE,CONTROL_NAME,CONTROL_ID  from WF_FORMAUTO_JOB_DATA");
		strSql.append(" where JOB_ID = "+ mainBizKey);
		
		List<WF_FORMAUTO_JOB_DATA> lists = jdbcTemplate_workflow.query(strSql.toString(), new RowMapper<WF_FORMAUTO_JOB_DATA>(){
			@Override
			public WF_FORMAUTO_JOB_DATA mapRow(ResultSet rs, int arg1)
					throws SQLException {
				WF_FORMAUTO_JOB_DATA FromAutoJobData = new WF_FORMAUTO_JOB_DATA();
				FromAutoJobData.setCONTROL_NAME(rs.getString("CONTROL_NAME"));
				FromAutoJobData.setVALUE(rs.getString("VALUE"));
				FromAutoJobData.setCONTROL_ID(rs.getInt("CONTROL_ID"));
				return FromAutoJobData;
			}
		});
		
		if(lists.size() > 0){
			return lists;
		}else{
			return null;
		}
	}
	/**
	 * 设备流转，待办时，workFlowAutoController中需要根据formId获取menuid
	 * 首先根据formid获取flowid
	 * 再根据flowid获取menuid
	 * lixin 
	 * 2016-11-30 15:34:47
	 * @param formId
	 * @return
	 * @throws SQLException
	 */
	public List<WF_FLOW> getWfFlowInfo(Integer formId) throws SQLException {
		StringBuffer strSql=new StringBuffer();
		strSql.append("select wf_form.form_id, wf_flow.flow_id from wf_form inner join wf_activity on wf_activity.form_id=wf_form.form_id inner join wf_flow on wf_flow.flow_id=wf_activity.flow_id");
		strSql.append(" where wf_form.form_id = "+ formId);
		
		List<WF_FLOW> list = jdbcTemplate_workflow.query(strSql.toString(), new RowMapper<WF_FLOW>(){
			@Override
			public WF_FLOW mapRow(ResultSet rs, int arg1)
					throws SQLException {
				WF_FLOW wfFlow = new WF_FLOW();
				wfFlow.setFLOW_ID(rs.getInt("FLOW_ID"));
				return wfFlow;
			}
		});
		
		return list;
	}
}
