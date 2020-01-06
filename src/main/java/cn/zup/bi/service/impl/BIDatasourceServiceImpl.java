package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIDatasourceDao;
import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.entity.BI_REPORT;
import cn.zup.bi.service.BIDatasourceService;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author ucisoft
 */
@Service("biDatasourceService")
public class BIDatasourceServiceImpl implements BIDatasourceService {

    @Autowired
    private BIDatasourceDao biDatasourceDao;

    @Override
    public int addDatasource(BI_Datasource biDatasource) {

        try{
            if(biDatasource.getId() != null){
                biDatasourceDao.updateByHiber(biDatasource);
            }else{
                biDatasourceDao.saveByHiber(biDatasource);
            }
        }catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return biDatasource.getId();
    }


    @Override
    public int deleteDatasource(int id) {
        try{
            biDatasourceDao.deleteDatasourceInfo(id);
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
        return 1;
    }

    @Override
    public BI_Datasource getDatasourceInfo(int id) {
        BI_Datasource biDatasource = biDatasourceDao.getDatasourceInfoById(id);
        return biDatasource;
    }

    @Override
    public List<BI_Datasource> getDatasourceList(BI_Datasource biDatasource) {
        return biDatasourceDao.listByHiber(biDatasource);
    }

    @Override
    public MiniDaoPage<BI_Datasource> getDatasourcePagingList(BI_Datasource biDatasource, int page, int rows) {
        return biDatasourceDao.getDatasourcePagingList(biDatasource, page, rows);

    }

}
