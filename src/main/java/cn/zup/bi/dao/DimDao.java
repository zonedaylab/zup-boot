package cn.zup.bi.dao;

import java.util.List;

import org.apache.ibatis.annotations.ResultType;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.bi.entity.BI_DIM;

@MiniDao
public interface DimDao extends MiniDaoSupportHiber<BI_DIM> {
	@Arguments({"reportId"})
	@ResultType(BI_DIM.class)
	List<BI_DIM> getDimField(Integer reportId);
}
