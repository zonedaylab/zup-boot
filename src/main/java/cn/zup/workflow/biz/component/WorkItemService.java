package cn.zup.workflow.biz.component;

import cn.zup.workflow.config.WorkItemState;
import cn.zup.workflow.dal.WF_WORK_ITEM;
import cn.zup.workflow.structure.SignInfo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service("workItemService")
public class WorkItemService{
	/** 
	 工作项数据操作	 
	*/
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_ITEM itemDal;
	@Autowired
	private cn.zup.workflow.dal.WF_ATTACH attachDal;
	
	/** 
	 构造函数，获取工作活动的工作项
	 
	 @param workActivityID
	 @param handlerID
	*/
	public WorkItem  getWorkItem(int workActivityID, java.util.List<cn.zup.workflow.model.WF_HANDLER> currentHandlerList, 
			SignInfo signInfo, int reviewType) throws SQLException{	
		
		WorkItem workItem=new WorkItem();
		workItem.setSignInfo(signInfo.clone());
		workItem.setCurrentHandlerList(currentHandlerList);
		workItem.setReviewType(reviewType);
		workItem.setWorkItemList(itemDal.ActivityWorkItemList(workActivityID));
		if (workItem.getWorkItemList()== null || workItem.getWorkItemList().size()==0)
		{			
			List<cn.zup.workflow.model.WF_WORK_ITEM> workItemList = new ArrayList<cn.zup.workflow.model.WF_WORK_ITEM>();		
			
			cn.zup.workflow.model.WF_WORK_ITEM workItemModel;
			for (cn.zup.workflow.model.WF_HANDLER handler : currentHandlerList)
			{
				workItemModel = new cn.zup.workflow.model.WF_WORK_ITEM();
				workItemModel.setWORK_ACTIVITY_ID(workActivityID);	
				workItemModel.setWORK_ITEM_DATETIME(new java.sql.Date(System.currentTimeMillis()));
				workItemModel.setWORK_ITEM_STATE(Byte.parseByte(String.valueOf(WorkItemState.InProgress.getValue())));
				
				workItemModel.setRECEIVER_TYPE(handler.getHANDLER_TYPE());
				workItemModel.setRECEIVER_NAME(handler.getHANDLER_NAME());
				workItemModel.setRECEIVER_ID(handler.getHANDLER());
				
				workItemModel.setRESPONSIBLE_ID(handler.getHANDLER());//应该已经废弃 by liuxf
				
				int workItemID = itemDal.add(workItemModel);
				workItemModel.setWORK_ITEM_ID(workItemID);
				workItemList.add(workItemModel);
			}
			workItem.setWorkItemList(workItemList);
		}
		return workItem;
	}
	/** 
	 工作项保存
	 
	 @param handlerID 操作者ID
	 * @throws Exception 
	*/
	public void WorkItemSave(WorkItem workItem) throws Exception
	{		
		cn.zup.workflow.model.WF_WORK_ITEM handlerWorkItem = WorkItemSet(workItem);
		itemDal.update(handlerWorkItem);
		attachDal.UpdateTran(handlerWorkItem.getWORK_ITEM_ID(), workItem.getAttachList());
	}

	/** 
	 工作项提交
	 
	 @param handlerID 操作者ID
	 @return 该工作活动下工作项全部提交标志
	 * @throws Exception 
	*/
	public boolean WorkItemCommit(WorkItem workItem) throws Exception
	{				
		cn.zup.workflow.model.WF_WORK_ITEM handlerWorkItem = WorkItemSet(workItem);
		handlerWorkItem.setWORK_ITEM_STATE((byte)WorkItemState.NormalEnd.getValue());
		
		itemDal.update(handlerWorkItem);
		attachDal.UpdateTran(handlerWorkItem.getWORK_ITEM_ID(), workItem.getAttachList());		
		
		if(workItem.getReviewType()==cn.zup.workflow.config.ReviewType.OnePass.getValue()) //如果活动的审批类型是一个人通过审批即可往下流转，则更新该活动下的其他工作项为自动通过状态
		{
			for(cn.zup.workflow.model.WF_WORK_ITEM workItemModel :  workItem.getWorkItemList())
			{
				if(workItemModel.getWORK_ITEM_ID()==handlerWorkItem.getWORK_ITEM_ID())
					continue;
				workItemModel.setWORK_ITEM_STATE( Byte.parseByte(String.valueOf(WorkItemState.AutoApprovalPassed.getValue())));
				itemDal.update(workItemModel);
				
			}
			
		}
		//获取工作中未完成的工作项（工作状态！=正常结束 ||工作项状态！=自动通过）
		workItem.setWorkItemList(itemDal.ActivityWorkItemList(handlerWorkItem.getWORK_ACTIVITY_ID()));
		
		int count=0;
		for(cn.zup.workflow.model.WF_WORK_ITEM item : workItem.getWorkItemList() )
		{
			if(item.getWORK_ITEM_STATE()!=WorkItemState.NormalEnd.getValue() &&  item.getWORK_ITEM_STATE() != WorkItemState.AutoApprovalPassed.getValue())
			 count++;					
			
		}
		if (count > 0)
		{
			return false; //该工作活动下还有未完成的工作项
		}
		else
		{
			return true; //该工作活动下所有的工作项以完成
		}
	}

	/** 
	查找该操作者对应的workItem	 
	 @return 
	*/
	private cn.zup.workflow.model.WF_WORK_ITEM WorkItemSet(WorkItem workItem)
	{				
		cn.zup.workflow.model.WF_WORK_ITEM handlerWorkItem=null;
		for(cn.zup.workflow.model.WF_WORK_ITEM workItemModel : workItem.getWorkItemList() )
		for(cn.zup.workflow.model.WF_HANDLER handlerItem  :workItem.getCurrentHandlerList())
		{
			if(workItemModel.getRECEIVER_TYPE() == handlerItem.getHANDLER_TYPE()
					&&workItemModel.getRECEIVER_ID()==handlerItem.getHANDLER())
			{
				handlerWorkItem=workItemModel;
				break;
			}
		}
		if(handlerWorkItem==null)
		{
			throw new RuntimeException("当前经办人工作已经不存在！");			
		}		
		if (handlerWorkItem.getWORK_ITEM_STATE()!=WorkItemState.InProgress.getValue()) //验证状态
		{
			throw new RuntimeException("当前经办人工作已经完成，请勿重复提交！");
		}
		handlerWorkItem.setRESPONSIBLE_ID( workItem.getSignInfo().getSignUserID());
		handlerWorkItem.setSIGN_NAME( workItem.getSignInfo().getSignUserName());
		handlerWorkItem.setSIGN_OPINION ( workItem.getSignInfo().getSignOpinion());
		handlerWorkItem.setSIGN_DATE (workItem.getSignInfo().getSignDatetime());
		return handlerWorkItem;
	}
}