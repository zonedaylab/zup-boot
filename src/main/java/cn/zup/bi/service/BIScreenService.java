package cn.zup.bi.service;

import cn.zup.bi.entity.BI_Screen;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

public interface BIScreenService {
	int updateScreenInfo(BI_Screen biScreen);
	
	int deleteScreenInfo(int bi_Screen_Id);
	
	BI_Screen getBiScreen(BI_Screen biScreen);
	
	List<BI_Screen> getBiScreenList(BI_Screen biScreen);

	List<BI_Screen> getBIScreenListPage(BI_Screen biScreen, int page, int rows);
}
