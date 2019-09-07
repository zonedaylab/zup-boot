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

import cn.zup.workflow.model.WF_ACTIVITY;

/**
 * @UpdateInfo 数据访问类WF_Activity_PopedomBase
 * @UpdateDate 2017-2-28 14:13:25
 * @UpdatePerson xieyan
 * */
@Repository
public class WF_Activity_PopedomBase{
	
	@Autowired
    private JdbcTemplate jdbcTemplate_workflow;
	
	public WF_Activity_PopedomBase(){}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-28 14:13:25
     * @UpdatePerson xieyan
     * */
	public int Add(cn.zup.workflow.model.WF_ACTIVITY_POPEDOM model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into wf_activity_popedom(");
		strSql.append("ACTIVITY_ID,CONTROL_ID,STATE,GRID_COLUMN_DISPLAY)");

		strSql.append(MessageFormat.format(" values ({0},{1},{2},{3})", model.getACTIVITY_ID()+"",
				model.getCONTROL_ID()+"", model.getSTATE()+"", model.getGRID_COLUMN_DISPLAY()));
		jdbcTemplate_workflow.update(strSql.toString());
		return 1;
	}

	/**
     * @UpdateInfo 更新一条数据
     * @UpdateDate 2017-2-28 14:06:18
     * @UpdatePerson xieyan
     * */
	public void Update(cn.zup.workflow.model.WF_ACTIVITY_POPEDOM model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update wf_activity_popedom set ");
		strSql.append("STATE="+model.getSTATE()); 
		strSql.append(",GRID_COLUMN_DISPLAY="+model.getGRID_COLUMN_DISPLAY());
		strSql.append(" where ACTIVITY_ID="+model.getACTIVITY_ID()+" and CONTROL_ID="+model.getCONTROL_ID());
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/**
     * @UpdateInfo 删除一条数据
     * @UpdateDate 2017-2-28 14:06:18
     * @UpdatePerson xieyan
     * */
	public void Delete(int ACTIVITY_ID,int CONTROL_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_activity_popedom ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID+" and CONTROL_ID="+CONTROL_ID );
		jdbcTemplate_workflow.update(strSql.toString());
	}

	/**
     * @UpdateInfo 得到一个对象实体
     * @UpdateDate 2017-2-28 12:03:52
     * @UpdatePerson xieyan
     * */
	public cn.zup.workflow.model.WF_ACTIVITY_POPEDOM GetModel(int ACTIVITY_ID,int CONTROL_ID) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,CONTROL_ID,STATE,GRID_COLUMN_DISPLAY from wf_activity_popedom  ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID+" and CONTROL_ID="+CONTROL_ID);
		
		cn.zup.workflow.model.WF_ACTIVITY_POPEDOM model = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM>(){

			@Override
			public cn.zup.workflow.model.WF_ACTIVITY_POPEDOM extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_ACTIVITY_POPEDOM model=null;
				while(rs.next())
					model=ReaderBind(rs);
				return model;
			}
			
		});

		return model;
	}

	/**
     * @UpdateInfo 获得数据列
     * @UpdateDate 2017-2-28 12:03:52
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> GetListArray(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,CONTROL_ID,STATE,GRID_COLUMN_DISPLAY ");
		strSql.append(" FROM wf_activity_popedom ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> list = new ArrayList<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM>();
				while(rs.next())
					list.add(ReaderBind(rs));
				return list;
			}
			
		});
		return list;
	}

	/**
     * @UpdateInfo 获得数据列
     * @UpdateDate 2017-2-28 12:03:52
     * @UpdatePerson xieyan
     * */
	public List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> GetListArrayTran(String strWhere) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,CONTROL_ID,STATE,GRID_COLUMN_DISPLAY ");
		strSql.append(" FROM wf_activity_popedom for update ");
		if(strWhere.trim()!=""){
			strSql.append(" where "+strWhere);
		}
		
		List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM>>(){

			@Override
			public List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM> list = new ArrayList<cn.zup.workflow.model.WF_ACTIVITY_POPEDOM>();
				while(rs.next())
					list.add(ReaderBind(rs));
				return list;
			}
			
		});
		
		return list;
	}
	
	/**
     * @UpdateInfo 对象实体绑定数据
     * @UpdateDate 2017-2-28 12:03:52
     * @UpdatePerson xieyan
     * */
	public cn.zup.workflow.model.WF_ACTIVITY_POPEDOM ReaderBind(ResultSet rs) throws SQLException{
		cn.zup.workflow.model.WF_ACTIVITY_POPEDOM model=new cn.zup.workflow.model.WF_ACTIVITY_POPEDOM();
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setCONTROL_ID(rs.getInt("CONTROL_ID"));
		model.setSTATE(rs.getByte("STATE"));
		model.setGRID_COLUMN_DISPLAY(rs.getString("GRID_COLUMN_DISPLAY"));
		return model;
	}

}

