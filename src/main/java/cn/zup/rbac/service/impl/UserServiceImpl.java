package cn.zup.rbac.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.AccountDao;
import cn.zup.rbac.dao.EnergyRelationDao;
import cn.zup.rbac.dao.UserDao;
import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.EnergyRelation;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigOrganType;
import cn.zup.rbac.service.settings.ConfigSetting;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;  
	@Autowired
	private AccountDao accountDao;
	@Autowired
	private OrganPostService organPostService;
	@Autowired
	private EnergyRelationDao energyRelationDao;
	@Autowired
	private AccountDao accountOperateDao;
	
	/**
	 * 获取当前用户信息
	 * @Author liuxf
	 * @Date   20160730
	 * @param request
	 * @return
	 */
	public  UserSession getCurrentHandler(HttpServletRequest request){		 
		UserSession currentHandler;				
		HttpSession session=request.getSession();			
		currentHandler=(UserSession)(session.getAttribute("usersession"));	
		if(currentHandler==null)
			throw new RuntimeException("当前用户没有登录");
		return currentHandler;
	}


	/**
	 * 获取用户会话信息
	 * 
	 * @param accountName
	 *            账户名称
	 * @param password
	 *            密码
	 * @return
	 */
	
	public UserSession getUserSessionInfo(String accountName, String password) {
		List<UserSession> list=userDao.getUserSession(accountName,password);
		if(list.size()!=0){
			System.err.println("获取userSession的信息");
			System.err.println(list.size());
			System.err.println(list.get(0).getClass().getName());
			return list.get(0);
		}		
		return null;
	}

	/**
	 * 获取用户会话信息
	 * 
	 * @param account
	 *            账户ID
	 * @return
	 */
	public  UserSession getUserSessionInfoByAccountID(int account) {
		List<UserSession> list=userDao.getUserSessionByAccountid(account);
		if(list.size()!=0){
			return  list.get(0);
		}		
		return null;		
	}

	/**
	 * 添加用户
	 * 
	 * @param user
	 *            用户
	 */
	public int  addUser(UserInfo user) {
		userDao.saveByHiber(user);		
		return user.getUserId();
	}

	/**
	 * 删除用户
	 * 
	 * @param user
	 *            用户
	 * @param physicalDelete
	 *            物理删除标识，TURE为物理删除
	 *            
	 *            有待继续完善loginlog            
	 */
	public void deleteUser(UserInfo user, boolean physicalDelete) {
		if (physicalDelete) {
			//删除account
			List<Account> alist = accountDao.getUserAccountList(user.getUserId ());
			if(alist.size() > 0){
				userDao.deleteUserFromAccount(user.getUserId());
			}
			//删除user
			userDao.deleteByHiber(user);
					
		}
		else{
			user.setValidFlag((Integer) 2); // 无效
			userDao.updateByHiber(user);
		}
	}

	/**
	 * 更新用户
	 * 
	 * @param user
	 *            用户信息
	 */
	public void updateUser(UserInfo user) {
		userDao.updateByHiber(user);
	}

	/**
	 * 验证用户重复(或是否与其他重复)，true为重复
	 * 
	 * @param userId
	 *            用户ID，可为null 如果不为null表示判断不包含该用户ID 
	 * @param realName
	 *            用户名称
	 */
	public  boolean getUserRepeatVerify(Integer userId, String realName) { 
		List<UserInfo> list = userDao.getUserRepeatVerify(userId, realName);
		if (list !=null && list.size() != 0) {
			return true;
		}
		return false;
	}

	/**
	 * 获取用户信息
	 * 
	 * @param userId
	 *            用户ID
	 * @return
	 */
	public  UserInfo getUserInfo(int userId) { 
		return userDao.getByIdHiber(UserInfo.class,userId);
	}

	/**
	 * 获取用户信息
	 * 
	 * @param accountId
	 *            用户ID
	 * @return
	 */
	public  UserInfo getAccountUserInfo(int accountId) {
		Account account=accountOperateDao.getByIdHiber(Account.class,accountId);
		int userId=account.getUserId();
		UserInfo user=getUserInfo(userId);
		return user;
	}
	/**
	 * 用户列表
	 * 
	 * @param organId
	 *            组织ID，可为空
	 * @param postId
	 *            岗位ID，可为空
	 * @param realName
	 *            用户姓名
	 * @param valueFlag
	 *            有效性，可为空
	 * @return
	 */
	public List<UserInfo> getUserList(Integer organId,Integer postId, String realName, Integer validFlag) { 
		return userDao.getUserListByCondition(organId,postId,realName,validFlag);
	}

	/**
	 * 用户分页列表
	 * 
	 * @param organ
	 *            组织ID，可为空
	 * @param post
	 *            岗位ID，可为空
	 * @param realName
	 *            用户姓名
	 * @param validFlag
	 *            有效性，可为空
	 * @param pageSize
	 *            分页行数
	 * @param pagination
	 *            页码
	 * @return
	 */
	public MiniDaoPage<UserInfo> getUserPagingList(UserInfo user, int page,int rows){	 
		user.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
		user.setSexConfig(ConfigSetting.Sex.getValue());
		user.setPoliticsStatusConfig(ConfigSetting.PoliticStatus.getValue());
		user.setContractTypeConfig(ConfigSetting.ContractType.getValue());
		user.setEducationConfig(ConfigSetting.Education.getValue());
		return userDao.getAllUsers(user,page,rows);
	}

	/**
	 * 获取组织下用户列表
	 * 
	 * @param organId
	 *            组织ID相同的 用户
	 * @return
	 */
	public List<UserInfo> getOrganUserList(int organId) { 
		return userDao.getUserFromOrgan(organId);		
	}

	/**
	 * 获取岗位下用户列表
	 * 
	 * @param postId
	 *  岗位ID
	 * @return
	 */
	public List<UserInfo> getPostUserList(int postId) { 
		return userDao.getUserFromPost(postId);
	}

	/**
	 * 根据userid获取用户关联的的子表关系
	 * @param userId
	 * @return
	 */
	public List<UserInfo> getUserSonTable(Integer userId) {
		
		return userDao.getUserSonTable(userId);
	}

	/**
	 * 根据账户id修改账户密码
	 */
	public int updatePassword(String password,int accountId) {
		return userDao.updatePassword(password,accountId);
	}


	@Override
	public List<UserInfo> getUserInfoList(String stationIds, String realName) {
		return userDao.getUserInfoList(stationIds, realName);
	}

	/**
	 * 获取给定一个organId下所有的包括子组织下的所有的用户集合
	 * lixin
	 * 2017-9-22 16:04:53
	 * @param organId
	 * 
	 * @return
	 */
	@Override
	public List<UserInfo> getUserListByParentOrganId(Integer organId) {
		return userDao.getUserListByParentOrganId(organId);
	}


	@Override
	public List<UserInfo> getMyUserListCheck(Organ organ) {
		List<UserInfo> userList=new ArrayList<UserInfo>();
		userList.addAll(getUserList(organ.getOrganId())) ;
		//如果是电力用户，还需要获取该电力用户所属售电公司的组织机构，并获取售电公司的组织机构下的人，用于审核电力用户的工作
		if(organ.getOrganType()==ConfigOrganType.commonCompany.getValue()){//电力用户
			EnergyRelation energyRelationSearch =new EnergyRelation();
			energyRelationSearch.setCommon_Organ_Id(organ.getOrganId());
			EnergyRelation energyRelation=energyRelationDao.getEnergyRelationInfo(energyRelationSearch);
			if(energyRelation!=null){
				//售电公司id
				int saleMerchantId=energyRelation.getDepartment_Id();
				userList.addAll(getUserList(saleMerchantId)) ;
			}
		}
		return userList;
	}  
	//获取当前organ下的所有人员
	private List<UserInfo> getUserList(int organId){
		List<UserInfo> userList=new ArrayList<UserInfo>();
		List<Organ> subOrganList=organPostService.getSubOrganList(organId);
		if(subOrganList.size()==0)
			userList.addAll(getOrganUserList(organId));
		else
			userList.addAll(getUserListByParentOrganId(organId));
		return userList;
	}


	@Override
	public String getSubUserIds(String mySubOrganIds) {
		String mySubUserIds="";
		UserInfo user=userDao.getSubUserIds(mySubOrganIds);
		if(user!=null){
			mySubUserIds="("+user.getUserIds()+")";
		}
		return mySubUserIds;
	}


	@Override
	public List<UserInfo> getRoleUserList(Integer roleId) {
		return userDao.getRoleUserList(roleId);
	}
}
