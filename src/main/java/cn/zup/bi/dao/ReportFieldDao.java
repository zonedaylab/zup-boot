package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_REPORT_FIELD;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface ReportFieldDao {

	void deleteReportField(Integer report_Field_Id);


	List<BI_REPORT_FIELD> getReportFieldList(@Param("reportField") BI_REPORT_FIELD reportField, @Param("rows") int rows, @Param("page") int page);


	BI_REPORT_FIELD getReportFieldById(@Param("reportField") BI_REPORT_FIELD reportField);


	void updateReportField(@Param("reportField") BI_REPORT_FIELD reportField);


	List<BI_REPORT_FIELD> getReportFieldByReportId(@Param("reportId") int reportId);


	List<BI_REPORT_FIELD> getReportTopicField(@Param("reportId") int reportId);


	Integer getReportDimCount(@Param("reportId") int reportId);

	void save(@Param("reportField") BI_REPORT_FIELD reportField);
}
