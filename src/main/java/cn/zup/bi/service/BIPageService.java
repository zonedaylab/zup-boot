package cn.zup.bi.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_Page;

public interface BIPageService {
	int updatePageInfo(BI_Page biPage);
	
	int deletePageInfo(int bi_Page_Id);
	
	BI_Page getBiPage(BI_Page biPage);
	
	List<BI_Page> getBiPageList(BI_Page biPage);
	
	MiniDaoPage<BI_Page> getBIPageListPage(BI_Page biPage, int page, int rows);
}
