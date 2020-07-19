package cn.zup.bi.service;
import cn.zup.bi.entity.V_ReportData;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface BIShowEngineService {

	List<Map<String, Object>> getBIPageService(V_ReportData vreportData) throws Exception;
	Map<String, Object>  showDimField(Integer reportId) throws Exception;
}
