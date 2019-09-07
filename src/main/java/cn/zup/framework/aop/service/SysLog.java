package cn.zup.framework.aop.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.OperateLogService;
import cn.zup.rbac.service.settings.OperateLogType;
import net.sf.json.JSONObject;

/**
 * 业务操作日志公用存储方法
 * OperateLogCommonByBus
 * */
@Component
public class SysLog {
	
	@Resource
	private OperateLogService operateLogService;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private static Logger log = Logger.getLogger(BusLog.class);
	
	private static boolean debug = false;
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 添加错误日志
	 * @author Andot
	 * @date 2017-12-18
	 * @param 
	 * 		logInfo 错误具体详细信息，什么方法传入什么参数，错误原因，具体修改原因   多条信息请用分号分割开
	 * 		sql     如果是Dao层，就把Sql语句传进来，没有就穿空字符串
	 * */
	@SuppressWarnings("unused")
	public void addErrorLog(String logInfo, String sql){
		OperateLog operateLog = new OperateLog();
		try{
			ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
			HttpSession session = attr.getRequest().getSession(true);
			UserSession us = (UserSession)session.getAttribute("usersession");
			//打印基本操作日志信息
			if(us != null){
				operateLog.setSystemId(us.getSystemId());
				operateLog.setUserId(us.getUserId());
				operateLog.setUserName(us.getRealName());
			}else{
				operateLog.setUserName("没有登录");
			}
		}catch(Exception e){
			operateLog.setUserName("RequestContextHolder.currentRequestAttributes() 不存在,"+e.getMessage());
		}
		operateLog.setLogDate(new Date());
		operateLog.setLogInfo(logInfo);
		operateLog.setLogLevel(OperateLogType.error.getValue());
		operateLog.setLogSql(sql);
		this.addOperateLog(operateLog);
		JSONObject json = new JSONObject();
		json.put("error-dataInfo", operateLog);
		if(debug)
			log.error(json.toString());
	}
	
	/**
	 * 添加监控日志
	 * @author Andot
	 * @date 2017-12-18
	 * @param 
	 * 		logInfo 用户操作具体详细信息，什么方法传入什么参数，是增删改查 增删改查了什么   多条信息请用分号分割开
	 * 		sql     如果是Dao层，就把Sql语句传进来，没有就穿空字符串
	 * */
	@SuppressWarnings("unused")
	public void addInfoLog(String logInfo, String sql){
		OperateLog operateLog = new OperateLog();
		try{
			ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
			HttpSession session = attr.getRequest().getSession(true);
			UserSession us = (UserSession)session.getAttribute("usersession");
			//打印基本操作日志信息
			if(us != null){
				operateLog.setSystemId(us.getSystemId());
				operateLog.setUserId(us.getUserId());
				operateLog.setUserName(us.getRealName());
			}else{
				operateLog.setUserName("没有登录");
			}
		}catch(Exception e){
			operateLog.setUserName("RequestContextHolder.currentRequestAttributes() 不存在, "+e.getMessage());
		}
		operateLog.setLogDate(new Date());
		operateLog.setLogInfo(logInfo);
		operateLog.setLogLevel(OperateLogType.info.getValue());
		operateLog.setLogSql(sql);
		this.addOperateLog(operateLog);
		JSONObject json = new JSONObject();
		json.put("info-dataInfo", operateLog);
		if(debug)
			log.info(json.toString());
	}
	
	/**
	 * 如果是在开发时期，存储日志的时候也打印日志到控制台，请添加日志时先调用此方法
	 * @author Andot
	 * @date 2017-12-18
	 * 
	 * */
	public void debug(){
		debug = true;
	}
	
	@Transactional(readOnly=false)
	private void addOperateLog(OperateLog operatelog) {
		final List<Object> args = new ArrayList<Object>();
		final StringBuffer strSql = new StringBuffer();
		StringBuffer strSqlCol = new StringBuffer();
		StringBuffer strSqlColVal = new StringBuffer();
		strSql.append("insert into operatelog ");
		strSqlCol.append("(");
		strSqlColVal.append("(");
		if(operatelog.getLogDate() != null){
			strSqlCol.append(" logDate, ");
			strSqlColVal.append("?,");
			args.add(sdf.format(operatelog.getLogDate()));
		}
		if(operatelog.getLogInfo() != null){
			strSqlCol.append(" logInfo, ");
			strSqlColVal.append("?,");
			args.add(operatelog.getLogInfo());
		}
		if(operatelog.getSystemId() != null){
			strSqlCol.append(" systemId, ");
			strSqlColVal.append("?,");
			args.add(operatelog.getSystemId());
		}
		if(operatelog.getLogSql() != null){
			strSqlCol.append(" logSql, ");
			strSqlColVal.append("?,");
			args.add(operatelog.getLogSql());
		}
		if(operatelog.getPageName() != null){
			strSqlCol.append(" pageName, ");
			strSqlColVal.append("?,");
			args.add(operatelog.getPageName());
		}
		if(operatelog.getUserId() != null){
			strSqlCol.append(" userId, ");
			strSqlColVal.append("?,");
			args.add(operatelog.getUserId());
		}
		if(operatelog.getLogLevel() != null){
			strSqlCol.append(" logLevel ");
			strSqlColVal.append("?");
			args.add(operatelog.getLogLevel() != null);
		}
		strSqlCol.append(")");
		strSqlColVal.append(")");
		strSql.append(strSqlCol.toString() + "values ");
		strSql.append(strSqlColVal.toString());
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try {
			jdbcTemplate.update(new PreparedStatementCreator() {
				@Override
				public PreparedStatement createPreparedStatement(Connection connection)throws SQLException {
					PreparedStatement ps = connection.prepareStatement(strSql.toString(),PreparedStatement.RETURN_GENERATED_KEYS);
					for(int i=0;i<args.size();i++){
						ps.setObject(i+1, args.get(i));	
					}
					return ps;
				}
			 },keyHolder);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
