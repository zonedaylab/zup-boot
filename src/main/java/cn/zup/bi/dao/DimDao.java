package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_DIM;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface DimDao {
	/**
	 * 分页模式获取维度列表
	 *
	 * */
    List<BI_DIM> getDimPagingList(@Param("dim") BI_DIM dim);

	List<BI_DIM> getDimField(@Param("reportId") Integer reportId);
	
	/**
	 * 根据字段名称获取到表名
	 * 
	 * */
	List<BI_DIM> getDimFilter(@Param("filterName") String filterName);

	/**
	 * 根据字段删除维表
	 *
	 * */
	void deleteDim(@Param("dimid") int dim_Id);


	void save(@Param("dim") BI_DIM dim);

	void update(@Param("dim") BI_DIM dim);

	List<BI_DIM> getDimList(@Param("biDim") BI_DIM dim);

	BI_DIM getDimById(@Param("dimId") int dim_Id);

	BI_DIM getDimInfo(@Param("dim") BI_DIM dim);
}
