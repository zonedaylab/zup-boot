package cn.zup.rbac.junit;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.AccountRole;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Role;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.OrganPostService;

public class AccountJunit{

	@Test
	public void account_insert(){//测试增加账户
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");			
		Account account =new Account();
		account.setAccountId(4);
		account.setAccountName("再次测试");
		account.setPassWord("123223");
		account.setUserId(3);
		account.setValidFlag(1);
		accountroleservices.addAccount(account);
		System.out.println("测试输出结果集的第一个用户名称"+account.getAccountName());
		
	}
	@Test
	public void account_delete(){//测试删除账户
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");			
		Account account =new Account();
		account.setAccountId(4);
		accountroleservices.deleteAccount(account, true);
		System.out.println("测试输出结果集的第一个用户名称");
	}
	@Test
	public void account_update(){//测试更新账户
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		Account account =new Account();
		account.setAccountId(1);
		account.setAccountName("韩老师");
		account.setPassWord("123456");
		account.setUserId(1);
		account.setValidFlag(1);	
		accountroleservices.updateAccount(account);
	}
	@Test
	public void account_repeat(){//账户重复验证
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		Account account =new Account();
		account.setAccountId(3);
		account.setAccountName("刘老师");
		account.setPassWord("123456");
		account.setUserId(3);
		account.setValidFlag(1);	
		Boolean b=accountroleservices.getAccountRepeatVerify(account.getAccountId(),0,account.getAccountName());
		System.out.println("输出布尔类型结果"+b.toString());
	}
	@Test
	public void account_accountinfo(){////获取账户信息
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		Account account=accountroleservices.getAccountInfo(1);	
		System.out.println("测试获取账户id为1的账户名称信息"+account.getAccountName());
	}
		
	@Test
	public void account_accountinfoByid(){////根据用户id获取账户信息		用户id为1
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		List<Account> list =accountroleservices.getUserAccountList(1);
		for(int i=0;i<list.size();i++)
		{
			Account account=new Account();
			account.setAccountName(list.get(i).getAccountName());
			System.out.println("第"+(i+1)+"个账户的账户名为"+account.getAccountName());
			
		}
	}
		
	@Test
	public void account_accountList(){//测试账户列表
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		Account account =new Account();
		account.setAccountId(1);
		List<Account> list=accountroleservices.getAccountList(account);
		System.out.println("获取的集合的长度为"+list.size());
		for(int i=0;i<list.size();i++)
		{
			System.out.println("第"+(i+1)+"个账户名称"+list.get(i).getAccountName());
		}
		
	}
		@Test
		public void OrganAccountList(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
			AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
			List<Account> list=accountroleservices.getOrganAccountList(1);
			for(int i=0;i<list.size();i++){
				
				System.out.println("第"+(i+1)+"个"+list.get(i).getAccountName());
			}
		}
		@Test
		public void Role_insert(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
			AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
			Role role=new Role();
			role.setRoleId(3);
			role.setParentRoleId(1);
			role.setRoleLimit(10);
			role.setRoleName("长期职工");
			role.setRoleType(1);
			accountroleservices.addRole(role);
			System.out.println("测试添加role的rolename"+role.getRoleName());			
		}
		@Test
		public void Role_delete(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
			AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
			Role role=new Role();
			role.setRoleId(4);
			accountroleservices.deleteRole(role);
			System.out.println("测试删除role的roleid"+role.getRoleId());			
		}
		
		@Test//测试通过
		public void RoleRepeatVerify(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
			AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
			System.out.println("测试role是否重复"+accountroleservices.getRoleRepeatVerify(1,"职工"));			
		}
	@Test
	public void RoleInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		Role role=accountroleservices.getRoleInfo(1);
		
		System.out.println("测试获取rolename"+role.getRoleName());			
	}
	@Test//测试通过
	public void RoleList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		List<Role> list=accountroleservices.getRoleList("职工",1);		
		System.out.println("测试获取rolename"+list.get(0).getRoleLimit());			
	}
	@Test
	public void RoleChildrenList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		List<Role> list=accountroleservices.getRoleChildrenList(1);
		
		System.out.println("测试获取子角色的rolename"+list.get(0).getRoleName());			
	}
	@Test
	public void accountRole_delete(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		AccountRole accountrole=new AccountRole();
		accountrole.setAccountId(1);
		accountrole.setRoleId(1);
		accountroleservices.deleteAccountRole(accountrole);
	}
	@Test
	public void accountRole_insert(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		AccountRole accountrole=new AccountRole();
		accountrole.setAccountId(4);
		accountrole.setRoleId(4);
		accountroleservices.addAccountRole(accountrole);
	}
	@Test
	public void AccountRoleInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		Integer x=1;
		Integer y=1;
		AccountRole accountrole=accountroleservices.getAccountRoleInfo(x,y);
		System.out.println("测试获取accountRole对象的accountid"+accountrole.getAccountId());
	}

	
	@Test
	public void UserRoleList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		List<Role> list=accountroleservices.getUserRoleList(1);
		
		System.out.println("测试通过用户id获取角色的rolename"+list.get(0).getRoleName());			
	}
	@Test
	public void RoleAccountList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		List<Account> list=accountroleservices.getRoleAccountList(1);		
		System.out.println("测试通过角色id获取角色的accountname"+list.get(0).getAccountName());			
	}
	@Test
	//测试通过
	public void AccountList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		Account account=new Account();
		account.setAccountId(1);
		List<Account> list=accountroleservices.getAccountList(account);
		System.out.println("测试通过未知的account信息获取accountid"+list.get(0).getAccountId());			
	}
	@Test
	public void MenuPermitRole(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");
		List<Role> list=accountroleservices.getMenuPermitRole(1);
		for(int i=0;i<list.size();i++){
			System.out.println("测试有菜单权限的角色的Rolename"+list.get(i).getRoleName());			
		}			
	}
	@Test
	public void ActionPermitRole(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		List<Role> list=accountroleservices.getActionPermitRole(1);
		for(int i=0;i<list.size();i++){
			System.out.println("测试有数据项权限的角色的Rolename"+list.get(i).getRoleName());			
		}			
	}
	@Test
	public void RolePagingList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		Role role=new Role();
		role.setRoleId(1);
		accountroleservices.getRolePagingList(role, 1, 2);
		System.out.println("测试输出记录总数"+(accountroleservices.getRolePagingList(role, 1, 2).getResults().size()));	
		}	
	@Test
	public void AccountPagingList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		AccountRoleService accountroleservices = (AccountRoleService) factory.getBean("accountRoleService");		
		Account account=new Account();
		account.setUserId(1);
		account.setValidFlagConfig(3);
		account.setValidFlag(1);
		accountroleservices.getAccountPagingList(account, 1, 2);
		System.out.println("测试输出记录总数"+(accountroleservices.getAccountPagingList(account, 1, 2).getTotal()));	
		}	
}

