package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_Screen;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface BIScreenDao {

	/**
	 * @param biScreen
	 * @return
	 */
	List<BI_Screen> getBiScreenListPage(@Param("biScreen") BI_Screen biScreen);

	/**
	 * @param biScreen
	 * @return
	 */
	List<BI_Screen> getBiScreenList(@Param("biScreen") BI_Screen biScreen);

	BI_Screen getById(@Param("screen_Id") Integer screen_Id);

	/**
	 * @param screen_Id
	 */
	void deleteScreenById(@Param("screen_Id") Integer screen_Id);

	void save(@Param("biScreen") BI_Screen biScreen);

	void update(@Param("biScreen") BI_Screen biScreen);

}
