package cn.zup.workflow.biz.impl;


import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_ACTIVITY_LAYOUT;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_LINE;

@Repository
public class WorkFlowSVG {
	public String strContentLable;
	@Autowired
	IWorkFlowConfig configService;
	public String CreateSVG(int FlowID , String AllowEdit) throws SQLException{
		strContentLable="";
		java.util.List<cn.zup.workflow.model.WF_ACTIVITY> activityList = configService.listActivity(FlowID);
		WF_ACTIVITY_LAYOUT layout;
		for(WF_ACTIVITY activity : activityList){
	        //评审模式
	        String strReviewType = "未设定";
	        List<WF_CONFIG> configList ;
	        if(!Integer.toString(activity.getREVIEW_TYPE()).isEmpty())
	        strReviewType=configService.listConfig(cn.zup.workflow.config.ConfigList.ReviewType.getValue()).get(0).getSUB_NAME();
	        String strActivityType = "";
	        String strNextActivity = activity.getNEXT_ACTIVITY_CODE();
	        switch (activity.getACTIVITY_TYPE())
	        {
	            case 1:
	                strActivityType = "\"start\"";
	                strNextActivity = activity.getNEXT_ACTIVITY_CODE();
	                break;
	            case 2:
	                strActivityType = "\"\"";
	                strNextActivity = activity.getNEXT_ACTIVITY_CODE();
	                break;
	            case 3:
	                strActivityType = "\"end\"";
	                strNextActivity = "结束";
	                break;
	        }
	
	        //布局
	        layout = configService.getActivityLayout(activity.getACTIVITY_ID());
	        String leftMargin = layout.getLEFT_MARGIN().toString();
	        String topMargin = layout.getTOP_MARGIN().toString();
	        strContentLable+="<svg width=\"100%\" height=\"100%\" version=\"1.1\"xmlns=\"http://www.w3.org/2000/svg\">";
	        strContentLable += "<vml:roundrect class=\"allvml\" id=" + activity.getACTIVITY_CODE();
	        if (AllowEdit != "false")
	            strContentLable += " ondblclick=Edit_Process(" + Integer.toString(activity.getACTIVITY_ID()) + ");";
	        strContentLable += " style=\"z-index: 1; left: ";
	        strContentLable += leftMargin + "px; vertical-align: middle; width: 100px; cursor: hand; position: absolute; top: " 
	                                       + topMargin + "px; height: 50px; text-align: center\"   title=\"下一步骤：" + strNextActivity;
	        //strContentLable += "&#13;&#10;--&#13;&#10;经办人：" + "todo";
	        strContentLable += "&#13;&#10;--&#13;&#10;可写字段：" + "@@";
	        strContentLable += "&#13;&#10;--&#13;&#10;评审模式：" + strReviewType;
	        strContentLable += "&#13;&#10;--&#13;&#10;当前节点，：" + activity.getACTIVITY_INTERVAL() + "小时未审批自动结束\";";
	        strContentLable += "  coordsize=\"21600,21600\" arcsize=\"4321f\" fillcolor=\"#00EE00\" receiverName=\"\" receiverID=\"\" readOnly=\"0\" flowFlag=\"0\" flowTitle=\"<b>" 
	                           + activity.getACTIVITY_CODE() + "</b><br>" +activity.getACTIVITY_NAME() + "\" passCount=\"0\" flowType=" 
	                           + strActivityType + " table_id=\"" + Integer.toString(activity.getACTIVITY_ID()) + "\" inset=\"2pt,2pt,2pt,2pt\">";
	        strContentLable += "<vml:shadow offset=\"4px,4px\" color=\"#b3b3b3\" type=\"single\" class=\"allvml\" on=\"T\"></vml:shadow>";
	        strContentLable += "<vml:textbox class=\"allvml\" onselectstart=\"return false;\" inset=\"1pt,2pt,1pt,1pt\"><B>" 
	                            + activity.getACTIVITY_CODE() + "</B><BR>" + activity.getACTIVITY_NAME() + "</vml:textbox></vml:roundrect>";
		}
		 List<WF_LINE> lineList = configService.listLine(FlowID);
		 for(WF_LINE line : lineList){
			 strContentLable += line.getLINE_CONTENT().toString();
		 }
		return strContentLable;
	}
}