package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.rbac.entity.Action;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.MenuPermission;
import cn.zup.rbac.entity.RoleAction;
import cn.zup.rbac.entity.RoleMenu;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.UserInfo;

@MiniDao
public interface ResourcePermissionRoleActionDao extends MiniDaoSupportHiber<RoleAction> {
	@Arguments({"role","action"})
	List<RoleAction> getactionPermissionInfo(int role, int action);
	@Arguments({"actionId"})
	List<RoleAction> getRoleActionFromAction(int actionId);

}
