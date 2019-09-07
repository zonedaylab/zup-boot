package cn.zup.workflow.junit;

import org.junit.Test;

import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.model.FLOW_MANAGE;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;

public class PagingJunit {

	@Test
	public void getFlowPage() throws Exception
	{
		IWorkFlowConfig configService =new WorkFlowConfig();
		QueryParameter queryParameter = new  QueryParameter();		
		int page=1;
		int rows=10;
		PagingData<FLOW_MANAGE> flowPageList = configService.listFlowPaging(queryParameter,page,rows);	
		
		int amout=flowPageList.getAmount();
		System.out.println("getFlowPage,数据总个数："+amout);
		System.out.println("getFlowPage,当前获取数据个数："+flowPageList.getData().size());
		
	}
}

