package cn.zup.rbac.dao;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.entity.Post;

@MiniDao
public interface OperateLogDao extends MiniDaoSupportHiber<OperateLog>  {
	
	@Arguments({ "operatelog", "page", "rows" })
	@ResultType(OperateLog.class)
	public MiniDaoPage<OperateLog> getOperateLogPagingList(OperateLog operatelog, int page, int rows);
	
}
