package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import net.sf.json.JSONObject;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.workflow.model.FLOW_MANAGE;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;
import cn.zup.workflow.util.Event;
import cn.zup.workflow.util.StringHelper;

@Repository("flowDal")
public class WF_FLOW extends WF_FlowBase{
	public WF_FLOW(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public List<cn.zup.workflow.model.WF_FLOW> FLowList(int systemID) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select FLOW_ID,SYSTEM_ID,FLOW_NAME,FLOW_TYPE,FLOW_STATE ");
		strSql.append(" FROM WF_FLOW ");
		strSql.append(" where SYSTEM_ID=" + systemID);
		
		List<cn.zup.workflow.model.WF_FLOW> list = jdbcTemplate_workflow.query(strSql.toString(), new RowMapper<cn.zup.workflow.model.WF_FLOW>(){
			@Override
			public cn.zup.workflow.model.WF_FLOW mapRow(ResultSet rs, int arg1) throws SQLException {
				cn.zup.workflow.model.WF_FLOW flow = new cn.zup.workflow.model.WF_FLOW();
				while (rs.next()){
					flow = ReaderBind(rs);
				}
				return flow;
			}
		});
		
		return list;
	}

	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public  PagingData<cn.zup.workflow.model.FLOW_MANAGE> FlowPagingList(QueryParameter queryParameter, 
			int pageIndex, int pageSize) throws Exception{
		JSONObject json = new JSONObject();
		StringBuilder bizSql = new StringBuilder();
		StringBuilder pagingSelect = new StringBuilder();
		int fromRecord = (pageIndex - 1) * pageSize;
		
		
		bizSql.append("select A.FLOW_ID,A.FLOW_NAME,A.FLOW_STATE,C.SUB_NAME as FLOW_STATE_NAME, A.FLOW_TYPE,A.SYSTEM_ID, F.SYSTEM_NAME ");
		
		StringBuilder strSql = new StringBuilder();		 
		strSql.append(" from WF_FLOW A inner join");
		strSql.append(" WF_CONFIG C on C.ID=");
		strSql.append(cn.zup.workflow.config.ConfigList.FlowState.getValue());
		strSql.append(" and A.FLOW_STATE=C.SUB_ID inner join WF_SYSTEM F ON F.SYSTEM_ID=A.SYSTEM_ID ");
		strSql.append("where 1=1");
		if (queryParameter.getSystemID()!= 0){
			strSql.append(" and A.SYSTEM_ID=" + queryParameter.getSystemID());
		}
		if(!StringHelper.isNullOrEmpty(queryParameter.getFlowName())){
			strSql.append(" and A.FLOW_NAME like '%" + queryParameter.getFlowName()+"%'");
		}
		if (queryParameter.getFlowState() != 0){
			strSql.append(" and A.FLOW_STATE=" + queryParameter.getFlowState());
		}
		bizSql.append(strSql);
		
		String[]sqlist=bizSql.toString().split("from");
		if(sqlist.length<2)
			throw new Exception("分页sql的from 字段需要小写");
		String countSql="select count(*) from "+sqlist[1];	
		//总条数
		int totalAmount = jdbcTemplate_workflow.query(countSql, new ResultSetExtractor<Integer>(){
			@Override
			public Integer extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				int totalAmount = 0;
				if (rs.next()){			
					totalAmount=rs.getInt(1);
				}	
				return totalAmount;
			}
		});
		//分页数据
		String newSql = bizSql + " order by FLOW_ID DESC ";
		pagingSelect.append("SELECT * FROM ("  +  newSql +" ) table_alias LIMIT " + fromRecord+","+pageSize);
		List<FLOW_MANAGE> list = jdbcTemplate_workflow.query(pagingSelect.toString() , new ResultSetExtractor<List<FLOW_MANAGE>>(){

			@Override
			public List<FLOW_MANAGE> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<FLOW_MANAGE> list = new ArrayList<FLOW_MANAGE>();
				while (rs.next()){
					list.add(ReaderBindFlowManage(rs));
				}
				return list;
			}
		});
		
		PagingData<cn.zup.workflow.model.FLOW_MANAGE> result = new PagingData<cn.zup.workflow.model.FLOW_MANAGE>();
		result.setData(list);
		result.setAmount(totalAmount);
		return result;
	}

	/** 
	 对象实体绑定数据
	 
	*/
	public  cn.zup.workflow.model.FLOW_MANAGE ReaderBindFlowManage(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.FLOW_MANAGE model = new cn.zup.workflow.model.FLOW_MANAGE();
		Object ojb;
		ojb = rs.getObject("FLOW_ID");
		if(ojb != null)
		{		
			model.setFLOW_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("SYSTEM_ID");	
		if(ojb != null)
		{			
			model.setSYSTEM_ID(Integer.parseInt(ojb.toString()));
		}		
		model.setFLOW_NAME(rs.getString("FLOW_NAME"));
		model.setFLOW_TYPE(rs.getString("FLOW_TYPE"));		
		ojb = rs.getObject("FLOW_STATE");
		model.setSYSTEM_NAME(rs.getString("SYSTEM_NAME"));
		if(ojb != null)	{			
			model.setFLOW_STATE((byte) Integer.parseInt(ojb.toString()));
		}	
		model.setFLOW_STATE_NAME(rs.getString("FLOW_STATE_NAME"));
		return model;
	}
}