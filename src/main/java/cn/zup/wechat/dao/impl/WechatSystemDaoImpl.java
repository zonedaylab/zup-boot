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

import cn.zup.wechat.dao.WechatSystemDao;
import cn.zup.wechat.entity.ServerTempView;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;

@Repository
public class WechatSystemDaoImpl implements WechatSystemDao {
	@Autowired
	private JdbcTemplate jdbcTemplate_wechat;

	private static Logger logger = Logger.getLogger(WechatSystemDaoImpl.class);
	
	/*
	 * 增加数据
	 * @see cn.zup.wechat.dao.WechatSystemDao#addSystem(cn.zup.wechat.entity.WechatSystem)
	 */
	@Override
	public int addSystem(WechatSystem wsys) {
		int i;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("INSERT INTO wechat_system (SERVICE_ID,SYSTEM_ID,SYSTEM_URL,REGION_ID,REGION_TYPE,IMG_URL,COMPANY_NAME)");
		sbSql.append(" VALUES (?,?,?,?,?,?,?)");
		Object[] args = {wsys.getService_ID(),wsys.getSystem_Id(),wsys.getSystem_Url(),wsys.getRegion_Id(),wsys.getRegion_Type(),
				wsys.getImg_Url(),wsys.getCompany_Name()};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args);
			i=1;
			return i;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
			return i;
		}
	}
	/*
	 * 删除数据
	 * @see cn.zup.wechat.dao.WechatSystemDao#deleteSystem(cn.zup.wechat.entity.WechatSystem)
	 */
	@Override
	public void deleteSystem(WechatSystem wsys) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("DELETE FROM wechat_system WHERE COMPANY_ID=?");
		Object[] args = {wsys.getCompany_Id()};
		jdbcTemplate_wechat.update(sbSql.toString(),args);
	}
	
	/*
	 * 更新数据
	 * @see cn.zup.wechat.dao.WechatSystemDao#updateSystem(cn.zup.wechat.entity.WechatSystem)
	 */
	@Override
	public int updateSystem(WechatSystem wsys) {
		int i ; 
		StringBuffer sbSql = new StringBuffer();
		List<Object> args = new ArrayList<Object>();
		sbSql.append("UPDATE wechat_system");
		sbSql.append(" SET SYSTEM_ID=?");
		args.add(wsys.getSystem_Id());
		if(wsys.getSystem_Url() != null){
			sbSql.append(" ,SYSTEM_URL=?");
			args.add(wsys.getSystem_Url());
		}
		if(wsys.getRegion_Id() != null){
			sbSql.append(" ,REGION_ID=?");
			args.add(wsys.getRegion_Id());
		}
		if(wsys.getRegion_Id() != null){
			sbSql.append(" ,REGION_TYPE=?");
			args.add(wsys.getRegion_Type());
		}
		if(wsys.getImg_Url() != null){
			sbSql.append(" ,IMG_URL=?");
			args.add(wsys.getImg_Url());
		}
		if(wsys.getCompany_Name() != null){
			sbSql.append(",COMPANY_NAME=?");
			args.add(wsys.getCompany_Name());
		}
		if(wsys.getService_ID() != null){
			sbSql.append(",SERVICE_ID= ?");
			args.add(wsys.getService_ID());
		}
		sbSql.append(" WHERE COMPANY_ID=?");
		args.add(wsys.getCompany_Id());
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
	public List<WechatServer> getAllService() {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select * from wechat_server");
		List<WechatServer> list = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<WechatServer> listWS = new ArrayList<WechatServer>();
			while(rs.next())
				listWS.add(bindData(rs));
			 return listWS;
		});
		return list;
	}

	@Override
	public List<WechatSystem> getAllSystem() {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select SERVICE_ID,SYSTEM_ID,SYSTEM_URL,REGION_ID,IMG_URL,COMPANY_NAME,COMPANY_ID from wechat_system");
		logger.info("getAllSystem===>"+ sbSql.toString());
		List<WechatSystem> list = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<WechatSystem> listWS = new ArrayList<WechatSystem>();
			while(rs.next()){
				WechatSystem entity = new WechatSystem();
				entity.setService_ID(rs.getInt("SERVICE_ID"));
				entity.setSystem_Id(rs.getInt("SYSTEM_ID"));
				entity.setSystem_Url(rs.getString("SYSTEM_URL"));
				entity.setRegion_Id(rs.getInt("REGION_ID"));
				entity.setImg_Url(rs.getString("IMG_URL"));
				entity.setCompany_Name(rs.getString("COMPANY_NAME"));
				entity.setCompany_Id(rs.getInt("COMPANY_ID"));
				listWS.add(entity);
			}
			return listWS;
		});
		return list;
	}

	@Override
	public List<ServerTempView> getServerTemp(WechatSystem wsys) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append(" SELECT ws.APPID,ws.APPSECRET,ws.SERVICE_ID,ws.TOKEN_NAME,ws.VALIDFLAG,");
		sbSql.append(" wt.REQUEST_URL,wt.SKIP_URL,wt.TEMPLATE_ID,wt.TEMP_ID,wt.TOP_COLOR,");
		sbSql.append(" wsys.COMPANY_ID,wsys.IMG_URL,wsys.REGION_ID,wsys.REGION_TYPE,wsys.SYSTEM_ID,wsys.SYSTEM_URL ");
		sbSql.append(" FROM wechat_template wt ");
		sbSql.append(" JOIN wechat_server ws ON wt.SERVICE_ID = ws.SERVICE_ID");
		sbSql.append(" JOIN wechat_system wsys ON ws.SERVICE_ID = wsys.SERVICE_ID");
		sbSql.append(" WHERE 1=1");
		if(wsys.getSystem_Id() != null)
			sbSql.append(" AND wsys.SYSTEM_ID = "+wsys.getSystem_Id());
		if(wsys.getRegion_Id() != null)
			sbSql.append(" AND wsys.REGION_ID = "+wsys.getRegion_Id());
		if(wsys.getRegion_Type() != null)
			sbSql.append(" AND wsys.REGION_TYPE = "+wsys.getRegion_Type());
		if(wsys.getTempId() != null)
			sbSql.append(" AND wt.TEMP_ID = "+wsys.getTempId());
		
		logger.info("getServerTemp===>"+ sbSql.toString());
		List<ServerTempView> result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<ServerTempView> list = new ArrayList<ServerTempView>();
			while(rs.next()){
				ServerTempView stv = new ServerTempView();
				stv.setAppid(rs.getString("APPID"));
				stv.setAppsecret(rs.getString("APPSECRET"));
				stv.setService_Id(rs.getInt("SERVICE_ID"));
				stv.setToken_Name(rs.getString("TOKEN_NAME"));
				stv.setValidFlag(rs.getInt("VALIDFLAG"));
				stv.setRequest_Url(rs.getString("REQUEST_URL"));
				stv.setSkip_Url(rs.getString("SKIP_URL"));
				stv.setTemplate_Id(rs.getString("TEMPLATE_ID"));
				stv.setTemp_Id(rs.getInt("TEMP_ID"));
				stv.setTop_Color(rs.getString("TOP_COLOR"));
				stv.setCompany_Id(rs.getInt("COMPANY_ID"));
				stv.setImg_Url(rs.getString("IMG_URL"));
				stv.setRegion_Id(rs.getInt("REGION_ID"));
				stv.setSystem_Id(rs.getInt("SYSTEM_ID"));
				stv.setSystem_Url(rs.getString("SYSTEM_URL"));
				list.add(stv);
			}
			return list;
		});
		return result;
	}

	@Override
	public WechatSystem getSystemInfo(WechatSystem ws) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select  *  from wechat_system sys where 1=1 ");
		if(ws.getSystem_Id() != null)
			sbSql.append(" and sys.SYSTEM_ID = "+ws.getSystem_Id());
		if(ws.getCompany_Id() != null)
			sbSql.append(" and sys.COMPANY_ID = "+ws.getCompany_Id());
		
		logger.info("getSystemInfo===>"+ sbSql.toString());
		WechatSystem result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			WechatSystem wechatSystem = new WechatSystem();
			while(rs.next()){			
				wechatSystem = readerBind(rs, 0);
			}	
			return wechatSystem;
		});
		return result;
	}

	@Override
	public MiniDaoPage<WechatSystem> getWechatSystemList(WechatSystem wsys,
			Integer rows, Integer page) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select sys.SYSTEM_URL,sys.REGION_ID,sys.REGION_TYPE,sys.IMG_URL,s.SYSTEMNAME SYSTEM_NAME,");
		sbSql.append(" ws.SERVICE_NAME,sys.COMPANY_ID,sys.COMPANY_NAME,sys.SERVICE_ID,sys.SYSTEM_ID  from wechat_system sys ");
		sbSql.append(" JOIN wechat_server ws ON sys.SERVICE_ID = ws.SERVICE_ID ");
		sbSql.append(" JOIN system s ON sys.SYSTEM_ID = s.SYSTEMID where 1=1 ");
		if(wsys.getService_ID() != null)
			sbSql.append(" and sys.SERVICE_ID = "+wsys.getService_ID());
		if(wsys.getSystem_Id() != null)
			sbSql.append(" and sys.SYSTEM_ID = "+wsys.getSystem_Id());
		if(wsys.getCompany_Name() != null)
			sbSql.append(" and sys.COMPANY_NAME like '%"+wsys.getCompany_Name()+"%'");
		if(wsys.getRegion_Id() != null)
			sbSql.append(" and sys.REGION_ID = "+wsys.getRegion_Id());
		logger.info("getWechatSystemList===>"+ sbSql.toString());
		Integer total = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			int totalAmount = 0;
			while(rs.next()){			
				totalAmount++;
			}	
			return totalAmount;
		});
		String sql = "SELECT *  FROM ( " +  sbSql +" ) table_alias LIMIT "+ ((page-1)*rows) +" , "+rows ;

		logger.info("getWechatSystemList===>"+ sql);
		List<WechatSystem> result = jdbcTemplate_wechat.query(sql, (rs) -> {
			List<WechatSystem> list = new ArrayList<WechatSystem>();
			while(rs.next()){
				list.add(readerBind(rs, 1));
			}
			return list;
		});
		MiniDaoPage<WechatSystem> minipage = new MiniDaoPage<WechatSystem>();
		minipage.setPage(page);
		minipage.setResults(result);
		minipage.setRows(rows);
		minipage.setTotal(total);
		return minipage;
	}

	@Override
	public List<WechatSystem> getWechatSystemLists(WechatSystem wechatSystem) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append(" select *  from wechat_system sys where 1=1 ");
		if(wechatSystem.getCompany_Id() != null)
			sbSql.append(" and sys.company_id = "+wechatSystem.getCompany_Id());
		if(wechatSystem.getSystem_Id() != null)
			sbSql.append(" and sys.system_id = "+wechatSystem.getSystem_Id());
		List<WechatSystem> result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<WechatSystem> list = new ArrayList<WechatSystem>();
			while(rs.next()){
				list.add(readerBind(rs, 0));
			}
			return list;
		});
		return result;
	}

	public WechatSystem readerBind(ResultSet rs, int flag) throws SQLException{
		WechatSystem entity=new WechatSystem();
		entity.setService_ID(rs.getInt("service_Id"));
		entity.setSystem_Id(rs.getInt("system_Id"));
		entity.setSystem_Url(rs.getString("system_Url"));
		entity.setRegion_Id(rs.getInt("region_Id"));
		entity.setRegion_Type(rs.getInt("region_Type"));
		entity.setImg_Url(rs.getString("img_Url"));
		entity.setCompany_Name(rs.getString("company_Name"));
		entity.setCompany_Id(rs.getInt("company_Id"));
		if(flag == 1){
			entity.setSystem_Name(rs.getString("SYSTEM_NAME"));
			entity.setService_Name(rs.getString("SERVICE_NAME"));
		}
		return entity;
	}
	
	/**
	 * 数据绑定
	 * 
	 * */
	final private WechatServer bindData(ResultSet rs) throws SQLException{
		WechatServer ws = new WechatServer();
		ws.setService_ID(rs.getInt("SERVICE_ID"));
		ws.setService_Name(rs.getString("SERVICE_NAME"));
		ws.setService_Account(rs.getString("SERVICE_ACCOUNT"));
		ws.setAppid(rs.getString("APPID"));
		ws.setAppsecret(rs.getString("APPSECRET"));
		ws.setOriginal_ID(rs.getString("ORIGINAL_ID"));
		ws.setToken_Name(rs.getString("TOKEN_NAME"));
		return ws;
	}

}
