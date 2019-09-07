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
/// 数据访问类BIZ_ORGAN
/// </summary>
@Repository("biz_Organ")
public class BIZ_ORGAN{
	
	public BIZ_ORGAN(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.BIZ_ORGAN GetModel(int OrganID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select OrganID,ParentOrganID,OrganCode,OrganName,ShortName,OrderCode,OrganType,Governor,ValidFlag,IsParent from biz_organ  ");
		strSql.append(" where OrganID="+OrganID);
		
		cn.zup.workflow.model.BIZ_ORGAN model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.BIZ_ORGAN>(){

			@Override
			public cn.zup.workflow.model.BIZ_ORGAN extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.BIZ_ORGAN model=null;
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
	public List<cn.zup.workflow.model.BIZ_ORGAN> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select OrganID,ParentOrganID,OrganCode,OrganName,ShortName,OrderCode,OrganType,Governor,ValidFlag,IsParent ");
		strSql.append(" FROM biz_organ ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.BIZ_ORGAN> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.BIZ_ORGAN>>(){

			@Override
			public List<cn.zup.workflow.model.BIZ_ORGAN> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.BIZ_ORGAN> list = new ArrayList<cn.zup.workflow.model.BIZ_ORGAN>();
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
	public List<cn.zup.workflow.model.BIZ_ORGAN> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select OrganID,ParentOrganID,OrganCode,OrganName,ShortName,OrderCode,OrganType,Governor,ValidFlag,IsParent ");
		strSql.append(" FROM biz_organ for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.BIZ_ORGAN> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.BIZ_ORGAN>>(){

			@Override
			public List<cn.zup.workflow.model.BIZ_ORGAN> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.BIZ_ORGAN> list = new ArrayList<cn.zup.workflow.model.BIZ_ORGAN>();
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
	public cn.zup.workflow.model.BIZ_ORGAN ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.BIZ_ORGAN model=new cn.zup.workflow.model.BIZ_ORGAN();
		model.setOrganID(rs.getInt("OrganID"));
		model.setParentOrganID(rs.getInt("ParentOrganID"));
		model.setOrganCode(rs.getString("OrganCode"));
		model.setOrganName(rs.getString("OrganName"));
		model.setShortName(rs.getString("ShortName"));
		model.setOrderCode(rs.getInt("OrderCode"));
		model.setOrganType(rs.getByte("OrganType"));
		model.setGovernor(rs.getString("Governor"));
		model.setValidFlag(rs.getByte("ValidFlag"));
		model.setIsParent(rs.getInt("IsParent"));
		return model;
	}

}

