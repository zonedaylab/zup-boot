package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.entity.BI_REPORT;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.io.Serializable;
import java.util.List;

/**
 * @author 王朔
 */
@MiniDao
public interface BIDatasourceDao extends MiniDaoSupportHiber<BI_Datasource> {


    @Arguments({"id"})
    @ResultType(BI_Datasource.class)
    BI_Datasource getDatasourceInfoById(int id);


    @Arguments({"biDatasource","page", "rows"})
    @ResultType(BI_Datasource.class)
    MiniDaoPage<BI_Datasource> getDatasourcePagingList(BI_Datasource biDatasource, int page, int rows);


    @Arguments({"id"})
    void deleteDatasourceInfo(int id);
}
