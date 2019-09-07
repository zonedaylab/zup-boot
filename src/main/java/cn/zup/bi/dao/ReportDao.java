package cn.zup.bi.dao;

import org.jeecgframework.minidao.annotation.ResultType;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_REPORT;

@MiniDao
public interface ReportDao extends MiniDaoSupportHiber<BI_REPORT> {
	
	@Arguments({"biReport","page", "rows"})
	@ResultType(BI_REPORT.class)
	MiniDaoPage<BI_REPORT> getReportPagingList(BI_REPORT biReport, int page,int rows);
	
	@Arguments({"reportId"})
	@ResultType(BI_REPORT.class)
	BI_REPORT getReportInfoById(int reportId);
	
	@Arguments({"pageId", "screenIndex"})
	@ResultType(BI_REPORT.class)
	List<BI_REPORT> getReportListByPageId(int pageId, int screenIndex);
	
	@Arguments({"reportId"})
	void deleteReportInfo(int reportId);
}
