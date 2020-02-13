package cn.zup.bi.service;

import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.entity.BI_REPORT;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

/**
 * @author ucisoft
 */
public interface BIDatasourceService {
    /***
     * 添加数据源and更新数据源
     * @param biDatasource
     * @return
     */
    int addDatasource(BI_Datasource biDatasource);



    /***
     * 删除数据源
     * @param id
     * @return
     */
    int deleteDatasource(int id);

    /***
     * 获取数据源详情
     * @param id
     * @return
     */
    BI_Datasource getDatasourceInfo(int id);

    /***
     * 获取数据源列表
     * @param biDatasource
     * @return
     */
    List<BI_Datasource> getDatasourceList(BI_Datasource biDatasource);


    /***
     *
     * @author 王朔
     */
    List<BI_Datasource> getDatasourcePagingList(BI_Datasource biDatasource);

}
