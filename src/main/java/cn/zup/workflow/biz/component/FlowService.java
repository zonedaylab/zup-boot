package cn.zup.workflow.biz.component;

import cn.zup.workflow.dal.WF_FLOW;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("flowService")
public class FlowService{
	/** 
	 流程数据操作
	*/
	@Autowired
	private WF_FLOW flowDal;
	
	@Autowired
	private ActivityService wfActivityService;	

	/** 
	 获取流程model  
	 @param flowID 流程ID
	*/
	public  Flow  getFlow(int flowID) throws SQLException
	{
		Flow flow=new Flow();
		flow.setFlowModel(flowDal.GetModel(flowID));		
		flow.setFirstActivity( wfActivityService.getActivityFlow(flowID));
		return flow;
	}
	
}