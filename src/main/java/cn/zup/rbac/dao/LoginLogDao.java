package cn.zup.rbac.dao;

import java.util.Date;
import java.util.List;


import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.LoginLog;

@MiniDao
public interface LoginLogDao extends MiniDaoSupportHiber<LoginLog> {
	@Arguments({ "loginLog","page", "rows" })
	@ResultType(LoginLog.class)
	public MiniDaoPage<LoginLog> getLoginLogPagingList(LoginLog loginLog,int page, int rows);
	
	@Arguments({ "loginLog"})
	@ResultType(Config.class)
	public List<Config> getLoginLogResult(LoginLog loginLog);
}