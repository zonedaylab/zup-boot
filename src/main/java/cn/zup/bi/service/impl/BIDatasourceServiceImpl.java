package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIDatasourceDao;
import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.service.BIDatasourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        biDatasourceDao.saveByHiber(biDatasource);
        return biDatasource.getId();
    }

    @Override
    public boolean updateDatasource(BI_Datasource biDatasource) {
        biDatasourceDao.saveByHiber(biDatasource);
        return true;
    }

    @Override
    public boolean delDatasource(Integer id) {
        BI_Datasource biDatasource = new BI_Datasource();
        biDatasource.setId(id);
        biDatasourceDao.deleteByHiber(biDatasource);
        return false;
    }

    @Override
    public BI_Datasource getDatasource(Integer id) {
        BI_Datasource biDatasource = new BI_Datasource();
        biDatasource.setId(id);
        return biDatasourceDao.getByEntityHiber(biDatasource);
    }

    @Override
    public List<BI_Datasource> getDatasourceList(BI_Datasource biDatasource) {
        return biDatasourceDao.listByHiber(biDatasource);
    }
}
