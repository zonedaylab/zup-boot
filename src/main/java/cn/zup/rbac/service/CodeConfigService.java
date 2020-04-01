package cn.zup.rbac.service;



import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.*;


public interface CodeConfigService {
	/**
	 * 添加编码规则
	 * 
	 * @param CodeConfig
	 *            编码规则
	 */
	
	void addCodeConfig(CodeConfig CodeConfig);

	/**
	 * 删除编码规则
	 * 
	 * @param CodeConfig
	 *            编码规则
	 */
	
	void deleteCodeConfig(CodeConfig CodeConfig);

	/**
	 * 更新编码规则
	 * 
	 * @param CodeConfig
	 *            编码规则
	 */
	
	void updateCodeConfig(CodeConfig CodeConfig);

	/**
	 * 获取编码规则列表
	 * 
	 * @param CodeConfig
	 *            编码规则
	 * @param Memo
	 *            备注
	 * @param pageSize
	 *            分页行数
	 * @param pageination
	 *            页码
	 * @return
	 */
	
	MiniDaoPage<CodeConfig> getCodeConfigList(CodeConfig codeconfig, int page, int rows);

	/**
	 * 获取新的编号
	 * 
	 * @param ConfigID
	 *            编码规则ID
	 * @param Params
	 *            参数列表
	 * @return
	 */
	
	String getCodeInfo(int ConfigID, List<String> codeParams);	
	
	String getCodeInfo(int configID, List<String> codeParams, int codeCount);
	
/**
 * 根据codeconfigid获取codeconfig对象信息
 * @param CodeConfigID
 * @return
 */
	CodeConfig getCodeConfigInfo(int CodeConfigID);
}
