package cn.zup.rbac.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Config;



public interface ConfigurationService {
	/**
	 * 添加配置信息
	 * 
	 * @param config
	 *            配置信息
	 */
	
	void addConfig(Config config);

	/**
	 * 删除配置信息
	 * 
	 * @param config
	 *            配置信息
	 */
	
	void deleteConfig(Config config);

	/**
	 * 更新配置信息
	 * 
	 * @param config
	 *            配置信息
	 */
	
	void updateConfig(Config config);

	/**
	 * 获取配置信息
	 * 
	 * @param configName
	 *            配置信息名称
	 * @return
	 */
	
	List<Config> getConfigList(String configName);

	/**
	 * 获取配置信息
	 * 
	 * @param type
	 *            配置信息ID
	 * @return
	 */
	
	List<Config> getConfigInfo(Config config);
	/**
	 * 获取CONFIG列表
	 * @return
	 */
	MiniDaoPage<Config> getConfigList(Config config, int page, int rows);
	
	/**
	 * 删除Config
	 */
	public void deleteConfig(Integer configid);
	
	/**
	 * 获取Config
	 */
	public Config getConfig(Config config);
	

	List<Config> getConfigList(Config config);
	
}
