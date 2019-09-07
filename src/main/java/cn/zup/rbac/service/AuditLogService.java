package cn.zup.rbac.service;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.AuditLog;

/**
 * 设计日志服务层
 * @author Andot
 * 
 * */
public interface AuditLogService {
	
	/**
	 * 添加审计日志
	 * @author Andot
	 * @date 2018-1-23 10:43:39
	 * 
	 */
	void addAuditLog(AuditLog auditLog);
	
	/**
	 * 获取审计日志列表
	 * 
	 * */
	MiniDaoPage<AuditLog> getAuditLogList(AuditLog auditLog, Integer page, Integer rows);
	
}
