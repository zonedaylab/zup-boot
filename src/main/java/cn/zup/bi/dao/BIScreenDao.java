package cn.zup.bi.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_Screen;

@MiniDao
public interface BIScreenDao extends MiniDaoSupportHiber<BI_Screen> {
	@Arguments({"biScreen", "page", "rows"})
	@ResultType(BI_Screen.class)
	MiniDaoPage<BI_Screen> getBIScreenListPage(BI_Screen biScreen, int page, int rows);
	
	@Arguments({"biScreen"})
	@ResultType(BI_Screen.class)
	List<BI_Screen> getBIScreenList(BI_Screen biScreen);
	
	@Arguments({"screen_Id"})
	void deleteScreenById(Integer screen_Id);
}
