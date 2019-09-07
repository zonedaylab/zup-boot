package cn.zup.rbacdemo.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.RoleData;
import cn.zup.rbacdemo.entity.DemoProvince;

public interface DemoProvinceService {
	
	public void add(DemoProvince demoProvince);

	public void saveByHiber(DemoProvince demoProvince);

	public void updateByHiber(DemoProvince demoProvince);

	public DemoProvince getByIdHiber(Class<DemoProvince> class1, String id);

	public void deleteByHiber(DemoProvince demoProvince);

	public void deleteByIdHiber(Class<DemoProvince> class1, String id);

	public List<DemoProvince> listByHiber(DemoProvince demoProvince);

	public MiniDaoPage<DemoProvince> getProvincePagingList(DemoProvince demoProvince, Integer page, Integer rows,List<RoleData> roledata);
	
}
