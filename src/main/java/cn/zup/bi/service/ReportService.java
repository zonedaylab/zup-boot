package cn.zup.bi.service;

import cn.zup.bi.entity.BI_REPORT;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

public interface ReportService {
	
	/**
	 * 保存报表模板
	 * @author 谢炎
	 * @date 2016-10-11 14:51:30
	 * 
	 * */
	int saveReport(BI_REPORT report);
	
	int deleteReport(int report_Id);
	
	BI_REPORT getReportInfo(int reportId);

	List<BI_REPORT> getReportPagingList(BI_REPORT report);
	
	List<BI_REPORT> getReportListByPageId(int pageId, int screenIndex);
	
}
