package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.model.FORM_CONTROL;

@Repository("formControlDal")
public class WF_FORM_CONTROL extends WF_Form_ControlBase{
	public WF_FORM_CONTROL(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/**
	    * @UpdateInfo 获取数据列表
	    * @UpdateDate 2017-2-28 09:11:11
	    * @UpdatePerson xieyan
	    * */
	public List<cn.zup.workflow.model.FORM_CONTROL> FormControlList(int formID) throws Exception{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select CONTROL_ID,FORM_ID,CONTROL_NAME,CONTROL_TEXT,CONTROL_TYPE,B.SUB_NAME as CONTROL_TYPE_NAME, NULL_PERMIT, C.SUB_NAME as NULL_PERMIT_NAME,CONTROL_MEANING, D.SUB_NAME as CONTROL_MEANING_NAME, DEFAULT_LENGTH,USER_CONTROL_NAME");
		strSql.append(" from  WF_FORM_CONTROL  A inner join ");
		strSql.append(" WF_CONFIG  B on B.ID=" + cn.zup.workflow.config.ConfigList.ControlType.getValue() + " and A.CONTROL_TYPE=B.SUB_ID inner join ");
		strSql.append(" WF_CONFIG  C on C.ID=" + cn.zup.workflow.config.ConfigList.NullPermit.getValue() + " and A.NULL_PERMIT=C.SUB_ID  inner join ");
		strSql.append(" WF_CONFIG  D on D.ID=" + cn.zup.workflow.config.ConfigList.ControlMeaning.getValue() + " and A.CONTROL_MEANING=D.SUB_ID ");
		strSql.append(" where FORM_ID =" + formID);
		List<cn.zup.workflow.model.FORM_CONTROL> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.FORM_CONTROL>>(){

			@Override
			public List<FORM_CONTROL> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.FORM_CONTROL> list = new ArrayList<cn.zup.workflow.model.FORM_CONTROL>();
				while (rs.next()){
					list.add(ControlReaderBind(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}

	/** 
	 对象实体绑定数据
	 
	*/
	public cn.zup.workflow.model.FORM_CONTROL ControlReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.FORM_CONTROL model = new cn.zup.workflow.model.FORM_CONTROL();
		Object ojb;
		ojb = rs.getObject("CONTROL_ID");
		if(ojb != null){
			model.setCONTROL_ID(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("FORM_ID");
		if(ojb !=null){
			model.setFORM_ID(Integer.parseInt(ojb.toString()));
		}
		model.setCONTROL_NAME(rs.getString("CONTROL_NAME"));
		model.setCONTROL_TEXT(rs.getString("CONTROL_TEXT"));
		model.setNULL_PERMIT_NAME(rs.getString("NULL_PERMIT_NAME"));
		ojb = rs.getObject("CONTROL_TYPE");
		if(ojb != null){
			model.setCONTROL_TYPE( Integer.parseInt(ojb.toString()));
		}
		model.setCONTROL_TYPE_NAME(rs.getString("CONTROL_TYPE_NAME"));
		ojb = rs.getObject("NULL_PERMIT");
		if(ojb != null){
			model.setNULL_PERMIT( Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("DEFAULT_LENGTH");
		if(ojb != null ){
			model.setDEFAULT_LENGTH(Integer.parseInt(ojb.toString()));
		}
		ojb = rs.getObject("CONTROL_MEANING");
		if(ojb != null){
			model.setCONTROL_MEANING( Integer.parseInt(ojb.toString()));
		}
		model.setCONTROL_MEANING_NAME(rs.getString("CONTROL_MEANING_NAME"));
		model.setUSER_CONTROL_NAME(rs.getString("USER_CONTROL_NAME"));
		return model;
	}


}