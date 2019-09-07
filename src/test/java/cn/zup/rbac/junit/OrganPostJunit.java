package cn.zup.rbac.junit;

import java.util.List;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.zup.rbac.dao.PostDao;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.service.OrganPostService;

public class OrganPostJunit{
	private PostDao oganpostDao2;
	@Test
	public void organ_insert(){//测试增加组织机构
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");	 
		
		Organ organ=new Organ();
		organ.setOrganId(4);
		organ.setParentOrganId(4);
		organ.setOrganCode("10434");
		organ.setOrganName("积成能源");
		organ.setShortName("积成");
		organ.setOrderCode(888);
		organ.setOrganType(1);
		organ.setGovernor("超级大Bose");
		organ.setValidFlag(1);
		organpostservices.addOrgan(organ);
	}
	@Test
	public void organ_delete(){//测试删除组织机构
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");
		Organ organ=new Organ();
		organ.setOrganId(4);
		organpostservices.deleteOrgan(organ);
	}
		
	@Test
	public void organ_update(){//测试更新Organ
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");
		
		Organ organ=new Organ();
		organ.setOrganId(2);
		organ.setParentOrganId(2);
		organ.setOrganCode("10434");
		organ.setOrganName("积成能源");
		organ.setShortName("积成de积成");
		organ.setOrderCode(8886666);
		organ.setOrganType(1);
		organ.setGovernor("超级大Bose");
		organ.setValidFlag(1);
		organpostservices.updateOrgan(organ);
		System.out.println("测试输出结果集的第一个用户名称"+organ.getOrganName());
	}
	@Test
	public void organ_info(){//测试两个参数获取Organ
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");
		Organ organ1=organpostservices.getOrganInfo(1);
		System.out.println("测试获取organ的id"+organ1.getOrganName());
	}
	@Test//测试组织排序号重复验证
	public void organ_repeat(){//测试organrepeatverify	
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");			
		Boolean b=organpostservices.getOrganRepeatVerify(null,6,"张庄镇");
		System.out.println("测试organ是否重复"+b.toString());
	}
	@Test
	public void organ_list(){//测试获取全部组织列表	
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");		
		List <Organ> list=organpostservices.getOrganList();
		System.out.println("获取list的长度"+list.size());
	}
	@Test
	public void organ_sublist(){//测试全部子组织列表
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");	
		List <Organ> list=organpostservices.getSubOrganList(1);
		System.out.println("获取自组织列表list的长度"+list.size());
	}
	@Test
	public void post_add(){//测试添加post
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");
		Post post=new Post();
		post.setPostId(88);
		post.setOrganId(1);
		post.setPostDuty("软件开发");
		post.setPostName("软件研发");
		post.setStandardNumber(66);
		post.setValidFlag(1);	
		organpostservices.addPost(post);
		System.out.println("测试输出结果集的第一个用户名称"+post.getPostName());
	}
	@Test
	public void post_delete(){//测试删除post
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");	
		Post post=new Post();
		post.setPostId(4);
		organpostservices.deletePost(post.getPostId());
		System.out.println("测试删除用户名称");
	}
		
	@Test
	public void post_update(){//测试更新post
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");
		Post post=new Post();
		post.setPostId(1);
		post.setOrganId(1);
		post.setPostDuty("软件开发");
		post.setPostName("软件研发");
		post.setStandardNumber(6666);
		post.setValidFlag(1);
		organpostservices.updatePost(post);
		System.out.println("测试输出结果集的第一个用户名称"+post.getPostName());
	}
	@Test
	public void post_repeat(){//post重复验证
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");	
		Post post=new Post();
		post.setPostId(109);
		post.setOrganId(3);
		//post.setPostDuty("软件研发");
		post.setPostName("安全员");
		//post.setStandardNumber(66);
	   // post.setValidFlag(1);
		Boolean b=organpostservices.getPostRepeatVerify(null,post.getOrganId(),post.getPostName());
		System.out.println("输出布尔类型结果"+b.toString());
	}
	
	@Test
	public void post_organ(){//验证 验证获取组织下岗位列表
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");	
		 List<Post> list =organpostservices.getOrganPostList(1);
		 for(int i=0;i<list.size();i++){
			 System.out.println("测试输出获取post的列表"+list.get(i).getPostName());
			 	 }
	}
	@Test
	public void post_apge(){	//测试岗位分页列表
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");
		Post post=new Post();
		post.setOrganId(1);
		post.setPostName("测试");
		organpostservices.getPostPagingList(post,1,2);
	}
	
	@Test
	public void PostInfo(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		OrganPostService organpostservices = (OrganPostService) factory.getBean("organPostService");	
		Post post=organpostservices.getPostInfo(1);
		System.out.println("测试获取职位名称"+post.getPostName());
	}
	
}
