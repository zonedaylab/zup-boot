package cn.zup.workflow.biz.impl;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.workflow.biz.IWorkFlowFormAuto;
import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA;
import cn.zup.workflow.model.WF_FORM_CONTROL;

@Service("formAuto")
public class WorkFlowFormAuto implements IWorkFlowFormAuto {

	@Autowired
	private cn.zup.workflow.dal.WF_FORMAUTO_JOB wfFormAutoJob;
	
	/** 
	 * 更新表单
	 * @author 谢炎
	 * @date 2016-8-25 10:39:40
	 * @param context
	 * @return 
	 * @throws SQLException 
	*/
	//1
	public  int updateFormAuto(String formID, String content)throws SQLException, UnsupportedEncodingException{
		return wfFormAutoJob.FormAutoUpdate(formID, content);
	}
	
	/** 
	 * 表单控制实体插入
	 * @author 谢炎
	 * @date 2016-8-25 10:39:40
	 * @param wfFormControl
	 * @return 
	 * @throws SQLException 
	*/
	//2
	@Override
	public  int saveFormControl(WF_FORM_CONTROL wfFormControl)throws SQLException, UnsupportedEncodingException {
		return wfFormAutoJob.FormControlInsert(wfFormControl);
	}
	
	/** 
	 * 插入自定义表单
	 * @author 谢炎
	 * @date 2016-8-25 15:48:11
	 * @param formAutoJob
	 * @return 
	 * @throws SQLException 
	*/
	//3
	public int saveFormAutoJob(cn.zup.workflow.model.WF_FORMAUTO_JOB formAutoJob) throws SQLException{
		return wfFormAutoJob.FormAutoJobSave(formAutoJob);
	}	
	
	/** 
	 * 插入自定义表单控件数据
	 * @author 谢炎
	 * @date 2016-8-25 15:48:11
	 * @param formAutoJob
	 * @return 
	 * @throws SQLException 
	*/
	//4
	public void saveFormAutoJobData(cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA formAutoJobData) throws SQLException{
		wfFormAutoJob.FormAutoJobDataSave(formAutoJobData);
	}
	
	/** 
	 更新自定义表单控件数据
	 
	 @param formAutoJobData 自定义表单控件数据实体
	 @return jobId
	 * @throws SQLException 
	*/
	//5
	public void updateFormAutoJobData(cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA formAutoJobData, int mainBizKey) throws SQLException{
		wfFormAutoJob.FormAutoJobDataUpdate(formAutoJobData, mainBizKey);
	}
	
	
	/** 
	 * 根据formId删除表单组件配置
	 * @author 谢炎
	 * @date 2016-08-30
	 * @param formId 表单Id
	 * @throws SQLException 
	*/
	//6
	public  void deleteFormControlByFormId(int formId) throws SQLException{
		wfFormAutoJob.FormControlDelete(formId);
	}
	
	/** 
	 * 根据formId和controlName获取组件Id
	 * @author 谢炎
	 * @date 2016-08-30
	 * @param formId 表单Id 、controlName 组件名称 
	 * @throws SQLException 
	*/
	//7
	public  List<Integer> getFormControl(int formId, String controlName) throws SQLException{
		return wfFormAutoJob.FormControlInfo(formId, controlName);
	}
	
	/**
	 * 
	 * 通过业务主键 获取业务数据
	 * @author 谢炎 
	 * @throws Exception 
	 * @date 2016-08-31
	 * 
	 * */
	//8
	public List<WF_FORMAUTO_JOB_DATA> getFormAuto(String mainBizKey) throws SQLException{
		return wfFormAutoJob.getFormAutoInfo(mainBizKey);
	}

	/**
	 * 设备流转，待办时，workFlowAutoController中需要根据formId获取menuid
	 * 首先根据formid获取flowid
	 * 再根据flowid获取menuid
	 * lixin 
	 * 2016-11-30 15:34:47
	 * @param formId
	 * @return
	 * @throws SQLException
	 */
	//9
	public List<WF_FLOW> getWfFlow(Integer formId) throws SQLException {
		return wfFormAutoJob.getWfFlowInfo(formId);
	}

}
