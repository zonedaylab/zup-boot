package cn.zup.bi.controller;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.bi.entity.BI_DIM;
import cn.zup.bi.entity.BI_DIM_ATTRIBUTE;
import cn.zup.bi.service.BIDimService;
import cn.zup.bi.utils.PropertiesUtil;

@Controller
@RequestMapping("/rest/bi/BIDimController")
public class BIDimController {
	
	@Resource
	BIDimService biDimService;
	
	/**
	 * 维表设计首页
	 * @author antsdot
	 * @date 2016-10-09 09:11:15
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(){
		return new ModelAndView("bi/biDimManage");
	}
	
	/**
	 * 
	 * 获取所有的数据表
	 * @author antsdot
	 * @date 2016-10-09 11:10:38
	 * */
	@RequestMapping("/getDatabaseTableName")
	@ResponseBody
	public String getDatabaseTableName(){
		JSONObject json = new JSONObject();
		Connection conn = PropertiesUtil.OpenConn();
		try {
			json.put("data", biDimService.getTableNameList(conn));
		} catch (SQLException e) {
			json.put("data", "error");
			e.printStackTrace();
		}finally {
			PropertiesUtil.CloseConn(conn);
		}
		
		return json.toString();
	}
	
	/**
	 * 获取数据表中的所有字段
	 * @author antsdot
	 * @date 2016-10-9 16:10:01
	 * @param tableName 表名称
	 * */
	@RequestMapping("/getTableData")
	@ResponseBody
	public String getTableData(String tableName){
		JSONObject json = new JSONObject();
		Connection conn = PropertiesUtil.OpenConn();
		try {
			json.put("data", biDimService.getColumnNameList(conn, tableName));
			json.put("pk", biDimService.getPrimaryKey(conn, tableName));
		} catch (SQLException e) {
			json.put("data", "error");
			e.printStackTrace();
		} finally {
			PropertiesUtil.CloseConn(conn);
		}
		return json.toString();
	}
	
	/**
	 * 
	 * 保存设计的维表名称
	 * @author antsdot
	 * @date 2016-10-10 09:12:08
	 * @param 维表实体
	 * 
	 * */
	@RequestMapping("/saveDimData")
	@ResponseBody
	public String saveDimData(HttpServletRequest request){
		BI_DIM biDim = new BI_DIM();
		Object dimIdstr = request.getParameter("dimId");
		Integer dimId = 0;
		if(dimIdstr != null)
			if(dimIdstr != "")
				dimId = Integer.parseInt(dimIdstr.toString());
		String dimName = request.getParameter("dimName");
		String dbName = request.getParameter("dbName");
		String[] valueColName = request.getParameterValues("valueColName");
		String[] textColName = request.getParameterValues("textColName");
		String[] valueName = request.getParameterValues("valueName");
		String[] valueId = request.getParameterValues("valueId");
		String tree = request.getParameter("tree");
		String idField = request.getParameter("idField");
		String nameField = request.getParameter("nameField");
		String treeInfo = "";
		if(tree.equals("2")){
			treeInfo = request.getParameter("piecewiseInfo");
		}else if(tree.equals("3")){
			treeInfo = request.getParameter("openPath");
		}
		biDim.setDim_Name(dimName);
		biDim.setBiz_Table_Name(dbName);
		biDim.setDrill_Type(tree);
		biDim.setDrill_Info(treeInfo);
		biDim.setId_Field(idField);
		biDim.setText_Field(nameField);
		int info = 0;
		if(dimId == 0){
			info = biDimService.saveDimData(biDim);
		}
		else{
			biDim.setDim_Id(dimId);
			info = biDimService.updateDimData(biDim);
		}
		if( info != 0){
			if(!tree.equals("1")){
				for (int i = 0; i < textColName.length; i++) {
					BI_DIM_ATTRIBUTE dimAttribute = new BI_DIM_ATTRIBUTE();
					dimAttribute.setAttribute_Id(Integer.parseInt(valueId[i]));
					dimAttribute.setDim_Id(info);
					dimAttribute.setAttribute_Caption_Field(valueName[i]);
					dimAttribute.setAttribute_Name(valueColName[i]);
					dimAttribute.setAttribute_Value_Field(valueColName[i]);
					if(Integer.parseInt(valueId[i]) == 0)
						biDimService.saveDimAttribute(dimAttribute);
					else{
						biDimService.updateDimAttribute(dimAttribute);
					}
				}
			}
		}
		JSONObject json = new JSONObject();
		if( info != 0){
			json.put("info", "success");
		}else{
			json.put("info", "error");
		}
		return json.toString();
		
	}
	
	/**
	 * 
	 * 加载维表保存数据
	 * @author antsdot
	 * @date 2016-10-10 09:12:08
	 * @param 维表实体
	 * 
	 * */
	@RequestMapping("/loadDbDim")
	@ResponseBody
	public String loadDbDim(String dnName, HttpServletRequest request){
		BI_DIM dim = biDimService.getDimInfo(dnName);
		JSONArray jsonarr = null;
		if(dim != null){
			List<BI_DIM_ATTRIBUTE> list = biDimService.getDimInInfo(dim.getDim_Id());
			jsonarr = JSONArray.fromObject(list); 
		}
		JSONObject json = new JSONObject();
		
		if(dim != null){
			json.put("dim", dim);
			json.put("dimInfo", jsonarr);
			json.put("info", "success");
		}else{
			json.put("info", "error");
		}
		return json.toString();
	}
	
	/**
	 * 通过DimId获取维表所有字段
	 * 
	 * */
	@RequestMapping("/getDimFiledByDimId")
	@ResponseBody
	public String getDimFiledByDimId(Integer dimId){
		JSONObject json = new JSONObject();
		List<BI_DIM_ATTRIBUTE> list = biDimService.getDimInInfo(dimId);
		json.put("data", list);
		return json.toString();
	}
}
