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
/// 数据访问类WF_ACTIVITY_LAYOUT
/// </summary>
@Repository("actLayoutDal")
public class WF_ACTIVITY_LAYOUT{
	
	public WF_ACTIVITY_LAYOUT(){}
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	/// <summary>
	/// 增加一条数据
	/// </summary>
	public int Add(cn.zup.workflow.model.WF_ACTIVITY_LAYOUT model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_activity_layout(");
		strSql.append("ACTIVITY_ID,TOP_MARGIN,LEFT_MARGIN)");
		strSql.append(MessageFormat.format(" values ({0},{1},{2})", model.getACTIVITY_ID()+""
				,model.getTOP_MARGIN()+"",model.getLEFT_MARGIN()+""));
		return jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_ACTIVITY_LAYOUT model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_activity_layout set ");
		strSql.append(MessageFormat.format("TOP_MARGIN={0}, LEFT_MARGIN={1} where ACTIVITY_ID={2}",
				model.getTOP_MARGIN()+"",model.getLEFT_MARGIN()+"",model.getACTIVITY_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ACTIVITY_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_activity_layout ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}
	
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_ACTIVITY_LAYOUT GetModel(int ACTIVITY_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,TOP_MARGIN,LEFT_MARGIN from wf_activity_layout  ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID);
		
		cn.zup.workflow.model.WF_ACTIVITY_LAYOUT model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT>(){

			@Override
			public cn.zup.workflow.model.WF_ACTIVITY_LAYOUT extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_ACTIVITY_LAYOUT model = new cn.zup.workflow.model.WF_ACTIVITY_LAYOUT();
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
	public List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,TOP_MARGIN,LEFT_MARGIN ");
		strSql.append(" FROM wf_activity_layout ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> list = new ArrayList<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT>();
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
	public List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,TOP_MARGIN,LEFT_MARGIN ");
		strSql.append(" FROM wf_activity_layout for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT> list = new ArrayList<cn.zup.workflow.model.WF_ACTIVITY_LAYOUT>();
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
	public cn.zup.workflow.model.WF_ACTIVITY_LAYOUT ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_ACTIVITY_LAYOUT model=new cn.zup.workflow.model.WF_ACTIVITY_LAYOUT();
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setTOP_MARGIN(rs.getFloat("TOP_MARGIN"));
		model.setLEFT_MARGIN(rs.getFloat("LEFT_MARGIN"));
		return model;
	}

}

