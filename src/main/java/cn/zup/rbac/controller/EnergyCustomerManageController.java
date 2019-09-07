package cn.zup.rbac.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.rbac.entity.EnergyCustomer;
import cn.zup.rbac.service.EnergyCustomerManageService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
/**
 * 1.客户线索 energyCustomerClue.jsp
 * 2.我的客户 energyCustomerManage.jsp
 * @author zxy
 *
 */
@Controller
@RequestMapping("/rest/rbac/energyCustomerManageController")
public class EnergyCustomerManageController {
	
	@Resource
	private EnergyCustomerManageService energyCustomerManageService;
	/**
	 * 进入客户线索界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/goEnergyCustomerClue")
	@ResponseBody
	public ModelAndView goCustomerClue(HttpServletRequest request){
		return new ModelAndView("rbac/energyCustomerClue");
	}
	/**
	 * 进入我的商户界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/goEnergyCustomerManage")
	@ResponseBody
	public ModelAndView goCustomerManage(HttpServletRequest request){
		return new ModelAndView("rbac/energyCustomerManage");
	}
	/**
	 * 获取地图加载数据&&查询-----getEnergyCustomerList
	 * @param energyCustomer
	 * @return
	 */
	@RequestMapping("/getMapData")
	@ResponseBody
	public Map<String, Object> getMapDate(EnergyCustomer energyCustomer){
		List<EnergyCustomer> mapList = energyCustomerManageService.getEnergyCustomerList(energyCustomer);
		JSONObject json = new JSONObject();
		json.put("data", mapList);
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("mapdata", mapList);  
		return map;
	}
	
	@RequestMapping("/getAllCustomer")
	@ResponseBody
	public String getAllCustomer(EnergyCustomer energyCustomer){
		List<EnergyCustomer> mapList = energyCustomerManageService.getEnergyCustomerList(energyCustomer);
		List<EnergyCustomer> mapListNew = new ArrayList<EnergyCustomer>();
		for(EnergyCustomer energyCustomerData : mapList){
			EnergyCustomer energyCustomerDataNew = new EnergyCustomer();
			energyCustomerDataNew.setCustomer_Id(energyCustomerData.getCustomer_Id());
			energyCustomerDataNew.setCustomer_Name(energyCustomerData.getCustomer_Name());
			energyCustomerDataNew.setProvinceString(energyCustomerData.getRegion_Code().substring(0,2).concat("0000"));
			energyCustomerDataNew.setRegion_Code(energyCustomerData.getRegion_Code());
			energyCustomerDataNew.setAddress(energyCustomerData.getAddress());
			energyCustomerDataNew.setLegal_Person(energyCustomerData.getLegal_Person());
			energyCustomerDataNew.setPhone(energyCustomerData.getPhone());
			energyCustomerDataNew.setVoltage_Class(energyCustomerData.getVoltage_Class());
			energyCustomerDataNew.setYear_Quantity(energyCustomerData.getYear_Quantity());
			energyCustomerDataNew.setProject_Situation(energyCustomerData.getProject_Situation());
			energyCustomerDataNew.setReg_User_Name(energyCustomerData.getReg_User_Name());
			energyCustomerDataNew.setReg_Date(energyCustomerData.getReg_Date());
			mapListNew.add(energyCustomerDataNew);
		}
		
		JSONObject json = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
	    jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd"));
	    JSONArray jsonArray = JSONArray.fromObject(mapListNew, jsonConfig);
	    json.put("data", jsonArray);
	    json.put("success", "success");
		return json.toString();
	}
	/**
	 * 添加
	 * @param energyCustomer
	 * @return
	 */
	@RequestMapping("/addCustomerInfo")
	@ResponseBody
	public String saveCustomerInfo(EnergyCustomer energyCustomer){
		energyCustomer.setProvinceString(energyCustomer.getRegion_Code().substring(0,2).concat("0000"));
		energyCustomer.setCheck_State(2);
		energyCustomerManageService.saveCustomerInfo(energyCustomer);
		JSONObject json = new JSONObject();
	    json.put("success", "success");
		return json.toString();
	}


}
