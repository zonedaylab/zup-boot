package cn.zup.rbac.dao;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.service.OperateLogService;
@MiniDao
public interface OrganPostDao2 extends MiniDaoSupportHiber<Post>{
	@Arguments({"post","page", "rows"})
	@ResultType(Post.class)
	public MiniDaoPage<Post> getAllPosts(Post post, int page,int rows);

}

