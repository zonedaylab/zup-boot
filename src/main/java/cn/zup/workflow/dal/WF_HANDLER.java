package cn.zup.workflow.dal;

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

@Repository("handlerDal")
public class WF_HANDLER extends WF_HandlerBase{
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	/**
     * @UpdateInfo 获得数据列表
     * @UpdateDate 2017-2-28 10:53:00
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_HANDLER> ActivityHandlerList(int activityID) throws SQLException{
   		StringBuilder strSql = new StringBuilder();
   		strSql.append("select HANDLER_ID,ACTIVITY_ID,HANDLER,HANDLER_TYPE,HANDLER_NAME ");
   		strSql.append(" from WF_HANDLER ");
   		strSql.append(" where ACTIVITY_ID="+activityID);
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
     * @UpdateInfo 根据活动ID删除操作者
     * @UpdateDate 2017-2-28 10:53:00
     * @UpdatePerson xieyan
     * */
	public void DeleteHandler(int activityID) throws SQLException{
   		StringBuilder strSql = new StringBuilder();
   		strSql.append("delete from WF_HANDLER ");
   		strSql.append(" where ACTIVITY_ID="+activityID);  
   		jdbcTemplate_workflow.update(strSql.toString());
   	}
}
