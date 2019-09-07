package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
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

import cn.zup.workflow.util.StringHelper;

@Repository("workActivityDal")
public class WF_WORK_ACTIVITY extends WF_WORK_ActivityBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	@Autowired
	private cn.zup.workflow.dal.WF_ACTIVITY activityDal;

	/** 
	 根据工作ID、活动ID获取某节点所有经办人（实现默认经办人）
	 
	 @param workID 工作ID
	 @param activityCode 活动编号
	 @return 
	 * @throws SQLException 
	*/
	public List<String> WorkActivityHandlerIDs(int workID, int activityCode) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.HANDLER_ID ");
		strSql.append(" from  WF_WORK_ITEM as A left outer join");
		strSql.append(" WF_WORK_ACTIVITY as B on A.WORK_ACTIVITY_ID=B.WORK_ACTIVITY_ID left outer join");
		strSql.append(" WF_ACTIVITY as C on B.ACTIVITY_ID=C.ACTIVITY_ID");
		strSql.append(MessageFormat.format(" where B.WORK_ID={0} and C.ACTIVITY_CODE={1}",
				workID+"", activityCode+""));	
		
		List<String> listHandler = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<String>>(){
			@Override
			public List<String> extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				List<String> listHandler = new ArrayList<String>();
				while (rs.next()){
					listHandler.add(String.valueOf(rs.getInt("A.HANDLER_ID")));
				}
				return listHandler;
			}
		});
		
		return listHandler;
	}
	
	/** 
	 获取最新的工作活动实体
	 * @throws SQLException 
	 
	*/
	public cn.zup.workflow.model.WF_WORK_ACTIVITY GetModel(int workID, int activityID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_ACTIVITY_ID,WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES from WF_WORK_ACTIVITY ");
		strSql.append(MessageFormat.format(" where WORK_ID={0} and ACTIVITY_ID={1} order by  CREATE_DATETIME desc",
				workID+"", activityID+""));
		
		cn.zup.workflow.model.WF_WORK_ACTIVITY model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_ACTIVITY>(){
			@Override
			public cn.zup.workflow.model.WF_WORK_ACTIVITY extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_WORK_ACTIVITY model = null;
				if(rs.next())
				     model=ReaderBind(rs);
				return model;
			}
		});

		return model;              
	}

	/** 
	 获取工作活动信息
	 
	 @param workItemID 工作项ID
	 @return 工作活动对象实体
	 * @throws SQLException 
	*/
	public cn.zup.workflow.model.WF_WORK_ACTIVITY GetModelByWorkItem(int workItemID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.WORK_ACTIVITY_ID,WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES ");
		strSql.append(" from WF_WORK_ACTIVITY  A inner join WF_WORK_ITEM  B ON A.WORK_ACTIVITY_ID=B.WORK_ACTIVITY_ID");
		strSql.append(MessageFormat.format(" where WORK_ITEM_ID={0}", workItemID+""));

		cn.zup.workflow.model.WF_WORK_ACTIVITY model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_ACTIVITY>(){
			@Override
			public cn.zup.workflow.model.WF_WORK_ACTIVITY extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_WORK_ACTIVITY model = null;
				if(rs.next())
				     model=ReaderBind(rs);
				return model;
			}
		});
		
		return model;             
	}


	/** 
	 判断是否可以进行提交
	 
	 @param flowID 流程ID
	 @param workID 工作ID
	 @param activityCode 活动编号
	 @return 
	*/
	public boolean PreAcitvityList(int flowID, int workID, int activityCode) throws SQLException{
		java.util.List<cn.zup.workflow.model.WF_ACTIVITY> activityList = activityDal.GetListArray("FLOW_ID=" + flowID);
		java.util.List<cn.zup.workflow.model.WF_ACTIVITY> activityIDList=new ArrayList<cn.zup.workflow.model.WF_ACTIVITY>();    	
		for(cn.zup.workflow.model.WF_ACTIVITY item : activityList){
    		String nextActCode=item.getNEXT_ACTIVITY_CODE();  
    		if(nextActCode==null || nextActCode.length() <= 0)
    			continue;
    		for(String codeItem :nextActCode.split("[,]")){
    			if(Integer.parseInt(codeItem)==activityCode) {
    				activityIDList.add(item);
    				break;
    			}
    		}                		
    	}
		StringBuilder preActivityIDs = new StringBuilder();
		for (cn.zup.workflow.model.WF_ACTIVITY item : activityIDList){
			preActivityIDs.append(item.getACTIVITY_CODE());
			preActivityIDs.append(",");
		}
		if (preActivityIDs.length() == 0){
			throw new RuntimeException("前置活动异常！");
		}
		preActivityIDs.deleteCharAt(preActivityIDs.length() - 1);		  

		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_ACTIVITY_ID,WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES from WF_WORK_ACTIVITY ");
		strSql.append(" where WORK_ID="+workID+" and WORK_ACTIVITY_STATE != ");
		strSql.append(cn.zup.workflow.config.WorkActivityState.Reject.getValue());
		strSql.append(" and ACTIVITY_ID in(");
		strSql.append(preActivityIDs.toString());
		strSql.append(")");
		
		List<cn.zup.workflow.model.WF_WORK_ACTIVITY> workActList = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ACTIVITY>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ACTIVITY> workActList = new ArrayList<cn.zup.workflow.model.WF_WORK_ACTIVITY>();
				while(rs.next()){
					workActList.add(ReaderBind(rs));
				}
				return workActList;
			}
		});
		
		if (workActList.size() < activityIDList.size()){ //若工作活动数量小于活动数量则不进行提交，交由工作流引擎判断
			return false;
		}

		List<cn.zup.workflow.model.WF_WORK_ACTIVITY> finishedCheck=new ArrayList<cn.zup.workflow.model.WF_WORK_ACTIVITY>();

		for(cn.zup.workflow.model.WF_WORK_ACTIVITY item : workActList){
    		int workactivitystate=item.getWORK_ACTIVITY_STATE();           		
			if(workactivitystate == cn.zup.workflow.config.WorkActivityState.InProgress.getValue()) {
				finishedCheck.add(item);
				break;
			}
    	}
		if (finishedCheck.size() > 0){ //有未完成的工作也不进行提交
			return false;
		}

		return true;
	}
	
	/** 
	 将工作活动及对应的工作项全部置为驳回状态
	 
	 @param workID
	 @param activityId
	 @param dbTran
	 @param transaction
	*/
	public void ActivityReject(int workID, String activityIDs) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("update WF_WORK_ACTIVITY set");
		strSql.append(" WORK_ACTIVITY_STATE="+cn.zup.workflow.config.WorkActivityState.Reject.getValue());
		strSql.append(" where WORK_ID="+workID+" and ACTIVITY_ID in(");
		strSql.append(activityIDs);
		strSql.append(")");
		strSql.append(" update WF_WORK_ITEM set");
		strSql.append(" WORK_ITEM_STATE="+cn.zup.workflow.config.WorkActivityState.Reject.getValue());
		strSql.append(" where WORK_ACTIVITY_ID in(select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where  WORK_ID="+workID+" and ACTIVITY_ID in (");
		jdbcTemplate_workflow.update(strSql.toString());
	}
			   
	//#region 获取需要激活节点的经办人
	public List<cn.zup.workflow.model.WF_HANDLER> WorkNewActivityHandlerList(int workID, int activityID) throws SQLException{
		WF_HANDLER handlerDal = new WF_HANDLER();
		String readyActivityCode;
		String readyHandlerID = null;
		int flowID;
		String subFLowID;
		List<cn.zup.workflow.model.WF_HANDLER> handlerList;

		//1-获取活动信息
		cn.zup.workflow.model.WF_ACTIVITY activityModel = activityDal.GetModel(activityID);
		readyActivityCode = Integer.toString(activityModel.getACTIVITY_CODE());
		flowID = activityModel.getFLOW_ID();
		subFLowID = Integer.toString(activityModel.getSUB_FLOW_ID());

		//2-获取活动操作者信息
		handlerList = handlerDal.ActivityHandlerList(activityID);
		
		//3-获取实际选择的操作者
		//3-1获取该节点的配置的父节点
		java.util.ArrayList<cn.zup.workflow.model.WF_ACTIVITY> activityList = (ArrayList<cn.zup.workflow.model.WF_ACTIVITY>) activityDal.GetListArray("FLOW_ID=" + flowID);
        for(cn.zup.workflow.model.WF_ACTIVITY item: activityList){
        	String nextActCode=item.getNEXT_ACTIVITY_CODE();
        	for(String codeItem :nextActCode.split("[,]"))
    		{
    			if(codeItem.equals(readyActivityCode)) 
    			{
    			   activityList.add(item);
    				
    			}
    		}   
        }
		//3-2获取实际的父节点
		cn.zup.workflow.dal.WF_WORK_ActivityBase workActivityDal = new cn.zup.workflow.dal.WF_WORK_ActivityBase();
		List<cn.zup.workflow.model.WF_WORK_ACTIVITY> workActList = workActivityDal.GetListArray("WORK_ID=" + workID);
		cn.zup.workflow.model.WF_WORK_ACTIVITY realWorkAct=null;
		for(cn.zup.workflow.model.WF_WORK_ACTIVITY item: workActList){
			for(cn.zup.workflow.model.WF_ACTIVITY activity:activityList){
				if(item.getACTIVITY_ID()==activity.getACTIVITY_ID()){
					if(item.getWORK_ACTIVITY_STATE()==2){
						realWorkAct=item;
						break;
					}
				}
			}
        }
		String realNextActCodesTemp = realWorkAct.getNEXT_ACTIVITY_CODES(); //下一工作活动节点临时量
		String realNextHandlerIDTemp = realWorkAct.getNEXT_ACTIVITY_HANDLERS(); //下一工作活动操作者临时量
		if (!StringHelper.isNullOrEmpty(realWorkAct.getNEXT_ACTIVITY_HANDLERS())){   
			//获取要激活的活动在字段中的索引
			int actIndex;
			for(String nextcodeItem :realNextActCodesTemp.split("[,]")){
    			actIndex=nextcodeItem.indexOf(readyActivityCode);
    		}   
			//实际选择的操作者
			for(String nextHandlerIDItem :realNextHandlerIDTemp.split("[,]")){
				readyHandlerID=nextHandlerIDItem;
    		} 
			handlerList = handlerDal.GetListArray("HANDLER_ID in(" + readyHandlerID + ")"); 
		}
		return handlerList;
	}

   /** 
	获取工作活动的历史接收者
	
	@param workID
	@param activityID
	@return 
 * @throws SQLException 
   */
   public List<cn.zup.workflow.model.WF_HANDLER> WorkActivityHandlerList(int workID, int activityID) throws SQLException{
	   List<cn.zup.workflow.model.WF_WORK_ITEM> workItemList = new WF_WORK_ITEM().GetListArray(workID, activityID);
	   java.util.List<cn.zup.workflow.model.WF_HANDLER> handlerList = new WF_HANDLER().ActivityHandlerList(activityID);
	   //handlerList = (from handler in handlerList join workItem in workItemList on handler.HANDLER equals workItem.RECEIVER_ID where handler.HANDLER_TYPE==workItem.RECEIVER_TYPE select handler).ToList();
	   for(cn.zup.workflow.model.WF_HANDLER handler:handlerList){
		   for(cn.zup.workflow.model.WF_WORK_ITEM workitem:workItemList){
			   if(handler.getHANDLER()==workitem.getRECEIVER_ID()){
				   if(handler.getHANDLER_TYPE()==workitem.getRECEIVER_TYPE()){
					   handlerList.add(handler);
				   }
			   }
		   }
	   }
	   return handlerList;
   }
		///#region 工作流引擎-获取AOV网

	/** 
	 获取AOV网
	 
	 @param flowID
	 @param workID
	 @return 
	 * @throws SQLException 
	*/
	public List<cn.zup.workflow.model.ACTIVITY_AOV> AOVNet(int flowID, int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.FLOW_ID, A.ACTIVITY_ID,A.ACTIVITY_CODE,A.ACTIVITY_PROPERTY,A.ACTIVITY_TYPE,A.NEXT_ACTIVITY_CODE,A.REJECT_ACTIVITY_CODE,");
		strSql.append("B.NEXT_ACTIVITY_CODES AS REAL_NEXT_ACTIVITY_CODES,");
		strSql.append("B.NEXT_ACTIVITY_HANDLERS as REAL_NEXT_HANDLERS,");
		strSql.append("(CASE WHEN B.WORK_ACTIVITY_ID IS NULL THEN 0 ELSE B.WORK_ACTIVITY_ID END) AS WORK_ACTIVITY_ID,");
		strSql.append("(CASE WHEN B.WORK_ACTIVITY_STATE IS NULL THEN 0 ELSE B.WORK_ACTIVITY_STATE END) AS FINISH_FLAG");
		strSql.append(" from WF_ACTIVITY A LEFT OUTER JOIN  WF_WORK_ACTIVITY B");
		strSql.append(" ON A.ACTIVITY_ID=B.ACTIVITY_ID AND B.WORK_ACTIVITY_STATE!=? "); //3表示驳回
		strSql.append(" AND B.WORK_ID=? WHERE A.FLOW_ID=?");
		
		List<cn.zup.workflow.model.ACTIVITY_AOV> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.ACTIVITY_AOV>>(){
			@Override
			public List<cn.zup.workflow.model.ACTIVITY_AOV> extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.ACTIVITY_AOV> list = new ArrayList<cn.zup.workflow.model.ACTIVITY_AOV>();
				while(rs.next()){
					list.add(ReaderBindAOV(rs));
				}
				return list;
			}
		});
		
		return list;
	}

/**
	 对象实体绑定数据
 * @throws SQLException 
	 
	*/
	public cn.zup.workflow.model.ACTIVITY_AOV ReaderBindAOV(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.ACTIVITY_AOV model = new cn.zup.workflow.model.ACTIVITY_AOV();
		Object ojb;
		ojb = rs.getObject("FLOW_ID");
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("ACTIVITY_ID");
		if(ojb != null){
			model.setACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("ACTIVITY_CODE");
		if(ojb != null){
			model.setACTIVITY_CODE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("ACTIVITY_PROPERTY");
		if(ojb != null){
			model.setACTIVITY_PROPERTY(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("ACTIVITY_TYPE");
		if(ojb != null){
			model.setACTIVITY_TYPE(Integer.parseInt(ojb.toString()));
		}
		model.setNEXT_ACTIVITY_CODE(rs.getInt("NEXT_ACTIVITY_CODE"));
		ojb = rs.getObject("REJECT_ACTIVITY_CODE");
		if(ojb != null){
			model.setREJECT_ACTIVITY_CODE(Integer.parseInt(ojb.toString()));
		}
		model.setREAL_NEXT_ACTIVITY_CODES(rs.getString("REAL_NEXT_HANDLERS"));
		ojb = rs.getObject("WORK_ACTIVITY_ID");
		if(ojb != null){
			model.setWORK_ACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("FINISH_FLAG");
		if(ojb != null){
			model.setFINISH_FLAG(Integer.parseInt(ojb.toString())); 
		}
		return model;
	}

	public List<cn.zup.workflow.model.WORK_ACTIVITY> WorkActivityActiveList() throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select B.FLOW_ID, A.WORK_ID,A.WORK_ACTIVITY_ID,A.FINISHED_DATETIME");
		strSql.append(" from WF_WORK_ACTIVITY A,  WF_WORK B ");
		strSql.append(" where A.WORK_ID=B.WORK_ID and B.WORK_STATE=" + cn.zup.workflow.config.WorkState.InProgress.getValue());
		strSql.append(" and A.FINISHED_DATETIME in(select max(FINISHED_DATETIME) from WF_WORK_ACTIVITY C WHERE C.WORK_ID=B.WORK_ID)");
		
		List<cn.zup.workflow.model.WORK_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_ACTIVITY>>(){
			@Override
			public List<cn.zup.workflow.model.WORK_ACTIVITY> extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_ACTIVITY> list = new ArrayList<cn.zup.workflow.model.WORK_ACTIVITY>();
				while (rs.next()){
					list.add(ReaderBindActivity(rs));
				}
				return list;
			}
		});
		
		return list;
	}

	/** 
	 对象实体绑定数据
	 * @throws SQLException 
	 
	*/
	public cn.zup.workflow.model.WORK_ACTIVITY ReaderBindActivity(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_ACTIVITY model = new cn.zup.workflow.model.WORK_ACTIVITY();
		Object ojb;
		ojb = rs.getObject("FLOW_ID");
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("WORK_ACTIVITY_ID");
		if(ojb != null){
			model.setWORK_ACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("WORK_ID");
		if(ojb != null){
			model.setWORK_ID(Integer.parseInt(ojb.toString()));
		}

		ojb = rs.getObject("FINISHED_DATETIME");
		if(ojb != null){
			model.setFINISHED_DATETIME((java.util.Date)ojb);
		}
		return model;
	}
	public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> getWorkActivityList(int activityId,Integer workId) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select * from WF_WORK_ACTIVITY where ACTIVITY_ID= "+activityId);
		if(workId!=null){
			strSql.append("  and WORK_ID= "+workId);
		}
		List<cn.zup.workflow.model.WF_WORK_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ACTIVITY>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> extractData(
					ResultSet rs) throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ACTIVITY> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ACTIVITY>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
		});
		return list;
	}

	public void deleteActivitySonTable(int activityID) {
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from  wf_work_activity where  ACTIVITY_ID="+activityID);
		System.err.println(strSql.toString());
		jdbcTemplate_workflow.update(strSql.toString());
	}

	public void deleteWFActivity(int nodeId) {
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from  wf_activity where ACTIVITY_ID="+nodeId);
		System.err.println(strSql.toString());
		jdbcTemplate_workflow.update(strSql.toString());
	}
}