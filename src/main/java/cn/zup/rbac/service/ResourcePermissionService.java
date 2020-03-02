package cn.zup.rbac.service;

import java.util.List;

import cn.zup.rbac.entity.*;

public interface ResourcePermissionService {

	/**
	 * 添加角色菜单权限
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	
	void addMenuPermission(RoleMenu roleMenu);

	/**
	 * 删除角色菜单权限
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	
	void deleteMenuPermission(RoleMenu roleMenu);

	/**
	 * 更新角色菜单权限
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	
	void updateMenuPermission(RoleMenu roleMenu);

	/**
	 * 获取角色菜单权限信息
	 * 
	 * @param role
	 *            角色ID
	 * @param menu
	 *            菜单ID
	 * @return
	 */
	
	RoleMenu getMenuPermissionInfo(int role, int menu);

	/**
	 * 获取角色菜单权限列表
	 * 
	 * @param role
	 *            角色
	 * @param system
	 *            系统
	 * @return
	 */
	
	List<MenuPermission> getMenuPermissionList(int role, int system);

	
	/**
	 * 添加角色操作项权限
	 * 
	 * @param roleAction
	 *            角色操作项权限
	 */
	
	void addActionPermission(RoleAction roleAction);

	/**
	 * 删除角色操作项权限
	 * 
	 * @param roleAction
	 *            角色操作项权限
	 */

	void deleteActionPermission(RoleAction roleAction);

	/**
	 * 更新角色操作项权限
	 * 
	 * @param roleAction
	 *            角色操作项权限
	 */
	
	void updateActionPermission(RoleAction roleAction);

	/**
	 * 获取角色操作项权限信息
	 * 
	 * @param role
	 *            角色
	 * @param action
	 *            操作项ID
	 * @return
	 */
	
	RoleAction getActionPermissionInfo(int role, int action);
	/**
	 * 通过actionId从roleAction表中获取roleaction实体
	 * @param actionId
	 * @return
	 */
	List<RoleAction> getRoleActionFromAction(int actionId);
	/**
	 * 获取角色菜单下操作项权限列表
	 * 
	 * @param account
	 *            账户ID
	 * @param menu
	 *            菜单
	 * @return
	 */
	
	List<ActionPermission> getActionPermissionList(int account, int menu);

	/**
	 * 根据权限码验证权限
	 * 
	 * @param account
	 *            账户
	 * @param permissionCode
	 *            权限码
	 * @return
	 */
	
	boolean getPermissionCodeVerification(int account, String permissionCode);

	/**
	 * 添加数据权限
	 * 
	 * @param data
	 *            数据权限
	 */
	
	void addDataPermission(RoleData data);

	/**
	 * 删除数据权限
	 * 
	 * @param data
	 *            数据权限
	 */

	void deleteDataPermission(RoleData data);

	/**
	 * 更新数据权限
	 * 
	 * @param data
	 *            数据权限
	 */
	
	void updateDataPermission(RoleData data);

	/**
	 * 获取数据权限信息
	 * 
	 * @param data
	 * @return
	 */
	
	RoleData getDataPermissionInfo(int data);

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
	
	List<RoleData> getAccountDataPermissionList(int account, int menu, cn.zup.rbac.service.settings.DataPermissionType type);

	/**
	 * 获取角色的数据权限列表
	 * 
	 * @param role
	 *            角色
	 * @return
	 */
	
	List<RoleData> getRoleDataPermissionList(int role);

	/**
	 * 获取菜单下角色数据权限列表
	 * 
	 * @param menu
	 *            数据ID
	 * @param role
	 *            角色ID
	 * @return
	 */
	
	List<RoleData> getMenuDataPermissionList(int menu, int role);

	/**
	 * 通过角色删除菜单
	 * 
	 * @param roleMenu
	 *            角色菜单权限
	 */
	void deleteMultMenuPermission(RoleMenu roleMenu);
	
}
