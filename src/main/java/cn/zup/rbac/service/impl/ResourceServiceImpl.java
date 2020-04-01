 package cn.zup.rbac.service.impl;

import cn.zup.rbac.dao.ResourceActionDao;
import cn.zup.rbac.dao.ResourceMenuDao;
import cn.zup.rbac.dao.ResourceSystemDao;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.rbacmap.dao.DomainSystemDao;
import cn.zup.rbacmap.entity.DomainSystem;
import cn.zup.wechat.util.GlobalConstants;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
/**
 * ResourceService的实现类
 * @author lixin 
 * time:2016/07/28
 *
 */
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService{
	@Autowired
	private ResourceSystemDao resourceSystemDao;
	@Autowired
	private ResourceMenuDao resourceMenuDao;
	@Autowired
	private ResourceActionDao resourceActionDao;
	@Autowired
	private DomainSystemDao domainSystemDao;
	private String superSystemName=GlobalConstants.getString("superSystemId");
	
	/**
	 * 添加系统
	 * 
	 * @param system：系统
	 */
	public void addSystem(System system) {
		resourceSystemDao.saveByHiber(system);
	}
	/**
	 * 删除系统
	 * 
	 * @param system：系统
	 */
	
	public  void deleteSystem(System system) {	
		resourceSystemDao.deleteByHiber(system);
	}

	/**
	 * 更新系统
	 * 
	 * @param system：系统
	 */

	public  void updateSystem(System system) {
		resourceSystemDao.updateByHiber(system);
	}

	/**
	 * 系统重复验证(或是否与其他重复)，true为重复
	 * @param systemId系统ID，可为null 如果不为null则标识不包含这个系统id
	 * @param systemName系统名称
	 * @return
	 */
	public  boolean getSystemRepeatVerify(Integer systemId, String systemName) {
	List<System> list=	resourceSystemDao.getSystemRepeatVerify(systemId,systemName);
		if(list.size()!=0){
			return true;			
		}
		return false;
	}

	/**
	 * 获取系统详情
	 * 
	 * @param systemId：系统id
	 * @return
	 */	
	public System getSystemInfo(int systemId) {
		int validFlag = ConfigSetting.ValigFlag.getValue();
		return resourceSystemDao.getSystemInfo(systemId,validFlag);
	}
	public System getSystemInfo(System system) {
		int validFlag = ConfigSetting.ValigFlag.getValue();
		List<System> systemList= resourceSystemDao.getSystem(system,validFlag);
		if(systemList.size()>0){
			return systemList.get(0);
		}
		else{
			return null;
		}
	}
	/**
	 * 获取系统列表
	 * @date 2016-7-28 16:32:11
	 * 
	 */
	public List<System> getSystemList() {		
		int validFlag = ConfigSetting.ValigFlag.getValue();
		return resourceSystemDao.getSystemList(validFlag);
	}

	/**
	 * 添加菜单
	 * @date 2016-7-28 16:32:11
	 * @param menu 菜单实体
	 */
	public void addMenu(Menu menu) {		
		resourceMenuDao.saveByHiber(menu);
	}

	/**
	 * 删除菜单
	 * @date 2016-7-28 16:32:11
	 * @param menu  菜单实体
	 */
	public  void deleteMenu(Menu menu) {
		//删除rolemenu
//		resourceMenudao.deleteFromRoleMenu(menu);
		resourceMenuDao.deleteByHiber(menu);
//		//删除roleaction
//		resourceMenudao.deleteFromRoleAction(menu);
//		//删除roledata
//		resourceMenudao.deleteFromRoleData(menu);
		
	}
	/**
	 * 
	 * 删除menu	
	 * @param menu 菜单实体
	 * 
	 * */
	public  void deleteMenus(Menu menu) {
		resourceMenuDao.deleteByHiber(menu);
	}
	/**
	 * 更新菜单
	 * 
	 * @param menu   菜单实体
	 */
	public void updateMenu(Menu menu) {
		resourceMenuDao.updateByHiber(menu);
	}

	/**
	 * 验证菜单重复(或是否与其他重复)，true为重复
	 * 
	 * @param menuId：菜单ID，可为null 如果为null 则表示判断不包含该菜单ID记录 
	 * @param systemId：系统ID（主要用于判断根目录）
	 * @param parentMenuId：父级菜单ID
	 * @param menuName：菜单名称
	 * @return
	 */
	public boolean getMenuRepeatVerify(Integer menuId, int systemId,int parentMenuId, String menuName) {
		List<Menu> list=resourceMenuDao.getmenuRepeatVerify(menuId,systemId,parentMenuId,menuName);
		if(list.size()!=0)
			return true;
		else
		return false;
	}
	/**
	 * @param menuId
	 * @param roleId
	 * @return
	 * 
	 */
	public boolean getMenuPermission (int menuId,int roleId){
		List<RoleMenu> roleMenu=resourceActionDao.getMenuPermission(menuId, roleId);
		if(roleMenu.size() !=0)
			return true;
		else 
			return false;
	}

	/**
	 * 获取菜单实体
	 * 
	 * @param menuId:菜单ID
	 * @return
	 */

	public Menu getMenuInfo(int menuId) {
		return resourceMenuDao.getByIdHiber(Menu.class,menuId);
	}

	/**
	 * 获取系统下菜单列表
	 * 
	 * @param systemId:系统ID
	 * @param rootOnly:是否只获取根菜单
	 * @return
	 */
	public List<Menu> getSystemMenuList(int systemId, int parentMenuId, boolean rootOnly) {
		Menu menu=new Menu();
		menu.setSystemId(systemId);
		menu.setParentMenuId(parentMenuId);
		return resourceMenuDao.getSystemMenuList(menu);
	}
	/**
	 * 获取父菜单下菜单列表
	 * 
	 * @param parentMenuId:父级菜单
	 * @return
	 */
	public List<Menu> getMenuList(int parentMenuId) {
		Menu menu=new Menu();
		menu.setParentMenuId(parentMenuId);
		return resourceMenuDao.listByHiber(menu);
	}

	/**获取系统角色有权限的菜单列表
	 * 
	 * @param roleId角色
	 * @param systemId系统
	 * @return
	 */
	
	public List<Menu> getRolePermitMenu(int roleId, int systemId) {	
		return resourceMenuDao.getRolePermitMenu(roleId,systemId);
	}
	
	/**
	 * 获取系统有权限的菜单列表
	 * 
	 * @param systemId:系统ID
	 * @param rootOnly:是否只获取根菜单
	 * @return
	 */
	public List<Menu> getRoleActionTree(Integer systemId, Integer menuId, Integer roleId){
		return resourceMenuDao.getRoleMenuActionTree(systemId, menuId, roleId);
	}

	/**获取系统角色有权限的子菜单列表
	 * 
	 * @param roleId角色
	 * @param systemId系统
	 * @param parentMenuId父菜单 
	 * @return
	 */
	
	public List<MenuRoleEx> getRolePermitChildMenu(int roleId, int systemId,int parentMenuId) {	
		return resourceMenuDao.getRolePermitChildMenu(roleId,systemId,parentMenuId);
	}

	/**获取账户系统下有权限的菜单列表
	 * 
	 * @param accountId账户ID
	 * @param systemId系统ID
	 * @param rootOnly是否只获取根目录
	 * @return
	 */
	public List<Menu> getAccountPermitMenu(Integer accountId,Integer systemId, boolean rootOnly,Integer mobileFlag) {
		int superSystemId=0;
		if(superSystemName!=null){
			superSystemId=Integer.parseInt(superSystemName);
		}
		List<Menu> listRootMenu=resourceMenuDao.getAccountPermitMenu(accountId,systemId,mobileFlag,superSystemId);
		if(rootOnly)//只获取根目录下的菜单
		{			
			return listRootMenu;
		}
		else {//获取子菜单
			List<Menu> listAllMenu=null;//存储全部子菜单
			listAllMenu.addAll(listRootMenu);
			for(int i=0;i<listRootMenu.size();i++)
			{				
				Menu menu=new Menu();
				//用menuid当做父级菜单id查询
				menu.setParentMenuId(listRootMenu.get(i).getMenuId());
				List<Menu> listChildMenu=getMenuList(menu.getParentMenuId());
				listAllMenu.addAll(listChildMenu);				
			}
			return listAllMenu;
		}
	}

	/**
	 * 获取账户菜单下有权限的菜单列表
	 * @param accountId账户ID
	 * @param parentMenuId父菜单ID
	 * @return
	 */	
	public List<Menu> getAccountPermitSubMenu(int accountId,int parentMenuId,int mobileFlag) {
		return resourceMenuDao.getAccountPermitSubMenu(accountId,parentMenuId,mobileFlag);
	}

	/**
	 * 添加操作项
	 * 
	 * @param action
	 *            操作项
	 */
	public void addAction(Action action) {
		resourceActionDao.saveByHiber(action);
	}

	/**
	 * 删除操作项
	 * @param action
	 *            操作项
	 */
	public void deleteAction(int actionId) {
		//删除action
		//Class<Action> actions=Action.class;
		Action action  = new Action();
		action.setActionId(actionId);
		resourceActionDao.deleteByHiber(action);
	}

	/**
	 * 更新操作项
	 * 
	 * @param action
	 *            操作项
	 */
	public void updateAction(Action action) {
		resourceActionDao.updateByHiber(action);
	}

	/**
	 * 获取操作项信息
	 * 
	 * @param action
	 *            操作项ID
	 * @return
	 */
	public Action getActionInfo(int actionId) {
		return resourceActionDao.getByIdHiber(Action.class, actionId);
	}

	/**
	 * 操作项重复验证(或是否与其他重复)，true为重复
	 * 
	 * @param actionId操作项ID,可为null 如果为 null表示判断时候不包含该操作项ID
	 * @param menuId菜单ID
	 * @param actionName操作项名称
	 */
	public boolean getActionRepeatVerify(Integer actionId, int menuId,String actionName) {
		List<Action> list=resourceActionDao.getActionRepeatVerify(actionId,menuId,actionName);
		if(list.size()!=0){
			return true;			
		}
		return false;
	}

	/**
	 * 获取菜单下操作项列表
	 * 
	 * @param menuId菜单
	 * @data 
	 */
	public List<Action> getActionList(int menuId) {
		Action action=new Action();
		action.setMenuId(menuId);
		return resourceActionDao.listByHiber(action);
	}
	
	/**
	 * 根据账号与菜单id获取拥有权限的ActionName
	 * 
	 * @param menuId菜单
	 * @param accountid账号
	 * @return
	 */
	public List<Action> getActionListByMenuAndAccount(int menuId,int accountId){
		return resourceActionDao.getActionListByMenuAndAccount(menuId,accountId);
	}
	
	/**
	 * 获取角色有权限的操作项列表
	 * 
	 * @param menuId菜单ID
	 * @param roleID角色Id
	 * @return
	 */
	public MiniDaoPage<ActionPermission> getRolePermitAction(Integer menuId, int roleId, int page,int rows) {
 		return resourceActionDao.getRolePermitAction(menuId,roleId, page,rows); 
	}

	/**
	 * 获取角色未选择的操作项列表
	 * 
	 * @param menuId菜单ID
	 * @param roleID角色Id
	 * @return
	 */
	public MiniDaoPage<ActionPermission> getRolePermitActionAdd(Integer menuId, int roleId, int page,int rows) {
 		return resourceActionDao.getRolePermitActionAdd(menuId,roleId, page,rows); 
	}
	/**
	 * 获取角色已经选择的操作项列表
	 * 
	 * @param menuId菜单ID
	 * @param roleID角色Id
	 * @return
	 */
	public MiniDaoPage<ActionPermission> getAlreadyRolePermitActionAdd(Integer menuId, int roleId, int page,int rows) {
 		return resourceActionDao.getAlreadyRolePermitActionAdd(menuId,roleId, page,rows); 
	}
	/**
	 * 操作信息分页列表
	 * 
	 * @param action操作项实体
	 * @param actioncode标识码    
	 * @param pageSize分页行数
	 * @param pageination 页码
	 * @return
	 */
	public MiniDaoPage<Action> getActionPagingList(Action action, int page, int rows){   
        return resourceActionDao.getActionPage(action, page, rows);
	}
	
	public MiniDaoPage<Action> getOperationSignList(Action action, int page, int rows){
		return resourceActionDao.getOperationSignList( action, page, rows);
		
	}
	/**
	 * 获取是否含有权限
	 * 
	 * @param url:访问的页面地址
	 * @param accountId:账号id
	 * @return
	 */
	@Override
	public boolean getUrlRoleVerify(String url, int accountId) {
		//是否是menu菜单权限
		int count = resourceMenuDao.getUrlRoleVerify(url, accountId);
		if(count >0)
			return true;
		//是否为action操作项权限
		count = resourceActionDao.getUrlRoleVerify(url, accountId);
		if(count >0)
			return true;
		return false;
	}
	
	/**
	 * 获取系统的子表
	 * @param systemId
	 * @return
	 */
	public List<System> getSystemSonTable(Integer systemId) {	 
		return resourceSystemDao.getSystemSonTable(systemId);
	}
	/**
	 * 根据实体获取menu信息
	 * @param menu
	 * @return
	 */
	public Menu getMenuInfo(Menu menu) {
		return resourceMenuDao.getByEntityHiber(menu);
	}
	@Override
	public DomainSystem getDomainSystemByDomain(String domain) {
		return domainSystemDao.getDomainSystemByDomain(domain);
	}
	@Override
	public DomainSystem getDomainSystemBySystemId(Integer systemId) {
		return domainSystemDao.getDomainSystemBySystemId(systemId);
	}
	@Override
	public List<DomainSystem> getDomainSystemList(DomainSystem domainSystem) {
		return domainSystemDao.getDomainSystemList(domainSystem);
	}
	@Override
	public List<Menu> getMenuList(Integer accountId, Menu menu) {
		return resourceMenuDao.getMenuListByObject(accountId, menu);
	}
}
