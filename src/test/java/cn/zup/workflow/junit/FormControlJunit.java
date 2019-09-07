package cn.zup.workflow.junit;

import java.sql.SQLException; 

import org.junit.Test;

import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowConfig; 
import cn.zup.workflow.config.ControlType;
import cn.zup.workflow.model.WF_FORM_CONTROL; 

public class FormControlJunit {
	//表单字段增删改查
	private IWorkFlowConfig configService =new WorkFlowConfig();
	@Test
	public void addFormControl() throws SQLException{
		WF_FORM_CONTROL formControl = new WF_FORM_CONTROL();
		formControl.setCONTROL_NAME("Pass"); //控件ID
		formControl.setFORM_ID(1);
		formControl.setCONTROL_TEXT("通过");  
		formControl.setCONTROL_TYPE((byte) ControlType.Button.getValue()); //控件类型 
		formControl.setNULL_PERMIT((byte)1);  //为空标志 1代表可空2为不可空   
		formControl.setDEFAULT_LENGTH(100); //默认长度 
		formControl.setCONTROL_MEANING((byte)1); //自定义 
		formControl.setUSER_CONTROL_NAME("通过按钮");
		
		int Id = configService.saveFormControl(formControl);	 
		System.out.println(Id);
	}
	@Test
	public void delFormControl() throws SQLException{ 
		configService.deleteFormControl(85);	 
		System.out.println("删除成功");
	}

	@Test
	public void getFormControl() throws SQLException{ 
		WF_FORM_CONTROL formControl = configService.getFormControl(1); 
		System.out.println(formControl.getCONTROL_ID());
	}

	@Test
	public void updateFormControl() throws SQLException{
		WF_FORM_CONTROL formControl = configService.getFormControl(1);
		configService.saveFormControl(formControl);	 
	}  
}
