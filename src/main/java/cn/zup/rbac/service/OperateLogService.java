package cn.zup.rbac.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.OperateLog;
public interface OperateLogService {
	 /**
	 * 添加操作日志,操作日志对象
	 * @param operateLog
	 */	
	 public void addOperateLog(OperateLog operateLog);
	
	 /**
	 * 根据参数获取操作日志
	 *
	 * @param userName
	 * 名称用户
	 * @param startLogDateTime
	 * 记录时间
	 * @param systemID
	 * 系统id
	 * @param pageSize
	 * 分页行数
	 * @param pageination
	 * 页码
	 * @return
	 */
	
	 MiniDaoPage<OperateLog> getOperateLogPagingList(OperateLog operatelog, int page, int rows);

}