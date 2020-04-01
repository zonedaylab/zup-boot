package cn.zup.bi.service.impl;

import cn.zup.bi.dao.ReportFieldDao;
import cn.zup.bi.entity.BI_REPORT_FIELD;
import cn.zup.bi.service.ReportFieldService;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author gavin
 */
@Service("reportFieldService")
public class ReportFieldServiceImpl implements ReportFieldService {
	@Autowired
	private ReportFieldDao reportFieldDao;
	
	/**
	 * 保存报表字段
	 * @author 谢炎
	 * @date 2016-10-11 14:51:30
	 * 
	 * */
	@Override
	public int saveReportField(BI_REPORT_FIELD reportField){
		try{
			if(reportField.getReport_Field_Id() != null) {
				reportFieldDao.updateReportField(reportField);
			}else {
				reportFieldDao.save(reportField);
			}
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	
	/**
	 * 删除报表模板字段
	 * @author 谢炎
	 * @date 2016-10-12 16:00:14
	 * @param report_Id
	 * */
	@Override
	public void deleteRpoetField(int report_Id){
		reportFieldDao.deleteReportField(report_Id);
	}

	@Override
	public BI_REPORT_FIELD getReportFieldInfo(BI_REPORT_FIELD reportField) {
		BI_REPORT_FIELD biReportField = reportFieldDao.getReportFieldById(reportField);
		return biReportField;
	}

	@Override
	public List<BI_REPORT_FIELD> getReportFieldList(BI_REPORT_FIELD report, int rows, int page) {
		return reportFieldDao.getReportFieldList(report, rows, page);
	}
	
}
