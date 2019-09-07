package cn.zup.rbac.junit;

import java.util.List;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.zup.rbac.entity.ActionPermission;
import cn.zup.rbac.entity.MenuPermission;
import cn.zup.rbac.entity.RoleAction;
import cn.zup.rbac.entity.RoleData;
import cn.zup.rbac.entity.RoleMenu;
import cn.zup.rbac.service.ResourcePermissionService;
public class ResourcePermissionJunit{

	@Test
	public void AddMenuPermission(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		RoleMenu roleMenu=new RoleMenu(); 
		roleMenu.setMenuId(3);
		roleMenu.setRoleId(1);
		roleMenu.setMenuPermission(1);
		resourcePermissionservices.addMenuPermission(roleMenu);
	}
	@Test
	public void MenuPermissionInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");	
		RoleMenu rolemenu=resourcePermissionservices.getMenuPermissionInfo(1,1);
		System.out.println("测试获取menu的id"+rolemenu.getRoleId());
	}
	@Test
	public void MenuPermissionList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");		
		List<MenuPermission> list=resourcePermissionservices.getMenuPermissionList(1,1);
		System.out.println("测试获取menuPermission的menuname"+list.get(0).getMenuName());
	}
	@Test
	public void AddActionPermission(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		RoleAction roleaction=new RoleAction();
		roleaction.setActionId(2);
		roleaction.setRoleId(2);
		roleaction.setActionPermission(1);		
		resourcePermissionservices.addActionPermission(roleaction);		
	}
	@Test
	public void ActionPermissionInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		RoleAction roleaction=resourcePermissionservices.getActionPermissionInfo(2,2);
		System.out.println("测试获取action的id"+roleaction.getActionId());			
	}
	@Test
	public void ActionPermissionList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		List<ActionPermission> list=resourcePermissionservices.getActionPermissionList(1,1);
		System.out.println("测试获取action的name"+list.get(0).getActionName());			
	}
	@Test
	public void PermissionCodeVerification(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		Boolean b=resourcePermissionservices.getPermissionCodeVerification(1,"2");
		System.out.println("测试permissionCode是否重复"+b.toString());			
	}
	@Test
	public void AddDataPermission(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		RoleData data=new RoleData();
		data.setDataId(2);
		data.setDataPermission("只读数据");
		data.setDataPermissionType(1);
		data.setMenuId(1);
		data.setRoleId(1);
		resourcePermissionservices.addDataPermission(data);				
	}
	@Test
	public void DataPermissionInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		RoleData data=resourcePermissionservices.getDataPermissionInfo(1);	
		System.out.println("测试获取权限的名称"+data.getDataPermission());
	}
	@Test
	public void AccountDataPermissionList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		cn.zup.rbac.service.settings.DataPermissionType type=cn.zup.rbac.service.settings.DataPermissionType.forValue(1);	
		List<RoleData> list=resourcePermissionservices.getAccountDataPermissionList(1,1,type);	
		System.out.println("测试获取权限的名称"+list.get(0).getDataPermission());
	}
	@Test
	public void RoleDataPermissionList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		List<RoleData> list=resourcePermissionservices.getRoleDataPermissionList(1);	
		System.out.println("测试获取权限的名称"+list.get(0).getDataPermission());
	}
	@Test
	public void MenuDataPermissionList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");		
		ResourcePermissionService resourcePermissionservices = (ResourcePermissionService) factory.getBean("resourcePermissionService");
		List<RoleData> list=resourcePermissionservices.getMenuDataPermissionList(1,1);	
		System.out.println("测试获取权限的名称"+list.get(0).getDataPermission());
	}		 
}
