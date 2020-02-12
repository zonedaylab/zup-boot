package cn.zup.bi.service.impl;

import cn.zup.bi.dao.ReportDao;
import cn.zup.bi.entity.BI_REPORT;
import cn.zup.bi.service.BIDimService;
import cn.zup.bi.service.ReportService;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author gavin
 * @see cn.zup.bi.service.ReportService
 */
@Service("reportService")
public class ReportServiceImpl implements ReportService {
	@Autowired
	private ReportDao reportDao;
	@Resource
	private BIDimService biDimService;

	
	/**
	 * 保存报表模板
	 * @author 谢炎
	 * @date 2016-10-11 14:51:30
	 * 
	 * */
	@Override
	public int saveReport(BI_REPORT report){
		report.setCreate_Date(new Date());
		try{
			if(report.getReport_Id() != null){
				reportDao.update(report);
			}else{
				reportDao.save(report);
			}
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return 1;
	}

	@Override
	public int deleteReport(int report_Id) {
		try{
			reportDao.deleteReportInfo(report_Id);
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return 1;
	}

	@Override
	public BI_REPORT getReportInfo(int reportId) {
		BI_REPORT biReport = reportDao.getReportInfoById(reportId);
		return biReport;
	}

	@Override
	public List<BI_REPORT> getReportPagingList(BI_REPORT bi_Report) {
		return reportDao.getReportPagingList(bi_Report);
	}

	@Override
	public List<BI_REPORT> getReportListByPageId(int pageId, int screenIndex) {
		return reportDao.getReportListByPageId(pageId, screenIndex);
	}	
}
