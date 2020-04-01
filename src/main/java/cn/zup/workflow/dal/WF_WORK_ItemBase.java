package cn.zup.workflow.dal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
//import com.mn886.frame.tool.ZFUUID;
/// <summary>
/// 数据访问类WF_WORK_ItemBase
/// </summary>
@Repository
public class WF_WORK_ItemBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int add(cn.zup.workflow.model.WF_WORK_ITEM model) throws SQLException{
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sql = "SELECT max(WORK_ITEM_ID) FROM WF_WORK_ITEM ";
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_WORK_ITEM(");
		strSql.append("WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3},{4},now(),{5},{6},{7},{8},{9})",
				model.getWORK_ACTIVITY_ID()+"", model.getRECEIVER_TYPE()+"", model.getRECEIVER_ID()+"",
				"'"+model.getRECEIVER_NAME()+"'", "'"+model.getCONTENT()+"'", model.getWORK_ITEM_STATE(),
				model.getRESPONSIBLE_ID()+"", "'"+model.getSIGN_NAME()+"'", model.getSIGN_DATE()==null?" now() " : "date_format('"+df.format(model.getSIGN_DATE())+"', '%Y-%m-%d %H:%i:%s') ",
				"'"+model.getSIGN_OPINION()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
		
		int incID = jdbcTemplate_workflow.queryForObject(sql, Integer.class);
		return incID;
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void update(cn.zup.workflow.model.WF_WORK_ITEM model) throws SQLException{
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_WORK_ITEM set ");
		strSql.append(MessageFormat.format("WORK_ACTIVITY_ID={0},",model.getWORK_ACTIVITY_ID()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_TYPE={0},",model.getRECEIVER_TYPE()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_ID={0},",model.getRECEIVER_ID()+"")); 
		strSql.append(MessageFormat.format("RECEIVER_NAME={0},", "'"+model.getRECEIVER_NAME()+"'")); 
		strSql.append(MessageFormat.format("CONTENT={0},", "'"+model.getCONTENT()+"'")); 
		strSql.append("WORK_ITEM_DATETIME=now(),"); 
		strSql.append(MessageFormat.format("WORK_ITEM_STATE={0},",model.getWORK_ITEM_STATE()+"")); 
		strSql.append(MessageFormat.format("RESPONSIBLE_ID={0},",model.getRESPONSIBLE_ID()+"")); 
		strSql.append(MessageFormat.format("SIGN_NAME={0},", "'"+model.getSIGN_NAME()+"'")); 
		strSql.append(MessageFormat.format("SIGN_DATE={0},", model.getSIGN_DATE()==null?"now()":"date_format('"+df.format(model.getSIGN_DATE())+"', '%Y-%m-%d %H:%i:%s')")); 
		strSql.append(MessageFormat.format("SIGN_OPINION={0}", "'"+model.getSIGN_OPINION()+"'"));
		strSql.append(MessageFormat.format(" where WORK_ITEM_ID={0} ",model.getWORK_ITEM_ID()+""));
		
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int WORK_ITEM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from WF_WORK_ITEM ");
		strSql.append(" where WORK_ITEM_ID="+WORK_ITEM_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_WORK_ITEM GetModel(int WORK_ITEM_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION from WF_WORK_ITEM  ");
		strSql.append(" where WORK_ITEM_ID= "+WORK_ITEM_ID);

		cn.zup.workflow.model.WF_WORK_ITEM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_WORK_ITEM>(){
			@Override
			public cn.zup.workflow.model.WF_WORK_ITEM extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_WORK_ITEM model = new cn.zup.workflow.model.WF_WORK_ITEM();
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
	public List<cn.zup.workflow.model.WF_WORK_ITEM> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION ");
		strSql.append(" FROM WF_WORK_ITEM ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK_ITEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ITEM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ITEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ITEM> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ITEM>();
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
	public List<cn.zup.workflow.model.WF_WORK_ITEM> GetListArrayTran(String strWhere) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select WORK_ITEM_ID,WORK_ACTIVITY_ID,RECEIVER_TYPE,RECEIVER_ID,RECEIVER_NAME,CONTENT,WORK_ITEM_DATETIME,WORK_ITEM_STATE,RESPONSIBLE_ID,SIGN_NAME,SIGN_DATE,SIGN_OPINION ");
		strSql.append(" FROM WF_WORK_ITEM for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_WORK_ITEM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_WORK_ITEM>>(){
			@Override
			public List<cn.zup.workflow.model.WF_WORK_ITEM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_WORK_ITEM> list = new ArrayList<cn.zup.workflow.model.WF_WORK_ITEM>();
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
	public cn.zup.workflow.model.WF_WORK_ITEM ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_WORK_ITEM model=new cn.zup.workflow.model.WF_WORK_ITEM();
		model.setWORK_ITEM_ID(rs.getInt("WORK_ITEM_ID"));
		model.setWORK_ACTIVITY_ID(rs.getInt("WORK_ACTIVITY_ID"));
		model.setRECEIVER_TYPE(rs.getByte("RECEIVER_TYPE"));
		model.setRECEIVER_ID(rs.getInt("RECEIVER_ID"));
		model.setRECEIVER_NAME(rs.getString("RECEIVER_NAME"));
		model.setCONTENT(rs.getString("CONTENT"));
		model.setWORK_ITEM_DATETIME(rs.getTimestamp("WORK_ITEM_DATETIME"));
		model.setWORK_ITEM_STATE(rs.getByte("WORK_ITEM_STATE"));
		model.setRESPONSIBLE_ID(rs.getInt("RESPONSIBLE_ID"));
		model.setSIGN_NAME(rs.getString("SIGN_NAME"));
		model.setSIGN_DATE(rs.getDate("SIGN_DATE"));
		model.setSIGN_OPINION(rs.getString("SIGN_OPINION"));
		return model;
	}
	

}

