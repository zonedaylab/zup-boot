package cn.zup.rbac.dao;

import cn.zup.rbac.entity.ActionPermission;
import cn.zup.rbac.entity.MenuPermission;
import cn.zup.rbac.entity.RoleMenu;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.util.List;

@MiniDao
public interface ResourcePermissionDao extends MiniDaoSupportHiber<RoleMenu> {
	@Arguments({"role","menu"})
	List<RoleMenu> getmenuPermissionInfo(int role, int menu);
	@Arguments({"role","system1"})
	List<MenuPermission> getmenuPermissionList(int role, int system1);
	@Arguments({"account","menu"})
	List<ActionPermission> getactionPermissionList(int account, int menu);
	@Arguments({"account","permissionCode"})
	List<ActionPermission> getpermissionCodeVerification(int account, String permissionCode);
	@Arguments("roleMenu")
	public void deleteMultMenuPermission(RoleMenu roleMenu);
	

}
