package cn.zup.workflow.biz;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;

import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_FORM_CONTROL;

public interface IWorkFlowFormAuto {

	/** 
	 * 更新表单
	 * @author 谢炎
	 * @date 2016-8-25 10:39:40
	 * @param context
	 * @return 
	 * @throws SQLException 
	*/
	//1
	int updateFormAuto(String formID, String context) throws SQLException, UnsupportedEncodingException;
	/** 
	 * 插入表单控制
	 * @author 谢炎
	 * @date 2016-8-25 15:48:11
	 * @param context
	 * @return 
	 * @throws SQLException 
	*/
	//2
	int saveFormControl(WF_FORM_CONTROL wfFormControl) throws SQLException, UnsupportedEncodingException;
	/** 
	 * 插入自定义表单数据
	 * @author 谢炎
	 * @date 2016-8-25 15:48:11
	 * @param formAutoJob
	 * @return 
	 * @throws SQLException 
	*/
	//3
	int saveFormAutoJob(cn.zup.workflow.model.WF_FORMAUTO_JOB formAutoJob) throws SQLException;	
	/** 
	 * 插入自定义表单控件数据
	 * @author 谢炎
	 * @date 2016-8-25 15:48:11
	 * @param formAutoJob
	 * @return 
	 * @throws SQLException 
	*/
	//4
	void saveFormAutoJobData(cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA formAutoJobData) throws SQLException;
	/** 
	 * 更新自定义表单控件数据
	 * @author 谢炎
	 * @date 2016-8-25 15:48:11
	 * @param formAutoJob
	 * @return 
	 * @throws SQLException 
	*/
	//5
	void updateFormAutoJobData(cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA formAutoJobData, int mainBizKey) throws SQLException;
	
	/** 
	 * 根据formId删除表单组件配置
	 * @author 谢炎
	 * @date 2016-08-30
	 * @param formId 表单Id
	 * @throws SQLException 
	*/
	//6
	void deleteFormControlByFormId(int formId) throws SQLException;	
	/** 
	 * 根据formId和controlName获取组件Id
	 * @author 谢炎
	 * @date 2016-08-30
	 * @param formId 表单Id 、controlName 组件名称 
	 * @throws SQLException 
	*/
	//7
	List<Integer> getFormControl(int formId, String controlName) throws SQLException;
	
	/**
	 * 
	 * 通过业务主键 获取业务数据
	 * @author 谢炎 
	 * @throws Exception 
	 * @date 2016-08-31
	 * 
	 * */
	//8
	List<cn.zup.workflow.model.WF_FORMAUTO_JOB_DATA> getFormAuto(String mainBizKey) throws SQLException;
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
	List<WF_FLOW> getWfFlow(Integer formId) throws SQLException;
}
