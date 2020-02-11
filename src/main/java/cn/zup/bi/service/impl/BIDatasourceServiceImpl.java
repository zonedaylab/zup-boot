package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIDatasourceDao;
import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.service.BIDatasourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author gavin
 */
@Service("biDatasourceService")
public class BIDatasourceServiceImpl implements BIDatasourceService {

    @Autowired
    private BIDatasourceDao biDatasourceDao;

    @Override
    public int addDatasource(BI_Datasource biDatasource) {

        try{
            if(biDatasource.getId() != null){
                biDatasourceDao.update(biDatasource);
            }else{
                biDatasourceDao.save(biDatasource);
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
        return biDatasourceDao.getDatasourcePagingList(biDatasource);
    }

    @Override
    public List<BI_Datasource> getDatasourcePagingList(BI_Datasource biDatasource) {
        List<BI_Datasource> list = biDatasourceDao.getDatasourcePagingList(biDatasource);
        return list;
    }

}
