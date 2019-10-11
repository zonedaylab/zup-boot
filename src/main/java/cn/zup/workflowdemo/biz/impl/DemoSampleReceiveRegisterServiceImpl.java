package cn.zup.workflowdemo.biz.impl;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflowdemo.biz.DemoSampleReceiveRegisterService;
import cn.zup.workflowdemo.dal.DemoSample;
import cn.zup.workflowdemo.model.DemoSampleReceiveRegister;

/**
 * 说明： 保存样本信息实现
 * @author 谢炎
 * @date 2016-8-17 16:11:49
 * 
 * */
@Service("demoSampleReceiveRegisterService")
public class DemoSampleReceiveRegisterServiceImpl implements DemoSampleReceiveRegisterService {
	
	@Autowired
	private DemoSample demoSampleDao;
	
	

	@Override
	public int SaveSamleInfo(DemoSampleReceiveRegister demoSampleReceiveRegister) throws SQLException {
		return demoSampleDao.AddCommon(demoSampleReceiveRegister);
	}


	@Override
	public DemoSampleReceiveRegister getSamleInfo(String sampleId)throws Exception {
		return demoSampleDao.getSampleInfo(sampleId);
	}


	@Override
	public FlowRequest getWorkItemActivety(String workId, String StateId)throws Exception {
		return demoSampleDao.getWorkItemActivety(workId, StateId);
	}


	@Override
	public int UpdateSamleInfo(DemoSampleReceiveRegister demoSampleReceiveRegister, String mainBizKey) throws SQLException {
		return demoSampleDao.UpdateCommon(demoSampleReceiveRegister, mainBizKey);
	}
	

}
