package cn.zup.rbac.dao;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.EnergyConsumeConf;
import cn.zup.rbac.entity.EnergyMerchant;
import cn.zup.rbac.entity.EnergyPark;

@MiniDao
public interface EnergyConsumeDao extends MiniDaoSupportHiber<EnergyConsumeConf>{
	@Arguments({"energyConsume","page","rows"})
	@ResultType(EnergyConsumeConf.class)
	MiniDaoPage<EnergyConsumeConf> gridEnergyConsumeList(EnergyConsumeConf energyConsume, int page, int rows);
	
}
