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

import cn.zup.rbac.service.settings.ValigFlag;
import cn.zup.wechat.dao.WechatServiceDao;
import cn.zup.wechat.entity.WechatServer;

@Repository
public class WechatServiceDaoImpl implements WechatServiceDao {
	@Autowired
	private JdbcTemplate jdbcTemplate_wechat;
	
	private static Logger logger = Logger.getLogger(WechatServiceDaoImpl.class);
			
	/*
	 * 增加数据      
	 * @see cn.zup.wechat.dao.WechatServiceDao#addWechatService(cn.zup.wechat.entity.WechatServer)
	 */
	@Override
	public Integer addWechatService(WechatServer ws) {
		int i;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("INSERT INTO wechat_server (SERVICE_NAME,SERVICE_ACCOUNT,APPID,APPSECRET,ORIGINAL_ID,VALIDFLAG,TOKEN_NAME)");
		sbSql.append(" VALUES(?,?,?,?,?,?,?)");
		Object[] args = {ws.getService_Name(),ws.getService_Account(),ws.getAppid(),ws.getAppsecret(),ws.getOriginal_ID(),ws.getValidFlag(),ws.getToken_Name()};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args);
			i= 1;
			return i;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
			return i;
		}
	}
	/*
	 * 删除数据
	 * @see cn.zup.wechat.dao.WechatServiceDao#deleteWechatService(cn.zup.wechat.entity.WechatServer)
	 */
	@Override
	public Integer deleteWechatService(WechatServer ws) {
		int i;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("DELETE FROM wechat_server WHERE SERVICE_ID=?");
		Object[] args = {ws.getService_ID()};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args);
			i=1;
			return 1;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
			return i;
		}
	}
	/*
	 * 更新数据
	 * @see cn.zup.wechat.dao.WechatServiceDao#updateWechatService(cn.zup.wechat.entity.WechatServer)
	 */
	@Override
	public Integer updateWechatService(WechatServer ws) {
		int i ; 
		StringBuffer sbSql = new StringBuffer();
		List<Object> args = new ArrayList<Object>();
		sbSql.append("UPDATE wechat_server");
		sbSql.append(" SET VALIDFLAG= ?");
		args.add(ws.getValidFlag());
		if(ws.getService_Account() != null){
			sbSql.append(" ,SERVICE_ACCOUNT=?");
			args.add(ws.getService_Account());
		}
		if(ws.getAppid() != null){
			sbSql.append(" ,APPID=?");
			args.add(ws.getAppid());
		}
		if(ws.getAppsecret() != null){
			sbSql.append(" ,APPSECRET=?");
			args.add(ws.getAppsecret());
		}
		if(ws.getOriginal_ID() != null){
			sbSql.append(",ORIGINAL_ID=?");
			args.add(ws.getOriginal_ID());
		}
		if(ws.getService_Name() != null){
			sbSql.append(",SERVICE_NAME=?");
			args.add(ws.getService_Name());
		}
		if(ws.getToken_Name() != null){
			sbSql.append(",TOKEN_NAME=?");
			args.add(ws.getToken_Name());
		}
		sbSql.append(" WHERE SERVICE_ID=?");
		args.add(ws.getService_ID());
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args.toArray());
			i=1;
			return i;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
			return i;
		}
	}

	
	@Override
	public MiniDaoPage<WechatServer> getWechatServiceList(WechatServer ws,
			Integer rows, Integer page) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select ws.SERVICE_ID,ws.SERVICE_NAME,ws.SERVICE_ACCOUNT,ws.APPID,ws.APPSECRET,ws.ORIGINAL_ID,");
		sbSql.append(" ws.TOKEN_NAME,configvf.SUBNAME validFlagStr from wechat_server ws  ");
		sbSql.append(" join config configvf on  ws.VALIDFLAG = configvf.SUBID ");
		sbSql.append(" where 1=1  and configvf.CONFIGID = "+ws.getValidFlagStr());
		
		if (ws.getService_Name() != null)
			sbSql.append(" and ws.SERVICE_NAME like '%"+ws.getService_Name()+"%'");
		if (ws.getService_Account() != null)
			sbSql.append(" and ws.SERVICE_ACCOUNT like '%"+ws.getService_Account()+"%'");
		if (ws.getValidFlag() != null)
			sbSql.append(" and ws.VALIDFLAG = "+ ws.getValidFlag());
		
		Integer total = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			int totalAmount = 0;
			while(rs.next()){			
				totalAmount++;
			}	
			return totalAmount;
		});
		String sql = "SELECT *  FROM ( " +  sbSql +" ) table_alias LIMIT "+ ((page-1)*rows) +" , "+rows ;

		logger.info("getWechatServiceList===>"+ sql);
		List<WechatServer> result = jdbcTemplate_wechat.query(sql, (rs) -> {
			List<WechatServer> list = new ArrayList<WechatServer>();
			while(rs.next()){
				list.add(bindData(rs));
			}
			return list;
		});
		MiniDaoPage<WechatServer> minipage = new MiniDaoPage<WechatServer>();
		minipage.setPage(page);
		minipage.setResults(result);
		minipage.setRows(rows);
		minipage.setTotal(total);
		return minipage;
	}
	
	@Override
	public WechatServer getWechatService(WechatServer ws) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select SERVICE_ID,SERVICE_NAME,SERVICE_ACCOUNT,APPID,APPSECRET,ORIGINAL_ID,VALIDFLAG,TOKEN_NAME");
		sbSql.append(" from wechat_server where 1=1 ");
		if(ws.getService_ID() != null)
			sbSql.append(" and SERVICE_ID = "+ws.getService_ID());
		if(ws.getOriginal_ID() != null) {
			sbSql.append(" and ORIGINAL_ID = '" + ws.getOriginal_ID()+"'");
		}
		if(ws.getValidFlag() != null) {
			sbSql.append(" and VALIDFLAG = " + ws.getValidFlag());
		}
		if(ws.getService_Name() != null) {
			sbSql.append(" and SERVICE_NAME = '" + ws.getService_Name()+"'");
		}
		if(ws.getService_Account() != null) {
			sbSql.append(" and SERVICE_ACCOUNT = '" + ws.getService_Account()+"'");
		}
		if(ws.getToken_Name() != null) {
			sbSql.append(" and TOKEN_NAME = '" + ws.getToken_Name()+"'");
		}
		logger.info("getWechatService===>"+ sbSql.toString());
		WechatServer result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			WechatServer wechatServer = new WechatServer();
			while(rs.next()){
				wechatServer.setService_ID(rs.getInt("SERVICE_ID"));
				wechatServer.setService_Name(rs.getString("SERVICE_NAME"));
				wechatServer.setService_Account(rs.getString("SERVICE_ACCOUNT"));
				wechatServer.setAppid(rs.getString("APPID"));
				wechatServer.setAppsecret(rs.getString("APPSECRET"));
				wechatServer.setOriginal_ID(rs.getString("ORIGINAL_ID"));
				wechatServer.setToken_Name(rs.getString("TOKEN_NAME"));
				wechatServer.setValidFlag(rs.getInt("VALIDFLAG"));
			}
			return wechatServer;
		});
		return result;
	}

	@Override
	public List<WechatServer> getWechatServiceList(WechatServer wechatServer) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select ws.SERVICE_ID,ws.SERVICE_NAME,ws.SERVICE_ACCOUNT,ws.APPID,ws.APPSECRET,ws.ORIGINAL_ID,ws.VALIDFLAG,ws.TOKEN_NAME");
		sbSql.append(" from wechat_server ws ");
		if(wechatServer.getSystem_Id() != null) {
			sbSql.append(" LEFT JOIN wechat_system wsys ON ws.SERVICE_ID = wsys.SERVICE_ID ");
		}
		sbSql.append(" where 1=1 ");
		if(wechatServer.getSystem_Id() != null) {
			sbSql.append(" AND wsys.SYSTEM_ID  IN (" + wechatServer.getSystem_Id() + ") ");
		}
		if(wechatServer.getService_ID() != null)
			sbSql.append(" AND ws.SERVICE_ID = "+wechatServer.getService_ID());
		if(wechatServer.getOriginal_ID() != null) {
			sbSql.append(" AND ws.ORIGINAL_ID = '" + wechatServer.getOriginal_ID()+"'");
		}
		if(wechatServer.getValidFlag() != null) {
			sbSql.append(" AND ws.VALIDFLAG = " + wechatServer.getValidFlag());
		}
		if(wechatServer.getService_Name() != null) {
			sbSql.append(" AND ws.SERVICE_NAME = '" + wechatServer.getService_Name()+"'");
		}
		if(wechatServer.getService_Account() != null) {
			sbSql.append(" AND ws.SERVICE_ACCOUNT = '" + wechatServer.getService_Account()+"'");
		}
		if(wechatServer.getToken_Name() != null) {
			sbSql.append(" AND ws.TOKEN_NAME = '" + wechatServer.getToken_Name()+"'");
		}
		logger.info("getWechatService===>"+ sbSql.toString());
		List<WechatServer> list = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<WechatServer> wechatServerList = new ArrayList<WechatServer>();
			while(rs.next()){
				WechatServer ws = new WechatServer();
				ws.setService_ID(rs.getInt("SERVICE_ID"));
				ws.setService_Name(rs.getString("SERVICE_NAME"));
				ws.setService_Account(rs.getString("SERVICE_ACCOUNT"));
				ws.setAppid(rs.getString("APPID"));
				ws.setAppsecret(rs.getString("APPSECRET"));
				ws.setOriginal_ID(rs.getString("ORIGINAL_ID"));
				ws.setToken_Name(rs.getString("TOKEN_NAME"));
				ws.setValidFlag(rs.getInt("VALIDFLAG"));
				wechatServerList.add(ws);
			}
			return wechatServerList;
		});
		return list;
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
		ws.setValidFlagStr(rs.getString("validFlagStr"));
		return ws;
	}
	
}
