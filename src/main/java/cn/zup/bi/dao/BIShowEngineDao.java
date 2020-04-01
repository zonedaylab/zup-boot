package cn.zup.bi.dao;

import cn.zup.bi.entity.BIShowField;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface BIShowEngineDao{

	/**
	 * @param ids
	 * @param report_Id
	 * @return
	 */
	List<BIShowField> getReportDimInfo(@Param("ids") String ids, @Param("report_Id") Integer report_Id);

	/**
	 * @param ids
	 * @param report_Id
	 * @return
	 */
	List<BIShowField> getReportTopicInfo(@Param("ids") String ids, @Param("report_Id") Integer report_Id);
	
}
