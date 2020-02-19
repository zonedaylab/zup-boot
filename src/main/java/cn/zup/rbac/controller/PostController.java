package cn.zup.rbac.controller;

import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigSetting;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 岗位管理页面控制器
 * @author 谢炎
 * @date 2016-7-29 11:01:03
 * */
@Controller
@RequestMapping("/rest/rbac/postController")
public class PostController{
	
	@Resource
	private OrganPostService postservice;
	@Resource
	private UserService userService;
	@Resource
	private OrganPostService organPostService;
	@Resource
	private MerchantService merchantService;
	/**
	 * 
	 * 岗位管理页面
	 * @author 谢炎
	 * @date 2016-7-27 11:18:19
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("rbac/postManage");
	}
	
	/** 
	* 岗位列表查询
	* @author 谢炎
	* @param Post 岗位实体
	* @date 2016-7-29 00:26:34
	*/
	@RequestMapping("/girdPostList")
	@ResponseBody 
	public String getGrid(Post post,Integer page,Integer rows,HttpServletRequest request) {
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		

		//判断组织查询
		if(post.getOrganId() ==null ||  post.getOrganId().equals(0))
		{
			String myOrganIds = "(";
			myOrganIds += organPostService.getMySubOrganIdsAll(userSession.getOrganId());
			myOrganIds +=")";
			post.setOrganId(null);
			post.setMyOrganIds(myOrganIds);
		}
		else
		{
			String myOrganIds = "(";
			myOrganIds += organPostService.getMySubOrganIdsAll(post.getOrganId());
			myOrganIds +=")";
			post.setOrganId(null);
			post.setMyOrganIds(myOrganIds);
		}
		
		
//		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
//		if(mySubOrganIds!=""){
//			post.setMyOrganIds(mySubOrganIds);
//		}
		post.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
		MiniDaoPage<Post> pagepost = postservice.getPostPagingList(post, page, rows);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", pagepost.getPages());
		json.put("total", pagepost.getTotal());
		JSONArray jsonarr = JSONArray.fromObject(pagepost.getResults());  
		json.put("data", jsonarr);
		return json.toString();
	}

	/** 
	 *删除岗位
	 *
	 *@param postIds 岗位id数组
	 *@date 2016-7-29 10:57:10
	 */
	@RequestMapping("/delPost")
	@ResponseBody
	public String PostDelete(@RequestParam("actionIds[]") String[] postIds)
	{
		JSONObject json = new JSONObject();
		String returnPostName="";
		for(int i=0; i<postIds.length; i++){			
			//判断该岗位是否有用户关联
			java.lang.System.out.println("获取该岗位关联的用户长度为======"+userService.getPostUserList(Integer.parseInt(postIds[i])));
			if(userService.getPostUserList(Integer.parseInt(postIds[i])).size()>0&&userService.getPostUserList(Integer.parseInt(postIds[i]))!=null){
				returnPostName += postIds[i]+",";
				json.put("info",returnPostName);
				json.put("result", "error");				
			}else{		
				postservice.deletePost(Integer.parseInt(postIds[i]));
				json.put("result", "success");				
			}			
		}
		return json.toString();
	}
	
	/** 
	 *岗位详情页面
	 *
	 *@param PostID  岗位id
	 *@date 2016-7-29 10:58:06
	*/
	@RequestMapping("/getPost")
	@ResponseBody
	public String getPost(int postId)
	{
		JSONObject json = new JSONObject();
		Post post = postservice.getPostInfo(postId);
		Organ organ = organPostService.getOrganInfo(post.getOrganId());
		JSONArray jsonarr = JSONArray.fromObject(post); 
		json.put("postinfo", jsonarr);
		json.put("organinfo", organ);
		return json.toString();
	}

	/** 
	 *岗位编辑更新
	 *
	 *@param post  岗位实体
	 *@date 2016-7-29 10:58:27
	*/
	@RequestMapping("/editPost")
	@ResponseBody
	public String editPost(Post post)
	{
		JSONObject json = new JSONObject();
		if(postservice.getPostRepeatVerify(post.getPostId(), post.getOrganId(), post.getPostName())){
			json.put("result", "error");
		}else{
			postservice.updatePost(post);
			json.put("result", "success");
		}	
		return json.toString();
	}
	
	/** 
	 *岗位添加
	 *@param post 岗位实体类
	 *@date 2016-7-28 18:47:48
	*/
	@RequestMapping("/addPost")
	@ResponseBody
	public String addPost(Post post)
	{
		JSONObject json = new JSONObject();
		if(postservice.getPostRepeatVerify(null, post.getOrganId(), post.getPostName())){
			json.put("result", "error");
		}else{
			postservice.addPost(post);
			json.put("result", "yes");
		}	
		return json.toString();
		
	}
	
	/**
	 * 
	 * desc:获取岗位的列表
	 * Author：宋冰飞
	 * Date: 2016.07.23
	 * @param organid
	 * 
	 * */ 
	@RequestMapping("/loadPost")
	@ResponseBody
	public String getLoadPost(int organId){
		List<Post> postList = postservice.getOrganPostList(organId);
		JSONObject json = new JSONObject();
		json.put("data", postList);
		return json.toString();
	}
}
