package cn.zup.workflow.biz.impl;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.biz.SampleReceiveRegisterService;
import cn.zup.workflow.dal.SampleDal;
import cn.zup.workflow.model.SampleReceiveRegister;

/**
 * 说明： 保存样本信息实现
 * @author 谢炎
 * @date 2016-8-17 16:11:49
 * 
 * */
@Service("demoSampleReceiveRegisterService")
public class SampleReceiveRegisterServiceImpl implements SampleReceiveRegisterService {
	
	@Autowired
	private SampleDal sampleDao;
	
	

	@Override
	public int SaveSamleInfo(SampleReceiveRegister sampleReceiveRegister) throws SQLException {
		return sampleDao.AddCommon(sampleReceiveRegister);
	}


	@Override
	public SampleReceiveRegister getSamleInfo(String sampleId)throws Exception {
		return sampleDao.getSampleInfo(sampleId);
	}


	@Override
	public FlowRequest getWorkItemActivety(String workId, String StateId)throws Exception {
		return sampleDao.getWorkItemActivety(workId, StateId);
	}


	@Override
	public int UpdateSamleInfo(SampleReceiveRegister sampleReceiveRegister, String mainBizKey) throws SQLException {
		return sampleDao.UpdateCommon(sampleReceiveRegister, mainBizKey);
	}
	

}
