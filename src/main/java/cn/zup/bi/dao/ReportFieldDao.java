package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_REPORT_FIELD;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface ReportFieldDao extends MiniDaoSupportHiber<BI_REPORT_FIELD>{
	@Arguments({"report_Field_Id"})
	public void deleteReportField(Integer report_Field_Id);
	
	@Arguments({"reportField", "rows", "page"})
	@ResultType(BI_REPORT_FIELD.class)
	MiniDaoPage<BI_REPORT_FIELD> getReportFieldList(BI_REPORT_FIELD reportField, int rows, int page);
	
	@Arguments({"reportField"})
	@ResultType(BI_REPORT_FIELD.class)
	BI_REPORT_FIELD getReportFieldById(BI_REPORT_FIELD reportField);
	
	@Arguments({"reportField"})
	void updateReportField(BI_REPORT_FIELD reportField);
	
	@Arguments({"reportId"})
	@ResultType(BI_REPORT_FIELD.class)
	List<BI_REPORT_FIELD> getReportFieldByReportId(int reportId);
	
	@Arguments({"reportId"})
	@ResultType(BI_REPORT_FIELD.class)
	List<BI_REPORT_FIELD> getReportTopicField(int reportId);
	
	@Arguments({"reportId"})
	@ResultType(Integer.class)
	Integer getReportDimCount(int reportId);
}
