package cn.zup.junit;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.zup.rbac.service.CodeConfigService;

public class TestSync implements Runnable{
	BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
	CodeConfigService codeconfigservice=(CodeConfigService) factory.getBean("codeConfigService");
    public void run(){
        for(int i=0;i<20;i++){
            getCodeInfoA();
        }
    }
    
    private void getCodeInfoA(){
    	for(int i=0;i<5 ;i++){
			String codeconfig=codeconfigservice.getCodeInfo(34,null);
			System.err.println("A测试获取的流水号"+codeconfig);		
		}
    }
}