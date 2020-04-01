package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_DIM;
import cn.zup.bi.entity.BI_DIM_ATTRIBUTE;
import cn.zup.bi.entity.BI_TOPIC_FIELD;
import cn.zup.bi.service.BIDimService;
import cn.zup.bi.service.TopicFieldService;
import cn.zup.bi.utils.BIConnection;
import cn.zup.framework.common.vo.CommonResult;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/rest/bi/BIDimController")
public class BIDimController {
	
	@Resource
	BIDimService biDimService;
	@Resource
	TopicFieldService topicFieldService;
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
	 * 维度字段设置页面
	 * @return
	 */
	@RequestMapping("/biDimSet")
	public ModelAndView biDimSet(HttpServletRequest request){
		String dimId = request.getParameter("dimId");
		ModelAndView mv = new ModelAndView("bi/biDimSet");
		mv.addObject("dimId", dimId);
		return mv;
	}

	
	/** 
	* 获取维表列表
	 */
	@RequestMapping("/girdDimList")
	@ResponseBody 
	public CommonResult getGrid(BI_DIM dim,Integer page,Integer rows,HttpServletRequest request) {
		List<BI_DIM> pagedim=biDimService.getDimPagingList(dim);
		return CommonResult.successPage(pagedim, page, rows);
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
		Connection conn = BIConnection.OpenConn();
		try {
			json.put("data", biDimService.getTableNameList(conn));
		} catch (SQLException e) {
			json.put("data", "error");
			e.printStackTrace();
		}finally {
			BIConnection.CloseConn(conn);
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
		Connection conn = BIConnection.OpenConn();
		try {
			json.put("data", biDimService.getColumnNameList(conn, tableName));
			json.put("pk", biDimService.getPrimaryKey(conn, tableName));
		} catch (SQLException e) {
			json.put("data", "error");
			e.printStackTrace();
		} finally {
			BIConnection.CloseConn(conn);
		}
		return json.toString();
	}
	
	/**
	 * 
	 * 保存设计的维表名称
	 * @author antsdot
	 * @date 2016-10-10 09:12:08 */
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
				if(!StringUtils.isEmpty(textColName))//weikong
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
		System.err.println(12);
		return json.toString();
		
	}

	/**
	 *
	 * 保存设计的维表名称
	 * @author antsdot
	 * @date 2020-03-01 16:05:21
	 * */
	@RequestMapping("/saveDim")
	@ResponseBody
	public String saveDim(BI_DIM biDim){
		int result = biDimService.saveDimData(biDim);
		JSONObject json = new JSONObject();
		if( result != 0){
			json.put("info", "success");
		}else{
			json.put("info", "error");
		}
		return json.toString();
	}
	/**
	 *
	 * 更新设计的维表名称
	 * @author antsdot
	 * @date 2020-03-01 16:05:21
	 * */
	@RequestMapping("/updateDim")
	@ResponseBody
	public String updateDim(BI_DIM biDim){
		int result = biDimService.updateDimData(biDim);
		JSONObject json = new JSONObject();
		if( result != 0){
			json.put("info", "success");
		}else{
			json.put("info", "error");
		}
		return json.toString();
	}
	/**
	 *
	 * 获取设计的维表名称
	 * @author antsdot
	 * @date 2020-03-01 16:05:21
	 * */
	@RequestMapping("/getDim")
	@ResponseBody
	public CommonResult getDim(Integer dimId){
		BI_DIM dim = biDimService.getDimInfo(dimId);
		return CommonResult.success("查询成功", dim);
	}
	
	/**
	 * 
	 * 加载维表保存数据
	 * @author antsdot
	 * @date 2016-10-10 09:12:08 */
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


	/**
	 * 维度数据删除
	 * @author 张朝阳
	 * @date 2019
	 */
	@RequestMapping("/deleteDimData")
	@ResponseBody
	public String deleteDimData(@RequestParam("dim_Ids[]") Integer[] dimIds, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String errorId = "";
		String tipstr="";
		List<BI_TOPIC_FIELD> fieldList=null;
		BI_TOPIC_FIELD field= new BI_TOPIC_FIELD();
		List<BI_DIM_ATTRIBUTE> dimAttributeList=null;
		for (int i = 0; i < dimIds.length; i++) {
			try{

				field.setDim_Id(dimIds[i]);
				fieldList=topicFieldService.getTopicFieldList(field);
				if(fieldList!=null&&fieldList.size()!=0) {
					tipstr += dimIds[i] + ",";

				} else {
				dimAttributeList=biDimService.getDimInInfo(dimIds[i]);
				if(dimAttributeList!=null&&dimAttributeList.size()!=0)	{
					for (BI_DIM_ATTRIBUTE o :dimAttributeList)
						biDimService.deleteDimAttribute(o);
					dimAttributeList.clear();
				}
				biDimService.deleteDimData(dimIds[i]);
				errorId = "success";
				}
			}catch(Exception e){
				if(i == dimIds.length-1){
					errorId += dimIds[i];
				}else{
					errorId += dimIds[i]+",";
				}
				errorId=errorId+" error:"+e.getMessage();
			}
		}
		json.put("data", errorId);
		json.put("mes",tipstr);
		return json.toString();
	}
}
