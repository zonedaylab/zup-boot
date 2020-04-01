package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_Datasource;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author 王朔
 * @update gavin
 */
@Repository
public interface BIDatasourceDao {

    /**
     * 已经修改了Mybatis
     * @param id
     * @return
     */
    BI_Datasource getDatasourceInfoById(@Param("id") Integer id);

    List<BI_Datasource> getDatasourcePagingList(@Param("biDatasource") BI_Datasource biDatasource);

    void deleteDatasourceInfo(@Param("id") int id);

    void save(@Param("biDatasource") BI_Datasource biDatasource);

    void update(@Param("biDatasource") BI_Datasource biDatasource);
}
