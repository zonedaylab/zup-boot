package cn.zup.bi.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_Page;

@MiniDao
public interface BIPageDao extends MiniDaoSupportHiber<BI_Page> {
	@Arguments({"biPage", "page", "rows"})
	@ResultType(BI_Page.class)
	MiniDaoPage<BI_Page> getBIPageListPage(BI_Page biPage, int page, int rows);
	
	@Arguments({"biPage"})
	@ResultType(BI_Page.class)
	List<BI_Page> getBIPageList(BI_Page biPage);
	

	@Arguments({"bi_Page_Id"})
	@ResultType(BI_Page.class)
	BI_Page getBIPageInfo(Integer bi_Page_Id);
	
	@Arguments({"bi_Page_Id"})
	void deletePageById(Integer bi_Page_Id);
}
