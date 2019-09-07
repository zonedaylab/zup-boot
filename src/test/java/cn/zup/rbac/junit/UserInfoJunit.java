package cn.zup.rbac.junit;

import java.util.Date;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;


import cn.zup.rbac.entity.EnergyRelation;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.UserService;

public class UserInfoJunit{

	@Test
	public void userinfo_insert(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");	
			UserService userServices= (UserService) factory.getBean("userService");
		//测试增加用户
			UserInfo userinfo=new UserInfo();
			//userinfo.setUserid(2);
			userinfo.setOrganId(1);
			userinfo.setPostId(1);
			userinfo.setRealName("李欣");
//			userinfo.setSex(0);
//			Date date1=DateUtil.parseDateStr("2016-07-01");
//			userinfo.setBirthday(date1);
//			userinfo.setIdentitycard("371426198911111111");
//			userinfo.setNativeplace("山东德州");
//			userinfo.setAddress("山东济南");
//			userinfo.setPhone("15098812889");
//			userinfo.setCellphone("15966015283");
//			userinfo.setEducation("研究生");
//			Date date2 = DateUtil.parseDateStr("2016-06-28");
//			userinfo.setGraduationdate(date2);
//			userinfo.setPoliticsstatus(1);
//			userinfo.setContracttype(1);
//			Date date3 = DateUtil.parseDateStr("2016-06-22");
//			userinfo.setContractstartdate(date3);
//			Date date4 = DateUtil.parseDateStr("2016-06-22");
//			userinfo.setContractterminationdate(date4);
//			userinfo.setProfessionalinfo("计算机应用技术");
//			Date date5 =DateUtil.parseDateStr("2016-06-28");
//			userinfo.setCreatedate(date5);
//			userinfo.setValidflag(1);
		
			userServices.addUser(userinfo);
		System.out.println("测试添加用户的真实名称"+userinfo.getRealName());
	}	

		@Test
		public void userinfo_delete(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
		//测试删除用户
			UserInfo user=new UserInfo();
			user.setUserId(3);
			userServices.deleteUser(user, true);
			System.out.println("测试删除用户的真实名称"+user.getUserId());			
		}
		
		@Test
		//测试通过
		public void userinfo_repeatVerify(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			Integer i=2;
			Boolean b=userServices.getUserRepeatVerify(i,"李欣");
			System.out.println("测试是否重复"+b.toString());			
		}
		@Test
		public void userinfo_UserInfo(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			userServices.getUserInfo(1);
			System.out.println("测试获取用户姓名"+userServices.getUserInfo(1).getRealName());			
		}
		@Test
		public void userinfo_AccountUserInfo(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			userServices.getAccountUserInfo(2);
			System.out.println("测试获取用户姓名"+userServices.getAccountUserInfo(2).getRealName());			
		}
		@Test
		public void userinfo_UserLsit(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");			
			userServices.getUserList(1,1,"李欣",1);
			System.out.println("测试获取用户id"+userServices.getUserList(1,1,"李欣",1).get(0).getUserId());			
		}
		@Test
		public void userinfo_OrganUserList(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");			
			userServices.getOrganUserList(1);
			System.out.println("测试获取用户id"+userServices.getOrganUserList(1).get(0).getRealName());			
		}
		@Test
		public void userinfo_PostUserList(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			
			userServices.getPostUserList(1);
			System.out.println("测试获取用户id"+userServices.getPostUserList(1).get(0).getRealName());			
		}
		@Test
		public void userinfo_UsersSession(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			UserSession usersession=userServices.getUserSessionInfo("李欣", "123");
			System.out.println("测试获取账户id"+usersession.getAccountId());	
			System.out.println("测试获取用户id"+usersession.getUserId());
			System.out.println("测试获取真实姓名"+usersession.getRealName());	
			
		}
		@Test
		public void UserSessionInfoByAccountID(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			UserSession usersession=userServices.getUserSessionInfoByAccountID(1);
			System.out.println("测试获取账户id"+usersession.getAccountId());	
			System.out.println("测试获取用户id"+usersession.getUserId());
			System.out.println("测试获取真实姓名"+usersession.getRealName());			
		}
		@Test
		public void getUserPagingList(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			UserService userServices= (UserService) factory.getBean("userService");
			UserInfo userinfo=new UserInfo();
			userinfo.setOrganId(1);
			//userinfo.setUserid(1);
			userinfo.setPostId(86);
			//userinfo.setRealname("韩老师");
			//userinfo.setValidflag(1);
			MiniDaoPage<UserInfo> userinfominipage=userServices.getUserPagingList(userinfo,1,2);	
			System.out.println("yeshu"+userinfominipage.getPage());		
		}
		@Test
		public void getEnergyRelation(){
			BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");			
			MerchantService merchantService= (MerchantService) factory.getBean("merchantService");
			EnergyRelation energyRelationTemp=new EnergyRelation();
			energyRelationTemp.setCommon_Organ_Id(1);
			EnergyRelation energyRelation=merchantService.getEnergyRelationInfo(energyRelationTemp);
			System.err.println(energyRelation.getDepartment_Id());
		}
		
		
	}
