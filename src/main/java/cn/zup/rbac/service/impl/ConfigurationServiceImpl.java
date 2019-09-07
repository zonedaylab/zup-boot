package cn.zup.rbac.service.impl;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.ConfigurationDao;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.ConfigurationService;
@Service("configurationService")

public class ConfigurationServiceImpl implements	ConfigurationService {
	@Autowired
	private ConfigurationDao configdao;

	/**
	 * 添加配置信息
	 * 
	 * @param config
	 *            配置信息
	 */
	public void addConfig(Config config) {
		configdao.saveByHiber(config);
	}

	/**
	 * 删除配置信息
	 * 
	 * @param config
	 *            配置信息
	 */
	public void deleteConfig(Config config) {
		configdao.deleteByHiber(config);
	}

	/**
	 * 更新配置信息
	 * 
	 * @param config
	 *            配置信息
	 */
	public  void updateConfig(Config config) {
		configdao.updateByHiber(config);
	}

	/**
	 * 获取配置信息
	 * 
	 * @param configName
	 *            配置信息名称
	 * @return
	 */
	public List<Config> getConfigList(String configName) {
		Config config=new Config();
		config.setName(configName);
		List<Config> list=configdao.listByHiber(config);
		//List<Config> list=configdao.getconfigList(configName);
		return list;
	}

	/**
	 * 获取配置信息
	 * 
	 * @param config
	 *            配置信息ID
	 * @return
	 */
	
	public List<Config> getConfigInfo(Config config) {		
		
		return configdao.getconfigInfo(config);
	}
	
	

	@Override
	public Config getConfig(Config config) {
		return configdao.getByEntityHiber(config);
	}
	
	@Override
	public List<Config> getConfigList(Config config) {
		return configdao.getConfigSignList(config);
	}
	/**
	 * 获取列表
	 */
	@Override
	public MiniDaoPage<Config> getConfigList(Config config, int page, int rows) {
		
		// TODO Auto-generated method stub
		return configdao.getConfigPagingList(config,page,rows);
	}
	/**
	 * 删除Config
	 */
	@Override
	public void deleteConfig(Integer configid) {
		
		configdao.deleteConfig(configid);
	}

}
