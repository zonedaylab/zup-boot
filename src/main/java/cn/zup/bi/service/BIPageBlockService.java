package cn.zup.bi.service;

import cn.zup.bi.entity.BI_Block_Info;

import java.util.List;

public interface BIPageBlockService {
	
	Integer saveBlock(BI_Block_Info bi_Block_Info);

	boolean updateBlock(BI_Block_Info bi_Block_Info);
	
	boolean deleteBlock(Integer bi_Block_Id);
	
	boolean deleteBlockByPageId(Integer page_Id);
	
	BI_Block_Info getBlockInfo(Integer bi_Block_Id);
	
	List<BI_Block_Info> getBlockList(BI_Block_Info bi_Block_Info);

	List<BI_Block_Info> getBlockListByPage(BI_Block_Info bi_Block_Info, int rows, int page);
	
	/**
	 * 根据页面id和屏幕顺序来获取页面需要的报表信息
	 * 
	 * */
	List<BI_Block_Info> getPageBlockByPageId(Integer bi_Page_Id, Integer screen_Index, Integer block_Id);
}
