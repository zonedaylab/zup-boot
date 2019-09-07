package cn.zup.rbac.junit;

import java.util.Date;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.zup.framework.util.DateUtil;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.service.OperateLogService;

public class OperateLogJunit{

//	@Test
//	public void addOperateLog(){
//		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
//		OperateLogService operateLogService = (OperateLogService) factory.getBean("operateLogService");
//		OperateLog operatelog=new OperateLog();
//		operatelog.setOperateid(4);
//		operatelog.setLoginfo("测试");
//		operatelog.setSystemid(1);
//		operatelog.setUserid(1);
//		operateLogService.addOperateLog(operatelog);
//	}
//	
//	@Test
//	public void getOperateLogPagingList(){
//		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
//		OperateLogService operateLogService = (OperateLogService) factory.getBean("operateLogService");
//		OperateLog operatelog=new OperateLog();
//		operatelog.setOperateid(4);
//		operatelog.setLoginfo("测试");
//		operatelog.setSystemid(1);
//		operatelog.setUserid(1);
//		Date date=DateUtil.parseDateStr("2016-07-12");
//		operatelog.setLogdate(date);
//		operateLogService.getOperateLogPagingList(operatelog,1,2);
//		System.out.println("测试获取结果集的长度"+operateLogService.getOperateLogPagingList(operatelog,1,2).getResults().size());
//	}
}
