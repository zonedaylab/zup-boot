package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_Datasource;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.io.Serializable;
import java.util.List;

/**
 * @author ucisoft
 */
@MiniDao
public interface BIDatasourceDao extends MiniDaoSupportHiber<BI_Datasource> {

}
