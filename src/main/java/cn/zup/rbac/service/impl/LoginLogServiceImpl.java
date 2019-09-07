package cn.zup.rbac.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.LoginLogDao;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.service.LoginLogService;
import cn.zup.rbac.service.settings.ConfigSetting;
@Service("loginLogService")
public class LoginLogServiceImpl implements LoginLogService {
	@Autowired
	private LoginLogDao loginlogdao;
	public void addLoginLog(LoginLog loginLog) {
		loginlogdao.saveByHiber(loginLog);		
	}
	public MiniDaoPage<LoginLog> getLoginLogPagingList(LoginLog loginLog, int page, int rows) {
		loginLog.setLogTypeConfig(ConfigSetting.LoginLogType.getValue());
		return	 loginlogdao.getLoginLogPagingList(loginLog,page, rows);
		
	}
	
	public List<Config> getLoginLogResult(LoginLog loginLog){
		List<Config> list = loginlogdao.getLoginLogResult(loginLog);
		return list;
	}
}
