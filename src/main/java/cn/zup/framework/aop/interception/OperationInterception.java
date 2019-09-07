package cn.zup.framework.aop.interception;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.zup.framework.aop.service.SysLog;
import cn.zup.wechat.util.GlobalConstants;

/**
 * AOP拦截用户操作记录
 * @author Andot
 * @date 2017-12-14 22:49:54
 * 
 * */
@Aspect
@Component
public class OperationInterception {
	
	@Autowired
	private SysLog sysLog;
	
	private String debug = GlobalConstants.getString("debug");
	
	/**
	 * 打印zup Service 的操作日志
	 * @throws Throwable 
	 * 
	 * */
	@Around("execution(* cn.zup.*.service.impl.*.*(..))")
	public Object doBaseProfilingByPmsCon(ProceedingJoinPoint pjp) throws Throwable{
		StringBuffer logstr = new StringBuffer();
		logstr.append(" 操作层级: Service 层; ");
		String argsStr =  "";
		for (Object o : pjp.getArgs()) {
			argsStr += o + " ,";
		}
		logstr.append(" 操作方法: "+pjp.getSignature()+"; 操作参数: " + argsStr);
		Object obj = new Object();
		try {
			obj = pjp.proceed();
		} catch (Throwable e) {
			logstr.append("; 操作异常详细信息: " + e.getMessage());
			if(debug.equals("yes"))
				sysLog.addErrorLog(logstr.toString(), "");
			throw e;
		}
		if(debug.equals("yes"))
			sysLog.addInfoLog(logstr.toString(), "");
		return obj;
	}
	
	/**
	 * 打印 PMS 所有 的操作日志
	 * @throws Throwable 
	 * 
	 * */
	@Around("execution(* cn.*.service.impl.*.*(..))")
	public Object allPmsSerMethodOper(ProceedingJoinPoint pjp) throws Throwable{
		StringBuffer logstr = new StringBuffer();
		logstr.append(" 操作层级: Service 层; ");
		String argsStr =  "";
		for (Object o : pjp.getArgs()) {
			argsStr += o + " ,";
		}
		logstr.append(" 操作方法: "+pjp.getSignature()+"; 操作参数: " + argsStr);
		Object obj = new Object();
		try {
			obj = pjp.proceed();
		} catch (Throwable e) {
    		/*ByteArrayOutputStream baos = new ByteArrayOutputStream(); 
			e.printStackTrace(new PrintStream(baos)); 
			String exception = baos.toString(); 
			exception.substring(0, 500).replace("\n", ";").replace(")", "]").replace("(", "[").replace(" ", "")*/
			logstr.append("; 操作异常详细信息: " + e.getMessage());
			if(debug.equals("yes"))
				sysLog.addErrorLog(logstr.toString(), "");
			throw e;
		}
		if(debug.equals("yes"))
			sysLog.addInfoLog(logstr.toString(), "");
		return obj;
	}
}
