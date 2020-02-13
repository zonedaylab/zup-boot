package cn.zup.bi.service;

import cn.zup.bi.entity.BI_REPORT_FIELD;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;


public interface ReportFieldService {
	/**
	 * 保存报表字段
	 * @author 谢炎
	 * @date 2016-10-11 14:51:30
	 * 
	 * */
	int saveReportField(BI_REPORT_FIELD reportField);
	
	/**
	 * 删除报表模板字段
	 * @author 谢炎
	 * @date 2016-10-12 16:00:14
	 * */
	void deleteRpoetField(int report_Id);
	
	BI_REPORT_FIELD getReportFieldInfo(BI_REPORT_FIELD reportField);

	List<BI_REPORT_FIELD> getReportFieldList(BI_REPORT_FIELD reportField, int rows, int page);
}
