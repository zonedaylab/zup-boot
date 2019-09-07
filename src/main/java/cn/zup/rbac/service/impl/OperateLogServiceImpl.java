package cn.zup.rbac.service.impl;


import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.zup.rbac.dao.OperateLogDao;
import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.service.OperateLogService;
@Service("operateLogService")
public class OperateLogServiceImpl implements OperateLogService {

	@Autowired
	private OperateLogDao operatelogDao;
	
	public void addOperateLog(OperateLog operateLog) {
		operatelogDao.saveByHiber(operateLog);
	}

	public MiniDaoPage<OperateLog> getOperateLogPagingList(OperateLog operatelog, int page,int rows) {
		MiniDaoPage<OperateLog> operatelogpage = operatelogDao.getOperateLogPagingList(operatelog, page, rows);
		return operatelogpage;
	}
}
