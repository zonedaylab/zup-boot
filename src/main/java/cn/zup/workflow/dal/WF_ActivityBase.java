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
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.model.WF_ACTIVITY;
//import com.mn886.frame.tool.ZFUUID;
/// <summary>
/// 数据访问类WF_ActivityBase
/// </summary>
@Repository
public class WF_ActivityBase{
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;

	public WF_ActivityBase(){}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-27 18:15:22
     * @UpdatePerson xieyan
     * */
	public int Add(cn.zup.workflow.model.WF_ACTIVITY model) throws SQLException{
		return AddOracle(model);
	}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-27 18:15:22
     * @UpdatePerson xieyan
     * */
	public int AddCommon(cn.zup.workflow.model.WF_ACTIVITY model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_ACTIVITY(");
		strSql.append("FLOW_ID,FORM_ID,ACTIVITY_CODE,ACTIVITY_NAME,ACTIVITY_TYPE,NEXT_ACTIVITY_CODE,SUB_FLOW_ID,REVIEW_TYPE,REJECT_ACTIVITY_CODE,BRANCH_SEL_TYPE,HANDLER_SEL_TYPE,ACTIVITY_INTERVAL,ACTIVITY_PROPERTY,RELATION_NODE,ACTIVITY_LEFT,ACTIVITY_TOP,ACTIVITY_ICON)");

		strSql.append(" values (");
		strSql.append(MessageFormat.format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16})",
				model.getFLOW_ID()+"", model.getFORM_ID()+"", model.getACTIVITY_CODE()+"", "'"+model.getACTIVITY_NAME()+"'",
				"'"+model.getACTIVITY_TYPE()+"'", model.getNEXT_ACTIVITY_CODE()+"", model.getSUB_FLOW_ID()+"", model.getREVIEW_TYPE()+"",
				model.getREJECT_ACTIVITY_CODE()+"", model.getBRANCH_SEL_TYPE()+"", model.getHANDLER_SEL_TYPE()+"",
				model.getACTIVITY_INTERVAL()+"", model.getACTIVITY_PROPERTY()+"", model.getRELATION_NODE()+"", 
				model.getACTIVITY_LEFT()+"", model.getACTIVITY_TOP()+"", "'"+model.getACTIVITY_ICON()+"'" ));
		strSql.append(";select @@IDENTITY");
		Integer result = jdbcTemplate_workflow.update(strSql.toString());
		if (result != null)
			return result;
		else
			return 0;
	}

	/**
     * @UpdateInfo 增加一条数据
     * @UpdateDate 2017-2-27 18:15:22
     * @UpdatePerson xieyan
     * */
	public int AddOracle(cn.zup.workflow.model.WF_ACTIVITY model) throws SQLException{
		StringBuffer strSql = new StringBuffer();
		strSql.append("insert into WF_ACTIVITY(");
		strSql.append("FLOW_ID,FORM_ID,ACTIVITY_CODE,ACTIVITY_NAME,ACTIVITY_TYPE,NEXT_ACTIVITY_CODE,SUB_FLOW_ID,REVIEW_TYPE,REJECT_ACTIVITY_CODE,BRANCH_SEL_TYPE,HANDLER_SEL_TYPE,ACTIVITY_INTERVAL,ACTIVITY_PROPERTY,RELATION_NODE,ACTIVITY_LEFT,ACTIVITY_TOP,ACTIVITY_ICON)");

		strSql.append(" values (");
		strSql.append(MessageFormat.format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16})",
				model.getFLOW_ID()+"", model.getFORM_ID()+"", model.getACTIVITY_CODE()+"", "'"+model.getACTIVITY_NAME()+"'",
				model.getACTIVITY_TYPE()+"", model.getNEXT_ACTIVITY_CODE()+"", model.getSUB_FLOW_ID()+"", model.getREVIEW_TYPE()+"",
				model.getREJECT_ACTIVITY_CODE()+"", model.getBRANCH_SEL_TYPE()+"", model.getHANDLER_SEL_TYPE()+"",
				model.getACTIVITY_INTERVAL()+"", model.getACTIVITY_PROPERTY()+"", model.getRELATION_NODE()+"",
				model.getACTIVITY_LEFT()+"", model.getACTIVITY_TOP()+"", "'"+model.getACTIVITY_ICON()+"'"));
		jdbcTemplate_workflow.update(strSql.toString());
		
		String sql = "SELECT max(ACTIVITY_ID) FROM WF_ACTIVITY";
		return jdbcTemplate_workflow.queryForObject(sql, Integer.class);
	}
	
	/// <summary>
	/// 更新一条数据
	/// </summary>
	/// <summary>
	/// 更新一条数据
	/// </summary>
	public void Update(cn.zup.workflow.model.WF_ACTIVITY model) throws SQLException{
		StringBuffer strSql=new StringBuffer();
		strSql.append("update WF_ACTIVITY set ");
		strSql.append(MessageFormat.format("FLOW_ID={0},", model.getFLOW_ID()+"")); 
		strSql.append(MessageFormat.format("FORM_ID={0},", model.getFORM_ID()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_CODE={0},", model.getACTIVITY_CODE()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_NAME={0},", "'"+model.getACTIVITY_NAME()+"'")); 
		strSql.append(MessageFormat.format("ACTIVITY_TYPE={0},", model.getACTIVITY_TYPE()+"")); 
		strSql.append(MessageFormat.format("NEXT_ACTIVITY_CODE={0},", "'"+model.getNEXT_ACTIVITY_CODE()+"'")); 
		strSql.append(MessageFormat.format("SUB_FLOW_ID={0},", model.getSUB_FLOW_ID()+"")); 
		strSql.append(MessageFormat.format("REVIEW_TYPE={0},", model.getREVIEW_TYPE()+"")); 
		strSql.append(MessageFormat.format("REJECT_ACTIVITY_CODE={0},", model.getREJECT_ACTIVITY_CODE()+"")); 
		strSql.append(MessageFormat.format("BRANCH_SEL_TYPE={0},", model.getBRANCH_SEL_TYPE()+"")); 
		strSql.append(MessageFormat.format("HANDLER_SEL_TYPE={0},", model.getHANDLER_SEL_TYPE()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_INTERVAL={0},", model.getACTIVITY_INTERVAL()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_PROPERTY={0},", model.getACTIVITY_PROPERTY()+"")); 
		strSql.append(MessageFormat.format("RELATION_NODE={0},", model.getRELATION_NODE()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_LEFT={0},", model.getACTIVITY_LEFT()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_TOP={0},", model.getACTIVITY_TOP()+"")); 
		strSql.append(MessageFormat.format("ACTIVITY_ICON={0}", "'"+model.getACTIVITY_ICON()+"'"));
		strSql.append(MessageFormat.format(" where ACTIVITY_ID={0} ", model.getACTIVITY_ID()+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}


	/// <summary>
	/// 删除一条数据
	/// </summary>
	public void Delete(int ACTIVITY_ID) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("delete from wf_activity ");
		strSql.append(MessageFormat.format(" where ACTIVITY_ID={0} ",  ACTIVITY_ID+""));
		jdbcTemplate_workflow.update(strSql.toString());
	}
	/// <summary>
	/// 得到一个对象实体
	/// </summary>
	public cn.zup.workflow.model.WF_ACTIVITY GetModel(int ACTIVITY_ID) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,FLOW_ID,FORM_ID,ACTIVITY_CODE,ACTIVITY_NAME,ACTIVITY_TYPE,NEXT_ACTIVITY_CODE,SUB_FLOW_ID,REVIEW_TYPE,REJECT_ACTIVITY_CODE,BRANCH_SEL_TYPE,HANDLER_SEL_TYPE,ACTIVITY_INTERVAL,ACTIVITY_PROPERTY,RELATION_NODE,ACTIVITY_LEFT,ACTIVITY_TOP,ACTIVITY_ICON from WF_ACTIVITY  ");
		strSql.append(" where ACTIVITY_ID="+ACTIVITY_ID);
		
		cn.zup.workflow.model.WF_ACTIVITY model = jdbcTemplate_workflow.query(strSql.toString(), new ResultSetExtractor<cn.zup.workflow.model.WF_ACTIVITY>(){

			@Override
			public WF_ACTIVITY extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				cn.zup.workflow.model.WF_ACTIVITY model = null;
				while(rs.next())
					model = ReaderBind(rs);
				return model;
			}
			
		});
		return model;
	}

	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_ACTIVITY> GetListArray(String strWhere) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,FLOW_ID,FORM_ID,ACTIVITY_CODE,ACTIVITY_NAME,ACTIVITY_TYPE,NEXT_ACTIVITY_CODE,SUB_FLOW_ID,REVIEW_TYPE,REJECT_ACTIVITY_CODE,BRANCH_SEL_TYPE,HANDLER_SEL_TYPE,ACTIVITY_INTERVAL,ACTIVITY_PROPERTY,RELATION_NODE,ACTIVITY_LEFT,ACTIVITY_TOP,ACTIVITY_ICON ");
		strSql.append(" FROM WF_ACTIVITY ");
		if(strWhere.trim()!="")
		{
			strSql.append(" where "+strWhere);
		}
		strSql.append(" order by ACTIVITY_TYPE");
		System.err.println(strSql.toString());
		List<cn.zup.workflow.model.WF_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<List<cn.zup.workflow.model.WF_ACTIVITY>>(){
					@Override
					public List<WF_ACTIVITY> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						List<WF_ACTIVITY> list = new ArrayList<WF_ACTIVITY>();
						while(rs.next()){
							list.add(ReaderBind(rs));
						}
						return list;
					}
			
		});
		return list;
	}
	
	/** 
	 获取工作流程第一个节点的活动id
	 @author 谢炎
	 @date 2016-12-2 16:42:28
	 @param flowId
	 @return 
	 * @throws SQLException 
	*/
	public cn.zup.workflow.model.WF_ACTIVITY getFirstActivitys(String strWhere) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,FLOW_ID,FORM_ID,ACTIVITY_CODE,ACTIVITY_NAME,ACTIVITY_TYPE,NEXT_ACTIVITY_CODE,SUB_FLOW_ID,REVIEW_TYPE,REJECT_ACTIVITY_CODE,BRANCH_SEL_TYPE,HANDLER_SEL_TYPE,ACTIVITY_INTERVAL,ACTIVITY_PROPERTY,RELATION_NODE,ACTIVITY_LEFT,ACTIVITY_TOP,ACTIVITY_ICON ");
		strSql.append(" FROM WF_ACTIVITY  where ACTIVITY_TYPE = 1 ");
		if(strWhere.trim()!="")
		{
			strSql.append(" and "+strWhere);
		}
		cn.zup.workflow.model.WF_ACTIVITY activity = jdbcTemplate_workflow.query(strSql.toString(), 
				new ResultSetExtractor<cn.zup.workflow.model.WF_ACTIVITY>(){

			@Override
			public WF_ACTIVITY extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				WF_ACTIVITY model = null;
				while(rs.next())
					model = ReaderBind(rs);
				return model;
			}
			
		});
		return activity;
	}
	
	/// <summary>
	/// 获得数据列
	/// </summary>
	public List<cn.zup.workflow.model.WF_ACTIVITY> GetListArrayTran(String strWhere) throws SQLException
	{
		StringBuffer strSql=new StringBuffer();
		strSql.append("select ACTIVITY_ID,FLOW_ID,FORM_ID,ACTIVITY_CODE,ACTIVITY_NAME,ACTIVITY_TYPE,NEXT_ACTIVITY_CODE,SUB_FLOW_ID,REVIEW_TYPE,REJECT_ACTIVITY_CODE,BRANCH_SEL_TYPE,HANDLER_SEL_TYPE,ACTIVITY_INTERVAL,ACTIVITY_PROPERTY,RELATION_NODE,ACTIVITY_LEFT,ACTIVITY_TOP,ACTIVITY_ICON ");
		strSql.append(" FROM WF_ACTIVITY for update ");
		if(strWhere.trim()!="")
		{
			strSql.append(" where "+strWhere);
		}
		List<cn.zup.workflow.model.WF_ACTIVITY> list = jdbcTemplate_workflow.query(strSql.toString(), 
				new RowMapper<cn.zup.workflow.model.WF_ACTIVITY>(){

			@Override
			public cn.zup.workflow.model.WF_ACTIVITY mapRow(ResultSet rs, int arg1) throws SQLException {
				return ReaderBind(rs);
			}
			
		});
		return list;
	}

	/// <summary>
	/// 对象实体绑定数据
	/// </summary>
	public cn.zup.workflow.model.WF_ACTIVITY ReaderBind(ResultSet rs) throws SQLException{
		
		cn.zup.workflow.model.WF_ACTIVITY model=new cn.zup.workflow.model.WF_ACTIVITY();
		model.setACTIVITY_ID(rs.getInt("ACTIVITY_ID"));
		model.setFLOW_ID(rs.getInt("FLOW_ID"));
		model.setFORM_ID(rs.getInt("FORM_ID"));
		model.setACTIVITY_CODE(rs.getInt("ACTIVITY_CODE"));
		model.setACTIVITY_NAME(rs.getString("ACTIVITY_NAME"));
		model.setACTIVITY_TYPE(rs.getByte("ACTIVITY_TYPE"));
		model.setNEXT_ACTIVITY_CODE(rs.getString("NEXT_ACTIVITY_CODE"));
		model.setSUB_FLOW_ID(rs.getInt("SUB_FLOW_ID"));
		model.setREVIEW_TYPE(rs.getByte("REVIEW_TYPE"));
		model.setREJECT_ACTIVITY_CODE(rs.getInt("REJECT_ACTIVITY_CODE"));
		model.setBRANCH_SEL_TYPE(rs.getInt("BRANCH_SEL_TYPE"));
		model.setHANDLER_SEL_TYPE(rs.getByte("HANDLER_SEL_TYPE"));
		model.setACTIVITY_INTERVAL(rs.getInt("ACTIVITY_INTERVAL"));
		model.setACTIVITY_PROPERTY(rs.getInt("ACTIVITY_PROPERTY"));
		model.setRELATION_NODE(rs.getInt("RELATION_NODE"));	
		model.setACTIVITY_LEFT(rs.getInt("ACTIVITY_LEFT"));
		model.setACTIVITY_TOP(rs.getInt("ACTIVITY_TOP"));	
		model.setACTIVITY_ICON(rs.getString("ACTIVITY_ICON"));
		return model;
	}
	

}

