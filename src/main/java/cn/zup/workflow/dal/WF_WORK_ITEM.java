package cn.zup.workflow.dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.rbac.entity.UserSession;

@Repository("item")
public class WF_WORK_ITEM  extends WF_WORK_ItemBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/** 
	 根据工作活动ID获取工作项列表
	 
	*/
	public List<cn.zup.workflow.model.WF_WORK_ITEM> ActivityWorkItemList(int workAcitivityID) throws SQLException{
   		StringBuilder strSql = new StringBuilder();
   		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION");
   		strSql.append(" FROM WF_WORK_ITEM ");
   		strSql.append(" where WORK_ACTIVITY_ID="+workAcitivityID);
   		
   		List<cn.zup.workflow.model.WF_WORK_ITEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ITEM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ITEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ITEM> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ITEM>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}  
				return list;
			}
		});
   		
   		return list;
   	}

	/** 
	 根据工作ID和活动ID获取工作项列表
	 
	 @param workID 工作ID
	 @param activityID 活动ID
	 @return 
	*/
	public List<cn.zup.workflow.model.WF_WORK_ITEM> GetListArray(int workID, int activityID) throws SQLException{
   		StringBuilder strSql = new StringBuilder();
   		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION");
   		strSql.append("  from WF_WORK_ITEM ");
   		strSql.append(" where WORK_ACTIVITY_ID in (select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where WORK_ID="+workID+" and ACTIVITY_ID="+activityID+" ) ");
   		System.err.println("GetListArray===="+strSql.toString());
   		List<cn.zup.workflow.model.WF_WORK_ITEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ITEM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ITEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ITEM> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ITEM>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
		});
   		
   		return list;
   	}
	/** 
	 根据工作ID、活动ID与操作者获取工作项信息
	 
	 @param workID
	 @param activityID
	 @param handlerIDs
	 @return 
	 * @throws SQLException 
	*/
	public cn.zup.workflow.model.WF_WORK_ITEM GetModel(int workID, int activityID, String handlerIDs) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION");
		strSql.append(" from WF_WORK_ITEM ");
		strSql.append(" where WORK_ACTIVITY_ID=(select top 1 WORK_ACTIVITY_ID from WF_WORK_ACTIVITY  where WORK_ID=? and ACTIVITY_ID=? order by FINISHED_DATETIME) and");
		strSql.append(" HANDLER_ID in(");
		strSql.append(handlerIDs);
		strSql.append(")");
		
		cn.zup.workflow.model.WF_WORK_ITEM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_ITEM>(){
			@Override
			public cn.zup.workflow.model.WF_WORK_ITEM extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_WORK_ITEM model = new cn.zup.workflow.model.WF_WORK_ITEM();
				if(rs.next())
				     model=ReaderBind(rs);
				return model;      
			}
		});

		return model;              
		
	}

	/** 
	 根据流程、业务主键获取工作项信息
	 
	 @param flowID 流程ID
	 @param mainBizKey 业务主键
	 @param activityID 活动ID
	 @return 
	 * @throws SQLException 
	*/
	public List<cn.zup.workflow.model.WF_WORK_ITEM> WorkItemList(int flowID, String mainBizKey, int activityID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION");
		strSql.append(" from WF_WORK_ITEM ");
		strSql.append(MessageFormat.format(" where WORK_ACTIVITY_ID in(select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where ACTIVITY_ID={0} and ", activityID));
		strSql.append(MessageFormat.format(" WORK_ID=(select WORK_ID from WF_WORK where FLOW_ID={0} and MAIN_BIZ_KEY={1}))", 
				flowID+"", "'"+mainBizKey+"'"));
		
		List<cn.zup.workflow.model.WF_WORK_ITEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ITEM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ITEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ITEM> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ITEM>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
		});
		
		return list;
	}
		
	///#region 获取工作项信息

	/** 
	 根据工作ID、活动ID，操作者信息获取该活动下的接受者为currentHandler的工作项信息
	 
	 @param workID
	 @param activityID
	 @param currentHandler
	 @return 
	 * @throws SQLException 
	*/
	public cn.zup.workflow.model.WF_WORK_ITEM WorkItemInfoByReciver(int workID, int activityID, UserSession currentHandler) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION");
		strSql.append(" from WF_WORK_ITEM ");
		strSql.append(MessageFormat.format(" where WORK_ACTIVITY_ID in(select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where WORK_ID={0} and ACTIVITY_ID={1}  and WORK_ACTIVITY_STATE={2})", 
				workID+"", activityID+"", cn.zup.workflow.config.WorkActivityState.InProgress.getValue()+""));
		strSql.append(MessageFormat.format(" and ((RECEIVER_TYPE={0} AND RECEIVER_ID={1}) or (RECEIVER_TYPE={2} AND RECEIVER_ID={3}) or (RECEIVER_TYPE={4} AND RECEIVER_ID ={5} )) ", 
				cn.zup.workflow.config.HandlerAndMonitorType.User.getValue()+"", currentHandler.getUserId()+"", 
				cn.zup.workflow.config.HandlerAndMonitorType.Position.getValue()+"", currentHandler.getPostId()+"",
				cn.zup.workflow.config.HandlerAndMonitorType.Department.getValue()+"", currentHandler.getOrganId()+""));
		strSql.append(" and WORK_ITEM_STATE="+cn.zup.workflow.config.WorkItemState.InProgress.getValue());

		cn.zup.workflow.model.WF_WORK_ITEM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_ITEM>(){
			@Override
			public cn.zup.workflow.model.WF_WORK_ITEM extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_WORK_ITEM model = new cn.zup.workflow.model.WF_WORK_ITEM();
				if(rs.next())
				     model=ReaderBind(rs);
				return model;      
			}
		});
		
		return model;
	}

	public void deleteActivitySonTable(int activityID) {
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from  wf_work_item where wf_work_item.WORK_ITEM_ID in ("+
						" select work_item_Id from ("+
							" select i.WORK_ITEM_ID from wf_work_item i"+
							   " LEFT JOIN wf_work_activity w on w.WORK_ACTIVITY_ID=i.WORK_ACTIVITY_ID"+
							   " LEFT JOIN wf_activity a on a.ACTIVITY_ID=w.ACTIVITY_ID"+
							   " where 1=1"+
							   " and a.ACTIVITY_ID="+activityID+
						" )a"+
						")");
		System.err.println(strSql.toString());
		jdbcTemplate_workflow.update(strSql.toString());
	}

}