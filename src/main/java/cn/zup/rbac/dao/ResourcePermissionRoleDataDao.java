package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.rbac.entity.Action;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.MenuPermission;
import cn.zup.rbac.entity.RoleAction;
import cn.zup.rbac.entity.RoleData;
import cn.zup.rbac.entity.RoleMenu;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.service.settings.DataPermissionType;

@MiniDao
public interface ResourcePermissionRoleDataDao extends MiniDaoSupportHiber<RoleData> {
	@Arguments({"account","menu","type"})
	List<RoleData> getaccountDataPermissionList(int account, int menu,	DataPermissionType type);
	@Arguments("role")
	List<RoleData> getRoleDataPermissionList(int role);
	@Arguments({"role","menu"})
	List<RoleData> getmenuDataPermissionList(int menu, int role);

	
	

}
