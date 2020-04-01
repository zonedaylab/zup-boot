package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Post;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
@MiniDao
public interface OrganPostDao2 extends MiniDaoSupportHiber<Post>{
	@Arguments({"post","page", "rows"})
	@ResultType(Post.class)
	public MiniDaoPage<Post> getAllPosts(Post post, int page, int rows);

}

