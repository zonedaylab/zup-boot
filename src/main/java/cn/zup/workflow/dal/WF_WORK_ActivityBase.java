package cn.zup.workflow.dal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;
import java.util.ArrayList;

import org.aspectj.internal.lang.annotation.ajcDeclareAnnotation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;
/// <summary>
/// 数据访问类WF_WORK_ACTIVITY
/// </summary>
@Repository
public class WF_WORK_ActivityBase{
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int add(cn.zup.workflow.model.WF_WORK_ACTIVITY model) throws SQLException{
		String sql = "SELECT max(WORK_ACTIVITY_ID) FROM WF_WORK_ACTIVITY";
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_WORK_ACTIVITY(");
		strSql.append("WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},now(),{3},{4},{5},{6})", 
				model.getWORK_ID()+"",model.getACTIVITY_ID()+"",model.getWORK_ACTIVITY_STATE()+"",
				model.getCREATE_DATETIME()==null?"now()":"date_format('"+model.getCREATE_DATETIME()+"', '%Y-%c-%d')",
				"'"+model.getPRE_ACTIVITY_INFO()+"'","'"+model.getNEXT_ACTIVITY_HANDLERS()+"'",
				"'"+model.getNEXT_ACTIVITY_CODES()+"'"));
		System.err.println("add === "+strSql.toString());
		jdbcTemplate_workflow.update(strSql.toString());
		
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_WORK_ACTIVITY model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_WORK_ACTIVITY set ");
		strSql.append(MessageFormat.format("WORK_ID={0},", model.getWORK_ID()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_ID={0},", model.getACTIVITY_ID()+"")); 
		strSql.append(MessageFormat.format("WORK_ACTIVITY_STATE={0},", model.getWORK_ACTIVITY_STATE()+"")); 		
		strSql.append("FINISHED_DATETIME=now(),"); 
		strSql.append(MessageFormat.format("PRE_ACTIVITY_INFO={0},", "'"+model.getPRE_ACTIVITY_INFO()+"'")); 
		strSql.append(MessageFormat.format("NEXT_ACTIVITY_HANDLERS={0},", "'"+model.getNEXT_ACTIVITY_HANDLERS()+"'")); 
		strSql.append(MessageFormat.format("NEXT_ACTIVITY_CODES={0}", "'"+model.getNEXT_ACTIVITY_CODES()+"'"));
		strSql.append(MessageFormat.format(" where WORK_ACTIVITY_ID={0}", model.getWORK_ACTIVITY_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int WORK_ACTIVITY_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_WORK_ACTIVITY ");
		strSql.append(" where WORK_ACTIVITY_ID="+ WORK_ACTIVITY_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_WORK_ACTIVITY GetModel(int WORK_ACTIVITY_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ACTIVITY_ID,WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES from WF_WORK_ACTIVITY  ");
		strSql.append(" where WORK_ACTIVITY_ID="+WORK_ACTIVITY_ID);
		
		cn.zup.workflow.model.WF_WORK_ACTIVITY model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_ACTIVITY>(){

			@Override
			public cn.zup.workflow.model.WF_WORK_ACTIVITY extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_WORK_ACTIVITY model=null;
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
	public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ACTIVITY_ID,WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES ");
		strSql.append(" FROM WF_WORK_ACTIVITY ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ACTIVITY>>(){

			@Override
			public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ACTIVITY> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ACTIVITY>();
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
	public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ACTIVITY_ID,WORK_ID,ACTIVITY_ID,WORK_ACTIVITY_STATE,CREATE_DATETIME,FINISHED_DATETIME,PRE_ACTIVITY_INFO,NEXT_ACTIVITY_HANDLERS,NEXT_ACTIVITY_CODES ");
		strSql.append(" FROM WF_WORK_ACTIVITY for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ACTIVITY>>(){

			@Override
			public List<cn.zup.workflow.model.WF_WORK_ACTIVITY> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ACTIVITY> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ACTIVITY>();
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
	public cn.zup.workflow.model.WF_WORK_ACTIVITY ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_WORK_ACTIVITY model=new cn.zup.workflow.model.WF_WORK_ACTIVITY();
		model.setWORK_ACTIVITY_ID(rs.getInt("WORK_ACTIVITY_ID"));
		model.setWORK_ID(rs.getInt("WORK_ID"));
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setWORK_ACTIVITY_STATE(rs.getInt("WORK_ACTIVITY_STATE"));
		model.setCREATE_DATETIME(rs.getDate("CREATE_DATETIME"));
		model.setFINISHED_DATETIME(rs.getDate("FINISHED_DATETIME"));
		model.setPRE_ACTIVITY_INFO(rs.getString("PRE_ACTIVITY_INFO"));
		model.setNEXT_ACTIVITY_HANDLERS(rs.getString("NEXT_ACTIVITY_HANDLERS"));
		model.setNEXT_ACTIVITY_CODES(rs.getString("NEXT_ACTIVITY_CODES"));
		return model;
	}
}

