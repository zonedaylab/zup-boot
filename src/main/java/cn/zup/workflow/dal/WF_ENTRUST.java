package cn.zup.workflow.dal;
import java.sql.Date;
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

import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;
import cn.zup.workflow.util.StringHelper;

/// <summary>
/// 数据访问类WF_ENTRUST。
/// </summary>
@Repository("entrustDal")
public class WF_ENTRUST extends WF_EntrustBase{
	
	 public WF_ENTRUST(){}
	
	 @Autowired
	 private JdbcTemplate jdbcTemplate_workflow;
                
	 public void UpdateEntrustState(int entrustID, int entrustState) throws Exception{
		 StringBuilder strSql = new StringBuilder();
		 strSql.append("update WF_ENTRUST set ");
		 strSql.append("TIME="+(Date) new java.util.Date());
		 strSql.append(",STATE="+(byte) entrustState);
		 strSql.append(" where ENTRUST_ID="+entrustID);
		 jdbcTemplate_workflow.update(strSql.toString());
	 }


    /** 
	 获取委托分页列表
	 
	 @param queryParameter 查询参数
	 @param userID 用户ID
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 分页数据
	 * @throws Exception 
	*/
	public PagingData<cn.zup.workflow.model.ENTRUST> EntrustPagingList(QueryParameter queryParameter, int userID, int pageIndex, int pageSize) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select A.ENTRUST_ID,A.ENTRUST_PEOPLE_ID,A.ENTRUST_PEOPLE_NAME,A.TRUST_PEOPLE_ID,A.TRUST_PEOPLE_NAME,A.TIME,A.STATE,B.SUB_NAME as STATE_NAME");
		strSql.append(" FROM WF_ENTRUST as A inner join ");
		strSql.append(" WF_CONFIG as B on A.STATE=B.SUB_ID and B.ID="
				+ ConfigList.EntrustState.getValue());
		strSql.append(" where  ENTRUST_PEOPLE_ID=" + userID);
		if (!StringHelper.isNullOrEmpty(queryParameter
				.getTrustPeople())) {
			strSql.append(" and A.TRUST_PEOPLE_NAME  like '%"
					+ queryParameter.getTrustPeople() + "%'");
		}
		if (queryParameter.getEntrustState() != null) {
			strSql.append(" and A.STATE=" + queryParameter.getEntrustState());
		}
		
		PagingService paingService = new PagingService();
		
		int totalAmount =  paingService.GetPagingData(strSql.toString(), "ENTRUST_ID", "TIME desc", pageIndex, pageSize);
		
		String pageSql=paingService.GetPagingSql(strSql.toString(), "ENTRUST_ID", "TIME desc", pageIndex, pageSize);
		System.err.println(pageSql);
		List<cn.zup.workflow.model.ENTRUST> list = jdbcTemplate_workflow.query(pageSql, 
				new ResultSetExtractor<List<cn.zup.workflow.model.ENTRUST>>(){
			@Override
			public List<cn.zup.workflow.model.ENTRUST> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.ENTRUST> list = new ArrayList<cn.zup.workflow.model.ENTRUST>();
				while (rs.next()) {
					list.add(ReaderBindV(rs));
				}	
				return list;
			}
			
		});
		
		// 获取总记录数
		// 分页数据
		PagingData<cn.zup.workflow.model.ENTRUST> page = new PagingData<cn.zup.workflow.model.ENTRUST>();
		page.setData(list);
		page.setAmount(totalAmount);
		return page;
	}



	/** 
	 对象实体绑定数据
	 * @throws Exception 
	 
	*/
	public cn.zup.workflow.model.ENTRUST ReaderBindV(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.ENTRUST model = new cn.zup.workflow.model.ENTRUST();
		Object ojb;
		ojb = rs.getObject("ENTRUST_ID");
		if(ojb != null){
		    model.setENTRUST_ID( Integer.parseInt(ojb.toString()));
		}
		ojb=rs.getObject("ENTRUST_PEOPLE_ID");
		if(ojb!=null){
			model.setENTRUST_PEOPLE_ID(Integer.parseInt(ojb.toString()));
		}
		model.setENTRUST_PEOPLE_NAME(rs.getString("ENTRUST_PEOPLE_NAME"));
		ojb=rs.getObject("TRUST_PEOPLE_ID");
		if(ojb!=null){
			model.setTRUST_PEOPLE_ID(Integer.parseInt(ojb.toString()));
		}
		model.setTRUST_PEOPLE_NAME(rs.getString("TRUST_PEOPLE_NAME"));
		ojb=rs.getObject("TIME");
		if(ojb!=null){
			model.setTIME((java.sql.Date)ojb);
		}
		ojb=rs.getObject("STATE");
		if(ojb!=null){
			model.setSTATE((byte) Integer.parseInt(ojb.toString()));
		}
		model.setSTATE_NAME(rs.getString("STATE_NAME"));
		return model;
	}
            
}

