package cn.zup.workflow.dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.model.WF_ACTIVITY;

@Repository("msgSetDal")
public class WF_MSG_SET extends WF_MSG_SetBase{
	public WF_MSG_SET(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	
	/**
     * @UpdateInfo 获取数据列
     * @UpdateDate 2017-2-28 11:09:31
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_MSG_SET> GetListArray(int activityID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select MSG_ID,ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME ");
		strSql.append(" FROM WF_MSG_SET ");
		strSql.append(" where ACTIVITY_ID=" + activityID);
		
		List<cn.zup.workflow.model.WF_MSG_SET> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MSG_SET>>(){

			@Override
			public List<cn.zup.workflow.model.WF_MSG_SET> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_MSG_SET> list =new ArrayList<cn.zup.workflow.model.WF_MSG_SET>();
				while(rs.next())
					list.add(ReaderBind(rs));
				return list;
			}
			
		});

		return list;
	}


	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 * @throws SQLException 
	 
	*/
	public List<cn.zup.workflow.model.WF_MSG_SET> GetListArrayTran(int activityID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select MSG_ID,ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME ");
		strSql.append(" FROM WF_MSG_SET WITH (UPDLOCK)  ");
		strSql.append(" where ACTIVITY_ID=" + activityID);
		
		List<cn.zup.workflow.model.WF_MSG_SET> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MSG_SET>>(){

			@Override
			public List<cn.zup.workflow.model.WF_MSG_SET> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_MSG_SET> list =new ArrayList<cn.zup.workflow.model.WF_MSG_SET>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
			
		});
			
		return list;
	}

	/** 
	 通知配置删除
	 
	 @param activityID 活动ID
	 * @throws SQLException 
	*/
	public void MsgSetDel(int activityID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("update WF_WORK_MSG set ");
		strSql.append("RECEIVER_DATE="+(Date) new java.util.Date());
		strSql.append(",RECEIVER_FLAG="+cn.zup.workflow.config.ReceiverFlag.Received.getValue());
		strSql.append(" where WORK_MSG_ID="+activityID);
		jdbcTemplate_workflow.update(strSql.toString());
	}

}