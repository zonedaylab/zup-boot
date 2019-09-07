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

/// <summary>
/// 数据访问类BIZ_POST
/// </summary>
@Repository("bizPost")
public class BIZ_POST{
	
	public BIZ_POST(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.BIZ_POST GetModel(int PostID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select PostID,OrganID,PostName,PostDuty,StandardNumber,ValidFlag from biz_post  ");
		strSql.append(" where PostID="+PostID);
		cn.zup.workflow.model.BIZ_POST model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.BIZ_POST>(){

			@Override
			public cn.zup.workflow.model.BIZ_POST extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.BIZ_POST model=null;
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
	public List<cn.zup.workflow.model.BIZ_POST> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select PostID,OrganID,PostName,PostDuty,StandardNumber,ValidFlag ");
		strSql.append(" FROM biz_post ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.BIZ_POST> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.BIZ_POST>>(){

			@Override
			public List<cn.zup.workflow.model.BIZ_POST> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.BIZ_POST> list = new ArrayList<cn.zup.workflow.model.BIZ_POST>();
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
	public List<cn.zup.workflow.model.BIZ_POST> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select PostID,OrganID,PostName,PostDuty,StandardNumber,ValidFlag ");
		strSql.append(" FROM biz_post for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.BIZ_POST> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.BIZ_POST>>(){

			@Override
			public List<cn.zup.workflow.model.BIZ_POST> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.BIZ_POST> list = new ArrayList<cn.zup.workflow.model.BIZ_POST>();
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
	public cn.zup.workflow.model.BIZ_POST ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.BIZ_POST model=new cn.zup.workflow.model.BIZ_POST();
		model.setPostID(rs.getInt("PostID"));
		model.setOrganID(rs.getInt("OrganID"));
		model.setPostName(rs.getString("PostName"));
		model.setPostDuty(rs.getString("PostDuty"));
		model.setStandardNumber(rs.getInt("StandardNumber"));
		model.setValidFlag(rs.getByte("ValidFlag"));
		return model;
	}

}

