package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface BIPageDao {

	List<BI_Page> getBIPageListPage(@Param("biPage") BI_Page biPage);


	List<BI_Page> getBIPageList(@Param("biPage") BI_Page biPage);


	BI_Page getBIPageById(@Param("bi_Page_Id") Integer bi_Page_Id);

	BI_Page getBIPageInfo(@Param("biPage") BI_Page biPage);


	void deletePageById(@Param("bi_Page_Id") Integer bi_Page_Id);

	void save(@Param("biPage") BI_Page biPage);

	void update(@Param("biPage") BI_Page biPage);
}
