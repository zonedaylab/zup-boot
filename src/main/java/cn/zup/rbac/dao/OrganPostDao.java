package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.util.List;

@MiniDao
public interface OrganPostDao extends MiniDaoSupportHiber<Organ>{
	@Arguments({"post","organ","postName"})
	public List<Post> getexists(Integer post, Integer organ, String postName);
	@Arguments({"organ"})
	public List<Post> getOrganPostList(int organ);
	@Arguments({"organid"})
	public void deleteFromPost(Integer organid);
	@Arguments({"organid"})
	public void deleteFromUserInfo(Integer organid);
	@Arguments({"postid"})
	public void deletePostFromUserInfo(Integer postid);
	@Arguments({"organ","postName","validFlag"})
	public List<Post> getPostListByCondition(Integer organ, String postName, Integer validFlag);


		
	
}
