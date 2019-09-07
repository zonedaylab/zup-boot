package cn.zup.rbac.service.impl;
import java.util.ArrayList;
import java.util.List;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.EnergyMerchantDao;
import cn.zup.rbac.dao.EnergyRegionDao;
import cn.zup.rbac.dao.EnergyRelationDao;
import cn.zup.rbac.dao.LinkmanDao;
import cn.zup.rbac.dao.OrganDao;
import cn.zup.rbac.dao.UserDao;
import cn.zup.rbac.entity.EnergyMerchant;
import cn.zup.rbac.entity.EnergyMerchantLinkman;
import cn.zup.rbac.entity.EnergyRegion;
import cn.zup.rbac.entity.EnergyRelation;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.settings.ConfigOrganType;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.rbac.service.settings.SystemTypeEnum;



@Service("merchantService")
public class MerchantServiceImpl implements MerchantService{
	@Autowired
	private LinkmanDao linkmanDao;
	@Autowired
	private EnergyRegionDao energyRegionDao;
	@Autowired
	private EnergyMerchantDao energyMerchantDao;
	@Autowired
	private EnergyRelationDao energyRelationDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrganDao organDao;
	
	public void addLinkMan(EnergyMerchantLinkman energyMarchartLinkman) {
		linkmanDao.saveByHiber(energyMarchartLinkman);
	}
	/**
	 * 获取联系人信息
	 * Author：zss
	 * @param 
	 */
	public MiniDaoPage<EnergyMerchantLinkman> girdLinkMan(EnergyMerchantLinkman energyMarchartLinkman, int page,int rows){	 
		return linkmanDao.girdLinkMan(energyMarchartLinkman,page,rows);
	}
	 /**
	 * desc:根据联系人id获得联系人信息
	 * Author：zss
	 * Date: 2017.2.21
	 * */
	public EnergyMerchantLinkman  getLinkManInfo(EnergyMerchantLinkman energyMerchantLinkman) { 
		return  linkmanDao.getByIdHiber(EnergyMerchantLinkman.class,energyMerchantLinkman.getLink_Man_Id());
	}
	 /**
	 * 更新联系人信息
	 */
	public void updateLinkMan(EnergyMerchantLinkman energyMarchartLinkman) {
		linkmanDao.updateByHiber(energyMarchartLinkman);
	}
	 /**
	 * desc:删除联系人信息
	 * Author：zss
	 * Date: 2017.2.21
	 * @param 
	 * */
	public void deleteLinkMan(EnergyMerchantLinkman energyMarchartLinkman) {
		linkmanDao.deleteByHiber(energyMarchartLinkman);
	}
	/**
	 * 获取省
	 * Author：zss
	 * @param 
	 */
	public List<EnergyRegion> getProvince(){	 
		return energyRegionDao.getProvince();
	}
	/**
	 * 根据省份获得市
	 * Author：zss
	 * @param 
	 */
	public List<EnergyRegion> getCity(String provinceCode){	 
		return energyRegionDao.getCity(provinceCode);
	}
	/**
	 * 根据市获得县
	 * Author：zss
	 * @param 
	 */
	public List<EnergyRegion> getCounty(String cityCode){	 
		return energyRegionDao.getCounty(cityCode);
	}
	/**
	 * 添加套餐信息
	 */
	public int addMerchant(EnergyMerchant energyMerchant) {		
		energyMerchantDao.saveByHiber(energyMerchant);		
		return energyMerchant.getOrganid();
		      
	}
	/**
	 * 获取联系人信息
	 * Author：zss
	 * @param 
	 */
	public MiniDaoPage<EnergyMerchant> girdMerchant(EnergyMerchant energyMerchant, int page,int rows){	 
		return energyMerchantDao.girdMerchant(energyMerchant,page,rows);
	}
	/**
     * 增加商户关系
     * @param energyRelation
     * @return
     */
	public void addEnergyRelation(EnergyRelation energyRelation) {
		energyRelationDao.saveByHiber(energyRelation);
	}
	/**
     * 获取商户的分页信息
     * @param energyMerchant
     * @return
     */
	public MiniDaoPage<EnergyMerchant> getMerchantPagingList(EnergyMerchant energyMerchant,int page,int rows) {
		return energyMerchantDao.getMerchantPagingList(energyMerchant,page,rows);
	}
	/**
	 * 更新商户信息
	 * lixin
	 * 2017-3-17 15:20:52
	 */
	public void updateMerchant(EnergyMerchant energyMerchant) {
		energyMerchantDao.updateEnergyMerchant(energyMerchant);
	}
	/**
	 * 获取商户信息
	 * lixin
	 * 2017-3-17 15:23:41
	 */
	public EnergyMerchant getEnergyMerchantInfo(EnergyMerchant energyMerchant) {
		
		return energyMerchantDao.getEnergyMerchantInfo(energyMerchant);
	}
	/**
	 * 删除商户信息
	 * lixin
	 * 2017-3-17 19:09:12
	 * @param organIds
	 * @return
	 */
	public void deleteEnergyMerchant(EnergyMerchant energyMerchant) {
		energyMerchantDao.deleteByHiber(energyMerchant);
	}
	/**
	 * 查询商户表在联系人表中有无关联关系
	 * lixin
	 * 2017-3-20 09:38:38
	 * 删除商户时用
	 * @param energyMerchant
	 * @return
	 */
	public List<EnergyMerchant> getMerchantEnergyParkSonTable(EnergyMerchant energyMerchant) {
		return energyMerchantDao.getMerchantEnergyParkSonTable(energyMerchant);
	}
	/**
	 * 查询商户表在微能源区表中有无关联关系
	 * lixin
	 * 2017-3-20 09:38:38
	 * 删除商户时用
	 * @param energyMerchant
	 * @return
	 */
	public List<EnergyMerchant> getMerchantLinkManSonTable(EnergyMerchant energyMerchant) {
		return energyMerchantDao.getMerchantLinkManSonTable(energyMerchant);
	}
	/**
	 * 删除商户时需要删除商户关系表
	 * lixin
	 * 2017-3-20 09:52:36
	 * @param energyRelation
	 */
	public void deleteEnergyRelation(EnergyRelation energyRelation) {
		energyRelationDao.deleteByHiber(energyRelation);
	}
	/**
	 * 权限分配
	 * 根据当前登录用户的id获取该经营公司下所有的商户信息
	 * @param energyMerchant
	 * @param page
	 * @param rows
	 * @return
	 */
	public MiniDaoPage<EnergyMerchant> getMerchantRelationList(EnergyMerchant energyMerchant, int page, int rows) {
		return energyMerchantDao.getMerchantRelationList(energyMerchant,page,rows);
	}
	/**
	 * 商户注册名称重复验证
	 * 2017-3-21 11:39:33
	 * lixin
	 * @param organId
	 * @param organName
	 * @return
	 */
	public boolean getMerchantRepeatVerify(Integer organId, String merchantName) {	 
		List<EnergyMerchant> energyMerchantList = energyMerchantDao.getMerchantRepeatVerify(organId, merchantName);
		if(energyMerchantList!=null&&energyMerchantList.size()>0)
			return true;
		else
			return false;
	}
	/**
	 * 根据用户id获取该商户下所有的普通商户
	 * lixin
	 * 2017-3-24 11:38:04
	 * @param userId
	 * @return
	 */
	public List<EnergyMerchant> getCommonMerchantList(Integer userId, Integer marketId, String summaryMerchantIds) {
		UserInfo userTemp = (UserInfo)userDao.getByIdHiber(UserInfo.class, userId);
	    Organ organTemp = (Organ) organDao.getByIdHiber(Organ.class, userTemp.getOrganId());
	    List<EnergyMerchant> energyMerchantList = new ArrayList<EnergyMerchant>();
	    if (organTemp != null) {
	      if (organTemp.getOrganType() == ConfigOrganType.jingyingCompany.getValue()) {
	        EnergyMerchant energyMerchant = new EnergyMerchant();
	        energyMerchant.setCheckStateConfig(ConfigSetting.checkState.getValue());
	        energyMerchant.setEnergyPropertyConfig(ConfigSetting.EnergyProperty.getValue());
	        energyMerchant.setMerchantTypeConfig(ConfigSetting.MerchantType.getValue());
	        energyMerchant.setTradeFlagConfig(ConfigSetting.TradeFlag.getValue());
	        energyMerchant.setMerchant_Type(1);
	        if (marketId != null) {
	          energyMerchant.setMarketId(marketId);
	        }
	        if (summaryMerchantIds != null) {
	          energyMerchant.setSummaryMerchantIds(summaryMerchantIds);
	        }
	        energyMerchantList =  energyMerchantDao.getCommonMerchantList(organTemp.getOrganId(), energyMerchant);
	      }
	      else if (organTemp.getOrganType() == ConfigOrganType.commonCompany.getValue()) {
	        EnergyMerchant energyMerchant = new EnergyMerchant();
	        energyMerchant.setCheckStateConfig( ConfigSetting.checkState.getValue());
	        energyMerchant.setEnergyPropertyConfig( ConfigSetting.EnergyProperty.getValue());
	        energyMerchant.setMerchantTypeConfig( ConfigSetting.MerchantType.getValue());
	        energyMerchant.setTradeFlagConfig( ConfigSetting.TradeFlag.getValue());
	        energyMerchantList =  energyMerchantDao.getCommonMerchantInfo(organTemp.getOrganId(), energyMerchant);
	      }
	      else if (organTemp.getOrganType() == ConfigOrganType.commonDepartment.getValue()) {
	        Organ organ = getMyOrgan(organTemp);
	        EnergyMerchant energyMerchant = new EnergyMerchant();
	        energyMerchant.setCheckStateConfig( ConfigSetting.checkState.getValue());
	        energyMerchant.setEnergyPropertyConfig( ConfigSetting.EnergyProperty.getValue());
	        energyMerchant.setMerchantTypeConfig( ConfigSetting.MerchantType.getValue());
	        energyMerchant.setTradeFlagConfig( ConfigSetting.TradeFlag.getValue());
	        energyMerchant.setMerchant_Type( 1);
	        if (marketId != null) {
	          energyMerchant.setMarketId(marketId);
	        }
	        if (summaryMerchantIds != null) {
	          energyMerchant.setSummaryMerchantIds(summaryMerchantIds);
	        }
	        if (organ.getOrganType()== ConfigOrganType.jingyingCompany.getValue()) {
	          energyMerchant.setOrganid(organ.getOrganId());
	          energyMerchantList =  energyMerchantDao.getCommonMerchantList(organ.getOrganId(), energyMerchant);
	        } else if (organ.getOrganType()== ConfigOrganType.commonCompany.getValue()) {
	          energyMerchantList =  energyMerchantDao.getCommonMerchantInfo(organ.getOrganId(), energyMerchant);
	        }
	      }
	    }
	    return energyMerchantList;
	}
	//通过传入一个组织机构的id，查询其经营公司的信息
	public Organ getMyOrgan(Organ organ){
		//该组织机构是不是经营公司或普通公司而且是普通部门，则继续查找上级组织机构
		Organ organUper=new Organ(); 
		if(organ.getOrganType()==ConfigOrganType.commonDepartment.getValue()){//普通部门，则继续向上找父级组织机构
			 organUper=organDao.getByIdHiber(Organ.class,organ.getParentOrganId());//以该部门的父级id为主键查询organ信息
			 getMyOrgan(organUper);
		}else{
			return organ;
		}
		return organUper;
	}
	/**
	 * 根据登录用户的id，获取该用户所属的公司以及公司类型
	 * @param userId
	 * @return
	 */
	public Organ getMyCompany(Integer userId) {
		UserInfo userTemp=userDao.getByIdHiber(UserInfo.class, userId);
		Organ organTemp=organDao.getByIdHiber(Organ.class,userTemp.getOrganId());
		Organ organ =new Organ();
		if(organTemp!=null){
			if(organTemp.getOrganType()==ConfigOrganType.commonDepartment.getValue()){//普通部门,查找上级的organType
				 organ=getMyOrgan(organTemp);
			}
			else{//直接属于经营公司
				 organ=organTemp;
			}
		}
		return organ;
	}
	/**
	 * 根据实体信息获取相应的组织机构列表
	 * 目前获取所属经营公司列表
	 * lixin
	 * 2017-3-3 11:54:22
	 * @param organ
	 * @return
	 */
	public List<Organ> getOperateOrganList(Organ organ) {
		return organDao.getOperateOrganList(organ);
	}
	/**
	 * 商户注册的三证合一号重复验证
	 * lixin
	 * 2017-4-13 16:03:47
	 * @param organid
	 * @param regNumber
	 * @return
	 */
	@Override
	public boolean getRegNumberRepeatVerify(Integer organId, String regNumber) {
		List<EnergyMerchant> energyMerchantList = energyMerchantDao.getRegNumberRepeatVerify(organId, regNumber);
		if(energyMerchantList!=null&&energyMerchantList.size()>0)
			return true;
		else
			return false;
	}
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
	@Override
	public MiniDaoPage<EnergyMerchant> getCommonMerchantListPage(int userId,EnergyMerchant energyMerchant,int page, int rows) {
		UserInfo userTemp=userDao.getByIdHiber(UserInfo.class, userId);
		Organ organTemp=organDao.getByIdHiber(Organ.class,userTemp.getOrganId());
		MiniDaoPage<EnergyMerchant> energyMerchantList=new MiniDaoPage<EnergyMerchant>();
		if(organTemp!=null){
			if(organTemp.getOrganType()==ConfigOrganType.jingyingCompany.getValue()){//代表经营公司
			energyMerchantList= energyMerchantDao.getCommonMerchantListPage(organTemp.getOrganId(),energyMerchant,page,rows);
		}
		else if(organTemp.getOrganType()==ConfigOrganType.commonCompany.getValue()){//普通商户
			
			energyMerchantList= energyMerchantDao.getCommonMerchantInfoPage(organTemp.getOrganId(),energyMerchant,page,rows);
		}
		else if(organTemp.getOrganType()==ConfigOrganType.commonDepartment.getValue()){//普通部门,查找上级的organType
				Organ organ=getMyOrgan(organTemp);
				if(organ.getOrganType()==ConfigOrganType.jingyingCompany.getValue()){//经营公司
					energyMerchant.setOrganid(organ.getOrganId());
					energyMerchantList= energyMerchantDao.getCommonMerchantListPage(organ.getOrganId(),energyMerchant,page,rows);
				}else if(organ.getOrganType()==ConfigOrganType.commonCompany.getValue()){//普通公司
					energyMerchantList= energyMerchantDao.getCommonMerchantInfoPage(organ.getOrganId(),energyMerchant,page,rows);
				}
			}
		}
		return energyMerchantList;
	}
	/**
	 * 获取所有的发电商
	 * lixin
	 * 2017-4-27 08:57:36
	 * @param organ
	 * @return
	 */
	@Override
	public List<Organ> getElectricityGeneratorList(EnergyMerchant energyMerchant,Integer saleMerchantId) {
		return energyMerchantDao.getElectricityGeneratorList(energyMerchant,saleMerchantId);
	}
	/**
	 * 获取商户关系信息
	 * lixin
	 * 2017-9-23 09:24:07
	 * @param energyRelation
	 * @return
	 */
	@Override
	public EnergyRelation getEnergyRelationInfo(EnergyRelation energyRelation) {
		return energyRelationDao.getEnergyRelationInfo(energyRelation);
	}

	@Override
	public String getMyOrganIds(UserSession userSession) {
		int userId=userSession.getUserId();
		int systemId=userSession.getSystemId();
		//根据当前登录用户获取当前登录用户所属的公司的类型
		Organ myCompany=getMyCompany(userId);
		//如果当前登录用户属于电力用户，则只加载当前公司下的组织及子组织。
		String myOrganIds="("+myCompany.getOrganId()+")";
		String merchantIds="";
		if(myCompany.getOrganType()==ConfigOrganType.jingyingCompany.getValue()){//如果是售电公司，则应该加载当前公司以及代理的所有用户的id集合
			if(systemId==SystemTypeEnum.ESALE.getValue()){
				//如果是售电系统则取自merchant表
				List<EnergyMerchant> listEnergyMerchant=getCommonMerchantList(userId, null, null);
				if(listEnergyMerchant.size()>0){
					for(int i=0;i<listEnergyMerchant.size();i++){
						merchantIds+=listEnergyMerchant.get(i).getOrganid()+",";
					}
//					merchantIds=merchantIds.substring(0,merchantIds.length()-1);
//					myOrganIds="("+myCompany.getOrganId()+","+merchantIds+")";
				}
			}else{
				//如果是光伏系统，取自energyRelation
				EnergyRelation energyRelationSearch=new EnergyRelation();
				energyRelationSearch.setDepartment_Id(myCompany.getOrganId());
				List<EnergyRelation> listEnergyRelation=energyRelationDao.getEnergyRelationList(energyRelationSearch);
				if(listEnergyRelation.size()>0){
					for(int i=0;i<listEnergyRelation.size();i++){
						merchantIds+=listEnergyRelation.get(i).getCommon_Organ_Id()+",";
					}
//					merchantIds=merchantIds.substring(0,merchantIds.length()-1);
//					myOrganIds="("+myCompany.getOrganId()+","+merchantIds+")";
				}
			}
		}else if(myCompany.getOrganType()==ConfigOrganType.yunyingDepartment.getValue()){//如果是运营公司,可以看全部的用户和组织机构
			int validFlag=ConfigSetting.ValigFlag.getValue();
			int organType=ConfigSetting.OrganType.getValue();
			int parentOrganId=0;
			List<Organ> organList=organDao.getMySubOrganList(validFlag, organType, parentOrganId, null);
			for(int i=0;i<organList.size();i++){
				merchantIds+=organList.get(i).getOrganId()+",";
			}
		}
		if(merchantIds!=""){
			merchantIds=merchantIds.substring(0,merchantIds.length()-1);
			myOrganIds="("+myCompany.getOrganId()+","+merchantIds+")";
		}
		return myOrganIds;
	}
	@Override
	public String getMySubOrganIds(UserSession userSession) {
		int userId=userSession.getUserId();
		int systemId=userSession.getSystemId();
		//根据当前登录用户获取当前登录用户所属的公司的类型
		Organ myCompany=getMyCompany(userId);
		//如果当前登录用户属于电力用户，则只加载当前公司下的组织及子组织。
		String myOrganIds=myCompany.getOrganId()+","+getMySubOrganIdsAll(myCompany.getOrganId());
		//如果是售电公司用户登录，则同时获取该售电公司下的所有电力用户的所有组织机构
		if(myCompany.getOrganType()==ConfigOrganType.jingyingCompany.getValue()){//如果是售电公司，则应该加载当前公司以及代理的所有用户的id集合
			if(systemId==SystemTypeEnum.ESALE.getValue()){
				//售电公司，获取所代理的所有用户，取自merchant表
				List<EnergyMerchant> listEnergyMerchant=getCommonMerchantList(userId, null, null);
				if(listEnergyMerchant.size()>0){
					for(int i=0;i<listEnergyMerchant.size();i++){
						myOrganIds+=listEnergyMerchant.get(i).getOrganid()+",";
						myOrganIds+=getMySubOrganIdsAll(listEnergyMerchant.get(i).getOrganid());
					}
				}
			}else{
				//光伏系统获取组织机构，不能获取merchant，直接获取energyrelation表
				EnergyRelation energyRelationSearch=new EnergyRelation();
				energyRelationSearch.setDepartment_Id(myCompany.getOrganId());
				List<EnergyRelation> listEnergyRelation=energyRelationDao.getEnergyRelationList(energyRelationSearch);
				if(listEnergyRelation.size()>0){
					for(int i=0;i<listEnergyRelation.size();i++){
						myOrganIds+=listEnergyRelation.get(i).getCommon_Organ_Id()+",";
						myOrganIds+=getMySubOrganIdsAll(listEnergyRelation.get(i).getCommon_Organ_Id());
					}
				}
			}
		}else if(myCompany.getOrganType()==ConfigOrganType.yunyingDepartment.getValue()){//如果是运营公司，目前针对超级管理员，应该加载全部用户
			int validFlag=ConfigSetting.ValigFlag.getValue();
			int organType=ConfigSetting.OrganType.getValue();
			int parentOrganId=0;
			List<Organ> organList=organDao.getMySubOrganList(validFlag, organType, parentOrganId, null);
			for(int i=0;i<organList.size();i++){
				myOrganIds+=organList.get(i).getOrganId()+",";
				myOrganIds+=getMySubOrganIdsAll(organList.get(i).getOrganId());
			}
		}
		if(myOrganIds.indexOf(",")>0){
			myOrganIds=myOrganIds.substring(0,myOrganIds.length()-1);
			myOrganIds="("+myOrganIds+")";
		}else{
			myOrganIds="";
		}
		return myOrganIds;
	}
	//获取一个组织机构下所有的子组织机构的ids
	private String getMySubOrganIdsAll(int organId){
		String myOrganIds="";
		List<Organ> mySubOrganList=listSubOrgan(organId);
		for(int i=0;i<mySubOrganList.size();i++){
			myOrganIds+=mySubOrganList.get(i).getOrganId()+",";
		}
		return myOrganIds;
	}
	/**
	 * 根据当前组织机构的id以及组织机构的最深层级，获取该组织机构下的所有的子组织
	 * lixin
	 * 2018-2-1 17:17:02
	 * @param organId
	 * @param organLevelNum
	 * @return
	 */
	private List<Organ> listSubOrgan(int organId){
		int validFlag=ConfigSetting.ValigFlag.getValue();
		int orgaType=ConfigSetting.OrganType.getValue();
		List<Organ> mySubOrganList=new ArrayList<Organ>();
		List<Organ> myOrganListFirst= organDao.getSubOrganList(organId,validFlag,orgaType);
		mySubOrganList.addAll(myOrganListFirst);
		if(myOrganListFirst.size()>0){
			mySubOrganList.addAll(getSubOrganList(myOrganListFirst, validFlag, orgaType));
		}
		return mySubOrganList;
	}
	private List<Organ> getSubOrganList(List<Organ> organList,int validFlag,int orgaType){
		List<Organ> mySubOrganList=new ArrayList<Organ>();
		for(int i=0;i<organList.size();i++){
			List<Organ> subOrganList=organDao.getSubOrganList(organList.get(i).getOrganId(),validFlag,orgaType);
			mySubOrganList.addAll(subOrganList);
			if(subOrganList.size()>0){
				mySubOrganList.addAll(getSubOrganList(subOrganList, validFlag, orgaType));
			}
		}
		return mySubOrganList;
	}
	@Override
	public List<EnergyMerchant> getEnergyMerchantList(EnergyMerchant energyMerchant) {
		return energyMerchantDao.getEnergyMerchantList(energyMerchant);
	}
	
}