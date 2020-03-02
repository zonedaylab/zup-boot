package cn.zup.rbac.service;

import java.util.Date;
import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.controller.ViewEntity.RoleDataViewModel;
import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.AccountRole;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.entity.Role;
import cn.zup.rbac.entity.RoleData;

public interface AccountRoleService {

	/**
	 * 添加账户
	 * 
	 * @param account
	 */
	int addAccount(Account account);

	/**
	 * 删除账户
	 * 
	 * @param account
	 *     账户
	 * @param physicalDelete
	 *    物理删除标识，TURE为物理删除
	 */
	void deleteAccount(Account account, boolean physicalDelete);

	/**
	 * 更新账户
	 * 
	 * @param account
	 * 
	 */
	void updateAccount(Account account);

	/**
	 * 账户重复验证(或是否与其他重复)，true为重复
	 * 
	 * @param account
	 *            账户ID
	 * @param accountName
	 *            账户名称
	 */
	boolean getAccountRepeatVerify(Integer accountId, Integer userId, String accountName);
	 
	 /**
	 * 获取账户信息
	 *
	 * @param account
	 * 账户ID
	 * @return
	 */
	 Account getAccountInfo(int accountId);	
	
	 /**
	 * 账户列表
	 *
	 * @param account
	 * 参数列表
	 * 
	 * 参数类型呢？？？
	 * 	 * 
	 * @return
	 */
	List<Account> getAccountList(Account account);
	/**
	 * 获取账户的全部子表
	 * @param account
	 * @return
	 */
	List<Account> getAccountSonTable(Account account);
	 /**
	 * 根据用户ID获取账户列表
	 *
	 * @param user
	 * 用户ID
	 * @return
	 */
	List<Account> getUserAccountList(int userId);
	MiniDaoPage<Account> getAccountPagingList(Account account, int page, int rows);
	 /**
	 * 根据组织ID获取账户列表
	 *
	 * @param organ
	 * 组织ID
	 * @return
	 */
	 List<Account> getOrganAccountList(Integer organId);
	
	 /**
	 * 获取角色下用账户列表
	 *
	 * @param role
	 * 角色
	 * @return
	 */
	List<Account> getRoleAccountList(int roleId);
	
	 /**
	 * 添加角色
	 *
	 * @param role
	 * 角色
	 */
	 void addRole(Role role);
	
	 /**
	 * 删除角色
	 *
	 * @param role
	 * 角色
	 */
	 void deleteRole(Role role);
	
	 /**
	 * 更新角色
	 *
	 * @param role
	 * 角色
	 */
	 void updateRole(Role role);
	
	 /**
	 * 角色重复验证(或是否与其他重复)，true为重复
	 *
	 * @param role
	 * 角色ID
	 * @param roleName
	 * 角色名称
	 * @return
	 */
	 boolean getRoleRepeatVerify(Integer roleId, String roleName);
	
	 /**
	 * 获取角色实例
	 *
	 * @param role
	 * 角色ID
	 */
	 Role getRoleInfo(int roleId);
	
	 /**
	 * 根据参数获取角色列表
	 *
	 * @param roleName
	 * 角色名称
	 * @param roleType
	 * 角色类型，可为空
	 * @return
	 */
	 List<Role> getRoleList(String roleName, Integer roleType);
	 /**
	  * 通过roleId获取角色的全部有关联的子表
	  * @param roleId
	  * @return
	  */
	 List<Role> getRoleSonTable(int roleId);
	 /**
	 * 根据参数获取角色列表
	 *
	 * @param roleName
	 * 角色名称
	 * @param roleType
	 * 角色类型，可为空
	 * @param pageSize
	 * 分页行数
	 * @param pageination
	 * 页码
	 * @return
	 */
	MiniDaoPage<Role> getRolePagingList(Role role, int page, int rows);
	
	 /**
	 * 获取父角色的子角色
	 *
	 * @param parentRole
	 * 父角色
	 * @return
	 */
	 List<Role> getRoleChildrenList(int parentRole);
	
	 /**
	 * 获取用户的角色列表
	 *
	 * @param user
	 * 用户id
	 * 有待在完成AccountRole后继续完善，
	 * @return
	 */
	 List<Role> getUserRoleList(int userId);
	
	 /**
	 * 获取拥有菜单权限的角色
	 *
	 * @param menu
	 * 菜单
	 * @return
	 */
	 List<Role> getMenuPermitRole(int menuId);
	
	 /**
	 * 获取拥有操作项权限的角色
	 *
	 * @param action
	 * 操作项
	 * @return
	 */
	 List<Role> getActionPermitRole(int actionId);
	
	 /**
	 * 添加账户角色分配
	 *
	 * @param accountRole
	 * 账户角色信息
	 */
	 void addAccountRole(AccountRole accountRole);
	
	 /**
	 * 删除账户角色分配
	 *
	 * @param accountRole
	 * 账户角色信息
	 */
	 void deleteAccountRole(AccountRole accountRole);
	
	 /**
	 * 获取指定账户、角色的配置信息
	 *
	 * @param account
	 * 账户
	 * @param role
	 * 角色
	 * @return
	 */
	 AccountRole getAccountRoleInfo(Integer accountId, Integer roleId);
	 /**
		 * 获取数据信息
		 *
		 * @param roledata  角色数据
		 * @return
		 */
	 public MiniDaoPage<RoleDataViewModel> getDataInfo(RoleData roledata, int page, int rows);
	 /**
		 * 角色重复验证(或是否与其他重复)，true为重复
		 *
		 * @param orginid
		 * 组织ID
		 * @param accountname
		 * 账户名称
		 * @return
		 */
	 List<Account> getAccountName(Integer organId, String accountName);
	 
	 
	 /**
	  * 根据accountId获取AccountRole信息
	  * @param accountId
	  * @return
	  */
	 List<AccountRole> getAccountRoleInfoByAccountId(Integer accountId);
	 
	 /**
	  * 根据账号和部门获取账号分页信息
	  * @param account
	  * @param organId
	  * @param page
	  * @param rows
	  * @return
	  */
	 public MiniDaoPage<Account> getAccountByOrganPagingList(Account account, Integer organId, int page, int rows);
	 
}
