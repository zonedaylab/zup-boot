package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Action;
import cn.zup.rbac.entity.ActionPermission;
import cn.zup.rbac.entity.RoleMenu;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;


@MiniDao
public interface ResourceActionDao extends MiniDaoSupportHiber<Action> {
	@Arguments({"actionId","menuId","actionName"})
	List<Action> getActionRepeatVerify(Integer actionId, int menuId, String actionName);
	@Arguments("menuId")
	List<Action> getActionList(int menuId);	
	@Arguments({"menuId" , "roleId"})
	List<RoleMenu>getMenuPermission(int menuId, int roleId);
	@Arguments("actionId")
	void deleteFromRoleAction(int actionId);
	@Arguments({"menuId","roleId","page", "rows"})
	@ResultType(ActionPermission.class)
	MiniDaoPage<ActionPermission> getRolePermitAction(Integer menuId, int roleId, int page, int rows);
	@Arguments({"action","page", "rows"})
	@ResultType(Action.class)
	public MiniDaoPage<Action> getActionPage(Action action, int page, int rows);
	//@Arguments({"menuId","actionCode"})
	//List<Action> getOperationSignList(Integer menuId,String actionCode);
	@Arguments({"action","page","rows"})
	@ResultType(Action.class)
	public MiniDaoPage<Action> getOperationSignList(Action action, int page, int rows);
	@Arguments({"url","accountId"})
	int getUrlRoleVerify(String url, int accountId);
	@Arguments({"menuId","accountId"})
	public List<String> getActionNameRoleAll(int menuId, int accountId);
	@Arguments({"menuId","roleId","page", "rows"})
	@ResultType(ActionPermission.class)
	MiniDaoPage<ActionPermission> getRolePermitActionAdd(Integer menuId, int roleId, int page, int rows);
	@Arguments({"menuId","roleId","page", "rows"})
	@ResultType(ActionPermission.class)
	MiniDaoPage<ActionPermission> getAlreadyRolePermitActionAdd(Integer menuId, int roleId, int page, int rows);
	
	@Arguments({"menuId","accountId"})
	List<Action> getActionListByMenuAndAccount(int menuId, int accountId);	
	
}
