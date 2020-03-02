package cn.zup.rbac.dao;

import cn.zup.rbac.entity.EnergyMerchant;
import cn.zup.rbac.entity.Organ;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface EnergyMerchantDao extends MiniDaoSupportHiber<EnergyMerchant>{
	@Arguments({"energyMerchant","page", "rows"})
	@ResultType(EnergyMerchant.class)
	public MiniDaoPage<EnergyMerchant> girdMerchant(EnergyMerchant energyMerchant, int page, int rows);
	@Arguments({"energyMerchant","page","rows"})
	@ResultType(EnergyMerchant.class)
	public MiniDaoPage<EnergyMerchant> getMerchantPagingList(EnergyMerchant energyMerchant, int page, int rows);
	@Arguments({"energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public EnergyMerchant getEnergyMerchantInfo(EnergyMerchant energyMerchant);
	@Arguments({"energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> getMerchantEnergyParkSonTable(EnergyMerchant energyMerchant);
	@Arguments({"energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> getMerchantLinkManSonTable(EnergyMerchant energyMerchant);
	@Arguments({"energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public void updateEnergyMerchant(EnergyMerchant energyMerchant);
	@Arguments({"energyMerchant","page","rows"})
	@ResultType(EnergyMerchant.class)
	public MiniDaoPage<EnergyMerchant> getMerchantRelationList(EnergyMerchant energyMerchant, int page, int rows);
	@Arguments({"organId","merchantName"})
	public List<EnergyMerchant> getMerchantRepeatVerify(Integer organId, String merchantName);
	@Arguments({"organId","energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> getCommonMerchantList(Integer organId, EnergyMerchant energyMerchant);
	@Arguments({"organId","energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> getCommonMerchantInfo(Integer organId, EnergyMerchant energyMerchant);
	@Arguments({"organId","regNumber"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> getRegNumberRepeatVerify(Integer organId, String regNumber);
	@Arguments({"organId","energyMerchant","page","rows"})
	@ResultType(EnergyMerchant.class)
	public MiniDaoPage<EnergyMerchant> getCommonMerchantListPage(Integer organId, EnergyMerchant energyMerchant, int page, int rows);
	@Arguments({"organId","energyMerchant","page","rows"})
	@ResultType(EnergyMerchant.class)
	public MiniDaoPage<EnergyMerchant> getCommonMerchantInfoPage(Integer organId, EnergyMerchant energyMerchant, int page, int rows);
	@Arguments({"energyMerchant","saleMerchantId"})
	@ResultType(Organ.class)
	public List<Organ> getElectricityGeneratorList(EnergyMerchant energyMerchant, Integer saleMerchantId);
	@Arguments({"marketId","departmentId"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> listEnergyMerchant(Integer marketId, Integer departmentId);
	@Arguments({"energyMerchant"})
	@ResultType(EnergyMerchant.class)
	public List<EnergyMerchant> getEnergyMerchantList(EnergyMerchant energyMerchant);

}
