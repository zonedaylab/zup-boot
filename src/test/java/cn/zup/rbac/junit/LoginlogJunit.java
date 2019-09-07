package cn.zup.rbac.junit;

import java.util.Date;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.zup.framework.util.DateUtil;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.service.LoginLogService;

public class LoginlogJunit{
	public void AddLoginLog(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		LoginLogService loginlogService = (LoginLogService) factory.getBean("loginlogService");
		LoginLog loginlog=new LoginLog();
		loginlog.setLoginlogid(8);
		loginlog.setAccountid(1);
		loginlog.setSystemid(2);
		loginlog.setUserid(1);
		loginlog.setRetrycount(2);
		loginlog.setLogtype(1);		
		loginlogService.addLoginLog(loginlog);		
	}
	
	@Test
	public void getLoginLogPagingList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		LoginLogService loginLogService = (LoginLogService) factory.getBean("loginLogService");
		Date startLogDateTime= DateUtil.parseDateStr("2016-07-14");
		Date endLogDateTime= DateUtil.parseDateStr("2016-07-18");
		//MiniDaoPage<LoginLog> minipage=loginLogService.getLoginLogPagingList("李欣",startLogDateTime,endLogDateTime,1,1,1,2);	
		//System.out.println("测试获取集合的长度"+minipage.getResults().size());
	}
	
}
