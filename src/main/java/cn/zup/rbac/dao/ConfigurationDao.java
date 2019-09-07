package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Config;

@MiniDao
public interface ConfigurationDao extends MiniDaoSupportHiber<Config>{
	@Arguments("configName")
	List<Config> getconfigList(String configName);
	@Arguments("config")
	List<Config> getconfigInfo(Config config);	
	@Arguments({"config"})
	public List<Config> getConfigSignList(Config config);
	@Arguments({"config","page","rows"})
	@ResultType(Config.class)
	public MiniDaoPage<Config> getConfigPagingList(Config config, int page, int rows);
	@Arguments({"configid"})
	public void deleteConfig(Integer configid);
	@Arguments({"config"})
	@ResultType(Config.class)
	List<Config> getConfig(Config config);
}
