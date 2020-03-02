package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Post;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface PostDao extends MiniDaoSupportHiber<Post>{
	@Arguments({"post","page", "rows"})
	@ResultType(Post.class)
	public MiniDaoPage<Post> getPostPagingList(Post post, int page, int rows);
	@Arguments({"postId","organId","postName"})
	public List<Post> getPostRepeatVerify(Integer postId, Integer organId, String postName);
	@Arguments({"organId","postName","validFlag"})
	public List<Post> getPostListByCondition(Integer organId, String postName, Integer validFlag);
	@Arguments({"parentOrganId","myOrganIds"})
	@ResultType(Post.class)
	public List<Post> getTreeReceiverPost(int parentOrganId, String myOrganIds);
}

