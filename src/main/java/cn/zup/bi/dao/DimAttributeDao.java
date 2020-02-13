package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_DIM;
import cn.zup.bi.entity.BI_DIM_ATTRIBUTE;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface DimAttributeDao {

    void save(@Param("biDimAttribute") BI_DIM_ATTRIBUTE biDimAttribute);

    void update(@Param("biDimAttribute") BI_DIM_ATTRIBUTE biDimAttribute);

    void delete(@Param("attribute_id") int attribute_id);

    List<BI_DIM_ATTRIBUTE> getDimInfoList(@Param("dimField") BI_DIM_ATTRIBUTE dimField);

    BI_DIM_ATTRIBUTE getBiDimAttributeById(@Param("attribute_id") int attribute_id);
}
