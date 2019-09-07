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
/// 数据访问类BIZ_USERINFO
/// </summary>
@Repository("bizUserInfo")
public class BIZ_USERINFO{
	public BIZ_USERINFO(){}

	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.BIZ_USERINFO GetModel(int UserID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select UserID,OrganID,PostID,RealName from biz_userinfo  ");
		strSql.append(" where UserID= "+UserID);
		cn.zup.workflow.model.BIZ_USERINFO model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.BIZ_USERINFO>(){

			@Override
			public cn.zup.workflow.model.BIZ_USERINFO extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.BIZ_USERINFO model=null;
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
	public List<cn.zup.workflow.model.BIZ_USERINFO> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select UserID,OrganID,PostID,RealName ");
		strSql.append(" FROM biz_userinfo ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.BIZ_USERINFO> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.BIZ_USERINFO>>(){

			@Override
			public List<cn.zup.workflow.model.BIZ_USERINFO> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.BIZ_USERINFO> list = new ArrayList<cn.zup.workflow.model.BIZ_USERINFO>();
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
	public List<cn.zup.workflow.model.BIZ_USERINFO> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select UserID,OrganID,PostID,RealName ");
		strSql.append(" FROM biz_userinfo for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.BIZ_USERINFO> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.BIZ_USERINFO>>(){

			@Override
			public List<cn.zup.workflow.model.BIZ_USERINFO> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.BIZ_USERINFO> list = new ArrayList<cn.zup.workflow.model.BIZ_USERINFO>();
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
	public cn.zup.workflow.model.BIZ_USERINFO ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.BIZ_USERINFO model=new cn.zup.workflow.model.BIZ_USERINFO();
		model.setUserID(rs.getInt("UserID"));
		model.setOrganID(rs.getInt("OrganID"));
		model.setPostID(rs.getInt("PostID"));
		model.setRealName(rs.getString("RealName"));
		return model;
	}

}

