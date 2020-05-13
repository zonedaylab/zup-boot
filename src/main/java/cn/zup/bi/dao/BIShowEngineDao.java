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
	 * @param report_Id
	 * @return
	 */
	List<BIShowField> getReportDimInfo( @Param("report_Id") Integer report_Id);

	/**

	 * @param report_Id
	 * @return
	 */
	List<BIShowField> getReportTopicInfo( @Param("report_Id") Integer report_Id);
	
}
