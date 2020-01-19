package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_DIM;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface DimDao extends MiniDaoSupportHiber<BI_DIM> {
	/**
	 * 分页模式获取维度列表
	 *
	 * */
	@Arguments({"dim","page", "rows"})
	@ResultType(cn.zup.bi.entity.BI_DIM.class)
	MiniDaoPage<BI_DIM> getDimPagingList(BI_DIM dim, int page, int rows);

	@Arguments({"reportId"})
	@ResultType(BI_DIM.class)
	List<BI_DIM> getDimField(Integer reportId);
	
	/**
	 * 根据字段名称获取到表名
	 * 
	 * */
	@Arguments({"filterName"})
	@ResultType(BI_DIM.class)
	List<BI_DIM> getDimFilter(String filterName);

	/**
	 * 根据字段删除维表
	 *
	 * */
	@Arguments({"dimid"})
	void deleteDim(int dimid);

}
