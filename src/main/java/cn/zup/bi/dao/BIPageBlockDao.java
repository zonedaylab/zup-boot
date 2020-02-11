package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_Block_Info;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 页面块仓储
 * @author gavin
 */
@Repository
public interface BIPageBlockDao {

	List<BI_Block_Info> getBIBlockList(@Param("biBlock") BI_Block_Info biBlock);

	BI_Block_Info getBIBlockInfo(@Param("bi_Block_Id") Integer bi_Block_Id);

	void deleteBlockById(@Param("bi_Block_Id") Integer bi_Block_Id);

	List<BI_Block_Info> getPageBlockByPageId(@Param("bi_Page_Id") Integer bi_Page_Id
			, @Param("screen_Index") Integer screen_Index
			, @Param("block_Id") Integer block_Id);

	void save(@Param("biBlock") BI_Block_Info biBlock);

	void update(@Param("biBlock") BI_Block_Info biBlock);

	void deleteBlockByPageId(Integer page_id);
}
