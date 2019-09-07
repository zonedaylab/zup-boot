package cn.zup.rbac.junit;

import java.util.List;


import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.ConfigurationService;
import cn.zup.rbac.service.OrganPostService;


public class ConfigJunit{

	@Test
	public void AddConfig(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		ConfigurationService configurationservices = (ConfigurationService) factory.getBean("configurationService");
		Config config=new Config();
		config.setConfigid(2);
		config.setSubid(3);
		config.setName("性别");
		config.setSubname("middle");
		configurationservices.addConfig(config);
	}
	@Test
	public void ConfigList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		ConfigurationService configurationservices = (ConfigurationService) factory.getBean("configurationService");
		List<Config> list=configurationservices.getConfigList("组织机构");
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i).getName()+list.get(i).getSubid());
		}
	}
	@Test
	public void ConfigInfo(){//
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		ConfigurationService configurationservices = (ConfigurationService) factory.getBean("configurationService");		
		Config config = new Config();
		config.setConfigid(cn.zup.rbac.service.settings.ConfigSetting.ValigFlag.getValue());
		List<Config> list=configurationservices.getConfigInfo(config);
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i).getName()+list.get(i).getSubid());
		}		
	}	
}
