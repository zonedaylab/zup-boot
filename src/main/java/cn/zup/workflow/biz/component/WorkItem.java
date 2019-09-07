package cn.zup.workflow.biz.component;

import cn.zup.workflow.config.WorkItemState;
import cn.zup.workflow.dal.WF_WORK_ITEM;
import cn.zup.workflow.structure.SignInfo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

public class WorkItem{
	
	/** 
	 经办人列表（需要生成的工作项操作者/当前操作者）	 
	*/
	private java.util.List<cn.zup.workflow.model.WF_HANDLER> currentHandlerList;	

    public java.util.List<cn.zup.workflow.model.WF_HANDLER> getCurrentHandlerList() {
		return currentHandlerList;
	}
	public void setCurrentHandlerList(
			java.util.List<cn.zup.workflow.model.WF_HANDLER> currentHandlerList) {
		this.currentHandlerList = currentHandlerList;
	}
	public java.util.List<Integer> getAttachList() {
		return attachList;
	}
	public void setAttachList(java.util.List<Integer> attachList) {
		this.attachList = attachList;
	}
	public SignInfo getSignInfo() {
		return signInfo;
	}
	public void setSignInfo(SignInfo signInfo) {
		this.signInfo = signInfo;
	}
	public int getReviewType() {
		return reviewType;
	}
	public void setReviewType(int reviewType) {
		this.reviewType = reviewType;
	}
	//附件上传列表
	private java.util.List<Integer> attachList;

	/** 
	 签字信息	 
	*/
	private SignInfo signInfo;

	/** 
	 当前活动的审批类型	 
	*/
	private int reviewType;
	public WorkItem(){
		
	}
	/** 
	 活动工作项列表	 
	*/
	private java.util.List<cn.zup.workflow.model.WF_WORK_ITEM> workItemList;	
	public java.util.List<cn.zup.workflow.model.WF_WORK_ITEM> getWorkItemList()
	{
		return workItemList;
	}
	public void setWorkItemList(java.util.List<cn.zup.workflow.model.WF_WORK_ITEM> value)
	{
		workItemList = value;
	}
}
