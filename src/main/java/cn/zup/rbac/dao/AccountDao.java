package cn.zup.rbac.dao;

import java.util.List;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.controller.ViewEntity.RoleDataViewModel;
import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.Role;
import cn.zup.rbac.entity.RoleData;

@MiniDao
public interface AccountDao extends MiniDaoSupportHiber<Role> {			
	public List<Account> selectAllAccount();
	public Integer getCount();
	
	@Arguments("account")
	List<Account> getAccountList(Account account);
	
	@Arguments({"userId"})
	List<Account> getUserAccountList(int userId);
	
	@Arguments("roleId")
	public List<Role> getRoleSelect(int roleId);

	@Arguments("account")
	public List<Account> selectByCondition(Account account);
	@Arguments({"organId", "accountName"})
	public List<Account> getAccountNameFromOrgan(Integer organId, String accountName);
	@Arguments({"roleId","roleName"})
	public List<Role> getroleRepeatVerify(Integer roleId, String roleName);
	@Arguments({"roleName","roleType"})
	public List<Role> getroleList(String roleName, Integer roleType);
	@Arguments({"parentRole"})
	public List<Role> getRoleChildrenList(int parentRole);
	@Arguments({"userId"})
	public List<Role> getAccountFromUser(int userId);
	@Arguments({"accountId"})
	public List<Role> getRoleFromAccount(int accountId);
	@Arguments({"menuId"})
	public List<Role> getmenuPermitRole(int menuId);
	@Arguments({"actionId"})
	public List<Role> getactionPermitRole(int actionId);
	@Arguments({"role","page", "rows"})
	@ResultType(Role.class)
	public MiniDaoPage<Role> getAllRoles(Role role, int page, int rows);
	@Arguments("role")
	public List<Role> getRoleSonTable(Role role);
	@Arguments("roleId")
	public List<Account> getRoleAccountList(int roleId);
		
}
