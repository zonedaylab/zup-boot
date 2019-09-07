package cn.zup.bi.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_Screen;

public interface BIScreenService {
	int updateScreenInfo(BI_Screen biScreen);
	
	int deleteScreenInfo(int bi_Screen_Id);
	
	BI_Screen getBiScreen(BI_Screen biScreen);
	
	List<BI_Screen> getBiScreenList(BI_Screen biScreen);
	
	MiniDaoPage<BI_Screen> getBIScreenListPage(BI_Screen biScreen, int page, int rows);
}
