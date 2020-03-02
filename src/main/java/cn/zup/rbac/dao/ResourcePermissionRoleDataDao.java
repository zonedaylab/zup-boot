package cn.zup.rbac.dao;

import cn.zup.rbac.entity.RoleData;
import cn.zup.rbac.service.settings.DataPermissionType;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.util.List;

@MiniDao
public interface ResourcePermissionRoleDataDao extends MiniDaoSupportHiber<RoleData> {
	@Arguments({"account","menu","type"})
	List<RoleData> getaccountDataPermissionList(int account, int menu, DataPermissionType type);
	@Arguments("role")
	List<RoleData> getRoleDataPermissionList(int role);
	@Arguments({"role","menu"})
	List<RoleData> getmenuDataPermissionList(int menu, int role);

	
	

}
