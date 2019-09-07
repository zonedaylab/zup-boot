package cn.zup.workflow.dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

/// <summary>
/// 数据访问类WF_Form_ControlBase
/// </summary>
@Repository
public class WF_Form_ControlBase{
	public WF_Form_ControlBase(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int addCommon(cn.zup.workflow.model.WF_FORM_CONTROL model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_form_control(");
		strSql.append("FORM_ID,CONTROL_NAME,CONTROL_TEXT,CONTROL_TYPE,NULL_PERMIT,DEFAULT_LENGTH,CONTROL_MEANING,USER_CONTROL_NAME)");

		strSql.append(" values (");
		strSql.append(MessageFormat.format("{0},{1},{2},{3},{4},{5},{6},{7}", model.getFORM_ID()+"", "'"+model.getCONTROL_NAME()+"'", 
				"'"+model.getCONTROL_TEXT()+"'", model.getCONTROL_TYPE()+"",
				model.getNULL_PERMIT()+"", model.getDEFAULT_LENGTH()+"",
				model.getCONTROL_MEANING()+"", "'"+model.getUSER_CONTROL_NAME()+"'"));

		int id = jdbcTemplate_workflow.update(strSql.toString());
		return id;
	}
	
	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int add(cn.zup.workflow.model.WF_FORM_CONTROL model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_form_control(");
		strSql.append("FORM_ID,CONTROL_NAME,CONTROL_TEXT,CONTROL_TYPE,NULL_PERMIT,DEFAULT_LENGTH,CONTROL_MEANING,USER_CONTROL_NAME)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5},{6},{7})", model.getFORM_ID()+"", 
				"'"+model.getCONTROL_NAME()+"'","'"+model.getCONTROL_TEXT()+"'",model.getCONTROL_TYPE()+"",
				model.getNULL_PERMIT()+"",model.getDEFAULT_LENGTH()+"",model.getCONTROL_MEANING()+"",
				"'"+model.getUSER_CONTROL_NAME()+"'"));	
		System.err.println("Add wf_form_control"+strSql.toString());
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sql = "select max(CONTROL_ID) from wf_form_control";
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void update(cn.zup.workflow.model.WF_FORM_CONTROL model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_form_control set ");
		strSql.append("FORM_ID="+model.getFORM_ID()); 
		strSql.append(",CONTROL_NAME="+"'"+model.getCONTROL_NAME()+"'"); 
		strSql.append(",CONTROL_TEXT="+"'"+model.getCONTROL_TEXT()+"'"); 
		strSql.append(",CONTROL_TYPE="+model.getCONTROL_TYPE()); 
		strSql.append(",NULL_PERMIT="+model.getNULL_PERMIT()); 
		strSql.append(",DEFAULT_LENGTH="+model.getDEFAULT_LENGTH()); 
		strSql.append(",CONTROL_MEANING="+model.getCONTROL_MEANING()); 
		strSql.append(",USER_CONTROL_NAME="+"'"+model.getUSER_CONTROL_NAME()+"'");
		strSql.append(" where CONTROL_ID="+model.getCONTROL_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void delete(int CONTROL_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_form_control ");
		strSql.append(" where CONTROL_ID="+ CONTROL_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_FORM_CONTROL GetModel(int CONTROL_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select CONTROL_ID,FORM_ID,CONTROL_NAME,CONTROL_TEXT,CONTROL_TYPE,NULL_PERMIT,DEFAULT_LENGTH,CONTROL_MEANING,USER_CONTROL_NAME from wf_form_control  ");
		strSql.append(" where CONTROL_ID="+CONTROL_ID);
		
		cn.zup.workflow.model.WF_FORM_CONTROL model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_FORM_CONTROL>(){

			@Override
			public cn.zup.workflow.model.WF_FORM_CONTROL extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_FORM_CONTROL model = new cn.zup.workflow.model.WF_FORM_CONTROL();
				if(rs.next())
					model=ReaderBind(rs);
				return model;
			}
			
		});
		
		return model;
	}

	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_FORM_CONTROL> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select CONTROL_ID,FORM_ID,CONTROL_NAME,CONTROL_TEXT,CONTROL_TYPE,NULL_PERMIT,DEFAULT_LENGTH,CONTROL_MEANING,USER_CONTROL_NAME ");
		strSql.append(" FROM wf_form_control ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_FORM_CONTROL> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_FORM_CONTROL>>(){

			@Override
			public List<cn.zup.workflow.model.WF_FORM_CONTROL> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_FORM_CONTROL> list = new ArrayList<cn.zup.workflow.model.WF_FORM_CONTROL>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
			
		});
		
		return list;
	}
	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_FORM_CONTROL> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select CONTROL_ID,FORM_ID,CONTROL_NAME,CONTROL_TEXT,CONTROL_TYPE,NULL_PERMIT,DEFAULT_LENGTH,CONTROL_MEANING,USER_CONTROL_NAME ");
		strSql.append(" FROM wf_form_control for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_FORM_CONTROL> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_FORM_CONTROL>>(){

					@Override
					public List<cn.zup.workflow.model.WF_FORM_CONTROL> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						List<cn.zup.workflow.model.WF_FORM_CONTROL> list = new ArrayList<cn.zup.workflow.model.WF_FORM_CONTROL>();
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
	public cn.zup.workflow.model.WF_FORM_CONTROL ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_FORM_CONTROL model=new cn.zup.workflow.model.WF_FORM_CONTROL();
		model.setCONTROL_ID(rs.getInt("CONTROL_ID"));
		model.setFORM_ID(rs.getInt("FORM_ID"));
		model.setCONTROL_NAME(rs.getString("CONTROL_NAME"));
		model.setCONTROL_TEXT(rs.getString("CONTROL_TEXT"));
		model.setCONTROL_TYPE(rs.getByte("CONTROL_TYPE"));
		model.setNULL_PERMIT(rs.getByte("NULL_PERMIT"));
		model.setDEFAULT_LENGTH(rs.getInt("DEFAULT_LENGTH"));
		model.setCONTROL_MEANING(rs.getByte("CONTROL_MEANING"));
		model.setUSER_CONTROL_NAME(rs.getString("USER_CONTROL_NAME"));
		return model;
	}

}

