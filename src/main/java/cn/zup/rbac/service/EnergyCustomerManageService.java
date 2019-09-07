package cn.zup.rbac.service;

import java.util.List;

import cn.zup.rbac.entity.EnergyCustomer;

public interface EnergyCustomerManageService {
	/**
	 * 加载地图初始化数据&&查询
	 * @param energyCustomer
	 * @return
	 */
	List<EnergyCustomer> getEnergyCustomerList(EnergyCustomer energyCustomer);
	/**
	 * 添加客户信息
	 * @param energyCustomer
	 */
	Integer saveCustomerInfo(EnergyCustomer energyCustomer);

}
