package cn.zup.bi.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.bi.entity.BIShowField;

@MiniDao
public interface BIShowEngineDao extends MiniDaoSupportHiber<BIShowField>{
	@Arguments({"ids", "report_Id"})
	@ResultType(BIShowField.class)
	List<BIShowField> getReportDimInfo(String ids, Integer report_Id);
	
	@Arguments({"ids", "report_Id"})
	@ResultType(BIShowField.class)
	List<BIShowField> getReportTopicInfo(String ids, Integer report_Id);
	
}
