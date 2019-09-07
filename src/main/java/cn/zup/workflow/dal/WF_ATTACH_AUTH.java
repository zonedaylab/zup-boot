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
/// 数据访问类WF_ATTACH_AUTH
/// </summary>
@Repository("wfAttachAuth")
public class WF_ATTACH_AUTH{
	public WF_ATTACH_AUTH(){}
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_ATTACH_AUTH model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_attach_auth(");
		strSql.append("ACTIVITY_ID,ALLOT_ACTIVITY_ID,OPER_TYPE)");

		strSql.append(MessageFormat.format(" values ({0},{1},{3})", model.getACTIVITY_ID()+"",
				model.getALLOT_ACTIVITY_ID()+"", model.getOPER_TYPE()+""));
		
		return jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_ATTACH_AUTH model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_attach_auth set ");
		strSql.append(MessageFormat.format("ALLOT_ACTIVITY_ID={0},", model.getALLOT_ACTIVITY_ID()+"")); 
		strSql.append(MessageFormat.format("OPER_TYPE={0} ", model.getOPER_TYPE()+""));
		strSql.append(MessageFormat.format(" where ACTIVITY_ID={0}", model.getACTIVITY_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ACTIVITY_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_attach_auth ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_ATTACH_AUTH GetModel(int ACTIVITY_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,ALLOT_ACTIVITY_ID,OPER_TYPE from wf_attach_auth  ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID);
		cn.zup.workflow.model.WF_ATTACH_AUTH model = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ATTACH_AUTH>(){

			@Override
			public cn.zup.workflow.model.WF_ATTACH_AUTH extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_ATTACH_AUTH model=null;
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
	public List<cn.zup.workflow.model.WF_ATTACH_AUTH> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,ALLOT_ACTIVITY_ID,OPER_TYPE ");
		strSql.append(" FROM wf_attach_auth ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ATTACH_AUTH> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ATTACH_AUTH>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ATTACH_AUTH> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_ATTACH_AUTH> list = new ArrayList<cn.zup.workflow.model.WF_ATTACH_AUTH>();
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
	public List<cn.zup.workflow.model.WF_ATTACH_AUTH> GetListArrayTran(String strWhere) throws SQLException{	
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,ALLOT_ACTIVITY_ID,OPER_TYPE ");
		strSql.append(" FROM wf_attach_auth for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_ATTACH_AUTH> list = jdbcTemplate_workflow.query(strSql.toString() , 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ATTACH_AUTH>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ATTACH_AUTH> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_ATTACH_AUTH> list = new ArrayList<cn.zup.workflow.model.WF_ATTACH_AUTH>();
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
	public cn.zup.workflow.model.WF_ATTACH_AUTH ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_ATTACH_AUTH model=new cn.zup.workflow.model.WF_ATTACH_AUTH();
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setALLOT_ACTIVITY_ID(rs.getInt("ALLOT_ACTIVITY_ID"));
		model.setOPER_TYPE(rs.getInt("OPER_TYPE"));
		return model;
	}
}

