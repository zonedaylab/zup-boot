package cn.zup.workflow.dal;
//import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
//import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.util.StringHelper;


@Repository("attachDal")
public class WF_ATTACH extends WF_AttachBase{
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;

	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public List<cn.zup.workflow.model.ATTACH> GetListArray(int flowD, int workItemID, UserSession currentHandler) throws Exception{
		StringBuilder strSql = new StringBuilder();
		if (workItemID != 0){
			strSql.append("select ATTACH_ID,A.WORK_ITEM_ID,D.ACTIVITY_NAME,ATTACH_NAME,ATTACH_PATH,A.HANDLER_NAME,UPLOAD_DATETIME ");
			strSql.append(" FROM WF_ATTACH as A left join");
			strSql.append(" WF_WORK_ITEM as B on A.WORK_ITEM_ID=B.WORK_ITEM_ID left join");
			strSql.append(" WF_WORK_ACTIVITY as C on B.WORK_ACTIVITY_ID=C.WORK_ACTIVITY_ID left join");
			strSql.append(" WF_ACTIVITY as D on C.ACTIVITY_ID=D.ACTIVITY_ID");
			strSql.append(MessageFormat.format(" where A.WORK_ITEM_ID={0} and A.HANDLER_NAME={1}", workItemID+"", "'"+currentHandler.getRealName()+"'"));
		}else{
			strSql.append("select ATTACH_ID,A.WORK_ITEM_ID,B.ACTIVITY_NAME,ATTACH_NAME,ATTACH_PATH,A.HANDLER_NAME,UPLOAD_DATETIME ");
			strSql.append(" FROM WF_ATTACH as A left join");
			strSql.append(" WF_ACTIVITY as B on A.FLOW_ID=B.FLOW_ID and B.ACTIVITY_TYPE="+cn.zup.workflow.config.ActivityType.IntialStage.getValue());
			strSql.append(MessageFormat.format(" where A.WORK_ITEM_ID={0} and A.HANDLER_NAME={1}", workItemID+"", "'"+currentHandler.getRealName()+"'") );
		}

		List<cn.zup.workflow.model.ATTACH> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.ATTACH>>(){

			@Override
			public List<cn.zup.workflow.model.ATTACH> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.ATTACH> list = new ArrayList<cn.zup.workflow.model.ATTACH>();
				while (rs.next()){
					list.add(ReaderBindAttach(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}
	/** 
	 获得数据列表（比DataSet效率高，推荐使用）
	 
	*/
	public List<cn.zup.workflow.model.ATTACH> AttachList(int workID) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select ATTACH_ID,A.WORK_ITEM_ID,D.ACTIVITY_NAME,ATTACH_NAME,ATTACH_PATH,A.HANDLER_NAME,UPLOAD_DATETIME ");
		strSql.append(" FROM WF_ATTACH as A left join");
		strSql.append(" WF_WORK_ITEM as B on A.WORK_ITEM_ID=B.WORK_ITEM_ID left join");
		strSql.append(" WF_WORK_ACTIVITY as C on B.WORK_ACTIVITY_ID=C.WORK_ACTIVITY_ID left join");
		strSql.append(" WF_ACTIVITY as D on C.ACTIVITY_ID=D.ACTIVITY_ID");
		strSql.append(" where C.WORK_ID="+workID);
		
		List<cn.zup.workflow.model.ATTACH> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.ATTACH>>(){

			@Override
			public List<cn.zup.workflow.model.ATTACH> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.ATTACH> list = new ArrayList<cn.zup.workflow.model.ATTACH>();
				while (rs.next()){
					list.add(ReaderBindAttach(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}

	/** 
	 对象实体绑定数据
	 
	*/
	public cn.zup.workflow.model.ATTACH ReaderBindAttach(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.ATTACH model = new cn.zup.workflow.model.ATTACH();
		Object ojb;
		ojb = rs.getObject("ATTACH_ID");
		if(ojb!=null){
			model.setATTACH_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("WORK_ITEM_ID");
		if(ojb!=null){
			model.setWORK_ITEM_ID(Integer.parseInt(ojb.toString()));
		}
		model.setACTIVITY_NAME(rs.getString("ACTIVITY_NAME"));
		model.setATTACH_NAME(rs.getString("ATTACH_NAME"));
		model.setATTACH_PATH(rs.getString("ATTACH_PATH"));
		model.setHANDLER_NAME(rs.getString("HANDLER_NAME"));
		ojb=rs.getObject("UPLOAD_DATETIME");
		if(ojb!=null){
			model.setUPLOAD_DATETIME((Date) ojb);
		}
		return model;
	}

	/** 
	 更新一条数据
	 
	*/
	public void UpdateTran(int workItemID, List<Integer> attachList) throws Exception{
		if(attachList==null)
			return;
		String attachIDs="";
		for (int id : attachList){
			attachIDs += "," + id;
		}
		if (!StringHelper.isNullOrEmpty(attachIDs)){
		   attachIDs=attachIDs.substring(1);
		   StringBuilder strSql = new StringBuilder();
		   strSql.append("update WF_ATTACH set ");
		   strSql.append(" WORK_ITEM_ID="+workItemID);
		   strSql.append("where ATTACH_ID in ("+attachIDs+")");		 
		   jdbcTemplate_workflow.update(strSql.toString());
		}
	}
}

