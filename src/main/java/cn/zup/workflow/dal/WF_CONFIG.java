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

import cn.zup.workflow.model.ACTIVITY_POPEDOM;
//import com.mn886.frame.tool.ZFUUID;
/// <summary>
/// 数据访问类WF_CONFIG
/// </summary>
@Repository("configDal")
public class WF_CONFIG{
	public WF_CONFIG(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	
	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_CONFIG model) throws SQLException{
		//String keyValue = ZFUUID.getUUID4Length(4);
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_config(");
		strSql.append("ID,NAME,SUB_ID,SUB_NAME)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3})", model.getID()+"", "'"+model.getNAME()+"'", model.getSUB_ID()+"", "'"+model.getSUB_NAME()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
		return 0;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_CONFIG model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_config set ");
		strSql.append("NAME="+model.getNAME()); 
		strSql.append(",SUB_NAME="+model.getSUB_NAME());
		strSql.append(" where ID="+model.getID()+" and SUB_ID="+model.getSUB_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ID,int SUB_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_config ");
		strSql.append(" where ID="+ID+" and SUB_ID="+SUB_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_CONFIG GetModel(int ID,int SUB_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ID,NAME,SUB_ID,SUB_NAME from wf_config  ");
		strSql.append(" where ID="+ID+" and SUB_ID="+SUB_ID);

		cn.zup.workflow.model.WF_CONFIG model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_CONFIG>(){

			@Override
			public cn.zup.workflow.model.WF_CONFIG extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_CONFIG model= new cn.zup.workflow.model.WF_CONFIG();;
				if(rs.next())
					model=ReaderBind(rs);
				return model;
			}
			
		});
		
		return model;
	}

	/**
	 * @UpdateInfo 获取流程状态下拉框数据
	 * @UpdateDate 2017-2-27 14:22:12
	 * @UpdatePerson xieyan
	 * */
	public List<cn.zup.workflow.model.WF_CONFIG> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ID,NAME,SUB_ID,SUB_NAME ");
		strSql.append(" FROM wf_config ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_CONFIG> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_CONFIG>>(){

			@Override
			public List<cn.zup.workflow.model.WF_CONFIG> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_CONFIG> list = new ArrayList<cn.zup.workflow.model.WF_CONFIG>();
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
	public List<cn.zup.workflow.model.WF_CONFIG> GetListArrayTran(String strWhere) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ID,NAME,SUB_ID,SUB_NAME ");
		strSql.append(" FROM wf_config for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_CONFIG> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_CONFIG>>(){

			@Override
			public List<cn.zup.workflow.model.WF_CONFIG> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_CONFIG> list = new ArrayList<cn.zup.workflow.model.WF_CONFIG>();
				while (rs.next()){
					list.add(ReaderBind(rs));
				}
				return list;
			}
			
		});

		return list;
	}

	/*
	*/


	/// <summary>
	/// 对象实体绑定数据
	/// </summary>
	public cn.zup.workflow.model.WF_CONFIG ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_CONFIG model=new cn.zup.workflow.model.WF_CONFIG();
		model.setID(rs.getInt("ID"));
		model.setNAME(rs.getString("NAME"));
		model.setSUB_ID(rs.getInt("SUB_ID"));
		model.setSUB_NAME(rs.getString("SUB_NAME"));
		return model;
	}

}

