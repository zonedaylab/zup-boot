package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.EnergyMerchant;
import cn.zup.rbac.entity.EnergyPark;

@MiniDao
public interface EnergyParkDao extends MiniDaoSupportHiber<EnergyPark>{
	@Arguments({"energyPark","page","rows"})
	@ResultType(EnergyPark.class)
	MiniDaoPage<EnergyPark> girdEnergyParkPagingList(EnergyPark energyPark,int page, int rows);
	@Arguments({"energyPark"})
	@ResultType(EnergyPark.class)
	List<EnergyPark> getEnergyParkByUserId(EnergyPark energyPark);
	
}
