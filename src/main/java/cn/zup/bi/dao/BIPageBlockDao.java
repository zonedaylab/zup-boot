package cn.zup.bi.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_Block_Info;

@MiniDao
public interface BIPageBlockDao extends MiniDaoSupportHiber<BI_Block_Info> {
	@Arguments({"biBlock", "page", "rows"})
	@ResultType(BI_Block_Info.class)
	MiniDaoPage<BI_Block_Info> getBIBlockListPage(BI_Block_Info biBlock, int page, int rows);
	
	@Arguments({"biBlock"})
	@ResultType(BI_Block_Info.class)
	List<BI_Block_Info> getBIBlockList(BI_Block_Info biBlock);
	
	@Arguments({"bi_Block_Id"})
	@ResultType(BI_Block_Info.class)
	BI_Block_Info getBIBlockInfo(Integer bi_Block_Id);
	
	@Arguments({"bi_Block_Id"})
	void deleteBlockById(Integer bi_Block_Id);
	
	@Arguments({"bi_Page_Id", "screen_Index", "block_Id"})
	@ResultType(BI_Block_Info.class)
	List<BI_Block_Info> getPageBlockByPageId(Integer bi_Page_Id, Integer screen_Index, Integer block_Id);
}
