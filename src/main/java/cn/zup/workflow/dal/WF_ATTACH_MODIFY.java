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
//import com.mn886.frame.tool.ZFUUID;
/// <summary>
/// 数据访问类WF_ATTACH_MODIFY
/// </summary>
@Repository("wfAttachModify")
public class WF_ATTACH_MODIFY{
	public WF_ATTACH_MODIFY(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_ATTACH_MODIFY model) throws SQLException{
		//String keyValue = ZFUUID.getUUID4Length(4);
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_attach_modify(");
		strSql.append("ATTACH_ID,USER_ID,ATTACH_PATH,UPLOAD_ID)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3})", model.getATTACH_ID()+"",
				model.getUSER_ID()+"", "'"+model.getATTACH_PATH()+"'", model.getUPLOAD_ID()+""));
		return jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_ATTACH_MODIFY model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_attach_modify set ");
		strSql.append(MessageFormat.format("USER_ID={0}",model.getUSER_ID()+"")); 
		strSql.append(MessageFormat.format(",ATTACH_PATH={0}",model.getATTACH_PATH()+"")); 
		strSql.append(MessageFormat.format(",UPLOAD_ID={0} ",model.getUPLOAD_ID()+""));
		strSql.append(MessageFormat.format(" where ATTACH_ID={0} ",model.getATTACH_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ATTACH_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_attach_modify ");
		strSql.append(MessageFormat.format(" where ATTACH_ID={0} ", ATTACH_ID+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_ATTACH_MODIFY GetModel(int ATTACH_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ATTACH_ID,USER_ID,ATTACH_PATH,UPLOAD_ID from wf_attach_modify  ");
		strSql.append(MessageFormat.format(" where ATTACH_ID={0} ", ATTACH_ID+""));
		cn.zup.workflow.model.WF_ATTACH_MODIFY model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ATTACH_MODIFY>(){

			@Override
			public cn.zup.workflow.model.WF_ATTACH_MODIFY extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_ATTACH_MODIFY model = null;
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
	public List<cn.zup.workflow.model.WF_ATTACH_MODIFY> GetListArray(String strWhere){
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ATTACH_ID,USER_ID,ATTACH_PATH,UPLOAD_ID ");
		strSql.append(" FROM wf_attach_modify ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ATTACH_MODIFY> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ATTACH_MODIFY>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ATTACH_MODIFY> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_ATTACH_MODIFY> list = new ArrayList<cn.zup.workflow.model.WF_ATTACH_MODIFY>();
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
	public List<cn.zup.workflow.model.WF_ATTACH_MODIFY> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ATTACH_ID,USER_ID,ATTACH_PATH,UPLOAD_ID ");
		strSql.append(" FROM wf_attach_modify for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_ATTACH_MODIFY> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ATTACH_MODIFY>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ATTACH_MODIFY> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_ATTACH_MODIFY> list = new ArrayList<cn.zup.workflow.model.WF_ATTACH_MODIFY>();
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
	public cn.zup.workflow.model.WF_ATTACH_MODIFY ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_ATTACH_MODIFY model=new cn.zup.workflow.model.WF_ATTACH_MODIFY();
		model.setATTACH_ID(rs.getInt("ATTACH_ID"));
		model.setUSER_ID(rs.getInt("USER_ID"));
		model.setATTACH_PATH(rs.getString("ATTACH_PATH"));
		model.setUPLOAD_ID(rs.getInt("UPLOAD_ID"));
		return model;
	}

}

