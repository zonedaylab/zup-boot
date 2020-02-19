package cn.zup.rbac.controller;

import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.ConfigurationService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigSetting;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 用于组织管理操作的相关控制
 * @author 李欣
 *	time:2016/7/29
 */
 @Controller
 @RequestMapping("/rest/rbac/organController")
 public class OrganController 
 {	
	@Resource
	private OrganPostService organPostService;
	@Resource
	private UserService userService;	
	@Resource
	private ConfigurationService configurationService;
	@Resource
	private MerchantService merchantService;
	/**
	 * 通过请求conroller访问jsp页面
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {  
	    return new ModelAndView("rbac/organManage");
	}
	
	/**
	 * 根据父节点的id获取子节点
	 * @param parentOrganId：父节点的id
	 * @return
	 */
	@RequestMapping("/getChildNode")
	@ResponseBody
	public String getChildNode(int parentOrganId){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		//根节点的ID=1，parentOrganId = -1
		if(parentOrganId == -1){
			TreeView ts = new TreeView();
			ts.setId(0);
			ts.setName("组织机构");
			ts.setType("folder");
			tree.add(ts);
		}
		else{
			List<Organ> listOrgan = organPostService.getSubOrganList(parentOrganId);  //获取所有节点  
			for(int i =0;i<listOrgan.size();i++){
				TreeView t = new TreeView();
				Organ organ = listOrgan.get(i);
				t.setId(organ.getOrganId());
				t.setName(organ.getOrganName());
				//List<Organ> listChild = organPostService.getSubOrganList(organ.getOrganId());
				if(organ.getChildCounts() <= 0)
					t.setType("item");				
				else
					t.setType("folder");							
				tree.add(t);
			}
		}
		json.put("data", tree);
		return json.toString();
	}
	/**
	 * 获取当前登录用户应该展示的组织结构，用于    售电公司
	 * lixins
	 * 2018-1-25 14:08:59
	 * 
	 * @param parentOrganId
	 * @return
	 */
	@RequestMapping("/getMyChildOrgan")
	@ResponseBody
	public String getMyChildOrgan(int parentOrganId,HttpServletRequest request){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		String myOrganIds=merchantService.getMyOrganIds(userSession);
		tree=getMyOrganTree(parentOrganId, myOrganIds);
		json.put("data", tree);
		return json.toString();
	}
	/**
	 * 根据父组织id和要获取的组织id的集合，获取属于当前公司的组织机构
	 * liixn
	 * 2018-2-1 08:38:56
	 * @param parentOrganId
	 * @param myOrganIds
	 * @return
	 */
	public List<TreeView> getMyOrganTree(int parentOrganId,String myOrganIds){
		List<TreeView> tree = new ArrayList<TreeView>();
		if(parentOrganId == -1){
			TreeView ts = new TreeView();
			ts.setId(0);
			ts.setName("组织机构");
			ts.setType("folder");
			tree.add(ts);
		}
		else{
			List<Organ> listOrgan =new ArrayList<Organ>();
			if(parentOrganId==0){
				listOrgan = organPostService.getMySubOrganList(parentOrganId,myOrganIds);  //获取所有节点  
			}else{
				listOrgan = organPostService.getSubOrganList(parentOrganId);  //获取所有节点  
			}
			for(int i =0;i<listOrgan.size();i++){
				TreeView t = new TreeView();
				Organ organ = listOrgan.get(i);
				t.setId(organ.getOrganId());
				t.setName(organ.getOrganName());
				List<Organ> listChild = organPostService.getSubOrganList(organ.getOrganId());
				if(listChild.size() <= 0)
					t.setType("item");				
				else
					t.setType("folder");							
				tree.add(t);
			}
		}
		return tree;
	}
	/**
	 * 显示组织机构的详细信息
	 * @param organId组织ID
	 * @param request
	 * @return
	 */
	@RequestMapping("/getOrgan")
	@ResponseBody 
	public String getOrgan(Integer organId,HttpServletRequest request) {		
		Organ organ = organPostService.getOrganInfo(organId);		
		JSONArray jsonarr = JSONArray.fromObject(organ);
		JSONObject json = new JSONObject();	
		json.put("data", jsonarr);	
		return json.toString();			
	}
	
	/**
	 * 删除某个组织
	 * @param organId组织id 	
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteOrgan")
	@ResponseBody 
	public String deleteOrgan(Integer organId,HttpServletRequest request) {		
		//该组织没有其他子组织以后，再判断该组织是否有外键关联				
		JSONObject json = new JSONObject();		
		if(userService.getOrganUserList(organId).size()>0 && userService.getOrganUserList(organId)!=null ){//判断该组织与用户表是否有关联			
			json.put("result", "error");
		}
		else if(organPostService.getOrganPostList(organId).size()!=0 && organPostService.getOrganPostList(organId)!=null){//判断该组织与post有没有外键关联			
				json.put("result", "error");
		}
		else{
			Organ organ=new Organ();
			organ.setOrganId(organId);				
			organPostService.deleteOrgan(organ);
			json.put("result", "success");		
			}		
		return json.toString();
	}
	
	/**
	 * 添加一个组织
	 * @param organ：添加的组织实体
	 * @param request
	 * @return
	 */	
	@RequestMapping("/addOrgan")
	@ResponseBody 
	public String addOrgan(Organ organ,HttpServletRequest request) {	
		//判断增加的组织名称是否重复 			
		JSONObject json = new JSONObject();		
		if(organPostService.getOrganRepeatVerify(null,organ.getParentOrganId(),organ.getOrganName())){
			json.put("msg", "organName");
		}
		else if(organPostService.getOrderCodeRepeatVerify(null,organ.getParentOrganId(),organ.getOrderCode())){
			json.put("msg", "orderCode");			
		}
		else{
			organPostService.addOrgan(organ);
			json.put("msg", "success");
		}
		return json.toString();
	}
	
	/**
	 * 编辑某个组织信息
	 * @param organ：要编辑的组织实体
	 * @param request
	 * @return
	 */
	@RequestMapping("/editOrgan")
	@ResponseBody 
	public String editOrgan(Organ organ,HttpServletRequest request) {
		JSONObject json = new JSONObject();		
		if(organPostService.getOrganRepeatVerify(organ.getOrganId(),organ.getParentOrganId(),organ.getOrganName())){
			json.put("msg", "organName");
		}else if(organPostService.getOrderCodeRepeatVerify(organ.getOrganId(),organ.getParentOrganId(),organ.getOrderCode())){
			json.put("msg", "orderCode");
			
		}else{
			organPostService.updateOrgan(organ);
			json.put("msg", "success");
		}
		return json.toString();
	}
	
	/**
	 * 通过枚举获取组织类型
	 * @return
	 */
	@RequestMapping("/getOrganType")
	@ResponseBody 
	public String getOrganType(){
		Config config = new  Config();
		config.setConfigid(ConfigSetting.OrganType.getValue());
		System.out.println("测试获取的组织类型相对应的configId");
		List<Config> listOrganType =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", listOrganType);
		return json.toString();
	}	

	/**
	 * 通过枚举获取组织类型
	 * @return
	 */
	@RequestMapping("/getOrganUsed")
	@ResponseBody 
	public String GetOrganUsed(int organId,int used){
		long start = System.currentTimeMillis();
		List<Organ> organLL = new ArrayList<Organ>();
		for (int i = 1; i < 4; i++) {
			long start1 = System.currentTimeMillis();
			List<Organ> organList = organPostService.GetOrganUsed(organId, used, i);
			for (Organ organ : organList) {
				System.out.println(organ.toString());
			}
			organLL = organList;
			long end1 = System.currentTimeMillis();
			System.out.println(i+"--------->>> "+(end1-start1)+"ms"); 
		}
		long end = System.currentTimeMillis();
		System.out.println("程序运行时间： "+(end-start)+"ms"); 

		JSONObject json = new JSONObject();
		json.put("data", organLL);
		return json.toString();
	}	
}
