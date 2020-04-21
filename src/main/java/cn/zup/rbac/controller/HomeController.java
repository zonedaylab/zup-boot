package cn.zup.rbac.controller;

import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.MenuView;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbacmap.entity.DomainSystem;
import cn.zup.workflow.biz.IWorkFlowConfig;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/rest/rbac/homeController")
public class HomeController{  
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private ResourceService resourceService;	
	/**
	 * 框架首页面
	 * Author：samson
	 * Date:2016.7.27
	 * @param 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {  
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		List<Menu> menulist = new ArrayList<Menu>();
		if(userSession != null && userSession.getAccountId() != null){

			int systemId=userSession.getSystemId();
//			String domains[]=request.getServletPath().split("/");
//			if(domains.length>0) {
//				DomainSystem domainSystem = resourceService.getDomainSystemByDomain(domains[domains.length - 2]);
//				systemId=domainSystem.getSystem_Id();
//			}
			menulist = resourceService.getAccountPermitMenu(userSession.getAccountId(),systemId,true, 2);
			JSONObject json = new JSONObject();
			json.put("parmenulist", menulist);
			request.setAttribute("parmenulist",menulist);
			return new ModelAndView("rbac/main");
		}else{
			return new ModelAndView("rbac/login");
		}
	}
	
	/**
	 * 框架首页面
	 * Author：谢炎
	 * Date:2016-8-1 14:34:23
	 * @param 
	 **/
	@RequestMapping("/welcome")
	public ModelAndView welcome(HttpServletRequest request) {  
	    return new ModelAndView("rbac/welcome");
	} 

	/**
	 * desc:登录的时候根据选择的菜单信息获取有权限的 子菜单
	 * Author：samson
	 * Date：2016.7.27 
	 * @param menuID
	 * @return
	 */
	@RequestMapping("/getPermitSubMenu")
	@ResponseBody
	public String getPermitSubMenu(int menuID,HttpServletRequest request) throws SQLException{ 
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		int userId = userSession.getUserId();
		List<Integer> listMenuId = configService.getMenuFlowId(userId, 1);
		
		List<Menu> menulist = new ArrayList<Menu>();
		if(userSession != null && userSession.getAccountId() != null){
			List<Menu> menulists = resourceService.getAccountPermitSubMenu(userSession.getAccountId(),menuID, 2); 
			for (int i = 0; i < menulists.size(); i++) {
				if(menulists.get(i).getFlowId() != null &&  menulists.get(i).getFlowId() != 0){
					for (int j = 0; j < listMenuId.size(); j++) {
						if(menulists.get(i).getFlowId().equals(listMenuId.get(j))){
							menulist.add(menulists.get(i));
						}
					}
				}else{
					menulist.add(menulists.get(i));
				}
			}
		}
		
		
//		List<Menu> menulist = new ArrayList<Menu>();
//		if(userSession != null && userSession.getAccountId() != null)
//			menulist = resourceService.getAccountPermitSubMenu(userSession.getAccountId(),menuID, 2); 
		JSONObject json = new JSONObject();
		json.put("submenulist", menulist);  
		return json.toString();
	}
	
	
	/**
	 * 获取首页全部菜单包括二级菜单
	 * @param request
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping("/getSystemAllMenu")
	@ResponseBody
	public String getSystemAllMenu(HttpServletRequest request) throws SQLException{  
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		List<Menu> menulist = new ArrayList<Menu>();
		List<MenuView> menuViewlist = new ArrayList<MenuView>();
		boolean result = false;
		if(userSession != null && userSession.getAccountId() != null){
			menulist = resourceService.getAccountPermitMenu(userSession.getAccountId(),userSession.getSystemId(),true, 2);
			for (int i=0; i<menulist.size(); i++) {
				MenuView menuView = new MenuView();
				menuView.setMenuId(menulist.get(i).getMenuId());
				menuView.setSystemId(menulist.get(i).getSystemId());
				menuView.setParentMenuId(menulist.get(i).getParentMenuId());
				menuView.setMenuName(menulist.get(i).getMenuName());
				menuView.setOrderCode(menulist.get(i).getOrderCode());
				menuView.setIconStyle(menulist.get(i).getIconStyle());
				menuView.setNameSpace(menulist.get(i).getNameSpace());
				menuView.setUrlAddress(menulist.get(i).getUrlAddress());
				menuView.setFormAddress(menulist.get(i).getFormAddress());
				menuView.setFlowId(menulist.get(i).getFlowId());
				menuView.setMobileFlag(menulist.get(i).getMobileFlag());
				List<Menu> list = resourceService.getMenuList(menulist.get(i).getMenuId());
				if(list.size() == 0) {
					menuView.setMobileFlagConfig(0);
				}else {
					menuView.setMobileFlagConfig(1);
					String subMenu = this.getPermitSubMenu(menulist.get(i).getMenuId(), request);
					menuView.setSubMenu(subMenu);
				}
				menuViewlist.add(menuView);
			}
			JSONObject json = new JSONObject();
			json.put("parmenulist", menulist);
			request.setAttribute("parmenulist",menulist);

			 result = true;
	    }
		
		JSONObject json = new JSONObject();
		json.put("data", menuViewlist);
		json.put("result", result);
		json.put("userSession", userSession); //用户userSession信息
		return json.toString();
	}
}
