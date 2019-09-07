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

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.config.HandlerAndMonitorType;

@Repository("monitorDal")
public class WF_MONITOR extends WF_MonitorBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/** 
	 根据监控者类型参数列表获取对应的监控者ID的SQL语句
	 
	 @param monitorInfo 监控类型参数列表
	 @return 
	*/
	
	/** 
	 根据监控者类型参数列表获取对应的监控者ID的SQL语句
	 
	 @param monitorInfo 监控类型参数列表
	 @return 
	*/
	public  String GetMonitorQuery(UserSession monitorInfo, int systemID){
		StringBuilder strSql = new StringBuilder();
		strSql.append("select MONITOR_ID from WF_MONITOR");
		strSql.append(" where 1=1");
			strSql.append(" or MONITOR_TYPE=" + HandlerAndMonitorType.Department.getValue() + " and MONITOR=" + monitorInfo.getOrganId());
			strSql.append(" or MONITOR_TYPE=" + HandlerAndMonitorType.Position.getValue() + " and MONITOR=" + monitorInfo.getPostId());
			strSql.append(" or MONITOR_TYPE=" + HandlerAndMonitorType.User.getValue() + " and MONITOR=" + monitorInfo.getUserId());
		strSql.append(" and FLOW_ID in(select FLOW_ID FROM WF_FLOW where SYSTEM_ID="+systemID+")");
		return strSql.toString();
	}

	/**
     * @UpdateInfo 获取流程下的监控者
     * @UpdateDate 2017-2-27 15:47:22
     * @UpdatePerson xieyan
     * */
	public void DeleteMonitor(int flowID) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("delete from WF_MONITOR ");
		strSql.append(" where FLOW_ID="+flowID);
		
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	public List<cn.zup.workflow.model.WF_MONITOR> GetWorkFlowMonitor(int flowId) {
		StringBuilder strSql = new StringBuilder();
		strSql.append(" select * from WF_MONITOR where FLOW_ID=" + flowId);
		System.out.println(strSql);
		List<cn.zup.workflow.model.WF_MONITOR> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MONITOR>>(){

			@Override
			public List<cn.zup.workflow.model.WF_MONITOR> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_MONITOR> list = new ArrayList<cn.zup.workflow.model.WF_MONITOR>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
		});
		
		return list;
	}
	
	/// <summary>
	/// 对象实体绑定数据
	/// </summary>
	public cn.zup.workflow.model.WF_MONITOR ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_MONITOR model=new cn.zup.workflow.model.WF_MONITOR();
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		model.setMONITOR(rs.getInt("MONITOR"));
		model.setMONITOR_ID(rs.getInt("MONITOR_TYPE"));
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		return model;
	}
}