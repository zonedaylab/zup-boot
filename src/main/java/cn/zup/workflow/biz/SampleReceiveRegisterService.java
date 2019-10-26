package cn.zup.workflow.biz;

import java.sql.SQLException;

import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.model.SampleReceiveRegister;

public interface SampleReceiveRegisterService {
	/**
	 * 说明： 保存样本信息
	 * @author 谢炎
	 * @throws SQLException 
	 * @date 2016-8-17 16:11:49
	 * 
	 * */
	public int SaveSamleInfo(SampleReceiveRegister demoSampleReceiveRegister) throws SQLException;
	
	/**
	 * 说明： 更新样本信息
	 * @author 谢炎
	 * @throws SQLException 
	 * @date 2016-8-17 16:11:49
	 * 
	 * */
	public int UpdateSamleInfo(SampleReceiveRegister demoSampleReceiveRegister, String mainBizKey) throws SQLException;
	
	/**
	 * 说明： 获取样本信息
	 * @author 谢炎
	 * @throws SQLException 
	 * @throws Exception 
	 * @date 
	 * 
	 * */
	public SampleReceiveRegister getSamleInfo(String sampleId) throws Exception;
	
	/**
	 * 说明：获取活动id和工作项id
	 * @author 谢炎
	 * @throws SQLException 
	 * @throws Exception 
	 * @date 
	 * 
	 * */
	public FlowRequest getWorkItemActivety(String workItemID, String StateId) throws Exception;
}
