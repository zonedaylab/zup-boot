package cn.zup.rbac.service.impl;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.AuditLogDao;
import cn.zup.rbac.entity.AuditLog;
import cn.zup.rbac.service.AuditLogService;
@Service("auditLogService")
public class AuditLogServiceImpl implements AuditLogService {

	@Autowired
	private AuditLogDao auditLogDao;
	
	@Override
	public void addAuditLog(AuditLog auditLog) {
		auditLogDao.saveByHiber(auditLog);
	}

	@Override
	public MiniDaoPage<AuditLog> getAuditLogList(AuditLog auditLog, Integer page, Integer rows) {
		return auditLogDao.getAuditLogList(auditLog, page, rows);
	}

}
