package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

//import javax.enterprise.deploy.shared.CommandType;

//import cn.zoneday.wf.config.ConfigList;
//import cn.zoneday.wf.config.HandlerAndMonitorType;
//import cn.zoneday.wf.config.ReceiverFlag;
import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;

@Repository("wfWorkMsg")
public class WF_WORK_MSG extends WF_WORK_MsgBase{
	
	public WF_WORK_MSG(){}
	
	@Autowired
	private cn.zup.workflow.dal.PagingService PagingService;
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	@Autowired
	private WF_MSG_SET msgSetDal;

	/** 
	 生成工作通知
	 
	 @param workActivityID 工作活动ID
	 @param activityID 活动ID
	 @param workName 工作名称
	 @param activityName 活动名称
	 @param tranDatabase
	 @param transaction
	 * @throws SQLException 
	*/
	public void WorkMsgSave(int workActivityID, int activityID, String workName, String activityName) throws SQLException{
		//拼写通知主题
		String sendContent = "[" + workName + "]节点：" + activityName + " 已完成";
		//获取通知接收者配置列表
		java.util.List<cn.zup.workflow.model.WF_MSG_SET> msgSetList = msgSetDal.GetListArray(activityID);
		//生成通知
		if (msgSetList.size() > 0){
			cn.zup.workflow.model.WF_WORK_MSG workMsg;
			for (cn.zup.workflow.model.WF_MSG_SET detail : msgSetList){
				workMsg =new cn.zup.workflow.model.WF_WORK_MSG();
				workMsg.setSEND_CONTENT(sendContent);
				workMsg.setWORK_ACTIVITY_ID(workActivityID);
				workMsg.setRECEIVER_TYPE(detail.getRECEIVER_TYPE());
				workMsg.setRECEIVER_ID(detail.getRECEIVER_ID());
				workMsg.setRECEIVER_NAME(detail.getRECEIVER_NAME());
				java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
				workMsg.setSEND_DATE(currentDate);
				workMsg.setRECEIVER_FLAG((byte)cn.zup.workflow.config.ReceiverFlag.NoReceive.getValue());
				Add(workMsg);
			}
		}
	}

	/** 
	 签收工作通知
	 
	 @param workMsgID 通知ID
	 * @throws SQLException 
	*/
	public void WorkMsgSign(int workMsgID) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("update WF_WORK_MSG set ");
		strSql.append("RECEIVER_DATE=now(),");
		strSql.append("RECEIVER_FLAG="+cn.zup.workflow.config.ReceiverFlag.Received.getValue());
		strSql.append(" where WORK_MSG_ID="+workMsgID);
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/** 
	 根据当前登录者获取工作通知总数
	 
	 @param currentHandler 操作者信息
	 @return 
	 * @throws SQLException 
	*/
	public int WorkMsgAmount(UserSession currentHandler) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select count(*)");
		strSql.append(" FROM WF_WORK_MSG ");
		strSql.append(" where RECEIVER_FLAG=" +cn.zup.workflow.config.ReceiverFlag.NoReceive.getValue()+" and (");
		strSql.append(" (RECEIVER_TYPE=" + cn.zup.workflow.config.HandlerAndMonitorType.User.getValue()+ " and RECEIVER_ID=" + currentHandler.getUserId()+ ") or");
		strSql.append(" (RECEIVER_TYPE=" + cn.zup.workflow.config.HandlerAndMonitorType.Position.getValue() + " and RECEIVER_ID=" + currentHandler.getAccountId() + ") or");
		strSql.append(" (RECEIVER_TYPE=" + cn.zup.workflow.config.HandlerAndMonitorType.Department.getValue() + " and RECEIVER_ID=" + currentHandler.getOrganId() + ")) ");
		
		int res = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<Integer>(){
			@Override
			public Integer extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				return rs.getRow();
			}
			
		});
		return res;
	}

		///#region 获取工作通知列表
	/** 
	 获取工作通知接收列表
	 
	 @param queryParameter
	 @param currentHandler
	 @return 
	 * @throws SQLException 
	*/
	public  PagingData<cn.zup.workflow.model.WORK_MSG> WorkMsgReceiveList(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.WORK_MSG_ID,A.WORK_ACTIVITY_ID,A.RECEIVER_TYPE,A.RECEIVER_ID,A.RECEIVER_NAME,A.SEND_CONTENT,A.SEND_DATE,A.RECEIVER_DATE,A.RECEIVER_FLAG,D.SUB_NAME as RECEIVER_FLAG_NAME ");
		strSql.append(" FROM WF_WORK_MSG as A inner join ");
		strSql.append(" WF_WORK_ACTIVITY as E on A.WORK_ACTIVITY_ID=E.WORK_ACTIVITY_ID inner join ");
		strSql.append(" WF_ACTIVITY as B on E.ACTIVITY_ID=B.ACTIVITY_ID inner join");
		strSql.append(" WF_FLOW as C on B.FLOW_ID=C.FLOW_ID inner join");
		strSql.append(" WF_CONFIG as D on A.RECEIVER_FLAG=D.SUB_ID and D.ID=" + cn.zup.workflow.config.ConfigList.ReceiverFlag.getValue());
		strSql.append(" where C.SYSTEM_ID=" + queryParameter.getSystemID() + " and (");
		strSql.append(" (A.RECEIVER_TYPE=" + cn.zup.workflow.config.HandlerAndMonitorType.User.getValue() + " and A.RECEIVER_ID=" + currentHandler.getUserId() + ") or");
		strSql.append(" (A.RECEIVER_TYPE=" + cn.zup.workflow.config.HandlerAndMonitorType.Position.getValue() + " and A.RECEIVER_ID=" + currentHandler.getAccountId() + ") or");
		strSql.append(" (A.RECEIVER_TYPE=" + cn.zup.workflow.config.HandlerAndMonitorType.Department.getValue() + " and A.RECEIVER_ID=" + currentHandler.getOrganId() + ")) ");
		if (queryParameter.getReceiverFlag() !=null){
			strSql.append(" and A.RECEIVER_FLAG=" + queryParameter.getReceiverFlag());
		}

		//获取分页SQL
		String pagingSql = PagingService.GetPagingSql(
				strSql.toString(), "WORK_MSG_ID", "SEND_DATE desc", pageIndex,
				pageSize);
		
		List<cn.zup.workflow.model.WORK_MSG> list = jdbcTemplate_workflow.query(pagingSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WORK_MSG>>(){

			@Override
			public List<cn.zup.workflow.model.WORK_MSG> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WORK_MSG> list = new ArrayList<cn.zup.workflow.model.WORK_MSG>();
				while (rs.next()){
					list.add(ReaderBindV(rs));
				}
				return list;
			}
		});
		
		int totalAmount = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<Integer>(){
			@Override
			public Integer extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				return rs.getRow();
			}
			
		});
		
		PagingData<cn.zup.workflow.model.WORK_MSG> result = new PagingData<cn.zup.workflow.model.WORK_MSG>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}


	/** 
	 对象实体绑定数据
	 * @throws SQLException 
	 
	*/
	public cn.zup.workflow.model.WORK_MSG ReaderBindV(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WORK_MSG model = new cn.zup.workflow.model.WORK_MSG();
		Object ojb;
		ojb = rs.getObject("WORK_MSG_ID");
		if(ojb != null){
			model.setWORK_MSG_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("WORK_ACTIVITY_ID");
		if(ojb != null){
			model.setWORK_ACTIVITY_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("RECEIVER_TYPE");
		if(ojb != null){
			model.setRECEIVER_TYPE(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("RECEIVER_ID");
		if(ojb != null){
			model.setRECEIVER_ID(Integer.parseInt(ojb.toString()));
		}
		model.setRECEIVER_NAME(rs.getString("RECEIVER_NAME"));
		model.setSEND_CONTENT(rs.getString("SEND_CONTENT"));
		ojb = rs.getObject("SEND_DATE");
		if(ojb != null){
			model.setSEND_DATE((java.util.Date)ojb);
		}
		ojb = rs.getObject("RECEIVER_DATE");
		if(ojb != null){
			model.setRECEIVER_DATE((java.util.Date)ojb);
		}
		ojb = rs.getObject("RECEIVER_FLAG");		
		if(ojb != null){
			model.setRECEIVER_FLAG(Integer.parseInt(ojb.toString()));
		}
		model.setRECEIVER_FLAG_NAME(rs.getString("RECEIVER_FLAG_NAME"));
		return model;
	}




}