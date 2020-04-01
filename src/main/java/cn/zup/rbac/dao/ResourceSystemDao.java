package cn.zup.rbac.dao;

import cn.zup.rbac.entity.System;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.util.List;

@MiniDao
public interface ResourceSystemDao extends MiniDaoSupportHiber<System> {
	@Arguments({"systemId","systemName"})
	List<System> getSystemRepeatVerify(Integer systemId, String systemName);
	@Arguments("systemId")
	List<System> getSystemSonTable(Integer systemId);
	@Arguments({"systemId","validFlag"})
	System getSystemInfo(int systemId, int validFlag);
	@Arguments("validFlag")
	List<System> getSystemList(int validFlag);
	@Arguments({"systemTemp","validFlag"})
	List<System> getSystem(System systemTemp, int validFlag);	
}
