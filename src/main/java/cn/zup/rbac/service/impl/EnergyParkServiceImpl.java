package cn.zup.rbac.service.impl;
import java.util.ArrayList;
import java.util.List;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.EnergyConsumeDao;
import cn.zup.rbac.dao.EnergyMerchantDao;
import cn.zup.rbac.dao.EnergyParkDao;
import cn.zup.rbac.dao.OrganDao;
import cn.zup.rbac.dao.UserDao;
import cn.zup.rbac.entity.EnergyConsumeConf;
import cn.zup.rbac.entity.EnergyPark;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.service.EnergyParkService;
import cn.zup.rbac.service.settings.ConfigOrganType;
import cn.zup.rbac.service.settings.ConfigSetting;



@Service("energyParkService")
public class EnergyParkServiceImpl implements EnergyParkService{
	@Autowired
	private EnergyParkDao energyParkDao;
	@Autowired
	private EnergyConsumeDao energyConsumeDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrganDao organDao;
	@Autowired
	private EnergyMerchantDao energyMerchantDao;
	/**
	 * 获取园区的分页列表
	 * @param energyPark
	 * @param page
	 * @param rows
	 * @return
	 */
	public MiniDaoPage<EnergyPark> girdEnergyParkPagingList(EnergyPark energyPark, int page, int rows) {
		return energyParkDao.girdEnergyParkPagingList(energyPark,page,rows);
	}
	/**
	 * 添加一个园区信息
	 * 2017-3-7 17:26:32
	 * lixin
	 * @param energyPark
	 * @return
	 */
	public int addEnergyPark(EnergyPark energyPark) {
		 energyParkDao.saveByHiber(energyPark);
		 return energyPark.getPark_Id();
	}
	/**
	 * 获取一个园区信息
	 * lixin
	 * 2017-3-7 18:15:23
	 * @param energyPark
	 * @return
	 */
	public EnergyPark getEnergyPark(EnergyPark energyPark) {
		return energyParkDao.getByIdHiber(EnergyPark.class, energyPark.getPark_Id());
	}
	/**
	 * 更新园区信息
	 * lixin
	 * 2017-3-8 09:23:07
	 * 
	 * @param energyPark
	 */
	public void updateEnergyPark(EnergyPark energyPark) {
		energyParkDao.updateByHiber(energyPark);
	}
	/**
	 * 删除园区信息
	 * @param energyPark
	 */
	public void deleteEnergyPark(EnergyPark energyPark) {
		energyParkDao.deleteByHiber(energyPark);
	}
	/**
	 * 增加用户用电信息
	 * lixin
	 * 2017-3-14 15:15:40
	 * @param energyConsume
	 * @return
	 */
	public void addEnergyConsume(EnergyConsumeConf energyConsume) {
		energyConsumeDao.saveByHiber(energyConsume);
	}
	/**
	 * 获取商户的用电列表信息
	 * lixin
	 * 2017-3-14 15:30:37
	 * @param energyConsume
	 * @param page
	 * @param rows
	 * @return
	 */
	public MiniDaoPage<EnergyConsumeConf> gridEnergyConsumeList(EnergyConsumeConf energyConsume, int page, int rows) {
		return energyConsumeDao.gridEnergyConsumeList(energyConsume,page,rows);
	}
	/**
	 * 获取用户用电配置信息
	 * @param energyConsume
	 * @return
	 */
	public EnergyConsumeConf getEnergyConsumeInfo(EnergyConsumeConf energyConsume) {
		return energyConsumeDao.getByIdHiber(EnergyConsumeConf.class, energyConsume.getPark_Id());
	}
	/**
	 * 更新用户用电配置信息
	 * lixin
	 * 2017-3-14 16:34:18
	 * @param energyConsume
	 */
	public void updateEnergyConsume(EnergyConsumeConf energyConsume) {
		energyConsumeDao.updateByHiber(energyConsume);
	}
	public void deleteEnergyConsume(EnergyConsumeConf energyConsumeConf) {
		energyConsumeDao.deleteByHiber(energyConsumeConf);
	}
	/**
	 * 冗余方法，获取所有的用电配置信息，不分页
	 * lixiin
	 * 2017-3-20 11:21:51
	 * @param energyConsume
	 * @return
	 */
	public List<EnergyConsumeConf> getAllEnergyConsumeConfSum(EnergyConsumeConf energyConsume) {
		return energyConsumeDao.listByHiber(energyConsume);
	}
	/**
	 * 通过登录用户的id，获取该用户所属组织机构下的所有的园区列表
	 * @param userId
	 * @return
	 */
	public List<EnergyPark> getEnergyParkByUserId(Integer userId) {
		UserInfo userTemp=userDao.getByIdHiber(UserInfo.class, userId);
		Organ organTemp=organDao.getByIdHiber(Organ.class,userTemp.getOrganId());
		List<EnergyPark> list=new ArrayList<EnergyPark>();
		if(organTemp!=null){
			if(organTemp.getOrganType()==ConfigOrganType.commonDepartment.getValue()){//普通部门,查找上级的organType
				Organ organ=getJingyingOrgan(organTemp);
					EnergyPark energyPark=new EnergyPark();
					energyPark.setParkTypeConfig(ConfigSetting.ParkType.getValue());
					energyPark.setDepartment_Id(organ.getOrganId());
					list=energyParkDao.getEnergyParkByUserId(energyPark);
			}
		}
		return  list;
	}
	//通过传入一个组织机构的id，查询其经营公司的信息
	public Organ getJingyingOrgan(Organ organ){
		//该组织机构是不是经营公司或普通公司而且是普通部门，则继续查找上级组织机构
		Organ organUper=new Organ(); 
		if(organ.getOrganType()==ConfigOrganType.jingyingCompany.getValue()||organ.getOrganType()==ConfigOrganType.commonCompany.getValue()){
				return organ;
			}
		 else if(organ.getOrganType()!=ConfigOrganType.jingyingCompany.getValue()&&organ.getOrganType()!=ConfigOrganType.commonCompany.getValue()&&organ.getOrganType()==ConfigOrganType.commonDepartment.getValue()){
			 organUper=organDao.getByIdHiber(Organ.class,organ.getParentOrganId());//以该部门的父级id为主键查询organ信息
			getJingyingOrgan(organUper);
		}
		return organUper;
	}
	/**
	 * 判断园区是否有子表关联
	 * lixin
	 * 2017-4-27 10:27:11
	 * 删除园区的时候需要判断
	 * @param parseInt
	 * @return
	 */
	@Override
	public boolean getEnergyParkSonTable(int parkId) {
		boolean b=false;
		//判断园区跟资产是否有子表关联,oracle数据库
		//判断园区跟电量计划是否有子表关联mysql数据库
		return b;
	}

	/**
	 * 获取园区的信息
	 * @param energyPark
	 * @return
	 */
	public List<EnergyPark> getEnergyParkList(EnergyPark energyPark) {
		return energyParkDao.getEnergyParkByUserId(energyPark);
	}
}