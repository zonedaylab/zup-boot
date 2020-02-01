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

    List<BI_Datasource> getDatasourcePagingList(BI_Datasource biDatasource);

    void deleteDatasourceInfo(int id);
}
