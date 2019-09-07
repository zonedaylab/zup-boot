package cn.zup.framework.aop.interception;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.entity.UserSession;

/**
 * 
 * AOP拦截SQL操作记录
 * @author Andot
 * @date 2017-12-14 22:49:14
 * 
 * */
@Aspect
@Component
public class SqlInterception {
	
	private static Logger log = Logger.getLogger(SqlInterception.class);
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * Sql语句监控
	 * @throws Throwable 
	 * 
	 * */
	@SuppressWarnings("unused")
	@Around("execution(* org.springframework.jdbc.core.JdbcTemplate.*(..))")  
    public Object logSqlExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable { 
		StringBuilder logstr = new StringBuilder();  
		Object result = new Object();
		OperateLog operateLog = new OperateLog();
		try{
			ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
			HttpSession session = attr.getRequest().getSession(true);
			UserSession us = (UserSession)session.getAttribute("usersession");
			logstr.append("\n======================================== \n");
			if(us != null){
				logstr.append(" 操作层级: 数据库操作层 \n");
				logstr.append(" 操作人名称: "+us.getRealName()+" \n");
				logstr.append(" 操作人ID: "+us.getUserId()+" \n");
				logstr.append(" 操作时间: "+sdf.format(new Date())+" \n");
				logstr.append(" 所属系统ID: "+us.getSystemId()+" \n");
			}else{
				logstr.append(" 操作层级: 数据库操作层 \n");
				logstr.append(" 操作人名称: 此人没有登录\n");
			}
		}catch(Exception e){
			logstr.append("RequestContextHolder.currentRequestAttributes() 不存在, "+e.getMessage()+"\n");
		}
		try {
        	result = joinPoint.proceed();
        	long startTime = System.currentTimeMillis();  
            logstr.append(" 操作方法: "+joinPoint.getSignature()+" \n");
            long costTime = System.currentTimeMillis() - startTime;  
            String sql = arrayToString(joinPoint.getArgs());
            if (costTime > (2 * 60 * 1000L)) {  
                logstr.append(" 操作SQL花费时间：: " + costTime + " ms \n");
            } else if (log.isInfoEnabled()) {  
                logstr.append(" 操作SQL花费时间：: " + costTime + " ms \n");
            }
            if(sql.indexOf("update") != -1){
            	logstr.append(" 操作方式：: 更新信息 \n");
            }else if(sql.indexOf("select") != -1){
            	logstr.append(" 操作方式：: 查询信息 \n");
            }else if(sql.indexOf("delete") != -1){
            	logstr.append(" 操作方式：: 删除信息 \n");
            }else if(sql.indexOf("insert") != -1){
            	logstr.append(" 操作方式：: 插入信息 \n");
            }
        	logstr.append(" 操作SQL：: " + sql + " \n");
        	logstr.append(" 操作日志等级: info \n");
		} catch (Throwable e) {
			ByteArrayOutputStream baos = new ByteArrayOutputStream(); 
			e.printStackTrace(new PrintStream(baos)); 
			String exception = baos.toString(); 
			logstr.append("操作异常详细信息: " + exception + "\n");
			logstr.append(" 操作日志等级: error \n");
			throw e;
		}
        logstr.append("======================================== \n");
        log.info(logstr);
        return result;  
    }   
	
    private static String arrayToString(Object[] a) {  
        if (a == null)  
            return "null";  
  
        int iMax = a.length - 1;  
        if (iMax == -1)  
            return "[]";  
  
        StringBuilder b = new StringBuilder();  
        b.append('[');  
        for (int i = 0;; i++) {  
            if (a[i] instanceof Object[]) {  
                b.append(arrayToString((Object[]) a[i]));  
            } else {  
                b.append(String.valueOf(a[i]));  
            }  
            if (i == iMax)  
                return b.append(']').toString();  
            b.append(", ");  
        }  
    }
	
}
