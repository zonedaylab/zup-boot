package cn.zup.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.ResourcePermissionDao;
import cn.zup.rbac.dao.ResourcePermissionRoleActionDao;
import cn.zup.rbac.dao.ResourcePermissionRoleDataDao;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.ResourcePermissionService;
import cn.zup.rbac.service.settings.DataPermissionType;
@Service("resourcePermissionService")
public class ResourcePermissionServiceImpl implements ResourcePermissionService {
	@Autowired
	private ResourcePermissionDao resourcePermissionDao;
	@Autowired
	private ResourcePermissionRoleActionDao resourcePermissionroleActionDao;
	@Autowired
	private ResourcePermissionRoleDataDao resourcePermissionroleDataDao;
	

	/**
	 * 添加角色菜单权限
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	public void addMenuPermission(RoleMenu roleMenu) {
		resourcePermissionDao.saveByHiber(roleMenu);
	}

	/**
	 * 删除角色菜单权限
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	public void deleteMenuPermission(RoleMenu roleMenu) {
		resourcePermissionDao.deleteByHiber(roleMenu);
	}

	/**
	 * 更新角色菜单权限
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	public void updateMenuPermission(RoleMenu roleMenu) {
		resourcePermissionDao.updateByHiber(roleMenu);
	}

	/**
	 * 获取角色菜单权限信息
	 * 
	 * @param role
	 *            角色ID
	 * @param menu
	 *            菜单ID
	 * @return
	 */
	public RoleMenu getMenuPermissionInfo(int roleId, int menuId) {
		List<RoleMenu> list=resourcePermissionDao.getmenuPermissionInfo(roleId,menuId); 
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	/**
	 * 获取角色菜单权限列表
	 * 
	 * @param role
	 *            角色
	 * @param system
	 *            系统
	 * @return
	 */
	public List<MenuPermission> getMenuPermissionList(int role, int system) {
		
		List<MenuPermission> list=resourcePermissionDao.getmenuPermissionList(role,system);
		return list;
	}

	/**
	 * 添加角色操作项权限
	 * 
	 * @param roleAction
	 *            角色操作项权限
	 */
	public  void addActionPermission(RoleAction roleAction) {
		resourcePermissionroleActionDao.saveByHiber(roleAction);
	}

	/**
	 * 删除角色操作项权限
	 * 
	 * @param roleAction
	 *            角色操作项权限
	 */
	public void deleteActionPermission(RoleAction roleAction) {
		resourcePermissionroleActionDao.deleteByHiber(roleAction);
	}

	/**
	 * 更新角色操作项权限
	 * 
	 * @param roleAction
	 *            角色操作项权限
	 */
	public void updateActionPermission(RoleAction roleAction) {
		resourcePermissionroleActionDao.updateByHiber(roleAction);
	}

	/**
	 * 获取角色操作项权限信息
	 * 
	 * @param role
	 * @param action
	 * @return
	 */
	public RoleAction getActionPermissionInfo(int roleId, int actionId) {
		RoleAction roleAction=new RoleAction();
		roleAction.setRoleId(roleId);
		roleAction.setActionId(actionId);		
		return resourcePermissionroleActionDao.getByEntityHiber(roleAction); 
	}

	/**
	 * 获取角色菜单下操作项权限列表
	 * 
	 * @param account
	 *            账户ID
	 * @param menu
	 *            菜单ID
	 * @return
	 */
	public List<ActionPermission> getActionPermissionList(int account, int menu) {
		return resourcePermissionDao.getactionPermissionList(account,menu);
	}

	/**
	 * 根据权限码验证权限
	 * 
	 * @param account
	 *            账户
	 * @param permissionCode
	 *            权限码
	 * @return
	 */
	public boolean getPermissionCodeVerification(int account,String permissionCode) {
		List<ActionPermission> list=resourcePermissionDao.getpermissionCodeVerification(account,permissionCode);
		if(list.size()!=0)
			return true;
		else
			return false;
	}

	/**
	 * 添加数据权限
	 * 
	 * @param data
	 *            数据权限
	 */
	public  void addDataPermission(RoleData data) {
		resourcePermissionroleDataDao.saveByHiber(data);
	}

	/**
	 * 删除数据权限
	 * 
	 * @param data
	 *            数据权限
	 */
	public  void deleteDataPermission(RoleData data) {
		resourcePermissionroleDataDao.deleteByHiber(data);
	}

	/**
	 * 更新数据权限
	 * 
	 * @param data
	 *            数据权限
	 */
	public void updateDataPermission(RoleData data) {
		resourcePermissionroleDataDao.updateByHiber(data);
	}

	/**
	 * 获取数据权限信息
	 * 
	 * @param data
	 * @return
	 */
	public  RoleData getDataPermissionInfo(int data) {
		Class<RoleData> class1=RoleData.class;
		RoleData roledata=resourcePermissionroleDataDao.getByIdHiber(class1, data);
		return roledata;
	}

	/**
	 * 获取账户的数据权限列表
	 * 
	 * @param account
	 *            账户
	 * @param menu
	 *            菜单ID
	 * @param type
	 *            数据权限类型
	 * @return
	 */
	public List<RoleData> getAccountDataPermissionList(int account, int menu,DataPermissionType type) {
		List<RoleData> list=resourcePermissionroleDataDao.getaccountDataPermissionList(account,menu,type);
		return list;
	}

	/**
	 * 获取角色的数据权限列表
	 * 
	 * @param role
	 *            角色
	 * @return
	 */
	public List<RoleData> getRoleDataPermissionList(int role) {
		List<RoleData> list=resourcePermissionroleDataDao.getRoleDataPermissionList(role);
		
		return list;
	}

	/**
	 * 获取菜单下角色数据权限列表
	 * 
	 * @param menu
	 *            数据ID
	 * @param role
	 *            角色ID
	 * @return
	 */
	public List<RoleData> getMenuDataPermissionList(int menu,int role) {
		List<RoleData> list=resourcePermissionroleDataDao.getmenuDataPermissionList(menu,role);
		return list;
	}

	/**
	 * 通过角色删除菜单
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	public void deleteMultMenuPermission(RoleMenu roleMenu) {
		resourcePermissionDao.deleteMultMenuPermission(roleMenu);
	}

	public List<RoleAction> getRoleActionFromAction(int actionId) {
		RoleAction roleAction=new RoleAction();
		roleAction.setActionId(actionId);		
		return resourcePermissionroleActionDao.getRoleActionFromAction(actionId);
	}
	
}
