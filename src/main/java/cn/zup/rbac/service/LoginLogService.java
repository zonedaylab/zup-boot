package cn.zup.rbac.service;

import java.util.Date;
import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.LoginLog;

public interface LoginLogService {
	 /**
		 * 添加登录日志
		 *
		 * @param loginLog
		 * 登陆日志
		 */
		 void addLoginLog(LoginLog loginLog);
		
		 /**
		 * 根据参数获取登录日志
		 *
		 * @param roleName
		 * 角色名称
		 * @param roleType
		 * 角色类型，可为空
		 * @param pageSize
		 * 分页行数
		 * @param pageination
		 * 页码
		 * @return
		 */
	MiniDaoPage<LoginLog> getLoginLogPagingList(LoginLog loginlog, int page, int rows);
	
	/**
	 * 获取登录状态
	 * @param loginLog
	 * @return
	 */
	List<Config> getLoginLogResult(LoginLog loginLog);
}