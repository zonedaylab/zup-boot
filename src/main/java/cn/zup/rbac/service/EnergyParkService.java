package cn.zup.rbac.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.EnergyConsumeConf;
import cn.zup.rbac.entity.EnergyPark;

public interface EnergyParkService {
	/**
	 * 获取园区的分页列表
	 * @param energyPark
	 * @param page
	 * @param rows
	 * @return
	 */
	MiniDaoPage<EnergyPark> girdEnergyParkPagingList(EnergyPark energyPark, int page, int rows);
	/**
	 * 通过登录用户的id，获取该用户所属组织机构下的所有的园区列表
	 * @param userId
	 * @return
	 */
	List<EnergyPark> getEnergyParkByUserId(Integer userId);
 	/**
	 * 添加一个园区信息
	 * 2017-3-7 17:26:32
	 * lixin
	 * @param energyPark
	 * @return
	 */
	int addEnergyPark(EnergyPark energyPark);
	/**
	 * 获取一个园区信息
	 * lixin
	 * 2017-3-7 18:15:23
	 * @param energyPark
	 * @return
	 */
	EnergyPark getEnergyPark(EnergyPark energyPark);
	/**
	 * 更新园区信息
	 * lixin
	 * 2017-3-8 09:23:07
	 * 
	 * @param energyPark
	 */
	void updateEnergyPark(EnergyPark energyPark);
	/**
	 * 删除园区信息
	 * @param energyPark
	 */
	void deleteEnergyPark(EnergyPark energyPark);
	/**
	 * 增加用户用电信息
	 * lixin
	 * 2017-3-14 15:15:40
	 * @param energyConsume
	 * @return
	 */
	void addEnergyConsume(EnergyConsumeConf energyConsume);
	/**
	 * 获取商户的用电列表信息
	 * lixin
	 * 2017-3-14 15:30:37
	 * @param energyConsume
	 * @param page
	 * @param rows
	 * @return
	 */
	MiniDaoPage<EnergyConsumeConf> gridEnergyConsumeList(EnergyConsumeConf energyConsume, int page, int rows);
	/**
	 * 获取用户用电配置信息
	 * @param energyConsume
	 * @return
	 */
	EnergyConsumeConf getEnergyConsumeInfo(EnergyConsumeConf energyConsume);
	/**
	 * 更新用户用电配置信息
	 * lixin
	 * 2017-3-14 16:34:18
	 * @param energyConsume
	 */
	void updateEnergyConsume(EnergyConsumeConf energyConsume);
	void deleteEnergyConsume(EnergyConsumeConf energyConsumeConf);
	/**
	 * 冗余方法，获取所有的用电配置信息，不分页
	 * lixiin
	 * 2017-3-20 11:21:51
	 * @param energyConsume
	 * @return
	 */
	List<EnergyConsumeConf> getAllEnergyConsumeConfSum(EnergyConsumeConf energyConsume);
	/**
	 * 判断园区是否有子表关联
	 * lixin
	 * 2017-4-27 10:27:11
	 * 删除园区的时候需要判断
	 * @param parseInt
	 * @return
	 */
	boolean getEnergyParkSonTable(int parkId);
	/**
	 * 获取园区的信息
	 * @param energyPark
	 * @return
	 */
	public List<EnergyPark> getEnergyParkList(EnergyPark energyPark);
}