package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.MenuRoleEx;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.util.List;

@MiniDao
public interface ResourceMenuDao extends MiniDaoSupportHiber<Menu> {	
	@Arguments({"menu","system","parentMenu","menuName"})
	List<Menu> getmenuRepeatVerify(Integer menu, int system, int parentMenu, String menuName);
	@Arguments({"menu"})
	List<Menu> getMenuList(Menu menu);
	@Arguments({"roleId","systemId"})
	List<Menu> getRolePermitMenu(int roleId, int systemId);
	@Arguments({"accountId","systemId","mobileFlag","superSystemId"})
	List<Menu> getAccountPermitMenu(Integer accountId, Integer systemId, Integer mobileFlag, int superSystemId);
	@Arguments({"accountId","parentMenuId","mobileFlag"})
	List<Menu> getAccountPermitSubMenu(int accountId, int parentMenuId, int mobileFlag);
	@Arguments("menuid")
	void deleteFromRoleMenu(int menuid);
	@Arguments("menu")
	void deleteFromRoleAction(int menu);
	@Arguments("menu")
	void deleteFromRoleData(int menu);
	@Arguments({"systemId","parentMenuId","roleId"})
	List<Menu> getRoleMenuActionTree(Integer systemId, Integer parentMenuId, Integer roleId);

	@Arguments({"url","accountid"})
	int getUrlRoleVerify(String url, int accountid);
	@Arguments({"roleId","systemId","parentMenuId"})
	List<MenuRoleEx> getRolePermitChildMenu(int roleId, int systemId, int parentMenuId);
	@Arguments({"menu"})
	@ResultType(Menu.class)
	List<Menu> getSystemMenuList(Menu menu);
	
	@Arguments({"accountId", "menu"})
	@ResultType(Menu.class)
	List<Menu> getMenuListByObject(Integer accountId, Menu menu);
	
}
