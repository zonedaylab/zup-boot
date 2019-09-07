package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.model.ACTIVITY_RULE;

@Repository("ruleDal")
public class WF_RULE extends WF_RuleBase{
	public WF_RULE(){}

	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public  List<cn.zup.workflow.model.ACTIVITY_RULE> RuleList(int activityID) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.ACTIVITY_CODE as GOTO_ACTIVITY_CODE, A.ACTIVITY_NAME as GOTO_ACTIVITY_NAME,B.RULE_ID,B.ACTIVITY_ID,B.CONDITIONS,D.SUB_NAME as CONDITIONS_NAME,B.CONTROL_ID,B.GOTO_ACTIVITY,B.JUDGE_BASIS,C.CONTROL_NAME,C.CONTROL_TEXT");
		strSql.append(" from WF_ACTIVITY A inner join");
		strSql.append(" WF_RULE B on A.ACTIVITY_ID=B.GOTO_ACTIVITY inner join");
		strSql.append(" WF_FORM_CONTROL C on B.CONTROL_ID=C.CONTROL_ID inner join");
		strSql.append(" WF_CONFIG D on  D.ID="+cn.zup.workflow.config.ConfigList.ConditionType.getValue()+" and B.CONDITIONS=D.SUB_ID ");
		strSql.append(" where  B.ACTIVITY_ID=" + activityID);
		List<cn.zup.workflow.model.ACTIVITY_RULE> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.ACTIVITY_RULE>>(){

					@Override
					public List<ACTIVITY_RULE> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						List<cn.zup.workflow.model.ACTIVITY_RULE> list = new ArrayList<cn.zup.workflow.model.ACTIVITY_RULE>();
						while (rs.next()){
							list.add(RuleReaderBind(rs));
						}
						return list;
					}
			
		});
		return list;
	}
	
	/** 
	 对象实体绑定数据
	 
	*/
	public  cn.zup.workflow.model.ACTIVITY_RULE RuleReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.ACTIVITY_RULE model = new cn.zup.workflow.model.ACTIVITY_RULE();
		Object ojb;
		ojb = rs.getObject("RULE_ID");
		if(ojb != null){
			model.setRULE_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("ACTIVITY_ID");
		if(ojb != null){
			model.setACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("GOTO_ACTIVITY");
		if(ojb != null){
			model.setGOTO_ACTIVITY(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("GOTO_ACTIVITY_CODE");		
		if(ojb != null){
			model.setGOTO_ACTIVITY(Integer.parseInt(ojb.toString()));
		}
		model.setGOTO_ACTIVITY_NAME(rs.getString("GOTO_ACTIVITY_NAME"));
		ojb = rs.getObject("CONTROL_ID");
		if(ojb != null){
			model.setCONTROL_ID(Integer.parseInt(ojb.toString()));
		}
		model.setCONTROL_NAME(rs.getString("CONTROL_NAME"));
		model.setCONTROL_TEXT(rs.getString("CONTROL_TEXT"));
		ojb = rs.getObject("CONDITIONS");
		if(ojb != null){
			model.setCONDITIONS(Integer.parseInt(ojb.toString()));
		}
		model.setCONTROL_NAME(rs.getString("CONDITIONS_NAME"));
		model.setJUDGE_BASIS(rs.getString("JUDGE_BASIS"));
		return model;
	}
	public void deleteWfRule(int activityID) throws SQLException{
   		StringBuilder strSql = new StringBuilder();
   		strSql.append("delete from WF_RULE ");
   		strSql.append(" where ACTIVITY_ID="+activityID);  
   		jdbcTemplate_workflow.update(strSql.toString());
   	}
}