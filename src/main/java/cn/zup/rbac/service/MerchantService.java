package cn.zup.rbac.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.EnergyMerchant;
import cn.zup.rbac.entity.EnergyMerchantLinkman;
import cn.zup.rbac.entity.EnergyRegion;
import cn.zup.rbac.entity.EnergyRelation;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserSession;

public interface MerchantService {
	 /**
	 * 增加联系人
	 * @param 
	 * @return
	 */
	void addLinkMan(EnergyMerchantLinkman energyMarchartLinkman);
	 /**
  	 * desc:加载联系人信息
  	 * Author：zss
  	 * Date: 2017.2.21
  	 * @param 
  	 * */
    MiniDaoPage<EnergyMerchantLinkman> girdLinkMan(EnergyMerchantLinkman energyMarchartLinkman, int page, int rows);
    /**
	 * desc:获得联系人信息
	 * Author：lixin
	 * Date: 2017-3-7 15:26:33
	 * */
    EnergyMerchantLinkman  getLinkManInfo(EnergyMerchantLinkman energyMerchantLinkman);
    /**
 	 * 更新联系人信息
 	 * @param 
 	 * @return
 	 */
 	void updateLinkMan(EnergyMerchantLinkman energyMarchartLinkman);
 	 /**
   	 * desc:删除联系人信息
   	 * Author：zss
   	 * Date: 2017.2.21
   	 * @param 
   	 * */
    void deleteLinkMan(EnergyMerchantLinkman energyMarchartLinkman);
 	/**
  	 * desc:获得省份
  	 * Author：zss
  	 * Date: 2017.2.21
  	 * @param 
  	 * */
    List<EnergyRegion> getProvince();
    /**
  	 * desc:根据省份编码加载市
  	 * Author：zss
  	 * Date: 2017.2.21
  	 * @param 
  	 * */
    List<EnergyRegion> getCity(String provinceCode);
    /**
  	 * desc:根据市加载区县
  	 * Author：zss
  	 * Date: 2017.2.21
  	 * @param 
  	 * */
    List<EnergyRegion> getCounty(String cityCode);
    /**
   	 * desc:增加商户信息
   	 * Author：zss
   	 * Date: 2017.2.22
   	 * */
     int addMerchant(EnergyMerchant energyMerchant);
     /**
      * 增加商户关系
      * @param energyRelation
      * @return
      */
    void addEnergyRelation(EnergyRelation energyRelation);
    /**
     * 获取商户的分页信息
     * @param energyMerchant
     * @return
     */
	MiniDaoPage<EnergyMerchant> getMerchantPagingList(EnergyMerchant energyMerchant, int page, int rows);
	/**
	 * 更新商户信息
	 * lixin
	 * 2017-3-17 15:20:52
	 */
	void updateMerchant(EnergyMerchant energyMerchant);
	/**
	 * 获取商户信息
	 * lixin
	 * 2017-3-17 15:23:03
	 * 
	 * 
	 * @param energyMerchant
	 * @return
	 */
	EnergyMerchant getEnergyMerchantInfo(EnergyMerchant energyMerchant);
	/**
	 * 删除商户信息
	 * lixin
	 * 2017-3-17 19:09:12
	 * @param organIds
	 * @return
	 */
	void deleteEnergyMerchant(EnergyMerchant energyMerchant);
	/**
	 * 查询商户表在联系人表中有无关联关系
	 * lixin
	 * 2017-3-20 09:38:38
	 * 删除商户时用
	 * @param energyMerchant
	 * @return
	 */
	List<EnergyMerchant> getMerchantLinkManSonTable(EnergyMerchant energyMerchant);
	/**
	 * 查询商户表在微能源区表中有无关联关系
	 * lixin
	 * 2017-3-20 09:38:38
	 * 删除商户时用
	 * @param energyMerchant
	 * @return
	 */
	List<EnergyMerchant> getMerchantEnergyParkSonTable(EnergyMerchant energyMerchant);
	/**
	 * 删除商户时需要删除商户关系表
	 * lixin
	 * 2017-3-20 09:52:36
	 * @param energyRelation
	 */
	void deleteEnergyRelation(EnergyRelation energyRelation);
	/**
	 * 权限分配
	 * 根据当前登录用户的id获取该经营公司下所有的商户信息
	 * @param energyMerchant
	 * @param page
	 * @param rows
	 * @return
	 */
	MiniDaoPage<EnergyMerchant> getMerchantRelationList(EnergyMerchant energyMerchant, int page, int rows);
	/**
	 * 商户名称重复验证
	 * 2017-3-21 11:45:18
	 * lixin
	 * @param organid
	 * @param merchantName
	 * @return
	 */
	boolean getMerchantRepeatVerify(Integer organid, String merchantName);
	/**
	 * 根据用户id获取该商户下所有的用电商户
	 * lixin
	 * 2017-3-24 11:38:04
    	过滤掉发电商
		2017-5-4 11:24:27
	 * @param userId
	 * @return
	 */
	List<EnergyMerchant> getCommonMerchantList(Integer userId, Integer marketId, String summaryMerchantIds);
	/**
	 * 根据登录用户的id，获取该用户所属的公司以及公司类型
	 * @param userId
	 * @return
	 */
	Organ getMyCompany(Integer userId);
	
	/**
	 * 根据实体信息获取相应的组织机构列表
	 * 目前获取所属经营公司列表
	 * lixin
	 * 2017-3-3 11:54:22
	 * @param organ
	 * @return
	 */
	List<Organ> getOperateOrganList(Organ organ);
	/**
	 * 获取所有的发电商
	 * lixin
	 * 2017-4-27 08:57:36
	 * 2017-11-29 17:18:37
	 * 改：获取一个交易市场下所有的发电商
	 * 改2018-3-12 15:05:45：
	 * lixin
	 * 不应该取一个交易市场下的发电商，应该取一个售电公司下注册的发电商
	 * @param energyMerchant
	 * marketId ：marketId 改为saleMerchantId
	 * @return
	 */
	List<Organ> getElectricityGeneratorList(EnergyMerchant energyMerchant, Integer saleMerchantId);
	/**
	 * 商户注册的三证合一号重复验证
	 * lixin
	 * 2017-4-13 16:03:47
	 * @param organid
	 * @param regNumber
	 * @return
	 */
	boolean getRegNumberRepeatVerify(Integer organid, String regNumber);
	/**
	 * 增加一个获取商户列表的分页方法
	 * lixin
	 * 2017-4-26 14:50:45
	 * 解决商户管理不能分页的bug
	 * @param userId
	 * @param page
	 * @param rows
	 * @return
	 */
	MiniDaoPage<EnergyMerchant> getCommonMerchantListPage(int userId, EnergyMerchant enercyMerchant, int page, int rows);
	/**
	 * 获取商户关系信息
	 * lixin
	 * 2017-9-23 09:24:07
	 * @param energyRelation
	 * @return
	 */
	EnergyRelation getEnergyRelationInfo(EnergyRelation energyRelation);
	
	/**
	 * 根据当前登录人的userId,获取当前登录人应该展示组织机构的oragnIds
	 * lixin
	 * 2018-2-1 08:58:16
	 * @param userId
	 * @return
	 */
	String getMyOrganIds(UserSession userSession);
	/**
	 * 获取当前登录人应展示的所有的组织机构以及子组织机构，展示用户时使用
	 * lixin
	 * 2018-2-1 09:45:00
	 * @param userId
	 * @return
	 */
	String getMySubOrganIds(UserSession userSession);
	
	/**
	 * 获取售电公司信息
	 * @return
	 */
	 List<EnergyMerchant> getEnergyMerchantList(EnergyMerchant energyMerchant);
}