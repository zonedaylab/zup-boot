package cn.zup.workflow.junit;

import java.sql.SQLException;
import java.util.List;

import org.junit.Test;

import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.model.FORM_CONTROL;
import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_SYSTEM;

public class WorkFormJunit {
	@Test
	public void SystemList(){//测试增加账户
		IWorkFlowConfig config = new WorkFlowConfig();
		List<WF_SYSTEM> list = config.listSystem();
		
		System.out.println(list.size());
		
	}
	
	@Test
	public void FormList() throws SQLException{//测试增加账户
		IWorkFlowConfig config = new WorkFlowConfig();
		List<WF_FORM> list = config.listForm(0);
		
		System.out.println(list.size());
		
	}
	
	@Test
	public void FormControlList() throws Exception{
		
		IWorkFlowConfig config = new WorkFlowConfig();
		List<FORM_CONTROL> list = config.listFormControl(1);
		
		System.out.println(list.size());
		
	}
	
	
}
