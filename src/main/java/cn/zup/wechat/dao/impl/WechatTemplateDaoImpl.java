package cn.zup.wechat.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import cn.zup.wechat.dao.WechatTemplateDao;
import cn.zup.wechat.entity.WechatTemplate;

@Repository
public class WechatTemplateDaoImpl implements WechatTemplateDao {

	@Autowired
	private JdbcTemplate jdbcTemplate_wechat;
	
	private static Logger logger = Logger.getLogger(WechatTemplateDaoImpl.class);
	
	/*
	 * 增加数据
	 * @see cn.zup.wechat.dao.WechatTemplateDao#addWechatTemplate(cn.zup.wechat.entity.WechatTemplate)
	 */
	@Override
	public Integer addWechatTemplate(WechatTemplate wt) {
		int i;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("INSERT INTO wechat_template(TEMP_NAME,TEMPLATE_ID,SKIP_URL,REQUEST_URL,TOP_COLOR,SERVICE_ID)");
		sbSql.append("VALUES(?,?,?,?,?,?)");
		Object[] args = {wt.getTemp_NAME(),wt.getTemplate_Id(),wt.getSkip_Url(),wt.getRequest_Url(),wt.getTop_Color(),wt.getService_Id()};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args);
			i=1;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
		}
		return i;
	}
	/*
	 * 删除数据
	 * @see cn.zup.wechat.dao.WechatTemplateDao#deleteWechatTemplate(cn.zup.wechat.entity.WechatTemplate)
	 */
	@Override
	public Integer deleteWechatTemplate(WechatTemplate wt) {
		int i;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("DELETE FROM wechat_template WHERE TEMP_ID=?");
		Object[] args = {wt.getTemp_Id()};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args);
			i=1;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
		}
		return i;
	}
	
	/*
	 * 更新数据
	 * @see cn.zup.wechat.dao.WechatTemplateDao#updateWechatTemplate(cn.zup.wechat.entity.WechatTemplate)
	 */
	@Override
	public Integer updateWechatTemplate(WechatTemplate wt) {
		int i ; 
		StringBuffer sbSql = new StringBuffer();
		List<Object> args = new ArrayList<Object>();
		sbSql.append("UPDATE wechat_template");
		sbSql.append(" SET SERVICE_ID=?");
		args.add(wt.getService_Id());
		if(wt.getTemp_NAME() != null){
			sbSql.append(", TEMP_NAME=?");
			args.add(wt.getTemp_NAME());
		}
		if(wt.getTemplate_Id() != null){
			sbSql.append(",TEMPLATE_ID=?");
			args.add(wt.getTemplate_Id());
		}
		if(wt.getSkip_Url() != null){
			sbSql.append(",SKIP_URL=?");
			args.add(wt.getSkip_Url());
		}
		if(wt.getRequest_Url() != null){
			sbSql.append(",REQUEST_URL=?");
			args.add(wt.getRequest_Url());
		}
		if(wt.getTop_Color() != null){
			sbSql.append(",TOP_COLOR=? ");
			args.add(wt.getTop_Color());
		}
		sbSql.append(" WHERE TEMP_ID=?");
		args.add(wt.getTemp_Id());
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args.toArray());
			i=1;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
		}
		return i;
	}


	@Override
	public WechatTemplate getWechatTemplate(WechatTemplate wt) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append(" select TEMP_ID,TEMP_NAME,TEMPLATE_ID,SKIP_URL,REQUEST_URL,TOP_COLOR,SERVICE_ID from wechat_template ");
		sbSql.append("  where 1=1 ");
		if (wt.getTemp_Id() != null)
			sbSql.append(" and TEMP_ID ="+wt.getTemp_Id());
		if (wt.getTemp_NAME() != null)
			sbSql.append(" and TEMP_NAME like '%"+wt.getTemp_NAME()+"%'");
		
		logger.info("getWechatTemplate===>"+ sbSql.toString());
		WechatTemplate result = jdbcTemplate_wechat.query(sbSql.toString(), rs->{
			WechatTemplate wtresult = new WechatTemplate();
			while(rs.next()){
				wtresult = readerBind(rs, 0);
			}
			return wtresult;
		});
		return result;
	}

	@Override
	public List<WechatTemplate> getWechatTemplateList(WechatTemplate wt) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append(" select TEMP_ID,TEMP_NAME,TEMPLATE_ID,SKIP_URL,REQUEST_URL,TOP_COLOR,SERVICE_ID from wechat_template ");
		sbSql.append("  where 1=1 ");
		if (wt.getTemp_NAME() != null)
			sbSql.append(" and wt.TEMP_NAME like '%"+wt.getTemp_NAME()+"%'");
		if (wt.getService_Id() != null)
			sbSql.append(" and wt.SERVICE_ID = "+ wt.getService_Id());
		
		logger.info("getWechatTemplateList===>"+ sbSql.toString());
		List<WechatTemplate> result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<WechatTemplate> list = new ArrayList<WechatTemplate>();
			while(rs.next()){
				list.add(readerBind(rs, 0));
			}
			return list;
		});
		
		return result;
	}

	@Override
	public MiniDaoPage<WechatTemplate> getWechatTemplateListByPage(
			WechatTemplate wt, Integer rows, Integer page) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select wt.TEMP_ID,wt.TEMP_NAME,wt.TEMPLATE_ID,wt.SKIP_URL,wt.REQUEST_URL,wt.TOP_COLOR, ");
		sbSql.append(" wt.SERVICE_ID ,ws.SERVICE_NAME from wechat_template wt   ");
		sbSql.append(" join wechat_server ws on  wt.SERVICE_ID = ws.SERVICE_ID  ");
		sbSql.append(" where 1=1 ");
		if (wt.getTemp_NAME() != null)
			sbSql.append(" and wt.TEMP_NAME like '%"+wt.getTemp_NAME()+"%'");
		if (wt.getService_Id() != null)
			sbSql.append(" and wt.SERVICE_ID = "+ wt.getService_Id());
		
		Integer total = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			int totalAmount = 0;
			while(rs.next()){			
				totalAmount++;
			}	
			return totalAmount;
		});
		
		String sql = "SELECT *  FROM ( " +  sbSql +" ) table_alias LIMIT "+ ((page-1)*rows) +" , "+rows ;

		logger.info("getWechatTemplateListByPage===>"+ sql);
		List<WechatTemplate> result = jdbcTemplate_wechat.query(sql, (rs) -> {
			List<WechatTemplate> list = new ArrayList<WechatTemplate>();
			while(rs.next()){
				list.add(readerBind(rs, 1));
			}
			return list;
		});
		MiniDaoPage<WechatTemplate> minipage = new MiniDaoPage<WechatTemplate>();
		minipage.setPage(page);
		minipage.setResults(result);
		minipage.setRows(rows);
		minipage.setTotal(total);
		return minipage;
	}
	
	/***
	 * 绑定实体
	 * */
	public WechatTemplate readerBind(ResultSet rs, int flag) throws SQLException{
			WechatTemplate entity = new WechatTemplate();
			entity.setTemp_Id(rs.getInt("temp_Id"));
			entity.setTemp_NAME(rs.getString("temp_Name"));
			entity.setTemplate_Id(rs.getString("template_Id"));
			entity.setSkip_Url(rs.getString("skip_Url"));
			entity.setRequest_Url(rs.getString("request_Url"));
			entity.setTop_Color(rs.getString("top_Color"));
			entity.setService_Id(rs.getInt("service_Id"));
			if(flag == 1)
				entity.setService_Name(rs.getString("SERVICE_NAME"));
			return entity;
	}

}
