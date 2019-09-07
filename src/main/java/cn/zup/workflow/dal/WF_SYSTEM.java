package cn.zup.workflow.dal;
import java.sql.Date;
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

//import com.mn886.frame.tool.ZFUUID;
/// <summary>
/// 数据访问类WF_SYSTEM
/// </summary>
@Repository("systemDal")
public class WF_SYSTEM{
	
	public WF_SYSTEM(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_SYSTEM model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_system(");
		strSql.append("SYSTEM_NAME,CREATE_DATE)");
		strSql.append(MessageFormat.format(" values ({0},{1})", "'"+model.getSYSTEM_NAME()+"'",(Date) model.getCREATE_DATE()));
		return jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_SYSTEM model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_system set ");
		strSql.append("SYSTEM_NAME="+model.getSYSTEM_NAME()); 
		strSql.append(",CREATE_DATE="+model.getCREATE_DATE());
		strSql.append(" where SYSTEM_ID="+model.getSYSTEM_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int SYSTEM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_system ");
		strSql.append(" where SYSTEM_ID="+SYSTEM_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_SYSTEM GetModel(int SYSTEM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select SYSTEM_ID,SYSTEM_NAME,CREATE_DATE from wf_system  ");
		strSql.append(" where SYSTEM_ID="+SYSTEM_ID);
		
		cn.zup.workflow.model.WF_SYSTEM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_SYSTEM>(){

			@Override
			public cn.zup.workflow.model.WF_SYSTEM extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_SYSTEM model = new cn.zup.workflow.model.WF_SYSTEM();
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
	public List<cn.zup.workflow.model.WF_SYSTEM> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select SYSTEM_ID,SYSTEM_NAME,CREATE_DATE ");
		strSql.append(" FROM wf_system ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}

		List<cn.zup.workflow.model.WF_SYSTEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_SYSTEM>>(){

			@Override
			public List<cn.zup.workflow.model.WF_SYSTEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_SYSTEM> list = new ArrayList<cn.zup.workflow.model.WF_SYSTEM>();
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
	public List<cn.zup.workflow.model.WF_SYSTEM> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select SYSTEM_ID,SYSTEM_NAME,CREATE_DATE ");
		strSql.append(" FROM wf_system for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_SYSTEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_SYSTEM>>(){

			@Override
			public List<cn.zup.workflow.model.WF_SYSTEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_SYSTEM> list = new ArrayList<cn.zup.workflow.model.WF_SYSTEM>();
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
	public cn.zup.workflow.model.WF_SYSTEM ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_SYSTEM model=new cn.zup.workflow.model.WF_SYSTEM();
		model.setSYSTEM_ID(rs.getInt("SYSTEM_ID"));
		model.setSYSTEM_NAME(rs.getString("SYSTEM_NAME"));
		model.setCREATE_DATE(rs.getDate("CREATE_DATE"));
		return model;
	}

}

