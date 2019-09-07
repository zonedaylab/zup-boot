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

import cn.zup.workflow.model.FORM_CONTROL;
import cn.zup.workflow.model.WF_FLOW;
/// <summary>
/// 数据访问类WF_WORK_MSG
/// </summary>
@Repository
public class WF_WORK_MsgBase{
	
	public WF_WORK_MsgBase(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_WORK_MSG model) throws SQLException{
		return AddOracle(model);
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddCommon(cn.zup.workflow.model.WF_WORK_MSG model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_WORK_MSG(");
		strSql.append("WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,SEND_CONTENT,SEND_DATE,RECEIVER_DATE,RECEIVER_FLAG)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5},{6},{7})", 
				model.getWORK_ACTIVITY_ID()+"",model.getRECEIVER_TYPE()+"",model.getRECEIVER_ID()+"",
				"'"+model.getRECEIVER_NAME()+"'","'"+model.getSEND_CONTENT()+"'",(Date) model.getSEND_DATE(),
				(Date) model.getRECEIVER_DATE(),model.getRECEIVER_FLAG()+""));
		strSql.append(";select @@IDENTITY");
		
		return jdbcTemplate_workflow.update(strSql.toString());
	}

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int AddOracle(cn.zup.workflow.model.WF_WORK_MSG model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_WORK_MSG(");
		strSql.append("WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,SEND_CONTENT,SEND_DATE,RECEIVER_DATE,RECEIVER_FLAG)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},{5},now(),{6})",
				model.getWORK_ACTIVITY_ID()+"",model.getRECEIVER_TYPE()+"",model.getRECEIVER_ID()+"",
				"'"+model.getRECEIVER_NAME()+"'","'"+model.getSEND_CONTENT()+"'", "date_format('"+model.getSEND_DATE()+"', '%Y-%c-%d')",
				model.getRECEIVER_FLAG()+""));
		jdbcTemplate_workflow.update(strSql.toString());
		String sql = "SELECT MSG_ID FROM WF_WORK_MSG";
		return jdbcTemplate_workflow.queryForObject(sql, Integer.class);
	}
	
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_WORK_MSG model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_WORK_MSG set ");
		strSql.append(MessageFormat.format("WORK_ACTIVITY_ID={0},", model.getWORK_ACTIVITY_ID()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_TYPE={0},", model.getRECEIVER_TYPE()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_ID={0},", model.getRECEIVER_ID()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_NAME={0},", "'"+model.getRECEIVER_NAME()+"'")); 
		strSql.append(MessageFormat.format("SEND_CONTENT={0},", "'"+model.getSEND_CONTENT()+"'")); 
		strSql.append(MessageFormat.format("SEND_DATE={0},", "date_format('"+model.getSEND_DATE()+"', '%Y-%c-%d')")); 
		strSql.append(MessageFormat.format("RECEIVER_DATE={0},", "date_format('"+model.getRECEIVER_DATE()+"', '%Y-%c-%d')")); 
		strSql.append(MessageFormat.format("RECEIVER_FLAG={0}", model.getRECEIVER_FLAG()+""));
		strSql.append(MessageFormat.format(" where WORK_MSG_ID={0}", model.getWORK_MSG_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
		
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int WORK_MSG_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_WORK_MSG ");
		strSql.append(" where WORK_MSG_ID="+ WORK_MSG_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_WORK_MSG GetModel(int WORK_MSG_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_MSG_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,SEND_CONTENT,SEND_DATE,RECEIVER_DATE,RECEIVER_FLAG from WF_WORK_MSG  ");
		strSql.append(" where WORK_MSG_ID="+WORK_MSG_ID);
		
		cn.zup.workflow.model.WF_WORK_MSG model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_MSG>(){

			@Override
			public cn.zup.workflow.model.WF_WORK_MSG extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_WORK_MSG model=null;
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
	public List<cn.zup.workflow.model.WF_WORK_MSG> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_MSG_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,SEND_CONTENT,SEND_DATE,RECEIVER_DATE,RECEIVER_FLAG ");
		strSql.append(" FROM WF_WORK_MSG ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK_MSG> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_MSG>>(){

			@Override
			public List<cn.zup.workflow.model.WF_WORK_MSG> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_MSG> list = new ArrayList<cn.zup.workflow.model.WF_WORK_MSG>();
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
	public List<cn.zup.workflow.model.WF_WORK_MSG> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_MSG_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,SEND_CONTENT,SEND_DATE,RECEIVER_DATE,RECEIVER_FLAG ");
		strSql.append(" FROM WF_WORK_MSG for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK_MSG> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_MSG>>(){

			@Override
			public List<cn.zup.workflow.model.WF_WORK_MSG> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_MSG> list = new ArrayList<cn.zup.workflow.model.WF_WORK_MSG>();
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
	public cn.zup.workflow.model.WF_WORK_MSG ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_WORK_MSG model=new cn.zup.workflow.model.WF_WORK_MSG();
		model.setWORK_MSG_ID(rs.getInt("WORK_MSG_ID"));
		model.setWORK_ACTIVITY_ID(rs.getInt("WORK_ACTIVITY_ID"));
		model.setRECEIVER_TYPE(rs.getByte("RECEIVER_TYPE"));
		model.setRECEIVER_ID(rs.getInt("RECEIVER_ID"));
		model.setRECEIVER_NAME(rs.getString("RECEIVER_NAME"));
		model.setSEND_CONTENT(rs.getString("SEND_CONTENT"));
		model.setSEND_DATE(rs.getDate("SEND_DATE"));
		model.setRECEIVER_DATE(rs.getDate("RECEIVER_DATE"));
		model.setRECEIVER_FLAG(rs.getByte("RECEIVER_FLAG"));
		return model;
	}

}

