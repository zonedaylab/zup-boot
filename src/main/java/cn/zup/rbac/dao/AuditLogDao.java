package cn.zup.rbac.dao;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.AuditLog;

@MiniDao
public interface AuditLogDao extends MiniDaoSupportHiber<AuditLog>{
	@Arguments({"auditLog", "page", "rows"})
	@ResultType(AuditLog.class)
	public MiniDaoPage<AuditLog> getAuditLogList(AuditLog auditLog, Integer page, Integer rows);
}
