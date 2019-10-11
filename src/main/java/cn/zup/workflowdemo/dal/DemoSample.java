package cn.zup.workflowdemo.dal;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflowdemo.model.DemoSampleReceiveRegister;
@Repository("demoSampleDao")
public class DemoSample{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	
	/**
	 * 
	 * 增加一条数据
	 * 
	 * 
	 * */
	public int AddCommon(DemoSampleReceiveRegister demoSampleReceiveRegister) throws SQLException
	{
		//int demoId = baseDao.getCurrentSequence("seq_demo");
		String sql = "SELECT SEQ_DEMO.NEXTVAL FROM DUAL";
		int demoId = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		StringBuffer strSql = new StringBuffer();
		strSql.append("INSERT INTO DEMO_SAMPLE_RECEIVE_REGISTER (");
		strSql.append(" SAMPLE_ID,SAMPLE_START_TIME,SAMPLE_END_TIME,SAMPLE_PEOPER,RECEIVE_TIME,RECEIVE_PEOPER,CONTAINER_TYPE,CONTAINER_SPECIFICATION,SAMPLE_SOURCE,SAMPLE_FACE,SAMPLE_USE)");
		strSql.append(" VALUES (");
		strSql.append(""+demoId+",to_date('"+demoSampleReceiveRegister.getSample_Start_Time()+"','yyyy-MM-dd'),to_date('"+demoSampleReceiveRegister.getSample_End_Time()+"','yyyy-MM-dd'),'");
		strSql.append(demoSampleReceiveRegister.getSample_Peoper()+"',to_date('"+demoSampleReceiveRegister.getReceive_Time()+"','yyyy-MM-dd'),'"+demoSampleReceiveRegister.getReceive_Peoper()+"','"+demoSampleReceiveRegister.getContainer_Type()+"','");
		strSql.append(demoSampleReceiveRegister.getContainer_Specification()+"',"+demoSampleReceiveRegister.getSample_Source()+",'"+demoSampleReceiveRegister.getSample_Face()+"','"+demoSampleReceiveRegister.getSample_Use()+"')");
		System.out.println(strSql);
		jdbcTemplate_workflow.update(strSql.toString());
		return demoId;
	}
	
	/**
	 * 
	 * 增加一条数据
	 * 
	 * 
	 * */
	public int UpdateCommon(DemoSampleReceiveRegister demoSampleReceiveRegister, String mainBizK) throws SQLException
	{
		StringBuffer strSql = new StringBuffer();
		strSql.append("update DEMO_SAMPLE_RECEIVE_REGISTER ");
		strSql.append(" set SAMPLE_START_TIME=to_date('"+demoSampleReceiveRegister.getSample_Start_Time()+"','yyyy-MM-dd'),SAMPLE_END_TIME=to_date('"+demoSampleReceiveRegister.getSample_End_Time()+"','yyyy-MM-dd')");
		strSql.append(",SAMPLE_PEOPER='"+demoSampleReceiveRegister.getSample_Peoper()+"',RECEIVE_TIME=to_date('"+demoSampleReceiveRegister.getReceive_Time()+"','yyyy-MM-dd'),RECEIVE_PEOPER='"+demoSampleReceiveRegister.getReceive_Peoper()+"',CONTAINER_TYPE='"+demoSampleReceiveRegister.getContainer_Type()+"',CONTAINER_SPECIFICATION='"+demoSampleReceiveRegister.getContainer_Specification()+"',SAMPLE_SOURCE="+demoSampleReceiveRegister.getSample_Source());
		strSql.append(",SAMPLE_FACE='"+demoSampleReceiveRegister.getSample_Face()+"',SAMPLE_USE='"+demoSampleReceiveRegister.getSample_Use()+"' where SAMPLE_ID="+mainBizK);
		System.out.println(strSql);
		jdbcTemplate_workflow.update(strSql.toString());
		return Integer.parseInt(mainBizK);
	}
	
	
	/** 
	 获取所有符合操作者各类型的待办工作列表
	 
	 @param handlerList
	 @return 
	*/
	public DemoSampleReceiveRegister getSampleInfo(String sampleId) throws Exception{
		
		int demoId = 0;
		if(!"".equals(sampleId)){
			demoId = Integer.parseInt(sampleId);
		}
		
		DemoSampleReceiveRegister demoSampleReceiveRegister = new DemoSampleReceiveRegister();
		StringBuilder strSql = new StringBuilder();
		strSql.append("SELECT SAMPLE_ID, to_char(SAMPLE_START_TIME, 'yyyy-MM-dd') SAMPLE_START_TIME,to_char(SAMPLE_END_TIME, 'yyyy-MM-dd') SAMPLE_END_TIME,SAMPLE_PEOPER,to_char(RECEIVE_TIME, 'yyyy-MM-dd') RECEIVE_TIME,RECEIVE_PEOPER,CONTAINER_TYPE,CONTAINER_SPECIFICATION,SAMPLE_SOURCE,SAMPLE_FACE,SAMPLE_USE FROM DEMO_SAMPLE_RECEIVE_REGISTER");
		strSql.append(" WHERE 1=1 and SAMPLE_ID="+demoId);
		demoSampleReceiveRegister = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<DemoSampleReceiveRegister>(){
			@Override
			public DemoSampleReceiveRegister extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				DemoSampleReceiveRegister demoSampleReceiveRegister = new DemoSampleReceiveRegister();
				while (rs.next()){
					demoSampleReceiveRegister.setSample_ID(Integer.parseInt(rs.getString("SAMPLE_ID")));
					demoSampleReceiveRegister.setSample_Start_Time(rs.getString("SAMPLE_START_TIME"));
					demoSampleReceiveRegister.setSample_End_Time(rs.getString("SAMPLE_END_TIME"));
					demoSampleReceiveRegister.setSample_Peoper(rs.getString("SAMPLE_PEOPER"));
					demoSampleReceiveRegister.setReceive_Time(rs.getString("RECEIVE_TIME"));
					demoSampleReceiveRegister.setReceive_Peoper(rs.getString("RECEIVE_PEOPER"));
					demoSampleReceiveRegister.setContainer_Type(rs.getString("CONTAINER_TYPE"));
					demoSampleReceiveRegister.setContainer_Specification(rs.getString("CONTAINER_SPECIFICATION"));
					demoSampleReceiveRegister.setSample_Source(Integer.parseInt(rs.getString("SAMPLE_SOURCE")));
					demoSampleReceiveRegister.setSample_Face(rs.getString("SAMPLE_FACE"));
					demoSampleReceiveRegister.setSample_Use(rs.getString("SAMPLE_USE"));
				}
				return demoSampleReceiveRegister;
			}
		});
		
		if(demoSampleReceiveRegister != null){
			return demoSampleReceiveRegister;
		}else{
			return null;
		}
	}
	
	
	/** 
	 获取所有符合操作者各类型的待办工作列表
	 
	 @param handlerList
	 @return 
	*/
	public FlowRequest getWorkItemActivety(String workIds, String StateId) throws Exception{
		int workId = 0;
		if(!"".equals(workIds)){
			workId = Integer.parseInt(workIds);
		}
		
		FlowRequest flowRequest = new FlowRequest();
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.WORK_ITEM_ID,E.MAIN_BIZ_KEY,C.ACTIVITY_ID,F.FLOW_ID,E.WORK_ID");
		strSql.append(" from WF_WORK_ITEM A inner join ");
		strSql.append(" WF_WORK_ACTIVITY B on A.WORK_ACTIVITY_ID = B.WORK_ACTIVITY_ID  left join");
		strSql.append(" WF_ACTIVITY C on B.ACTIVITY_ID = C.ACTIVITY_ID left join");
		strSql.append(" WF_WORK E on B.WORK_ID = E.WORK_ID left join");
		strSql.append(" WF_FLOW F on C.FLOW_ID = F.FLOW_ID where 1=1 and A.WORK_ITEM_STATE="+StateId+" and E.WORK_ID = "+workId);
		flowRequest = jdbcTemplate_workflow.query(strSql.toString(), new ResultSetExtractor<FlowRequest>(){

			@Override
			public FlowRequest extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				FlowRequest flowRequest = new FlowRequest();
				if(rs.next()){
					flowRequest.setActivityID(rs.getString("ACTIVITY_ID"));
					flowRequest.setWorkID(rs.getString("WORK_ID"));
					flowRequest.setWorkItemID(rs.getString("WORK_ITEM_ID"));
					flowRequest.setFlowID(rs.getString("FLOW_ID"));
				}
				return flowRequest;
			}
			
		});
		
		if(flowRequest != null){
			return flowRequest;
		}
		return null;
	}
}
