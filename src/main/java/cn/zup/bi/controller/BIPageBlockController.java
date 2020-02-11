package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Block_Info;
import cn.zup.bi.service.BIPageBlockService;
import cn.zup.bi.service.settings.MgeidsConfig;
import cn.zup.framework.common.vo.CommonResult;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.service.ConfigurationService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 区块保存接口
 * @author Andot
 * @date 2018-5-10 16:53:40
 * 
 * */
@Controller
@RequestMapping("/rest/bi/biPageBlockController")
public class BIPageBlockController {

	@Resource
	private BIPageBlockService biPageBlockService;
	@Resource
	private ConfigurationService configurationService;
		
	/**
	 * 添加块
	 * @author 谢炎
	 * */
	@RequestMapping("/saveBlock")
	@ResponseBody
	public String saveBlock(BI_Block_Info bi_Block_Info){
		Integer blcokId = biPageBlockService.saveBlock(bi_Block_Info);
		JSONObject json = new JSONObject();
		if(blcokId != 0){
			json.put("data", "success");
			json.put("blcokId", blcokId);
		}else {
			json.put("data", "fail");
		}
		return json.toString();
	}
	
	/**
	 * 更新块
	 * @author 谢炎
	 * */
	@RequestMapping("/updateBlock")
	@ResponseBody
	public String updateBlock(BI_Block_Info bi_Block_Info){
		boolean b = biPageBlockService.updateBlock(bi_Block_Info);
		JSONObject json = new JSONObject();
		if(b) {
			json.put("data", "success");
		}else {
			json.put("data", "fial");
		}
		return json.toString();
	}
	
	/**
	 * 删除块
	 * @author 谢炎
	 * */
	@RequestMapping("/deleteBlock")
	@ResponseBody
	public String deleteBlock(@RequestParam("blockId[]")Integer[] bi_Block_Ids){
		JSONObject json = new JSONObject();
		boolean b = false;
		for (int i = 0; i < bi_Block_Ids.length; i++) {
			b = biPageBlockService.deleteBlock(bi_Block_Ids[i]);
			if(!b) {
				json.put("msg", bi_Block_Ids[i]);
			}
		}
		if(b) {
			json.put("data", "success");
		} else {
			json.put("data", "fial");
		}
		return json.toString();
	}
	
	/**
	 * 根据报表的需求，根据页面删除所有的报表快
	 * @author 谢炎
	 * */
	@RequestMapping("/deleteBlockByPageId")
	@ResponseBody
	public String deleteBlockByPageId(Integer page_Id){
		JSONObject json = new JSONObject();
		boolean b = biPageBlockService.deleteBlockByPageId(page_Id);
		if(b) {
			json.put("data", "success");
		} else {
			json.put("data", "fial");
		}
		return json.toString();
	}
	
	/**
	 * 获取块信息
	 * @author 谢炎
	 * */
	@RequestMapping("/getBlockInfo")
	@ResponseBody
	public String getBlockInfo(Integer bi_Block_Id){
		BI_Block_Info blockInfo = biPageBlockService.getBlockInfo(bi_Block_Id);
		JSONObject json = new JSONObject();
		json.put("data", blockInfo);
		return json.toString();
	}
	
	/**
	 * 获取块列表
	 * @author 谢炎
	 * */
	@RequestMapping("/getBlockList")
	@ResponseBody
	public String getBlockList(BI_Block_Info bi_Block_Info){
		List<BI_Block_Info> list = biPageBlockService.getBlockList(bi_Block_Info);
		JSONObject json = new JSONObject();
		json.put("data", list);
		return json.toString();
	}
	
	/**
	 * 获取块列表分页
	 * @author 谢炎
	 * */
	@RequestMapping("/getBlockListByPage")
	@ResponseBody
	public CommonResult getBlockListByPage(BI_Block_Info bi_Block_Info, int rows, int page){
		List<BI_Block_Info> list = biPageBlockService.getBlockListByPage(bi_Block_Info, rows, page);
		return CommonResult.successPage(list, page, rows);
	}
	
	/**
	 * 获取图表类型：例如表格、柱状图、折线图等
	 * @author 谢炎
	 * */
	@RequestMapping("/getBlockType")
	@ResponseBody
	public String getPageType(){
		Config config = new  Config();
		config.setConfigid(MgeidsConfig.Block_Type.getValue());
		List<Config> fieldType = configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", fieldType);
		return json.toString();
	}
}
