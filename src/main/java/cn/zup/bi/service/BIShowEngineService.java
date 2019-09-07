package cn.zup.bi.service;

import java.util.List;

public interface BIShowEngineService {
	String showReport(Integer reportId, List<String> key, List<Object> value);
	
	List<String> showDimField(Integer reportId);
}
