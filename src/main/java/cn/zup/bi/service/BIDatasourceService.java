package cn.zup.bi.service;

import cn.zup.bi.entity.BI_Datasource;

import java.util.List;

/**
 * @author ucisoft
 */
public interface BIDatasourceService {
    /***
     * 添加数据源
     * @param biDatasource
     * @return
     */
    int addDatasource(BI_Datasource biDatasource);

    /***
     * 更新数据源
     * @param biDatasource
     * @return
     */
    boolean updateDatasource(BI_Datasource biDatasource);

    /***
     * 删除数据源
     * @param id
     * @return
     */
    boolean delDatasource(Integer id);

    /***
     * 获取数据源详情
     * @param id
     * @return
     */
    BI_Datasource getDatasource(Integer id);

    /***
     * 获取数据源列表
     * @param biDatasource
     * @return
     */
    List<BI_Datasource> getDatasourceList(BI_Datasource biDatasource);
}
