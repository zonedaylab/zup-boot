package cn.zup.workflowdemo.biz;

import java.sql.SQLException;

import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflowdemo.model.DemoSampleReceiveRegister;

public interface DemoSampleReceiveRegisterService {
	/**
	 * 说明： 保存样本信息
	 * @author 谢炎
	 * @throws SQLException 
	 * @date 2016-8-17 16:11:49
	 * 
	 * */
	public int SaveSamleInfo(DemoSampleReceiveRegister demoSampleReceiveRegister) throws SQLException;
	
	/**
	 * 说明： 更新样本信息
	 * @author 谢炎
	 * @throws SQLException 
	 * @date 2016-8-17 16:11:49
	 * 
	 * */
	public int UpdateSamleInfo(DemoSampleReceiveRegister demoSampleReceiveRegister, String mainBizKey) throws SQLException;
	
	/**
	 * 说明： 获取样本信息
	 * @author 谢炎
	 * @throws SQLException 
	 * @throws Exception 
	 * @date 
	 * 
	 * */
	public DemoSampleReceiveRegister getSamleInfo(String sampleId) throws Exception;
	
	/**
	 * 说明：获取活动id和工作项id
	 * @author 谢炎
	 * @throws SQLException 
	 * @throws Exception 
	 * @date 
	 * 
	 * */
	public FlowRequest getWorkItemActivety(String workId, String StateId) throws Exception;
}
