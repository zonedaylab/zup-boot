package cn.zup.rbac.service;

import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.*;
import cn.zup.rbacmap.entity.DomainSystem;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;
/**
 * 用于资源管理的service层
 * @author lixin
 * time：2016/7/28
 *
 */
public interface ResourceService {

	/**
	 * 添加系统
	 * 
	 * @param system：系统
	 */

	void addSystem(System system);

	/**
	 * 删除系统
	 * 
	 * @param system：系统
	 */
	
	void deleteSystem(System system);

	/**
	 * 更新系统
	 * 
	 * @param system：系统
	 */

	void updateSystem(System system);
	/**
	 * 系统重复验证(或是否与其他重复)，true为重复
	 * @param systemId系统ID，可为空
	 * @param systemName系统名称
	 * @return
	 */
	boolean getSystemRepeatVerify(Integer systemId, String systemName);

	/**
	 * 获取系统详情
	 * 
	 * @param systemId：系统id
	 * @return
	 */	
	System getSystemInfo(int systemId);
	/**
	 * 获取系统
	 * lixin
	 * 2017-5-16 10:12:13
	 * 区分开光伏、售电和OA等
	 * @param system
	 * @return
	 */
	System getSystemInfo(System system);

	/**
	 * 获取系统列表
	 */
	
	List<System> getSystemList();

	/**
	 * 添加菜单
	 * 
	 * @param menu：菜单
	 */
	
	void addMenu(Menu menu);

	/**
	 * 删除菜单
	 * 
	 * @param menuId：菜单ID
	 */
	void deleteMenu(Menu menu);
	
	/**
	 * 更新菜单
	 * 
	 * @param menu：菜单
	 */

	void updateMenu(Menu menu);

	/**
	 * 验证菜单重复(或是否与其他重复)，true为重复
	 * 
	 * @param menuId：菜单ID，可为空
	 * @param systemId：系统ID（主要用于判断根目录）
	 * @param parentMenuId：父级菜单ID
	 * @param menuName：菜单名称
	 * @return
	 */
	
	boolean getMenuRepeatVerify(Integer menuId, int systemId, int parentMenuId, String menuName);
/**
	 * 单选框填充
	 * @param menuId
	 * @param roleId
	 * @return
	 * 
	 */
	boolean getMenuPermission(int menuId, int roleId);
	/**
	 * 获取菜单实体
	 * 
	 * @param menuId:菜单ID
	 * @return
	 */

	Menu getMenuInfo(int menuId);
	/**
	 * 根据实体获取menu信息
	 * @param menu
	 * @return
	 */
	Menu getMenuInfo(Menu menu);

	/**
	 * 获取系统下菜单列表
	 * 
	 * @param systemId:系统ID
	 * @param rootOnly:是否只获取根菜单
	 * @return
	 */
	
	List<Menu> getSystemMenuList(int systemId, int menuId, boolean rootOnly);
	
	/**
	 * 获取系统有权限的菜单列表
	 * 
	 * @param systemId:系统ID
	 * @param rootOnly:是否只获取根菜单
	 * @return
	 */
	List<Menu> getRoleActionTree(Integer systemId, Integer menuId, Integer roleId);

	/**
	 * 获取父菜单下菜单列表
	 * 
	 * @param parentMenuId:父级菜单
	 * @return
	 */

	List<Menu> getMenuList(int parentMenuId);
	
	/**
	 * 获取系统的子表
	 * @param systemId
	 * @return
	 */
	List<System> getSystemSonTable(Integer systemId);	
	
	/**获取系统角色有权限的菜单列表
	 * 
	 * @param roleId角色
	 * @param systemId系统
	 * @return
	 */
	
	List<Menu> getRolePermitMenu(int roleId, int systemId);

	
	/**获取账户系统下有权限的菜单列表
	 * 
	 * @param accountId账户ID
	 * @param systemId系统ID
	 * @param rootOnly是否只获取根目录
	 * @return
	 */
	List<Menu> getAccountPermitMenu(Integer accountId, Integer systemId, boolean rootOnly, Integer MobileFlag);
	
	/**
	 * 根据条件获取有所有菜单
	 * @author Andot
	 * @param accountId 账户ID
	 * @param systemId 系统ID  必填项
	 * @return mobileFlag 终端标识 1 手机端 2 电脑端
	 * @return List<Menu> 菜单列表
	 */
	List<Menu> getMenuList(Integer accountId, Menu menu);

	/**
	 * 获取账户菜单下有权限的菜单列表
	 * @param accountId账户ID
	 * @param parentMenuId父菜单ID
	 * @return
	 */
	
	List<Menu> getAccountPermitSubMenu(int accountId, int parentMenuId, int MobileFlag);

	
	/**
	 * 添加操作项
	 * 
	 * @param action操作项
	 */
	
	void addAction(Action action);

	/**
	 * 删除操作项
	 * 
	 * @param actionId操作项
	 */
	
	void deleteAction(int actionId);
	/**
	 * 更新操作项
	 * 
	 * @param action操作项
	 */
	
	void updateAction(Action action);

	/**
	 * 获取操作项信息
	 * 
	 * @param actionId操作项ID
	 * @return
	 */
	
	Action getActionInfo(int actionId);

	/**
	 * 操作项重复验证(或是否与其他重复)，true为重复
	 * 
	 * @param actionId操作项ID,可为空
	 * @param menuId菜单ID
	 * @param actionName操作项名称
	 */

	boolean getActionRepeatVerify(Integer actionId, int menuId, String actionName);

	/**
	 * 获取菜单下操作项列表
	 * 
	 * @param menuId菜单
	 * @return
	 */
	
	List<Action> getActionList(int menuId);
	
	/**
	 * 根据账号与菜单id获取拥有权限的ActionName
	 * 
	 * @param menuId菜单
	 * @param accountid账号
	 * @return
	 */
	
	List<Action> getActionListByMenuAndAccount(int menuId, int accountId);


	/**
	 * 获取角色有权限的操作项列表
	 * 
	 * @param menuId菜单ID
	 * @param roleID角色Id
	 * @return
	 */
	
	MiniDaoPage<ActionPermission> getRolePermitAction(Integer menuId, int roleId, int page, int rows);
	/**
	 * 获取角色未选择的操作项列表
	 * 
	 * @param menuId菜单ID
	 * @param roleID角色Id
	 * @return
	 */
	
	MiniDaoPage<ActionPermission> getRolePermitActionAdd(Integer menuId, int roleId, int page, int rows);
	/**
	 * 获取角色已经选择的操作项列表
	 * 
	 * @param menuId菜单ID
	 * @param roleID角色Id
	 * @return
	 */
	
	MiniDaoPage<ActionPermission> getAlreadyRolePermitActionAdd(Integer menuId, int roleId, int page, int rows);
	/**
	 * 操作信息分页列表
	 * 
	 * @param action操作项实体
	 * @param actioncode标识码    
	 * @param pageSize分页行数
	 * @param pageination 页码
	 * @return
	 */
	MiniDaoPage<Action> getActionPagingList(Action action, int page, int rows);
	public MiniDaoPage<Action> getOperationSignList(Action action, int page, int rows);
	/**
	 * 获取是否含有权限
	 * 
	 * @param url:访问的页面地址
	 * @param accountId:账号id
	 * @return
	 */
	boolean getUrlRoleVerify(String url, int accountId);


	/**
	 * 获取系统角色有权限的子菜单列表
	 * @param i
	 * @param systemId
	 * @param parentMenuId
	 * @return
	 */
	List<MenuRoleEx> getRolePermitChildMenu(int roleId, int systemId, int parentMenuId);
	/**
	 * 通过域名获取域名系统的信息
	 * lixin
	 * 2017-6-6 09:20:09
	 * @param domain
	 * @return
	 */
	DomainSystem getDomainSystemByDomain(String domain);
	/**
	 * 通过系统id获取域名系统信息
	 * 
	 * @param systemId
	 * @return
	 */
	DomainSystem getDomainSystemBySystemId(Integer systemId);
	/**
	 * 通过实体获取域名系统信息
	 * lixin
	 * 2017-6-6 09:22:14
	 * @param domainSystem
	 * @return
	 */
	List<DomainSystem> getDomainSystemList(DomainSystem domainSystem);
	
}
