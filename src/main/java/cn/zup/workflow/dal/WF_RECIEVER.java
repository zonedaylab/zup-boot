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

import cn.zup.workflow.model.WF_LINE;
/// <summary>
/// 数据访问类WF_RECIEVER
/// </summary>
@Repository("wfReciever")
public class WF_RECIEVER{
	
	public WF_RECIEVER(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_RECIEVER model) throws SQLException{
		//String keyValue = ZFUUID.getUUID4Length(4);
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_reciever(");
		strSql.append("RECIEVER_ID,ACTIVITY_ID,RECIEVER,RECIEVER_TYPE)");

		strSql.append(MessageFormat.format(" values ({0}{1}{2}{3})", 
				model.getRECIEVER_ID()+"",model.getACTIVITY_ID()+"",
				model.getRECIEVER()+"",model.getRECIEVER_TYPE()+""));
		
		return jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_RECIEVER model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_reciever set ");
		strSql.append(MessageFormat.format("ACTIVITY_ID={0},", model.getACTIVITY_ID())); 
		strSql.append(MessageFormat.format("RECIEVER={0},", model.getRECIEVER())); 
		strSql.append(MessageFormat.format("RECIEVER_TYPE={0}", model.getRECIEVER_TYPE()));
		strSql.append(MessageFormat.format(" where RECIEVER_ID={0}", model.getRECIEVER_ID()));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int RECIEVER_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_reciever ");
		strSql.append(" where RECIEVER_ID= "+ RECIEVER_ID);
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_RECIEVER GetModel(int RECIEVER_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select RECIEVER_ID,ACTIVITY_ID,RECIEVER,RECIEVER_TYPE from wf_reciever  ");
		strSql.append(" where RECIEVER_ID="+RECIEVER_ID);
		
		cn.zup.workflow.model.WF_RECIEVER model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_RECIEVER>(){
			@Override
			public cn.zup.workflow.model.WF_RECIEVER extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				cn.zup.workflow.model.WF_RECIEVER model = new cn.zup.workflow.model.WF_RECIEVER();
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
	public List<cn.zup.workflow.model.WF_RECIEVER> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select RECIEVER_ID,ACTIVITY_ID,RECIEVER,RECIEVER_TYPE ");
		strSql.append(" FROM wf_reciever ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}

		List<cn.zup.workflow.model.WF_RECIEVER> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_RECIEVER>>(){

			@Override
			public List<cn.zup.workflow.model.WF_RECIEVER> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_RECIEVER> list = new ArrayList<cn.zup.workflow.model.WF_RECIEVER>();
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
	public List<cn.zup.workflow.model.WF_RECIEVER> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select RECIEVER_ID,ACTIVITY_ID,RECIEVER,RECIEVER_TYPE ");
		strSql.append(" FROM wf_reciever for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_RECIEVER> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_RECIEVER>>(){

			@Override
			public List<cn.zup.workflow.model.WF_RECIEVER> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<cn.zup.workflow.model.WF_RECIEVER> list = new ArrayList<cn.zup.workflow.model.WF_RECIEVER>();
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
	public cn.zup.workflow.model.WF_RECIEVER ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_RECIEVER model=new cn.zup.workflow.model.WF_RECIEVER();
		model.setRECIEVER_ID(rs.getInt("RECIEVER_ID"));
		model.setACTIVITY_ID(rs.getString("ACTIVITY_ID"));
		model.setRECIEVER(rs.getInt("RECIEVER"));
		model.setRECIEVER_TYPE(rs.getInt("RECIEVER_TYPE"));
		return model;
	}

}

