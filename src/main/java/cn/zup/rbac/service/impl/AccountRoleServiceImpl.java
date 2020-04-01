package cn.zup.rbac.service.impl;
 
import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.zup.rbac.controller.ViewEntity.RoleDataViewModel;
import cn.zup.rbac.dao.AccountDao;
import cn.zup.rbac.dao.AccountOperateDao;
import cn.zup.rbac.dao.AccountRoleDao;
import cn.zup.rbac.dao.UserDao;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.settings.ConfigSetting;


@Service("accountRoleService")
public class AccountRoleServiceImpl implements AccountRoleService{

	@Autowired
	private AccountDao roleDao;
	@Autowired
	private UserDao userdao;
	@Autowired
	private AccountRoleDao accountroledao;
	@Autowired
	private AccountOperateDao accountDao;
		/**
	 * 添加账户
	 * 
	 * @param account
	 */
	public int addAccount(Account account) {
		accountDao.saveByHiber(account);
		return account.getAccountId();
	}

	/**
	 * 删除账户
	 * 
	 * @param account
	 *            账户
	 * @param physicalDelete
	 *            物理删除标识，TURE为物理删除
	 */
	public void deleteAccount(Account account, boolean physicalDelete) {
		if (physicalDelete) {	
			accountDao.deleteByHiber(account);
		}
		else {
			//account.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
			account.setValidFlag(2); // 无效
			accountDao.updateByHiber(account);
		}
	}

	/**
	 * 更新账户
	 * 
	 * @param account
	 * 
	 */
	public void updateAccount(Account account) {
		accountDao.updateByHiber(account);
	}

	/**
	 * 账户重复验证(或是否与其他重复)，true为重复
	 * 
	 * @param account
	 *      账户ID
	 * @param accountName
	 *      账户名称
	 */
	public boolean getAccountRepeatVerify(Integer accountId, Integer userId,String accountName) {
		List<Account> accountList=accountDao.getAccountRepeatVerify(accountId, userId,accountName);
		if(accountList!=null&&accountList.size()!=0)
		{
			return true;
		}
		else
			return false;

	}

	 /**
	 * 获取账户信息
	 *
	 * @param account
	 * 账户ID
	 * @return
	 */
	public Account getAccountInfo(int accountId) {  
		return accountDao.getByIdHiber(Account.class, accountId);
	}	
	 /**
	 * 账户列表
	 *
	 * @param account
	 * 参数列表
	 * @return
	 */
	 public List<Account> getAccountList(Account account) {		  
		 return roleDao.getAccountList(account);	
	 }
	
	 /**
	 * 根据用户ID获取账户列表
	 *
	 * @param user
	 * 用户ID
	 * @return
	 */
	 public List<Account> getUserAccountList(int userId) {  
		 return roleDao.getUserAccountList(userId);
	 }
	/**
	 * 账户信息的分页查询
	 */
	public MiniDaoPage<Account> getAccountPagingList(Account account, int page,int rows) {		
			return accountDao.getAccountPagingList(account,page,rows);
		}
	 /**
	 * 根据组织D获取账户列表
	 *
	 * @param organ
	 * 组织ID
	 * @return
	 */
	 public List<Account> getOrganAccountList(Integer organId) {
		 return userdao.getorganAccountList(organId);	
	 }

	 /**
	 * 获取角色下账户列表
	 *
	 * @param roleID
	 * 角色
	 * @return
	 */
	 public List<Account> getRoleAccountList(int roleId) {		
		 return roleDao.getRoleAccountList(roleId);
	 }
	
	 /**
	 * 添加角色
	 *
	 * @param role
	 * 角色
	 */
	 public  void addRole(Role role) {
		 roleDao.saveByHiber(role);;
	 }
	
	 /**
	 * 删除角色
	 *
	 * @param role
	 * 角色
	 */
	 public  void deleteRole(Role role) {		
		 roleDao.deleteByHiber(role);
	 }
	
	 /**
	 * 更新角色
	 *
	 * @param role
	 * 角色
	 */
	 public void updateRole(Role role) {
	 roleDao.updateByHiber(role);
	 }
	
	 /**
	 * 角色重复验证(或是否与其他重复)，true为重复
	 *
	 * @param role
	 * 角色ID 如果非null 表示验证的时候不包含该角色ID
	 * @param roleName
	 * 角色名称
	 * @return
	 */
	public boolean getRoleRepeatVerify(Integer roleId, String roleName) {
		List<Role> list = roleDao.getroleRepeatVerify(roleId, roleName);
		if (list.size() != 0) {
			return true;
		}
		return false;
	}
	
	 /**
	 * 获取角色实例
	 *
	 * @param role
	 * 角色ID
	 */
	 public Role getRoleInfo(int roleId) { 
		 return roleDao.getByIdHiber(Role.class, roleId);
	 }
	
	 /**
	 * 根据参数获取角色列表
	 *
	 * @param roleName
	 * 角色名称
	 * @param roleType
	 * 角色类型，可为空
	 * @return
	 */
	 public List<Role> getRoleList(String roleName,Integer roleType) { 
		return roleDao.getroleList(roleName,roleType);
	 }
	
	 /**
	 * 根据参数获取角色列表
	 *
	 * @param roleName
	 * 角色名称
	 * @param roleType
	 * 角色类型，可为空
	 * @param pageSize
	 * 分页行数
	 * @param pagination
	 * 页码
	 * @return
	 */
	public MiniDaoPage<Role> getRolePagingList(Role role,int page, int rows) { 
		role.setRoleTypeConfig(ConfigSetting.RoleType.getValue());
		return roleDao.getAllRoles(role,page, rows);
	}
	
	 /**
	 * 获取父角色的子角色
	 *
	 * @param parentRole
	 * 父角色
	 * @return
	 */
	 public List<Role> getRoleChildrenList(int parentRole) {		 
		 return roleDao.getRoleChildrenList(parentRole);
	 }
	
	 /**
	 * 获取用户的角色列表
	 *
	 * @param user
	 * 通过用户id找寻Account账户信息
	 * 再通过Account中的roleid查询role信息
	 * @return
	 */
	 public List<Role> getUserRoleList(int userId) {		  
		return roleDao.getAccountFromUser(userId);
	 }
	 /**
	 * 获取拥有菜单权限的角色
	 *
	 * @param menu
	 * 菜单
	 * @return
	 */
	 public List<Role> getMenuPermitRole(int menuId) { 
		 return  roleDao.getmenuPermitRole(menuId);	
	 }
	
	 /**
	 * 获取拥有操作项权限的角色
	 *
	 * @param action
	 * 操作项
	 * @return
	 */
	 public List<Role> getActionPermitRole(int actionId) { 	
		 return roleDao.getactionPermitRole(actionId);	
	 }
	
	 /**
	 * 添加账户角色分配
	 *
	 * @param accountRole
	 * 账户角色信息
	 */
	 public void addAccountRole(AccountRole accountRole) {
		 accountroledao.saveByHiber(accountRole);	
	 }
	
	 /**
	 * 删除账户角色分配
	 *
	 * @param accountRole
	 * 账户角色信息
	 */
	 public  void deleteAccountRole(AccountRole accountRole) {
		 accountroledao.deleteByHiber(accountRole);
	 }
	
	 /**
	 * 获取指定账户、角色的配置信息
	 *
	 * @param account
	 * 账户
	 * @param role
	 * 角色
	 * @return
	 */
	 public  AccountRole getAccountRoleInfo(Integer accountId, Integer roleId) {
		 AccountRole accountRole=new AccountRole();
		 accountRole.setAccountId(accountId);
		 accountRole.setRoleId(roleId);
		return accountroledao.getByEntityHiber(accountRole);		
	 }
	 /**
		 * 获取数据信息
		 *
		 * @param roledata  角色数据
		 * @return
		 */
	public MiniDaoPage<RoleDataViewModel> getDataInfo(RoleData roledata,int page, int rows){
			MiniDaoPage<RoleDataViewModel> minidaoPage = accountroledao.getAllRoleData(roledata, page, rows);
			return minidaoPage;
	}
	
	/**
	 * 角色重复验证(或是否与其他重复)，true为重复
	 *
	 * @param orginid
	 * 组织ID
	 * @param accountname
	 * 账户名称
	 * @return
	 */
	public List<Account> getAccountName(Integer organId, String accountName){
		List<Account> list= roleDao.getAccountNameFromOrgan(organId, accountName); 
		 return list;
	}
	/**
	 * 获取账户的全部子表
	 */
	public List<Account> getAccountSonTable(Account account) {		 
		return accountDao.getAccountSonTable(account);
	}
	 /**
	  * 通过roleId获取角色的全部有关联的子表
	  * @param roleId
	  * @return
	  */
	public List<Role> getRoleSonTable(int roleId) {
		Role role=new Role();
		role.setRoleId(roleId);		
		return roleDao.getRoleSonTable(role);
	}
	
	@Override
	public List<AccountRole> getAccountRoleInfoByAccountId(Integer accountId) {
		return accountroledao.getAccountRoleInfo(accountId, null);
	}
	
	/**
	 * 账户信息的分页查询按照部门和账号信息
	 */
	public MiniDaoPage<Account> getAccountByOrganPagingList(Account account,Integer organId, int page,int rows) {		
			return accountDao.getAccountByOrganPagingList(account,organId,page,rows);
	}
	
}
