package cn.zup.bi.service;

import cn.zup.bi.entity.ConditionTransfer;

import java.util.List;

public interface BIShowEngineService {
	String showReport(ConditionTransfer conditionTransfer);
	
	List<String> showDimField(Integer reportId);
}
