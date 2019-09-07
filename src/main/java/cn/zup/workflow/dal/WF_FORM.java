package cn.zup.workflow.dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;
@Repository("formDal")
public class WF_FORM extends WF_FormBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/** 
	 根据活动ID获取表单信息
	 
	 @param activityID 活动ID
	 @return 表单对象实体
	 * @throws SQLException 
	*/
	public  cn.zup.workflow.model.WF_FORM FormInfo(int activityID) throws SQLException
	{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.FORM_ID,PARENT_FORM_ID,A.FORM_NAME,URL,A.SYSTEM_ID ");
		strSql.append(" from WF_FORM AS A inner join WF_ACTIVITY AS B on A.FORM_ID=B.FORM_ID");
		strSql.append(" where B.ACTIVITY_ID="+activityID);
		cn.zup.workflow.model.WF_FORM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_FORM>(){
			@Override
			public cn.zup.workflow.model.WF_FORM extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				return ReaderBind(rs);
			}
		});
		
		return model;
	}

	/** 
	 根据工作ID获取表单路径
	 
	 @param workID 工作ID
	 @return 
	 * @throws SQLException 
	*/
	public  String FormUrl(int workID) throws SQLException
	{
		StringBuilder strSql = new StringBuilder();
		int atype = cn.zup.workflow.config.ActivityType.InterMediateStage.getValue();
		strSql.append("select URL from WF_FORM");
		strSql.append(" where FORM_ID in(select FORM_ID from WF_ACTIVITY ");
		strSql.append(MessageFormat.format(" where ACTIVITY_TYPE={0} and FLOW_ID=(select FLOW_ID from WF_WORK where WORK_ID={1}))", atype+"", workID+""));
		
		String url = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<String>(){
			@Override
			public String extractData(
					ResultSet rs) throws SQLException,
					DataAccessException {
				return rs.getString(1);
			}
		});
		return url;
	}
	
	/// <summary>
	/// 对象实体绑定数据
	/// </summary>
	public cn.zup.workflow.model.WF_FORM ReaderBind(ResultSet rs) throws SQLException
	{
		cn.zup.workflow.model.WF_FORM model=new cn.zup.workflow.model.WF_FORM();
		model.setFORM_ID(rs.getInt("FORM_ID"));
		model.setPARENT_FORM_ID(rs.getInt("PARENT_FORM_ID"));
		model.setSYSTEM_ID(rs.getInt("SYSTEM_ID"));
		model.setFORM_NAME(rs.getString("FORM_NAME"));
		model.setURL(rs.getString("URL"));
		return model;
	}
}