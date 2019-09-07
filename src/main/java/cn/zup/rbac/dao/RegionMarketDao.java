package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.rbac.entity.EnergyPark;
import cn.zup.rbac.entity.RegionMarket;

@MiniDao
public interface RegionMarketDao extends MiniDaoSupportHiber<RegionMarket>{
	@Arguments({"regionMarket"})
	@ResultType(RegionMarket.class)
	List<RegionMarket> getRegionMarketList(RegionMarket regionMarket);
	@Arguments({"regionMarket"})
	void deleteRegionMarket(RegionMarket regionMarket);
	@Arguments({"regionMarket"})
	void addRegionMarketModel(RegionMarket regionMarket);
}
