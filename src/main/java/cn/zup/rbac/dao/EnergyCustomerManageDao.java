package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.rbac.entity.EnergyCustomer;
@MiniDao
public interface EnergyCustomerManageDao extends MiniDaoSupportHiber<EnergyCustomer> {
	@Arguments({"energyCustomer"})
	@ResultType(EnergyCustomer.class)
	List<EnergyCustomer> getEnergyCustomerList(EnergyCustomer energyCustomer);
}
