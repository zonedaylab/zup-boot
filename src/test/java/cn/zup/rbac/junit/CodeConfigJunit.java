package cn.zup.rbac.junit;

import java.util.ArrayList;
import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.zup.rbac.entity.CodeConfig;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.service.CodeConfigService;


public class CodeConfigJunit {
	@Test
	public void CodeConfigInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		CodeConfigService codeconfigservice=(CodeConfigService) factory.getBean("codeConfigService");
		CodeConfig c=codeconfigservice.getCodeConfigInfo(1);
		System.out.println("测试获取编码配置的备注信息"+c.getMemo());
}
	@Test
	public void CodeConfigList(){//
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		CodeConfigService codeconfigservice=(CodeConfigService) factory.getBean("codeConfigService");
		CodeConfig codeconfig=new CodeConfig();
		codeconfig.setConfigcode("随意编码");
		codeconfig.setMemo("随意编码成功");
		MiniDaoPage<CodeConfig> page=codeconfigservice.getCodeConfigList(codeconfig, 1, 2);
		System.out.println("测试获取结果集"+page.getResults().size());		
}	
	@Test
	public void GetCodeInfo(){//
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		CodeConfigService codeconfigservice=(CodeConfigService) factory.getBean("codeConfigService");
		List<String> codeParams=new ArrayList<String>();
		codeParams.add("2233");	
		for(int i=0;i<5 ;i++){
			String codeconfig=codeconfigservice.getCodeInfo(34,codeParams);
			System.err.println("测试获取的流水号"+codeconfig);		
		}
	}	
}
