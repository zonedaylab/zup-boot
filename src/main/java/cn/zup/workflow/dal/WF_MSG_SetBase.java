package cn.zup.workflow.dal;
import java.sql.Date;
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

/**
 * @UpdateInfo 数据访问类WF_MSG_SET
 * @UpdateDate 2017-2-28 09:16:36
 * @UpdatePerson xieyan
 * */
@Repository
public class WF_MSG_SetBase{
	public WF_MSG_SetBase(){}

	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	
	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public int Add(cn.zup.workflow.model.WF_MSG_SET model) throws SQLException{
		return AddOracle(model);
	}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public int AddCommon(cn.zup.workflow.model.WF_MSG_SET model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_MSG_SET(");
		strSql.append("ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3});select @@IDENTITY",
				model.getACTIVITY_ID()+"", model.getRECEIVER_TYPE()+"",
				model.getRECEIVER_ID()+"", "'"+model.getRECEIVER_NAME()+"'"));
		
		int icid = jdbcTemplate_workflow.update(strSql.toString());
		return icid;
	}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-28 09:16:36
     * @UpdatePerson xieyan
     * */
	public int AddOracle(cn.zup.workflow.model.WF_MSG_SET model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_MSG_SET(");
		strSql.append("ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3})",
				model.getACTIVITY_ID()+"", model.getRECEIVER_TYPE()+"", 
				model.getRECEIVER_ID()+"", "'"+model.getRECEIVER_NAME()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sql = "SELECT max(MSG_ID) FROM WF_MSG_SET";
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_MSG_SET model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_MSG_SET set ");
		strSql.append(MessageFormat.format("ACTIVITY_ID={0},", model.getACTIVITY_ID()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_TYPE={0},", model.getRECEIVER_TYPE()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_ID={0},", model.getRECEIVER_ID()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_NAME={0}", "'"+model.getRECEIVER_NAME()+"'"));
		strSql.append(MessageFormat.format(" where MSG_ID={0}", model.getMSG_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int MSG_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_MSG_SET ");
		strSql.append(" where MSG_ID="+MSG_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_MSG_SET GetModel(int MSG_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select MSG_ID,ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME from WF_MSG_SET  ");
		strSql.append(" where MSG_ID="+MSG_ID);
		
		cn.zup.workflow.model.WF_MSG_SET model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_MSG_SET>(){
			@Override
			public cn.zup.workflow.model.WF_MSG_SET extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_MSG_SET model = new cn.zup.workflow.model.WF_MSG_SET();
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
	public List<cn.zup.workflow.model.WF_MSG_SET> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select MSG_ID,ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME ");
		strSql.append(" FROM WF_MSG_SET ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_MSG_SET> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MSG_SET>>(){
			@Override
			public List<cn.zup.workflow.model.WF_MSG_SET> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_MSG_SET> list = new ArrayList<cn.zup.workflow.model.WF_MSG_SET>();
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
	public List<cn.zup.workflow.model.WF_MSG_SET> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select MSG_ID,ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME ");
		strSql.append(" FROM WF_MSG_SET for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_MSG_SET> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_MSG_SET>>(){
			@Override
			public List<cn.zup.workflow.model.WF_MSG_SET> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_MSG_SET> list = new ArrayList<cn.zup.workflow.model.WF_MSG_SET>();
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
	public cn.zup.workflow.model.WF_MSG_SET ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_MSG_SET model=new cn.zup.workflow.model.WF_MSG_SET();
		model.setMSG_ID(rs.getInt("MSG_ID"));
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setRECEIVER_TYPE(rs.getInt("RECEIVER_TYPE"));
		model.setRECEIVER_ID(rs.getInt("RECEIVER_ID"));
		model.setRECEIVER_NAME(rs.getString("RECEIVER_NAME"));
		return model;
	}

}

