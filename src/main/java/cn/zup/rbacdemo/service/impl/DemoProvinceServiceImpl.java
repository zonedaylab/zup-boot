package cn.zup.rbacdemo.service.impl;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.entity.RoleData;
import cn.zup.rbacdemo.dao.DemoProvinceDao;
import cn.zup.rbacdemo.entity.DemoProvince;
import cn.zup.rbacdemo.service.DemoProvinceService;

@Service("demoProvinceService")
public class DemoProvinceServiceImpl implements DemoProvinceService {

	@Autowired
	private DemoProvinceDao demoProvinceDao;
	
	public void add(DemoProvince demoProvince) {
		demoProvinceDao.saveByHiber(demoProvince);
	}

	public void saveByHiber(DemoProvince demoProvince) {
		demoProvinceDao.saveByHiber(demoProvince);

	}

	public void updateByHiber(DemoProvince demoProvince) {
		demoProvinceDao.updateByHiber(demoProvince);

	}

	public DemoProvince getByIdHiber(Class<DemoProvince> class1, String id) {
		return demoProvinceDao.getByIdHiber(class1, id);
	}

	public void deleteByHiber(DemoProvince demoProvince) {
		demoProvinceDao.deleteByHiber(demoProvince);
	}

	public void deleteByIdHiber(Class<DemoProvince> class1, String id) {
		demoProvinceDao.deleteByIdHiber(DemoProvince.class, id);
	}

	public List<DemoProvince> listByHiber(DemoProvince DemoProvince) {
		return demoProvinceDao.listByHiber(DemoProvince);
	}

	@Override
	public MiniDaoPage<DemoProvince> getProvincePagingList(DemoProvince demoProvince, Integer page, Integer rows,List<RoleData> roledata) {
		
		StringBuffer sb = new StringBuffer();
		//实现类拼接sql
		for(RoleData role : roledata){
			sb.append(" and ");
			sb.append(role.getDataPermission());
		}
		
		return demoProvinceDao.getProvincePagingList(demoProvince, page, rows,sb.toString());
	}
	
}
