package cn.zup.workflow.engine;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import cn.zup.workflow.biz.impl.WorkFlowControl;
import cn.zup.workflow.model.ACTIVITY_AOV;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_WORK;
import cn.zup.workflow.model.WF_WORK_ACTIVITY;

public  class WfDal{
	@Autowired
	private static JdbcTemplate jdbcTemplate_workflow;
	public static  int WF_GetActivityParentCount(int activityID){
		StringBuilder strSql = new StringBuilder();
		strSql.append("select ACTIVITY_ID,FLOW_ID,ACTIVITY_CODE,NEXT_ACTIVITY_CODE");
		strSql.append(" from WF_ACTIVITY ");
		strSql.append(" where FLOW_ID=(select FLOW_ID from WF_ACTIVITY where ACTIVITY_ID=" + activityID + ")");
		List<WF_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString(),new ResultSetExtractor<List<WF_ACTIVITY>>(){
			@Override
			public List<WF_ACTIVITY> extractData(ResultSet rs) throws SQLException, DataAccessException {
				return null;
			}
			
		});
		//DataSet ds = DbHelperSQL.Query(strSql.toString());
		int parentCount = 0; 
		for (int i=0;i<list.size();i++){
			String actCode = String.valueOf(list.get(i).getACTIVITY_CODE());
			if (list.get(i).getNEXT_ACTIVITY_CODE().contains(actCode)){
				parentCount++;
			}
		}
		return parentCount;
	}

	public static  List<ACTIVITY_AOV> WF_GetAOVNet(int flowID, int workID){
		StringBuilder strSql = new StringBuilder();
		if (workID != 0){
			strSql.append("select A.ACTIVITY_CODE,A.ACTIVITY_ID,A.ACTIVITY_PROPERTY,A.ACTIVITY_TYPE,A.FLOW_ID,A.NEXT_ACTIVITY_CODE,A.REJECT_ACTIVITY_CODE,");
			strSql.append("B.NEXT_ACTIVITY_CODES AS REAL_NEXT_ACTIVITY_CODES,");
			strSql.append("B.NEXT_ACTIVITY_HANDLERS as REAL_NEXT_HANDLERS,");
			strSql.append("(CASE WHEN B.WORK_ACTIVITY_ID IS NULL THEN 0 ELSE B.WORK_ACTIVITY_ID END) AS WORK_ACTIVITY_ID,");
			strSql.append("(CASE WHEN B.WORK_ACTIVITY_STATE IS NULL THEN 0 ELSE B.WORK_ACTIVITY_STATE END) AS FINISH_FLAG");
			strSql.append(" from WF_ACTIVITY A LEFT OUTER JOIN  WF_WORK_ACTIVITY B");
			strSql.append(" ON A.ACTIVITY_ID=B.ACTIVITY_ID AND B.WORK_ACTIVITY_STATE!=3 "); //3��ʾ����
			strSql.append(" AND B.WORK_ID=" + workID + " WHERE A.FLOW_ID=" + flowID);
		}else{
			strSql.append(" select A.ACTIVITY_CODE,0 AS WROK_ACTIVITY_ID,A.ACTIVITY_ID,A.ACTIVITY_PROPERTY,A.ACTIVITY_TYPE,");
			strSql.append("A.FLOW_ID,A.NEXT_ACTIVITY_CODE,A.REJECT_ACTIVITY_CODE, 0 AS FINISH_FLAG,REAL_NEXT_ACTIVITY_CODES=''");
			strSql.append(" from dbo.WF_ACTIVITY A  WHERE A.FLOW_ID=" + flowID);
		}
		List<ACTIVITY_AOV> list = jdbcTemplate_workflow.query(strSql.toString(),new ResultSetExtractor<List<ACTIVITY_AOV>>(){
			@Override
			public List<ACTIVITY_AOV> extractData(ResultSet rs) throws SQLException, DataAccessException {
				return null;
			}
			
		});
		return list;
	}

	public static  void WF_WorkServiceNewActivity(int workID, int activityID, String responsible) throws SQLException{
		WorkFlowControl IWorkFlowControl = new WorkFlowControl();
		try{
			IWorkFlowControl.getWorkNewActivity(workID, activityID);
		}catch (RuntimeException ex){
			String Msg = String.format("WORK_ID=%1$s,READY_ACTIVITY_ID=%2$s", String.valueOf(workID), String.valueOf(activityID));
			Msg += ex.getMessage();
			throw (new RuntimeException(Msg));
		}
	}

	public static List<WF_WORK> WF_GetActiveWork(){
		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_DATETIME,WORK_ID,FLOW_ID from WF_WORK");
		strSql.append("where WORK_STATE=1");
		List<WF_WORK> list = jdbcTemplate_workflow.query(strSql.toString(),new ResultSetExtractor<List<WF_WORK>>(){
			@Override
			public List<WF_WORK> extractData(ResultSet rs) throws SQLException, DataAccessException {
				return null;
			}
			
		});
		//DataSet ds = DbHelperSQL.Query(strSql.toString());
		return list;
	}
	public static  void WF_SetWorkFinish(int nWorkID){
		String strSql = "update WF_WORK set WORK_STATE=2 where WORK_ID=" + String.valueOf(nWorkID);
		//DbHelperSQL.ExecuteSql(strSql);
		jdbcTemplate_workflow.update(strSql.toString());
	}

	public static List<WF_WORK_ACTIVITY> WF_GetWorkActivity(){
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.WORK_ID,A.WORK_ACTIVITY_ID,A.FINISHED_DATETIME,B.FLOW_ID");
		strSql.append(" from WF_WORK_ACTIVITY A,  WF_WORK B ");
		strSql.append(" where A.WORK_ID=B.WORK_ID and B.WORK_STATE=1 ");
		strSql.append(" and A.FINISHED_DATETIME in(select max(FINISHED_DATETIME) from WF_WORK_ACTIVITY C WHERE C.WORK_ID=B.WORK_ID)");
		List<WF_WORK_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString(),new ResultSetExtractor<List<WF_WORK_ACTIVITY>>(){
			@Override
			public List<WF_WORK_ACTIVITY> extractData(ResultSet rs) throws SQLException, DataAccessException {
				return null;
			}
		});
		return list;
	}
}
