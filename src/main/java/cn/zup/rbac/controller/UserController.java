package cn.zup.rbac.controller;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.framework.util.MD5Base;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.*;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.wechat.entity.WechatRegister;
import cn.zup.wechat.service.BindWechatService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.lang.System;
/**
 * 用于关于用户操作的管理
 * @author iesies
 *
 */
@Controller
@RequestMapping("/rest/rbac/userController")
public class UserController 
{
	@Resource
	private UserService userService;
	@Resource
	private ConfigurationService configurationService; 
	@Resource
	private AccountRoleService accountService; 
	@Resource
	private OrganPostService postService;
	@Resource
	private OrganPostService postservice;
	@Resource
	private BindWechatService bindService;
	@Resource
	private OrganPostService organPostService;
	@Resource
	private MerchantService merchantService;
	/**
	 * 用于通过controller访问userManage.jsp页面
	 * Author：韩圣传
	 * @param 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {  
	    return new ModelAndView("rbac/userManage");
	 }
	
	/**
	 * 通过表格显示用户的信息
	 * @param userInfo
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	@RequestMapping("/girdUser")
	@ResponseBody 
	public String getGrid(UserInfo userInfo, int page, int rows,HttpServletRequest request) {		
		//判断组织查询
		if(userInfo.getOrganId() !=null && userInfo.getOrganId().equals(0))
			userInfo.setOrganId(null);
		//判断岗位查询
		if(userInfo.getPostId() !=null && userInfo.getPostId().equals(0))
			userInfo.setPostId(null);
		//判断真实名称查询
		if(userInfo.getRealName() !=null && userInfo.getRealName().equals(""))
			userInfo.setRealName(null);
		//判断有效标识查询
		if(userInfo.getValidFlag() !=null && userInfo.getValidFlag().equals(0))
			userInfo.setValidFlag(null);
		
		userInfo.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
		userInfo.setSexConfig(ConfigSetting.Sex.getValue());
		userInfo.setPoliticsStatusConfig(ConfigSetting.PoliticStatus.getValue());
		userInfo.setContractTypeConfig(ConfigSetting.ContractType.getValue());
		userInfo.setEducationConfig(ConfigSetting.Education.getValue());
		MiniDaoPage<UserInfo> pageopers = userService.getUserPagingList(userInfo, page, rows);		
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageopers.getPages());
		json.put("total",pageopers.getTotal());		
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonArray = JSONArray.fromObject(pageopers.getResults(), jsonConfig);  
		json.put("data", jsonArray);		
		return json.toString();  
	}

	/***
	 * 
	 * @param userInfo
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	@RequestMapping("/getGridByOrgans")
	@ResponseBody 
	public String getGridByOrgans(UserInfo userInfo, int page, int rows,HttpServletRequest request) {	

		//通过当前登录用户获取所有部门，进行数据过滤
		long date1 = System.currentTimeMillis();
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		//判断组织查询
		if(userInfo.getOrganId() == null ||  userInfo.getOrganId().equals(0))
		{
			String myOrganIds = "(";
			myOrganIds += organPostService.getMySubOrganIdsAll(userSession.getOrganId());
			myOrganIds +=")";
			userInfo.setOrganId(null);
			userInfo.setOrganIds(myOrganIds);
		}
		else
		{
			String myOrganIds = "(";
			myOrganIds += organPostService.getMySubOrganIdsAll(userInfo.getOrganId());
			myOrganIds +=")";
			userInfo.setOrganId(null);
			userInfo.setOrganIds(myOrganIds);
		}
		//判断岗位查询
		if(userInfo.getPostId() !=null && userInfo.getPostId().equals(0))
			userInfo.setPostId(null);
		//判断真实名称查询
		if(userInfo.getRealName() !=null && userInfo.getRealName().equals(""))
			userInfo.setRealName(null);
		//判断有效标识查询
		if(userInfo.getValidFlag() !=null && userInfo.getValidFlag().equals(0))
			userInfo.setValidFlag(null);
		
		userInfo.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
		userInfo.setSexConfig(ConfigSetting.Sex.getValue());
		userInfo.setPoliticsStatusConfig(ConfigSetting.PoliticStatus.getValue());
		userInfo.setContractTypeConfig(ConfigSetting.ContractType.getValue());
		userInfo.setEducationConfig(ConfigSetting.Education.getValue());
		long date2 = System.currentTimeMillis();
		System.out.println("organS=----->"+(date2-date1));
		MiniDaoPage<UserInfo> pageopers = userService.getUserPagingList(userInfo, page, rows);	
		long date3 = System.currentTimeMillis();	
		System.out.println("organS=----->"+(date3-date1));
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageopers.getPages());
		json.put("total",pageopers.getTotal());		
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonArray = JSONArray.fromObject(pageopers.getResults(), jsonConfig);  
		json.put("data", jsonArray);		
		return json.toString();  
	}
	/**
	 * 加载当前登录用户权限内的用户信息
	 * 售电系统：如果是普通公司，则只展示当前普通公司下所有组织以及子组织的用户
	 *       如果是售电公司，则展示当前售电公司下所有组织以及子组织的用户、和售电公司代理电力用户的所有组织以及子组织下的所有用户
	 * 光伏系统：待定
	 *       lixin
	 *       2018-2-1 16:34:55
	 * @param userInfo
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	@RequestMapping("/girdMyUser")
	@ResponseBody 
	public String getMyGrid(UserInfo userInfo, int page, int rows,HttpServletRequest request) {	
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		//获取当前登录用户权限范围内的组织机构
		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
		//判断组织查询
		if(userInfo.getOrganId() !=null && userInfo.getOrganId().equals(0))
			userInfo.setOrganId(null);
			userInfo.setOrganIds(mySubOrganIds);
		//判断岗位查询
		if(userInfo.getPostId() !=null && userInfo.getPostId().equals(0))
			userInfo.setPostId(null);
		//判断真实名称查询
		if(userInfo.getRealName() !=null && userInfo.getRealName().equals(""))
			userInfo.setRealName(null);
		//判断有效标识查询
		if(userInfo.getValidFlag() !=null && userInfo.getValidFlag().equals(0))
			userInfo.setValidFlag(null);
		MiniDaoPage<UserInfo> pageopers = userService.getUserPagingList(userInfo, page, rows);		
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageopers.getPages());
		json.put("total",pageopers.getTotal());		
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonArray = JSONArray.fromObject(pageopers.getResults(), jsonConfig);  
		json.put("data", jsonArray);		
		return json.toString();  
	}
	/**
	 * 
	 * desc:获取有效标识
	 * Author：samson
	 * Date: 2016.07.23 
	 * 
	 * */ 
	@RequestMapping("/getValidFlag")
	@ResponseBody
	public String getValidFlag(){
		Config config = new  Config();
		config.setConfigid(ConfigSetting.ValigFlag.getValue());
		List<Config> validFlag =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", validFlag);
		return json.toString();
	}
	/**
	 * 通过字典配置获取性别
	 * @return
	 */
	@RequestMapping("/getSex")
	@ResponseBody
	public String getSex(){
		System.out.println("已经成功进入获取性别的controller");
		Config config = new  Config();
		config.setConfigid(ConfigSetting.Sex.getValue());
		List<Config> sex =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", sex);
		return json.toString();
	}
	/**
	 * 
	 * desc:获取政治面貌
	 * Author：lixin
	 * Date: 2016.08.16
	 * @param organid
	 * 
	 * */ 
	@RequestMapping("/getPoliticsStatus")
	@ResponseBody
	public String getPoliticsStatus(){		
		Config config = new  Config();
		config.setConfigid(ConfigSetting.PoliticStatus.getValue());
		List<Config> politicsStatus =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", politicsStatus);
		return json.toString();
	}
	/**
	 * 获取合同类型
	 * @return
	 */
	@RequestMapping("/getContractType")
	@ResponseBody
	public String getContractType(){		
		Config config = new  Config();
		config.setConfigid(ConfigSetting.ContractType.getValue());
		List<Config> contractType =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", contractType);
		return json.toString();
	}
	/**
	 * 获取学历的下拉菜单
	 * @return
	 */
	@RequestMapping("/getEducation")
	@ResponseBody
	public String getEducation(){		
		Config config = new  Config();
		config.setConfigid(ConfigSetting.Education.getValue());
		List<Config> contractType =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", contractType);
		return json.toString();
	}
	/**
	 * 
	 * desc:添加用户
	 * Author：samson
	 * Date: 2016.07.23
	 * @param user
	 * 
	 * */
	@RequestMapping("/addUser")
	@ResponseBody
	public String addUser(UserInfo user)
	{
		JSONObject json = new JSONObject();
		if(userService.getUserRepeatVerify(null, user.getRealName())){
			json.put("result", "error");
		}else{
			userService.addUser(user);
			json.put("result", "success");
		}	
		return json.toString(); 
	}

	/**
	 * 
	 * desc:获取某个用户信息
	 * Author：samson
	 * Date: 2016.07.23
	 * @param userId
	 * 
	 * */
	@RequestMapping("/getUserInfo")
	@ResponseBody
	public String getUserInfo(int userId, HttpServletRequest request)
	{
		JSONObject json = new JSONObject();
		UserInfo userInfo = userService.getUserInfo(userId);
		Organ organInfo = organPostService.getOrganInfo(userInfo.getOrganId());
		JSONArray jsonArr = JSONArray.fromObject(userInfo); 
		json.put("data", jsonArr);
		json.put("organInfo", organInfo);
		return json.toString();
	}
	
	/**
	 * 
	 * desc:编辑用户
	 * Author：samson
	 * Date: 2016.07.23
	 * @param user
	 * 
	 * */
	@RequestMapping("/editUserInfo")
	@ResponseBody
	public String editUserInfo(UserInfo user, HttpServletRequest request)
	{
		System.out.println("获取到的userid======================="+user.getUserId());
		JSONObject json = new JSONObject();
		if(userService.getUserRepeatVerify(user.getUserId(), user.getRealName())){
			json.put("result", "error");
		}else{
			userService.updateUser(user);
			json.put("result", "success");
		}	
		return json.toString();
	}
	
	/**
	 * 
	 * desc:删除用户
	 * Author：samson
	 * Date: 2016.07.23
	 * @param userid
	 * 
	 * */
	@RequestMapping("/delUserInfo")
	@ResponseBody
	public String delUserInfo(@RequestParam("userIds[]") String[] userIds)
	{		
		JSONObject json = new JSONObject();
		String returnUserId="";
		for(int i=0;i<userIds.length;i++){
			//判断该用户是否有子表关联
			if(accountService.getUserAccountList(Integer.parseInt(userIds[i])).size()>0&&
					accountService.getUserAccountList(Integer.parseInt(userIds[i]))!=null){
				returnUserId += userIds[i]+",";
				json.put("info",returnUserId);
				json.put("result", "error");
			}
			else{
				UserInfo user=new UserInfo();
				user.setUserId(Integer.parseInt(userIds[i])); 
				userService.deleteUser(user,true);
				json.put("result", "success");
			}			
		}
		return json.toString();
	} 

	/**
	 * 
	 * desc:获取账号的列表
	 * Author：samson
	 * Date: 2016.07.23
	 * @param organid
	 * 
	 * */

	@RequestMapping("/gridAccount")
	@ResponseBody 
	public String gridAccount(Account account, int page, int rows,HttpServletRequest request) {			
		account.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());		
		if(account.getValidFlag()!=null && account.getValidFlag()==0){//判断有效值是否为0，若为0，则设置为null
			account.setValidFlag(null);
		}
		MiniDaoPage<Account>  pageopers = accountService.getAccountPagingList(account,page,rows);			
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageopers.getPages());
		json.put("total",pageopers.getTotal());	
		JSONArray jsonArray = JSONArray.fromObject(pageopers.getResults());  
		json.put("data", jsonArray);		
		return json.toString();  	
	}

	/**
	 * 
	 * desc:添加账号
	 * Author：samson
	 * Date: 2016.07.23
	 * @param account
	 * 
	 * */
	@RequestMapping("/addAccount")
	@ResponseBody
	public String addAccount(Account account)
	{
		JSONObject json = new JSONObject();
		//账户名称重复验证
		if(accountService.getAccountRepeatVerify(null,account.getUserId(),account.getAccountName())){
			json.put("result", "error");
		}
		else{
			accountService.addAccount(account);
			json.put("result", "success");
		}
		return json.toString();		
	}

	/**
	 * 
	 * desc:账号信息
	 * Author：samson
	 * Date: 2016.07.23
	 * @param accountId
	 * 
	 * */
	@RequestMapping("/getAccountInfo")
	@ResponseBody
	public String getAccountInfo(int accountId, HttpServletRequest request)
	{
		JSONObject json = new JSONObject(); 
		Account accountInfo = accountService.getAccountInfo(accountId);
		JSONArray jsonArr = JSONArray.fromObject(accountInfo); 
		json.put("accountInfo", jsonArr);
		return json.toString();
	}
	
	/**
	 * 
	 * desc:编辑账号
	 * Author：samson
	 * Date: 2016.07.23
	 * @param user
	 * 
	 * */
	@RequestMapping("/editAccountInfo")
	@ResponseBody
	public String editAccountInfo(Account account, String flag, HttpServletRequest request)
	{		
		JSONObject json = new JSONObject();
			if(flag!=null){  //重置密码的标识，重置密码是不需要账户名重复性验证的，只需要通过主键更新密码即可
				Account ainfo = accountService.getAccountInfo(account.getAccountId());
				ainfo.setPassWord(account.getPassWord());
				accountService.updateAccount(ainfo);
				json.put("result", "success");
			}else{
				if(accountService.getAccountRepeatVerify(account.getAccountId(),account.getUserId(),account.getAccountName())){
					json.put("result", "error");
				}
				else{
					accountService.updateAccount(account);
					json.put("result", "success");
				}	
			}
		return json.toString();
	}
	
	
	/**
	 * 
	 * desc:账号删除
	 * Author：samson
	 * Date: 2016.07.23
	 * @param accountid
	 * 
	 * */
	@RequestMapping("/delAccountInfo")
	@ResponseBody
	public String AccountDelete(@RequestParam("accountIds[]") String[] accountIds)
	{		
		JSONObject json = new JSONObject();
		String returnAccountName="";
		//判断该账号是否跟其他表有无关联关系
		for(int i=0;i<accountIds.length;i++){
			Account account=new Account();
			account.setAccountId(Integer.parseInt(accountIds[i]));
			if(accountService.getAccountSonTable(account).size()>0&&accountService.getAccountSonTable(account)!=null){
				returnAccountName += accountIds[i]+",";
				json.put("info",returnAccountName);
				json.put("result", "error");
			}
			else
			{
				accountService.deleteAccount(account, true);
				json.put("result", "success");
			}
		}	
		return json.toString();	
	}
	
	/**
	 * 用户密码修改
	 * 
     * @author 谢炎
	 * @throws SQLException 
     * @date 2016年10月28日10:12:51
	 */
	@RequestMapping("/editPassword")
	@ResponseBody
	public String editPassword(String oldPwd, String password,int accountId,HttpServletRequest request) throws SQLException
	{	
		//对用户的密码进行md5加密，
		String	passwordMd5 = MD5Base.md5AddCode(password);
		String	oldpasswordMd5 = MD5Base.md5AddCode(oldPwd);
		JSONObject json = new JSONObject();
		Account getAccount=accountService.getAccountInfo(accountId);
		//判断用户输入的加密的密码和用户的真实密码是否相同
		if(!getAccount.getPassWord().equals(oldpasswordMd5)){
			json.put("info", "oldError");
			return json.toString();
		}
		else{
			int result = userService.updatePassword(passwordMd5,accountId);
			if(result == 0){
				json.put("info", "error");
			}else{
				json.put("info", "success");
			}
			return json.toString();
		}
	}
	/**
	 * 重置密码
	 * @param accountId
	 * @param accountName
	 * @param userId
	 * */
	//ResponseBody
	//public String subPasswordResert(int accountId,int userId,String accountName){
		
		//JSONObject json = new JSONObject();
		//int result = accountService.subPasswordResert(accountId, userId, accountName);
		//if(result == 0){
			//json.put("result", "error");
		//}else{
		//	json.put("result", "error");
		//}
		//return json.toString();
	//}
	/**
	 * mysql取消绑定
	 * 
     * @author 谢炎
	 * @throws SQLException 
     * @date 2016年10月28日10:12:51
	 */
	@RequestMapping("/closeBind")
	@ResponseBody
	public String closeBind(HttpServletRequest request,HttpServletResponse response) throws SQLException
	{	
		JSONObject json = new JSONObject();
		HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("usersession");
		
		if(obj == null){
			json.put("info", "error");
		}
		else{
			UserSession usersession = (UserSession)obj;
			int accountid = usersession.getAccountId();
			Account acountInfo = accountService.getAccountInfo(accountid);
			String name = acountInfo.getAccountName();
			WechatRegister wr = new WechatRegister();
			wr.setRegisterName(name);
			wr.setSystemId(usersession.getSystemId());
			
			WechatRegister info = bindService.getRegister(wr);
			WechatRegister infos = new WechatRegister();
			infos.setRegisterId(info.getRegisterId());
			int result = bindService.delRegister(infos);
			
			//判断用户输入的加密的密码和用户的真实密码是否相同
			if(result > 0){
				json.put("info", "success");
				System.err.println("删除成功");
			}
			else{
				json.put("info", "error");
			}
		}
		return json.toString();
	}
	
	/**
	 * 根据账户id获取密码
	 * @param account
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPassword")
	@ResponseBody
	public String getPassword(int accountId,String oddPass, HttpServletRequest request)
	{		
		JSONObject json = new JSONObject();
		Account getAccount=accountService.getAccountInfo(accountId);
		//对用户输入的密码进行MD5	加密，
		String	password = MD5Base.md5AddCode(oddPass);
		//判断用户输入的加密的密码和用户的真实密码是否相同
		if(getAccount.getPassWord().equals(password)){
			json.put("result", "success");
			json.put("data",getAccount.getAccountName());//将用户的账户名返回前台
		}
		else{
			json.put("result", "error");
		}
		return json.toString();
	}
	
	/**
	 * 获取有效性的岗位名称
	 * @author 谢炎
	 * @date 2016-11-1 09:27:56
	 * 
	 * 
	 * */
	@RequestMapping("/loadPost")
	@ResponseBody
	public String loadPost(Integer organId){
		List<Post> postList = postservice.getOrganPostFlagList(organId);
		JSONObject json = new JSONObject();
		json.put("data", postList);
		return json.toString();
	}
	
}
