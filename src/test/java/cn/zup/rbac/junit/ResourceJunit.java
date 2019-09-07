package cn.zup.rbac.junit;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.zup.rbac.entity.Action;
import cn.zup.rbac.entity.ActionPermission;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.RoleAction;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.service.ResourceService;

public class ResourceJunit{
	@Test//测试增加系统
	public void addSystem(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");	
		System system =new System();
		system.setSystemName("测试系统2222");
		system.setSystemUrl("192.16.10.88");
		system.setValidFlag(1);
		resourceservices.addSystem(system);	
	}
	@Test//测试删除系统
	public void deleteSystem(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");	
		System system =new System();
		system.setSystemId(5);	
		resourceservices.deleteSystem(system);	
	}
	@Test
	public void SystemRepeatVerify(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
		Integer i=1;
		Boolean b=resourceservices.getSystemRepeatVerify(i,"运维系统");
	
	}
	@Test
	public void SystemInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
		resourceservices.getSystemInfo(1);
	
	}
	
	@Test
	public void SystemList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
	
	}
	@Test
	public void AddMenu(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
		Menu menu=new Menu();
		menu.setMenuId(4);
		menu.setSystemId(2);
		menu.setParentMenuId(0);
		menu.setMenuName("导航菜单");			
	
	}
	@Test
	public void MenuRepeatVerify(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");				
	
	}
	@Test
	public void MenuInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				Menu menu1=resourceservices.getMenuInfo(1);
				
	}
	@Test
	public void MenuListformParent(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				List<Menu> list=resourceservices.getMenuList(0);
	
	}
	@Test
	public void SystemMenuList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				List<Menu> list=resourceservices.getSystemMenuList(1,0,false);
				for(int i=0;i<list.size();i++)
				{
					list.get(i).getMenuName();	
					java.lang.System.out.println(list.get(i).getMenuName());
				}	
	}
	@Test
	public void AccountPermitMenu(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				List<Menu> list=resourceservices.getAccountPermitMenu(1,1,true,2);
				for(int i=0;i<list.size();i++)
				{
					list.get(i).getMenuName();	
				}	
	}
	@Test
	public void RolePermitMenu(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				List<Menu> list=resourceservices.getRolePermitMenu(1,1);
				for(int i=0;i<list.size();i++)
				{
					list.get(i).getMenuName();	
				}	
	}
	@Test
	public void AccountPermitSubMenu(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				List<Menu> list=resourceservices.getAccountPermitSubMenu(1,0,2);
				for(int i=0;i<list.size();i++)
				{
					list.get(i).getMenuName();	
				}	
	}
	@Test
	public void addAction(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				Action action=new Action();
				action.setActionId(2);
				action.setMenuId(1);
				action.setActionName("删除数据项");				
				resourceservices.addAction(action);					
	}
	@Test
	public void ActionInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");				
		Action action=resourceservices.getActionInfo(2);	
		
	}
	@Test
	public void ActionRepeatVerify(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				
		Boolean b=resourceservices.getActionRepeatVerify(1,1,"增加数据项");	
		
	}
	@Test
	public void ActionList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				
		List<Action> list=resourceservices.getActionList(1);	
		
	}
	@Test
	public void RolePermitAction(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourceService resourceservices = (ResourceService) factory.getBean("resourceService");
				
		MiniDaoPage<ActionPermission> list=resourceservices.getRolePermitAction(1,1,1,1);	
		
	}	 
}
