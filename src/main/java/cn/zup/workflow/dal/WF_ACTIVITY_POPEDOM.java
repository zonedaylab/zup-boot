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

import cn.zup.workflow.model.ACTIVITY_POPEDOM;

@Repository("activityPopedomDal")
public class WF_ACTIVITY_POPEDOM extends WF_Activity_PopedomBase{
	public WF_ACTIVITY_POPEDOM(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 * @throws Exception 
	 
	*/
	public List<cn.zup.workflow.model.ACTIVITY_POPEDOM> ActivityPopedomList(int activityID) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select ACTIVITY_ID,A.CONTROL_ID,B.CONTROL_NAME,B.CONTROL_TEXT, STATE, C.SUB_NAME as STATE_NAME,GRID_COLUMN_DISPLAY");
		strSql.append(" from WF_ACTIVITY_POPEDOM  A inner join ");
		strSql.append(" WF_FORM_CONTROL  B on A.CONTROL_ID=B.CONTROL_ID inner join ");
		strSql.append(" WF_CONFIG  C on C.ID="+cn.zup.workflow.config.ConfigList.ControlState.getValue()+" and A.STATE=C.SUB_ID ");
		strSql.append(" where ACTIVITY_ID=" + activityID);
		List<cn.zup.workflow.model.ACTIVITY_POPEDOM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.ACTIVITY_POPEDOM>>(){

			@Override
			public List<ACTIVITY_POPEDOM> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.ACTIVITY_POPEDOM> list = new ArrayList<cn.zup.workflow.model.ACTIVITY_POPEDOM>();
				while (rs.next()){
					list.add(ManageReaderBind(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}

	/** 
	 对象实体绑定数据
	 
	*/
	public cn.zup.workflow.model.ACTIVITY_POPEDOM ManageReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.ACTIVITY_POPEDOM model = new cn.zup.workflow.model.ACTIVITY_POPEDOM();
		Object ojb;
		ojb = rs.getObject("ACTIVITY_ID");
		if(ojb!=null){
			model.setACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("CONTROL_ID");
		if(ojb != null){
			model.setCONTROL_ID(Integer.parseInt(ojb.toString()));
		}
		model.setCONTROL_NAME(rs.getString("CONTROL_NAME"));
		model.setCONTROL_TEXT(rs.getString("CONTROL_TEXT"));
		ojb = rs.getObject(5);
		if(ojb != null){
			model.setSTATE((byte) Integer.parseInt(ojb.toString()));
		}
		model.setSTATE_NAME(rs.getString("STATE_NAME"));
		model.setGRID_COLUMN_DISPLAY(rs.getString("GRID_COLUMN_DISPLAY"));
		return model;
	}
	/**
	 * 根据活动id删除活动权限表
	 * wf_activity_popedom
	 * @param activityID
	 * @throws SQLException
	 */
	public void deleteWfActivityPopedom(int activityID) throws SQLException{
   		StringBuilder strSql = new StringBuilder();
   		strSql.append("delete from WF_ACTIVITY_POPEDOM ");
   		strSql.append(" where ACTIVITY_ID="+activityID);  
   		jdbcTemplate_workflow.update(strSql.toString());
   	}
}