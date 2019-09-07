package cn.zup.rbac.dao;
import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.EnergyRegion;

@MiniDao
public interface EnergyRegionDao extends MiniDaoSupportHiber<EnergyRegion>{
	@ResultType(EnergyRegion.class)
	public List<EnergyRegion> getProvince();
	@Arguments({"provinceCode"}) 
	public List<EnergyRegion> getCity(String provinceCode);
	@Arguments({"cityCode"}) 
	public List<EnergyRegion> getCounty(String cityCode);

	
}
