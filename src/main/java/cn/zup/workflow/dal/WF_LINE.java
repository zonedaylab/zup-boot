package cn.zup.workflow.dal;

import java.sql.SQLException;
import java.text.MessageFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository("lineDal")
public class WF_LINE extends WF_LineBase{
	public WF_LINE(){}

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/** 
	 删除连线关系（删除活动时）
	 
	 @param flowID 流程ID
	 @param activityCode 当前节点
	 @param dbTran 数据库连接实例
	 @param transaction 事务
	*/
	public void DeleteTran(int flowID, int activityCode) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("delete from WF_LINE");
		strSql.append(MessageFormat.format(" where FLOW_ID={0} and (BEGIN_CODE={1} or END_CODE={2})", 
				flowID+"", activityCode+"", activityCode+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/** 
	  删除连线关系
	 
	 @param flowID 流程ID
	 @param beginCode 开始节点
	*/
	public void Delete(int flowID, int beginCode) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("delete from WF_LINE");
		strSql.append(MessageFormat.format(" where FLOW_ID={0} and (BEGIN_CODE={1} or END_CODE={2})", 
				flowID+"", beginCode+"", beginCode+""));	
		jdbcTemplate_workflow.update(strSql.toString());
	}

	public void deleteLineList(int flowId) {
		StringBuffer strSql = new StringBuffer();
		strSql.append("delete from WF_LINE  where FLOW_ID="+flowId);	
		jdbcTemplate_workflow.update(strSql.toString());
	}

}