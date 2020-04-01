package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_TOPIC;
import cn.zup.bi.service.TopicService;
import cn.zup.framework.common.vo.CommonResult;
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
 * @author gavin
 */
@Controller
@RequestMapping("/rest/bi/BITopicController")
public class BITopicController {
	
	@Resource
	private TopicService topicService;
	
	/** 
	* 主题设置页面
	* @author 谢炎
	* @date 2016-10-5 11:35:44
	*/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("bi/biTopicManage");
	}
	
	/** 
	* 主题列表获取
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/girdTopicList")
	@ResponseBody 
	public CommonResult getGrid(BI_TOPIC topic,Integer page,Integer rows,HttpServletRequest request) {
		List<BI_TOPIC> pagetopic = topicService.getTopicPagingList(topic);
		return CommonResult.successPage(pagetopic, page, rows);
	}
	
	/** 
	* 主题数据编辑
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/editTopicData")
	@ResponseBody
	public String getTopicData(BI_TOPIC topic, HttpServletRequest request) {
		JSONObject json = new JSONObject(); 
		int flag = topicService.updateTopicData(topic);
		if(flag != 0){
			json.put("data", "success");
		}else{
			json.put("data", "error");
		}
		return json.toString();
	}
	
	/** 
	* 主题数据添加
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/addTopicData")
	@ResponseBody
	public String addTopicData(BI_TOPIC topic, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		if(topic.getDs_id()==null||topic.getDs_id()==0)
			topic.setDs_id(1);
		int flag = topicService.addTopicData(topic);
		if(flag != 0){
			json.put("data", "success");
		}else{
			json.put("data", "error");
		}
		return json.toString();
	}
	
	/** 
	* 主题数据删除
	* @author 谢炎
	* @date 2016-10-5 16:33:54
	*/
	@RequestMapping("/deleteTopicData")
	@ResponseBody
	public String deleteTopicData(@RequestParam("topic_Ids[]") String[] topicIds, HttpServletRequest request) {
		JSONObject json = new JSONObject(); 
		String errorId = "";
		for (int i = 0; i < topicIds.length; i++) {
			try{

				topicService.deleteTopicData(Integer.parseInt(topicIds[i]));

				errorId = "success";
			}catch(Exception e){
				if(i == topicIds.length-1){
					errorId += topicIds[i];
				}else{
					errorId += topicIds[i]+",";
				}
			}
		}
		json.put("data", errorId);
		return json.toString();
	}
	
	/** 
	* 主题列表数据获取 编辑框填充的数据
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/getTopicData")
	@ResponseBody
	public String editTopicData(Integer topic_Id, HttpServletRequest request) {
		BI_TOPIC topicData = topicService.getTopicData(topic_Id);
		JSONObject json = new JSONObject(); 
		JSONArray jsonarr = JSONArray.fromObject(topicData);
		json.put("data", jsonarr);
		return json.toString();
	}
}
