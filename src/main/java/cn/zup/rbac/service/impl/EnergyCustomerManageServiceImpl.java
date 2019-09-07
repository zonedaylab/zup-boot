package cn.zup.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.EnergyCustomerManageDao;
import cn.zup.rbac.entity.EnergyCustomer;
import cn.zup.rbac.service.EnergyCustomerManageService;

@Service("energyCustomerManageService")
public class EnergyCustomerManageServiceImpl implements EnergyCustomerManageService {
	@Autowired
	private EnergyCustomerManageDao energyCustomerManageDao;

	@Override
	public List<EnergyCustomer> getEnergyCustomerList(EnergyCustomer energyCustomer) {
		return energyCustomerManageDao.getEnergyCustomerList(energyCustomer);
	}

	@Override
	public Integer saveCustomerInfo(EnergyCustomer energyCustomer) {
		energyCustomerManageDao.saveByHiber(energyCustomer);
		return energyCustomer.getCustomer_Id();
	}

}
