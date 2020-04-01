package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_REPORT;
import org.apache.ibatis.annotations.Param;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface ReportDao {

	List<BI_REPORT> getReportPagingList(@Param("biReport") BI_REPORT biReport);

	BI_REPORT getReportInfoById(@Param("reportId") int reportId);

	List<BI_REPORT> getReportListByPageId(@Param("pageId") int pageId, @Param("screenIndex") int screenIndex);

	void deleteReportInfo(@Param("reportId") int reportId);

	void update(@Param("report") BI_REPORT report);

	void save(@Param("report") BI_REPORT report);
}
