package cn.zup.rbac.dao;
import cn.zup.rbac.entity.EnergyMerchantLinkman;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

@MiniDao
public interface LinkmanDao extends MiniDaoSupportHiber<EnergyMerchantLinkman>{
	@Arguments({"energyMerchantLinkman","page", "rows"})
	@ResultType(EnergyMerchantLinkman.class)
	public MiniDaoPage<EnergyMerchantLinkman> girdLinkMan(EnergyMerchantLinkman energyMerchantLinkman, int page, int rows);
}
