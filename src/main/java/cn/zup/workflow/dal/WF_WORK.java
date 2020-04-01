package cn.zup.workflow.dal;
import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.config.EntrustState;
import cn.zup.workflow.config.HandlerAndMonitorType;
import cn.zup.workflow.config.WorkItemState;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;
import cn.zup.workflow.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository("workDal")
public class WF_WORK extends WF_WorkBase{
	public WF_WORK(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	@Autowired
	private PagingService paingService;

	/** 
	 *liudeli 
	 *20161220 获取监控工作列表
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public PagingData<cn.zup.workflow.model.WF_WORK> getWorkMonistorList(QueryParameter queryParameter,
			UserSession currentHandler, int pageIndex, int pageSize) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append(" select a.work_id,a.flow_id,a.work_name,a.work_state,a.sponsor_id, ");
		strSql.append(" a.sponsor_name,a.create_datetime,a.main_biz_key,a.parent_work_id ");
		strSql.append(" ,a.parent_activity_id,e.sub_name as WORK_STATE_NAME, ");
		strSql.append(" b.flow_name,c.system_id,c.system_name,d.activity_id,d.activity_name  ");
		strSql.append(" from Wf_Work a");
		strSql.append(" left join WF_FLOW b on a.flow_id=b.flow_id");
		strSql.append(" left join WF_SYSTEM c on b.system_id=c.system_id");
		strSql.append(" left join WF_ACTIVITY d on b.flow_id=d.flow_id and d.activity_type=1");
		strSql.append(" left join WF_CONFIG e on a.work_state=e.sub_id and e.id=" + ConfigList.WorkState.getValue());
		strSql.append(" left join wf_monitor f on f.FLOW_ID = b.FLOW_ID ");
		strSql.append(" where 1=1");
		strSql.append(" and f.MONITOR = '" + currentHandler.getUserId()+ "'");
		if(queryParameter.getSystemID() != 0){
			strSql.append(" and c.SYSTEM_ID=" + queryParameter.getSystemID());
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and b.FLOW_NAME like '%" + queryParameter.getFlowName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getWorkName())){
			strSql.append(" and a.WORK_NAME like '%" + queryParameter.getWorkName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getActivityName())){
			strSql.append(" and d.ACTIVITY_NAME like '%" + queryParameter.getActivityName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFromDate())){
			strSql.append(" and date_format(a.CREATE_DATETIME, '%Y-%c-%d') >= date_format('" + queryParameter.getFromDate() + "', '%Y-%c-%d')");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getToDate())){
			strSql.append(" and date_format(a.CREATE_DATETIME, '%Y-%c-%d') <= date_format('" + queryParameter.getToDate() + "', '%Y-%c-%d')");
		}
		if (queryParameter.getWorkState() != 0){
			strSql.append(" and a.WORK_STATE =" + queryParameter.getWorkState());
		}
		if(queryParameter.getSponsorName() != null){
			strSql.append(" and a.sponsor_name like '%" + queryParameter.getSponsorName()+"%'");
		}
		
		//获取分页
		int totalAmount = paingService.GetPagingData(strSql.toString(), "a.WORK_ID", "a.CREATE_DATETIME desc", pageIndex,pageSize);
		
		String pageSql=paingService.GetPagingSql(strSql.toString(), "a.WORK_ID", "a.CREATE_DATETIME desc", pageIndex,pageSize);
		System.err.println(pageSql);
		List<cn.zup.workflow.model.WF_WORK> list = jdbcTemplate_workflow.query(pageSql, 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK> list = new ArrayList<cn.zup.workflow.model.WF_WORK>();
				while (rs.next()){
					list.add(ReaderBindMonistorList(rs));
				}	
				return list;
			}
			
		});
		
		PagingData<cn.zup.workflow.model.WF_WORK> result = new PagingData<cn.zup.workflow.model.WF_WORK>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}
	/** 
	 对象实体绑定数据
	 * @throws SQLException 
	 
	*/
	public cn.zup.workflow.model.WF_WORK ReaderBindMonistorList(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_WORK model = new cn.zup.workflow.model.WF_WORK();
		Object ojb;
		ojb = rs.getObject(1);
		if(ojb != null){
			model.setWORK_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject(2);
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_NAME(rs.getString(3));
		ojb = rs.getObject(4);
		if(ojb != null){
			model.setWORK_STATE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject(5);
		if(ojb !=null){
			model.setSPONSOR_ID(Integer.parseInt(ojb.toString()));
		}
		model.setSPONSOR_NAME(rs.getString(6));
		ojb = rs.getTimestamp(7);
		if(ojb != null){
			model.setCREATE_DATETIME((Date)ojb);
		}
		model.setMAIN_BIZ_KEY(rs.getString(8));
		ojb = rs.getObject(9);
		if(ojb != null){
			model.setPARENT_WORK_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject(10);
		if(ojb != null){
			model.setPARENT_ACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_STATE_NAME(rs.getString(11));
		model.setFLOW_NAME(rs.getString(12));
		ojb = rs.getObject(13);
		if(ojb != null){
			model.setSYSTEM_ID(Integer.parseInt(ojb.toString()));
		}
		model.setSYSTEM_NAME(rs.getString(14));
		ojb = rs.getObject(15);
		if(ojb != null){
			model.setACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		model.setACTIVITY_NAME(rs.getString(16));
		return model;
	}
	/** 
	 根据当前登录者获取工作待办数
	 
	 @param currentHandler
	 @return 
	*/
	public int WorkTodoAmount(UserSession currentHandler) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select count(*)");
		strSql.append(" FROM WF_WORK_ITEM ");
		strSql.append(" where WORK_ITEM_STATE=" + WorkItemState.InProgress.getValue() + " and (");
		strSql.append(" (RECEIVER_TYPE=" + HandlerAndMonitorType.User.getValue() + " and RECEIVER_ID=" + currentHandler.getUserId() + ") or");
		strSql.append(" (RECEIVER_TYPE=" + HandlerAndMonitorType.Position.getValue() + " and RECEIVER_ID=" + currentHandler.getPostId() + ") or");
		strSql.append(" (RECEIVER_TYPE=" + HandlerAndMonitorType.Department.getValue() + " and RECEIVER_ID=" + currentHandler.getOrganId() + "))");
		
		int count = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<Integer>(){
			@Override
			public Integer extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				int count = 0;
				if (rs.next()){			
					count=Integer.parseInt(rs.getInt(1)+"");
				}
				return count;
			}
			
		});
		
		return count;
	}

	/** 
	 获取所有符合操作者各类型的待办工作列表
	 
	 @param handlerList
	 @return 
	*/
	public PagingData<cn.zup.workflow.model.WORK_TODO> TodoList(QueryParameter queryParameter, 
			UserSession currentHandler, int pageIndex, int pageSize) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.RECEIVER_TYPE,A.RECEIVER_ID,A.RECEIVER_NAME,A.WORK_ITEM_ID,E.MAIN_BIZ_KEY,C.ACTIVITY_ID,C.ACTIVITY_CODE,");
		strSql.append("A.WORK_ITEM_STATE WORK_STATE, F.FLOW_ID,F.FLOW_NAME,E.WORK_ID,E.WORK_NAME,F.SYSTEM_ID,C.ACTIVITY_NAME,");
		strSql.append("date_format( A.WORK_ITEM_DATETIME, '%Y-%c-%d %H:%i:%s' ) WORK_ITEM_DATETIME, B.PRE_ACTIVITY_INFO,G.SUB_NAME WORK_STATE_NAME,SY.SYSTEM_NAME ");
		strSql.append(" from WF_WORK_ITEM A inner join ");
		strSql.append(" WF_WORK_ACTIVITY B on A.WORK_ACTIVITY_ID = B.WORK_ACTIVITY_ID and A.WORK_ITEM_STATE in(" + WorkItemState.InProgress.getValue() + ") inner join");
		strSql.append(" WF_ACTIVITY C on B.ACTIVITY_ID = C.ACTIVITY_ID left outer join");
		strSql.append(" WF_WORK E on B.WORK_ID = E.WORK_ID left outer join");
		strSql.append(" WF_FLOW F on C.FLOW_ID = F.FLOW_ID left outer join");
		strSql.append(" WF_CONFIG G on A.WORK_ITEM_STATE = G.SUB_ID and G.ID =" + ConfigList.WorkItemState.getValue());
		strSql.append(" left outer join WF_SYSTEM SY on SY.SYSTEM_ID = F.SYSTEM_ID ");
		strSql.append(" where 1=1");
		if(queryParameter.getSystemID() != 0){
			strSql.append(" and F.SYSTEM_ID=" + queryParameter.getSystemID());
		}
		strSql.append(" and ( (A.RECEIVER_TYPE=" + HandlerAndMonitorType.User.getValue() + " and A.RECEIVER_ID=" +currentHandler.getUserId() + ") or");
		strSql.append(" (A.RECEIVER_TYPE=" + HandlerAndMonitorType.Position.getValue() + " and A.RECEIVER_ID=" + currentHandler.getPostId() + ") or");
		strSql.append(" (A.RECEIVER_TYPE=" + HandlerAndMonitorType.Department.getValue() + " and A.RECEIVER_ID=" + currentHandler.getOrganId() + "))");
		if (!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and F.FLOW_NAME like '%" + queryParameter.getFlowName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getWorkName())){
			strSql.append(" and E.WORK_NAME like '%" + queryParameter.getWorkName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getActivityName())){
			strSql.append(" and C.ACTIVITY_NAME like '%" + queryParameter.getActivityName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFromDate())){
			strSql.append(" and date_format( A.WORK_ITEM_DATETIME, '%Y-%c-%d') >= date_format('" + queryParameter.getFromDate() + "', '%Y-%c-%d')");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getToDate())){
			strSql.append(" and date_format( A.WORK_ITEM_DATETIME, '%Y-%c-%d') <= date_format('" + queryParameter.getToDate() + "', '%Y-%c-%d')");
		}
		//2016-10-13lixin修改待办工作的分页功能
		//获取分页
		int totalAmount = paingService.GetPagingData(strSql.toString(), "WORK_ITEM_ID", "WORK_ITEM_DATETIME desc", pageIndex,pageSize);
		ResultSet rs = paingService.getResultSet();
		
		String pageSql=paingService.GetPagingSql(strSql.toString(), "WORK_ITEM_ID", "WORK_ITEM_DATETIME desc", pageIndex,pageSize);
		System.err.println(pageSql);
		List<cn.zup.workflow.model.WORK_TODO> list = jdbcTemplate_workflow.query(pageSql, 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_TODO>>(){
			@Override
			public List<cn.zup.workflow.model.WORK_TODO> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_TODO> list = new ArrayList<cn.zup.workflow.model.WORK_TODO>();
				while (rs.next()){
					list.add(ReaderBindWork(rs));
				}	
				return list;
			}
			
		});
			
		PagingData<cn.zup.workflow.model.WORK_TODO> result = new PagingData<cn.zup.workflow.model.WORK_TODO>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}


	/** 
	 对象实体绑定数据
	 
	*/
	public cn.zup.workflow.model.WORK_TODO ReaderBindWork(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_TODO model = new cn.zup.workflow.model.WORK_TODO();
		Object ojb;
		ojb = rs.getObject("WORK_ITEM_ID");
		if(ojb != null){
			model.setWORK_ITEM_ID(Integer.parseInt(ojb.toString()));
		}
		model.setMAIN_BIZ_KEY(rs.getString("MAIN_BIZ_KEY"));
		ojb = rs.getObject("ACTIVITY_ID");
		if(ojb != null){
			model.setACTIVITY_ID(4);
		}
		ojb = rs.getObject("ACTIVITY_CODE");
		if(ojb != null){
			model.setACTIVITY_CODE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("WORK_STATE");
		if(ojb != null){
			model.setWORK_STATE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("FLOW_ID");
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		model.setFLOW_NAME(rs.getString("FLOW_NAME"));
		ojb = rs.getObject("WORK_ID");
		if(ojb != null){
			model.setWORK_ID(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_NAME(rs.getString("WORK_NAME"));
		ojb = rs.getObject("SYSTEM_ID");
		if(ojb != null){
			model.setSYSTEM_ID(Integer.parseInt(ojb.toString()));
		}
		model.setACTIVITY_NAME(rs.getString("ACTIVITY_NAME"));
		ojb = rs.getObject("RECEIVER_TYPE");
		if(ojb != null){
			model.setRECEIVER_TYPE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("SYSTEM_NAME");
		if(ojb != null){
			model.setSYSTEM_NAME(ojb.toString());
		}
		ojb = rs.getObject("RECEIVER_ID");
		if(ojb != null){
			model.setRECEIVER_ID(Integer.parseInt(ojb.toString()));
		}
		model.setRECEIVER_NAME(rs.getString("RECEIVER_NAME"));
		ojb = rs.getObject("WORK_ITEM_DATETIME");
		if(ojb != null){
			String date=(ojb.toString());
			model.setWORK_ITEM_DATETIME(date);
		}
		model.setPRE_ACTIVITY_INFO(rs.getString("PRE_ACTIVITY_INFO"));
		model.setWORK_STATE_NAME(rs.getString("WORK_STATE_NAME"));
		return model;
	}

	/** 
	 获取当前登录者的委托工作
	 
	 @param queryParameter 查询条件
	 @param currentHandler 当前操作者
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	public PagingData<cn.zup.workflow.model.WORK_TODO> EntrustList(QueryParameter queryParameter, 
			UserSession currentHandler, int pageIndex, int pageSize) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.RECEIVER_TYPE,A.RECEIVER_ID,A.RECEIVER_NAME,A.WORK_ITEM_ID,E.MAIN_BIZ_KEY,C.ACTIVITY_ID,C.ACTIVITY_CODE,");
		strSql.append("A.WORK_ITEM_STATE as WORK_STATE, F.FLOW_ID,F.FLOW_NAME,E.WORK_ID,E.WORK_NAME,F.SYSTEM_ID,C.ACTIVITY_NAME,");
		strSql.append("A.WORK_ITEM_DATETIME, B.PRE_ACTIVITY_INFO,G.SUB_NAME as WORK_STATE_NAME");
		strSql.append(" from  dbo.WF_WORK_ITEM as A inner join ");
		strSql.append(" dbo.WF_ENTRUST as D on A.RECEIVER_ID=D.ENTRUST_PEOPLE_ID and D.STATE="+EntrustState.Valid.getValue()+" and  A.RECEIVER_TYPE=" + HandlerAndMonitorType.User.getValue()+" inner join");
		strSql.append(" dbo.WF_WORK_ACTIVITY as B on A.WORK_ACTIVITY_ID = B.WORK_ACTIVITY_ID and A.WORK_ITEM_STATE in(" + WorkItemState.InProgress.getValue() + ") inner join");
		strSql.append(" dbo.WF_ACTIVITY as C on B.ACTIVITY_ID = C.ACTIVITY_ID left outer join");
		strSql.append(" dbo.WF_WORK as E on B.WORK_ID = E.WORK_ID left outer join");
		strSql.append(" dbo.WF_FLOW as F on C.FLOW_ID = F.FLOW_ID left outer join");
		strSql.append(" dbo.WF_CONFIG as G on A.WORK_ITEM_STATE = G.SUB_ID and G.ID =" + ConfigList.WorkItemState.getValue());
		strSql.append(" where F.SYSTEM_ID=" + queryParameter.getSystemID());
		strSql.append(" and D.TRUST_PEOPLE_ID=" + currentHandler.getUserId());
		if (!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and F.FLOW_NAME like '%" + queryParameter.getFlowName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getWorkName())){
			strSql.append(" and E.WORK_NAME like '%" + queryParameter.getWorkName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getActivityName())){
			strSql.append(" and C.ACTIVITY_NAME like '%" + queryParameter.getActivityName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFromDate())){
			strSql.append(" and A.WORK_ITEM_DATETIME > '" + queryParameter.getFromDate() + "'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getToDate())){
			strSql.append(" and A.WORK_ITEM_DATETIME < '" + queryParameter.getToDate() + "'");
		}
		//获取分页SQL
		
		int totalAmount = paingService.GetPagingData(
				strSql.toString(), "WORK_ITEM_ID", "WORK_ITEM_DATETIME desc", pageIndex,
				pageSize);
		ResultSet rs = paingService.getResultSet();	

		String pageSql=paingService.GetPagingSql(strSql.toString(), "WORK_ITEM_ID", "WORK_ITEM_DATETIME desc", pageIndex,pageSize);
		System.err.println(pageSql);
		List<cn.zup.workflow.model.WORK_TODO> list = jdbcTemplate_workflow.query(pageSql, 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_TODO>>(){
			@Override
			public List<cn.zup.workflow.model.WORK_TODO> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_TODO> list = new ArrayList<cn.zup.workflow.model.WORK_TODO>();
				while (rs.next()){
					list.add(ReaderBindWork(rs));
				}
				return list;
			}
			
		});
		
		PagingData<cn.zup.workflow.model.WORK_TODO> result = new PagingData<cn.zup.workflow.model.WORK_TODO>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}  

	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public PagingData<cn.zup.workflow.model.WORK_DEALT> DealtList(QueryParameter queryParameter, 
			UserSession currentHandler, int pageIndex, int pageSize) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.RESPONSIBLE_ID,A.SIGN_NAME,A.WORK_ITEM_ID,E.MAIN_BIZ_KEY,B.WORK_ID,C.ACTIVITY_ID,C.ACTIVITY_CODE,A.WORK_ITEM_STATE,");
		strSql.append("E.WORK_NAME,F.SYSTEM_ID,F.FLOW_ID,F.FLOW_NAME,C.ACTIVITY_NAME,date_format( A.WORK_ITEM_DATETIME, '%Y-%c-%d %H:%i:%s' ) WORK_ITEM_DATETIME,");
		strSql.append(" B.PRE_ACTIVITY_INFO,G.SUB_NAME WORK_STATE_NAME");
		strSql.append(" from  WF_WORK_ITEM A inner join");
		strSql.append(" WF_WORK_ACTIVITY B on A.WORK_ACTIVITY_ID = B.WORK_ACTIVITY_ID and A.WORK_ITEM_STATE IN (" + WorkItemState.NormalEnd.getValue() + ") inner join");
		strSql.append(" WF_ACTIVITY C on B.ACTIVITY_ID = C.ACTIVITY_ID left outer join ");
		strSql.append(" WF_WORK E on B.WORK_ID = E.WORK_ID left outer join  ");
		strSql.append(" WF_FLOW F on C.FLOW_ID = F.FLOW_ID left outer join ");
		strSql.append(" WF_CONFIG G on A.WORK_ITEM_STATE = G.SUB_ID and G.ID =" + ConfigList.WorkState.getValue());
		strSql.append(" where A.Receiver_Id=" + currentHandler.getUserId());
		if(queryParameter.getSystemID() != 0){
			strSql.append(" and F.SYSTEM_ID=" + queryParameter.getSystemID());
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and F.FLOW_NAME like '%" + queryParameter.getFlowName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getWorkName())){
			strSql.append(" and E.WORK_NAME like '%" + queryParameter.getWorkName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getActivityName())){
			strSql.append(" and C.ACTIVITY_NAME like '%" + queryParameter.getActivityName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFromDate())){
			strSql.append(" and date_format( A.WORK_ITEM_DATETIME, '%Y-%c-%d') >= date_format('" + queryParameter.getFromDate() + "', '%Y-%c-%d')");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getToDate())){
			strSql.append(" and date_format( A.WORK_ITEM_DATETIME, '%Y-%c-%d') <= date_format('" + queryParameter.getToDate() + "', '%Y-%c-%d')");
		}
		if (queryParameter.getWorkState() != 0){
			strSql.append(" and A.WORK_ITEM_STATE =" + queryParameter.getWorkState());
		}
		//获取分页
		int totalAmount = paingService.GetPagingData(strSql.toString(), "WORK_ITEM_ID", "WORK_ITEM_DATETIME desc", pageIndex,pageSize);
		
		String pageSql=paingService.GetPagingSql(strSql.toString(), "WORK_ITEM_ID", "WORK_ITEM_DATETIME desc", pageIndex,pageSize);
		System.err.println(pageSql);
		List<cn.zup.workflow.model.WORK_DEALT> list = jdbcTemplate_workflow.query(pageSql, 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_DEALT>>(){
			@Override
			public List<cn.zup.workflow.model.WORK_DEALT> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_DEALT> list = new ArrayList<cn.zup.workflow.model.WORK_DEALT>();
				while (rs.next()){
					list.add(ReaderBindDealtList(rs));
				}	
				return list;
			}
			
		});
		PagingData<cn.zup.workflow.model.WORK_DEALT> result = new PagingData<cn.zup.workflow.model.WORK_DEALT>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}

	/** 
	 对象实体绑定数据
	 
	*/
	public cn.zup.workflow.model.WORK_DEALT ReaderBindDealtList(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_DEALT model = new cn.zup.workflow.model.WORK_DEALT();
		Object ojb;
		ojb = rs.getObject(1);
		if(ojb != null){
			model.setRESPONSIBLE_ID(Integer.parseInt(ojb.toString()));
		}
		model.setSIGN_NAME(rs.getString(2));
		ojb = rs.getObject(3);
		if(ojb != null){
			model.setWORK_ITEM_ID(Integer.parseInt(ojb.toString()));
		}
		model.setMAIN_BIZ_KEY(rs.getString(4));
		ojb = rs.getObject(5);
		if(ojb != null){
			model.setWORK_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject(6);
		if(ojb != null){
			model.setACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getString(7);
		if(ojb != null){
			model.setACTIVITY_CODE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject(8);
		if(ojb != null){
			model.setWORK_STATE(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_NAME(rs.getString(9));
		ojb = rs.getObject(10);
		if(ojb != null){
			model.setSYSTEM_ID(Integer.parseInt(ojb.toString()));
		}

		ojb = rs.getString(11);
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		model.setFLOW_NAME(rs.getString(12));
		model.setACTIVITY_NAME(rs.getString(13));
		ojb = rs.getObject(14);
		if(ojb != null){
			String date=(ojb.toString());
			model.setWORK_ITEM_DATETIME(date);
		}
		model.setPRE_ACTIVITY_INFO(rs.getString(15));
		model.setWORK_STATE_NAME(rs.getString(16));
		return model;
	}

	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 * @throws SQLException 
	 
	*/
	public PagingData<cn.zup.workflow.model.WORK_INIT> InitList(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.WORK_ID,A.MAIN_BIZ_KEY,A.WORK_NAME,A.WORK_STATE,D.SUB_NAME as WORK_STATE_NAME,");
		strSql.append("A.SPONSOR_ID,A.SPONSOR_NAME, A.CREATE_DATETIME,A.FLOW_ID, B.FLOW_NAME ");
		strSql.append(" from dbo.WF_WORK as A left outer join ");
		strSql.append(" dbo.WF_FLOW as B on A.FLOW_ID=B.FLOW_ID left outer join ");
		strSql.append(" dbo.WF_CONFIG as D on A.WORK_STATE=D.SUB_ID and D.ID=" + ConfigList.WorkState.getValue());
		strSql.append(" where A.SPONSOR_ID=" + currentHandler.getUserId() + " and B.SYSTEM_ID=" + queryParameter.getSystemID());
		if (!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and B.FLOW_NAME like '%" + queryParameter.getFlowName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getWorkName())){
			strSql.append(" and A.WORK_NAME like '%" + queryParameter.getWorkName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFromDate())){
			strSql.append(" and A.CREATE_DATETIME > '" + queryParameter.getFromDate() + "'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getToDate())){
			strSql.append(" and A.CREATE_DATETIME < '" + queryParameter.getToDate() + "'");
		}
		if (queryParameter.getWorkState() != 0){
			strSql.append(" and A.WORK_STATE =" + queryParameter.getWorkState());
		}
		String pagingSql = new PagingService().GetPagingSql(
				strSql.toString(), "WORK_ITEM_ID", "CREATE_DATETIME desc", pageIndex,
				pageSize);

		List<cn.zup.workflow.model.WORK_INIT> list = jdbcTemplate_workflow.query(pagingSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_INIT>>(){

			@Override
			public List<cn.zup.workflow.model.WORK_INIT> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_INIT> list = new ArrayList<cn.zup.workflow.model.WORK_INIT>();
				while (rs.next()){
					list.add(ReaderBindInit(rs));
				}
				return list;
			}
		});
		
		//获取总记录
		int totalAmount = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<Integer>(){

			@Override
			public Integer extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				return rs.getRow();
			}
		});
		
		PagingData<cn.zup.workflow.model.WORK_INIT> result = new PagingData<cn.zup.workflow.model.WORK_INIT>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}


	/** 
	 对象实体绑定数据
	 * @throws SQLException 
	 
	*/
	public cn.zup.workflow.model.WORK_INIT ReaderBindInit(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_INIT model = new cn.zup.workflow.model.WORK_INIT();
		Object ojb;
		ojb = rs.getObject(1);
		if(ojb != null){
			model.setWORK_ID(Integer.parseInt(ojb.toString()));
		}
		model.setMAIN_BIZ_KEY(rs.getString(2));
		model.setWORK_NAME(rs.getString(3));
		ojb = rs.getObject(4);
		if(ojb != null){
			model.setWORK_STATE(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_STATE_NAME(rs.getString(5));
		ojb = rs.getObject(6);
		if(ojb !=null){
			model.setSPONSOR_ID(Integer.parseInt(ojb.toString()));
		}
		model.setSPONSOR_NAME(rs.getString(7));
		ojb = rs.getObject(8);
		if(ojb != null){
			model.setCREATE_DATETIME((Date)ojb);
		}
		ojb = rs.getObject(10);
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		model.setFLOW_NAME(rs.getString(11));
		return model;
	}
	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 * @throws SQLException 
	 
	*/
	public PagingData<cn.zup.workflow.model.WORK_MONITOR> MonitorList(QueryParameter queryParameter, 
			String monitorIDs, int pageIndex, int pageSize) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.WORK_ID,A.MAIN_BIZ_KEY,A.WORK_NAME,A.WORK_STATE,E.SUB_NAME WORK_STATE_NAME,");
		strSql.append("A.SPONSOR_ID,A.SPONSOR_NAME,A.CREATE_DATETIME,A.FLOW_ID,B.FLOW_NAME");
		strSql.append(" from WF_WORK A left outer join ");
		strSql.append(" WF_FLOW B on A.FLOW_ID=B.FLOW_ID left outer join ");
		strSql.append(" WF_CONFIG E on A.WORK_STATE=E.SUB_ID and E.ID=" + ConfigList.WorkState.getValue());
		strSql.append(" where A.FLOW_ID IN(select FLOW_ID from WF_MONITOR where MONITOR_ID IN(" + monitorIDs + "))");
		if (!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and B.FLOW_NAME like '%" + queryParameter.getFlowName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getWorkName())){
			strSql.append(" and A.WORK_NAME like '%" + queryParameter.getWorkName() + "%'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getFromDate())){
			strSql.append(" and A.CREATE_DATETIME >= '" + queryParameter.getFromDate() + "'");
		}
		if (!StringHelper.isNullOrEmpty(queryParameter.getToDate())){
			strSql.append(" and A.CREATE_DATETIME <= '" + queryParameter.getToDate() + "'");
		}
		if (queryParameter.getWorkState() != 0){
			strSql.append(" and A.WORK_STATE =" + queryParameter.getWorkState());
		}
		String pagingSql = new PagingService().GetPagingSql(
				strSql.toString(), "WORK_ITEM_ID", "CREATE_DATETIME desc", pageIndex,
				pageSize);
		
		List<cn.zup.workflow.model.WORK_MONITOR> list = jdbcTemplate_workflow.query(pagingSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_MONITOR>>(){

			@Override
			public List<cn.zup.workflow.model.WORK_MONITOR> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_MONITOR> list = new ArrayList<cn.zup.workflow.model.WORK_MONITOR>();
				while (rs.next()){
					list.add(ReaderBindMonitor(rs));
				}
				return list;
			}
		});
		
		//获取总记录
		int totalAmount = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<Integer>(){

			@Override
			public Integer extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				return rs.getRow();
			}
		});
		
		PagingData<cn.zup.workflow.model.WORK_MONITOR> result = new PagingData<cn.zup.workflow.model.WORK_MONITOR>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}

	/** 
	 对象实体绑定数据
	 * @throws SQLException 
	*/
	public cn.zup.workflow.model.WORK_MONITOR ReaderBindMonitor(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_MONITOR model = new cn.zup.workflow.model.WORK_MONITOR();
		Object ojb;
		ojb = rs.getObject(1);
		if(ojb != null){
			model.setWORK_ID(Integer.parseInt(ojb.toString()));
		}
		model.setMAIN_BIZ_KEY(rs.getString(2));
		model.setWORK_NAME(rs.getString(3));
		ojb = rs.getObject(4);
		if(ojb != null){
			model.setWORK_STATE(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_STATE_NAME(rs.getString(5));
		ojb = rs.getObject(6);
		if(ojb != null){
			model.setSPONSOR_ID(Integer.parseInt(ojb.toString()));
		}
		model.setSPONSOR_NAME(rs.getString(7));
		ojb = rs.getObject(8);
		if(ojb != null){
			model.setCREATE_DATETIME((Date)ojb);
		}
		ojb = rs.getObject(9);
		if(ojb != null){
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		model.setFLOW_NAME(rs.getString(10));
		return model;
	}
	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 * @throws SQLException 
	 
	*/
	public List<cn.zup.workflow.model.WORK_HISTORY> WorkHistoryList(int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select C.WORK_ITEM_ID,B.ACTIVITY_ID, B.ACTIVITY_NAME, C.RECEIVER_TYPE,C.RECEIVER_ID,C.RECEIVER_NAME, C.RESPONSIBLE_ID,C.SIGN_NAME,C.SIGN_OPINION, " + "\r\n" + "                                A.CREATE_DATETIME, isnull(C.SIGN_DATE,A.FINISHED_DATETIME) as FINISHED_DATETIME,C.WORK_ITEM_STATE," + "\r\n" + "                                E.SUB_NAME as WORK_ITEM_STATE_NAME");
		strSql.append(" from WF_WORK_ACTIVITY as A" + "\r\n" + "				                left outer join  WF_ACTIVITY  as B on A.ACTIVITY_ID = B.ACTIVITY_ID " + "\r\n" + "				                left outer join  WF_WORK_ITEM as C on C.WORK_ACTIVITY_ID = A.WORK_ACTIVITY_ID " + "\r\n" + "				                left outer join  WF_CONFIG as E on C.WORK_ITEM_STATE = E.SUB_ID and E.ID=" + ConfigList.WorkItemState);
		strSql.append(" where A.WORK_ID =" + workID);
		strSql.append(" order by A.CREATE_DATETIME  desc, A.FINISHED_DATETIME desc ,C.WORK_ITEM_STATE asc");

		List<cn.zup.workflow.model.WORK_HISTORY> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_HISTORY>>(){
			@Override
			public List<cn.zup.workflow.model.WORK_HISTORY> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_HISTORY> list = new ArrayList<cn.zup.workflow.model.WORK_HISTORY>();
				while (rs.next()){
					list.add(ReaderBindHistory(rs));
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
	public cn.zup.workflow.model.WORK_HISTORY ReaderBindHistory(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_HISTORY model = new cn.zup.workflow.model.WORK_HISTORY();
		Object ojb;
		ojb = rs.getObject("WORK_ITEM_ID");
		if(ojb != null){
			model.setWORK_ITEM_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("ACTIVITY_ID");
		if(ojb != null){
			model.setACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		model.setACTIVITY_NAME(rs.getString("ACTIVITY_NAME"));
		ojb = rs.getObject("RECEIVER_TYPE");
		if(ojb != null){
			model.setRECEIVER_TYPE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("RECEIVER_ID");
		if(ojb != null){
			model.setRECEIVER_ID(Integer.parseInt(ojb.toString()));
		}
		model.setRECEIVER_NAME(rs.getString("RECEIVER_NAME"));
		ojb = rs.getObject("RESPONSIBLE_ID");
		if(ojb != null){
			model.setRESPONSIBLE_ID(Integer.parseInt(ojb.toString()));
		}
		model.setSIGN_NAME(rs.getString("SIGN_NAME"));
		ojb = rs.getString("SIGN_OPINION");
		if(ojb != null){
			model.setCREATE_DATETIME((Date)ojb);
		}
		ojb = rs.getObject("FINISHED_DATETIME");
		if(ojb != null){
			model.setFINISHED_DATETIME((Date)ojb);
		}
		ojb = rs.getObject("WORK_ITEM_STATE");
		if(ojb != null){
			model.setWORK_ITEM_STATE(Integer.parseInt(ojb.toString()));
		}
		model.setWORK_ITEM_STATE_NAME(rs.getString("WORK_ITEM_STATE_NAME"));
		return model;
	}


	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 * @throws SQLException 
	 
	*/
	public List<cn.zup.workflow.model.WORK_SIGN> WorkSignList(int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select ACTIVITY_NAME,SIGN_NAME,SIGN_DATE,SIGN_OPINION ");
		strSql.append(" from WF_WORK_ITEM A LEFT JOIN ");
		strSql.append(" WF_WORK_ACTIVITY B ON A.WORK_ACTIVITY_ID=B.WORK_ACTIVITY_ID and A.SIGN_NAME is not null left outer join");
		strSql.append(" WF_ACTIVITY C ON B.ACTIVITY_ID=C.ACTIVITY_ID ");
		strSql.append(" where 1=1 and WORK_ID=" + workID);
		strSql.append(" and SIGN_NAME !="+"'"+null+"'");
		List<cn.zup.workflow.model.WORK_SIGN> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_SIGN>>(){
			@Override
			public List<cn.zup.workflow.model.WORK_SIGN> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_SIGN> list = new ArrayList<cn.zup.workflow.model.WORK_SIGN>();
				while (rs.next()){
					list.add(ReaderBindSign(rs));
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
	public cn.zup.workflow.model.WORK_SIGN ReaderBindSign(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_SIGN model = new cn.zup.workflow.model.WORK_SIGN();
		Object ojb;
		model.setACTIVITY_NAME(rs.getString("ACTIVITY_NAME"));
		model.setSIGN_NAME(rs.getString("SIGN_NAME"));
		ojb = rs.getTimestamp("SIGN_DATE");
		if(ojb != null){
			model.setSIGN_DATE((Date)ojb);
		}
		model.setSIGN_OPINION(rs.getString("SIGN_OPINION"));
		return model;
	}

	/** 
	 判断流程下时候有工作
	 
	 @param flowID
	 @return 
	 * @throws SQLException 
	*/
	public boolean Exist(int flowID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select count(*) count ");
		strSql.append(" from WF_WORK");
		strSql.append(" where FLOW_ID=" + flowID);
		int incID = jdbcTemplate_workflow.queryForObject(strSql.toString(), Integer.class);
		System.err.println("Exist==="+strSql.toString());
		if(incID == 0){
			return false;
		}else{
			return true;
		}
	}

	/** 
	 获取工作
	 
	 @param flowID 流程ID
	 @param mainBizKey 业务主键
	 @return 
	 * @throws SQLException 
	*/
	public List<cn.zup.workflow.model.WF_WORK> WorkList(int flowID, String mainBizKey) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select WORK_ID,FLOW_ID,WORK_NAME,WORK_STATE,HANDLER_ID,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID ");
		strSql.append(" from WF_WORK");
		strSql.append(" where FLOW_ID="+flowID);
		if(mainBizKey!=null){
			strSql.append("  and MAIN_BIZ_KEY="+mainBizKey);
		}
		List<cn.zup.workflow.model.WF_WORK> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK> list = new ArrayList<cn.zup.workflow.model.WF_WORK>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}

	/** 
	 暂停工作
	 
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	public void WorkPause(int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		//1-工作项
		strSql.append("update WF_WORK_ITEM set");
		strSql.append(" WORK_ITEM_STATE="+ WorkItemState.Pause.getValue());
		strSql.append(MessageFormat.format(" where WORK_ACTIVITY_ID in(select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where WORK_ID={0} and WORK_ACTIVITY_STATE={1} ) and ",
				workID+"", WorkItemState.InProgress.getValue()+""));
		strSql.append(" WORK_ITEM_STATE="+ WorkItemState.Pause.getValue());
		//2-工作活动
		strSql.append(" update WF_WORK_ACTIVITY set");
		strSql.append(" WORK_ACTIVITY_STATE="+ WorkItemState.InProgress.getValue());
		strSql.append(MessageFormat.format(" where WORK_ID={0} and WORK_ACTIVITY_STATE={1}",
				workID+"", WorkItemState.InProgress.getValue()+""));
		//3-工作
		strSql.append(" update WF_WORK set");
		strSql.append(" WORK_STATE="+cn.zup.workflow.config.WorkState.Pause.getValue()+"");
		strSql.append(" where WORK_ID="+workID+"");
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/** 
	 重启工作
	 
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	public void WorkRelaunch(int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		//1-工作项
		strSql.append("update WF_WORK_ITEM set");
		strSql.append(" WORK_ITEM_STATE="+ WorkItemState.InProgress.getValue());
		strSql.append(MessageFormat.format(" where WORK_ACTIVITY_ID in(select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where WORK_ID={0} and WORK_ACTIVITY_STATE={1} ) and",
				workID+"", cn.zup.workflow.config.WorkActivityState.InProgress.getValue()+""));
		strSql.append(" WORK_ITEM_STATE="+ WorkItemState.InProgress.getValue());
		//2-工作活动
		strSql.append(" update WF_WORK_ACTIVITY set");
		strSql.append(" WORK_ACTIVITY_STATE="+cn.zup.workflow.config.WorkActivityState.InProgress.getValue());
		strSql.append(MessageFormat.format(" where WORK_ID={0} and WORK_ACTIVITY_STATE={1}",
				 workID+"", cn.zup.workflow.config.WorkActivityState.InProgress.getValue()+""));
		//3-工作
		strSql.append(" update WF_WORK set");
		strSql.append(" WORK_STATE="+cn.zup.workflow.config.WorkState.InProgress.getValue());
		strSql.append(" where WORK_ID="+workID);
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/** 
	 强制结束工作
	 
	 @param workID 工作ID
	 * @throws SQLException 
	*/
	public void WorkTerminate(int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append(MessageFormat.format("update WF_WORK set WORK_STATE={0} where WORK_ID={1}",
				cn.zup.workflow.config.WorkState.ForcedEnd.getValue()+"", workID+""));
		strSql.append(MessageFormat.format(" update WF_WORK_ACTIVITY set WORK_ACTIVITY_STATE={0} where WORK_ID={1}",
				cn.zup.workflow.config.WorkActivityState.ForcedEnd.getValue()+"", workID+""));
		strSql.append(MessageFormat.format(" update WF_WORK_ITEM set WORK_ITEM_STATE={0} where WORK_ACTIVITY_ID in (select WORK_ACTIVITY_ID from WF_WORK_ACTIVITY where WORK_ID={1})",
				WorkItemState.ForcedEnd.getValue()+"", workID+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/** 
	 设置工作结束
	 
	 @param workID
	 * @throws SQLException 
	*/
	public void WorkFinish(int workID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("update WF_WORK");
		strSql.append(" set WORK_STATE="+cn.zup.workflow.config.WorkState.NormalEnd.getValue());
		strSql.append(" where WORK_ID="+workID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	public void deleteWorkList(int flowId) {
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from  wf_work where wf_work.FLOW_ID ="+flowId);
		System.err.println(strSql.toString());
		jdbcTemplate_workflow.update(strSql.toString());
	}
}