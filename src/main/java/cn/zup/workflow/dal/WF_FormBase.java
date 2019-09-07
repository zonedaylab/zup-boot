package cn.zup.workflow.dal;

import java.sql.Blob;
import java.sql.Connection;
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



/// <summary>
/// 数据访问类WF_FormBase
/// </summary>
@Repository
public class WF_FormBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddCommon(cn.zup.workflow.model.WF_FORM model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_FORM(");
		strSql.append("PARENT_FORM_ID,SYSTEM_ID,FORM_NAME,FORM_DELBIZ_CONTROLLER,URL)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4})", model.getPARENT_FORM_ID()+"",
				model.getSYSTEM_ID()+"", "'"+model.getFORM_NAME()+"'","'"+model.getFORM_DELBIZ_CONTROLLER()+"'", "'"+model.getURL()+"'"));
		strSql.append(";select @@IDENTITY");
		System.err.println(strSql.toString());
		return jdbcTemplate_workflow.update(strSql.toString());
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddOracle(cn.zup.workflow.model.WF_FORM model) throws SQLException{
		String sql = "SELECT max(FORM_ID) from WF_FORM";
		
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_FORM(");
		strSql.append("PARENT_FORM_ID,SYSTEM_ID,FORM_NAME,FORM_DELBIZ_CONTROLLER,URL)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4})",
				model.getPARENT_FORM_ID()+"", model.getSYSTEM_ID()+"",
				"'"+model.getFORM_NAME()+"'","'"+model.getFORM_DELBIZ_CONTROLLER()+"'", "'"+model.getURL()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
		
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void UpdateWorkForm(cn.zup.workflow.model.WF_FORM model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_FORM set ");
		strSql.append("PARENT_FORM_ID="+model.getPARENT_FORM_ID()); 
		strSql.append(",SYSTEM_ID="+model.getSYSTEM_ID()); 
		strSql.append(",FORM_NAME="+"'"+model.getFORM_NAME()+"'"); 
		strSql.append(",FORM_DELBIZ_CONTROLLER="+"'"+model.getFORM_DELBIZ_CONTROLLER()+"'"); 
		strSql.append(",URL="+"'"+model.getURL()+"'");
		strSql.append("  where FORM_ID="+model.getFORM_ID());
		jdbcTemplate_workflow.execute(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int FORM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_FORM ");
		strSql.append(" where FORM_ID="+ FORM_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_FORM GetModel(int FORM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FORM_ID,PARENT_FORM_ID,SYSTEM_ID,FORM_NAME,URL,FORM_DELBIZ_CONTROLLER from WF_FORM  ");
		strSql.append(" where FORM_ID="+FORM_ID);
		System.err.println(strSql.toString());
		cn.zup.workflow.model.WF_FORM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_FORM>(){
			@Override
			public cn.zup.workflow.model.WF_FORM extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_FORM model = new cn.zup.workflow.model.WF_FORM();
				while (rs.next()) {
					model= ReaderBindAll(rs);
				}
				return model;
			}
		});
		return model;
	}
	
	/// <summary>
	/// 得到自定义表单的html内容
	/// </summary>
	public String GetFormAutoContent(int FORM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FORM_AUTO_CONTENT from WF_FORM  ");
		strSql.append(MessageFormat.format(" where FORM_ID={0} ", FORM_ID+""));
		Connection conn=null;
		PreparedStatement ps =null;
		ResultSet rs =null;
		Blob b = null;
		try {
			conn = jdbcTemplate_workflow.getDataSource().getConnection();
			ps = conn.prepareStatement(strSql.toString());
			ps.clearParameters();
			rs= ps.executeQuery();
			if(rs.next()){
				b = rs.getBlob("FORM_AUTO_CONTENT");
			}
			if(b==null)
				return "";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			rs.close();
			ps.close();
			conn.close();
		}
		return new String(b.getBytes(1, (int) b.length()));
	}

	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_FORM> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FORM_ID,PARENT_FORM_ID,SYSTEM_ID,FORM_NAME,URL,FORM_DELBIZ_CONTROLLER ");
		strSql.append(" FROM WF_FORM ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_FORM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_FORM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_FORM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_FORM> list = new ArrayList<cn.zup.workflow.model.WF_FORM>();
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
	public List<cn.zup.workflow.model.WF_FORM> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select FORM_ID,PARENT_FORM_ID,SYSTEM_ID,FORM_NAME,FORM_DELBIZ_CONTROLLER,URL ");
		strSql.append(" FROM WF_FORM for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_FORM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_FORM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_FORM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_FORM> list = new ArrayList<cn.zup.workflow.model.WF_FORM>();
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
	public cn.zup.workflow.model.WF_FORM ReaderBind(ResultSet rs) throws SQLException
	{
		cn.zup.workflow.model.WF_FORM model=new cn.zup.workflow.model.WF_FORM();
		model.setFORM_ID(rs.getInt("FORM_ID"));
		model.setPARENT_FORM_ID(rs.getInt("PARENT_FORM_ID"));
		model.setSYSTEM_ID(rs.getInt("SYSTEM_ID"));
		model.setFORM_NAME(rs.getString("FORM_NAME"));
		model.setURL(rs.getString("URL"));
		return model;
	}
	public cn.zup.workflow.model.WF_FORM ReaderBindAll(ResultSet rs) throws SQLException
	{
		cn.zup.workflow.model.WF_FORM model=new cn.zup.workflow.model.WF_FORM();
		model.setFORM_ID(rs.getInt("FORM_ID"));
		model.setPARENT_FORM_ID(rs.getInt("PARENT_FORM_ID"));
		model.setSYSTEM_ID(rs.getInt("SYSTEM_ID"));
		model.setFORM_NAME(rs.getString("FORM_NAME"));
		model.setFORM_DELBIZ_CONTROLLER(rs.getString("FORM_DELBIZ_CONTROLLER"));
		model.setURL(rs.getString("URL"));
		return model;
	}
	

}

