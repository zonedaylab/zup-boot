package cn.zup.workflow.wfInterface.wfService.Impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.wfInterface.wfService.WorkFormAccessService;


@Service("workFormAccessService")
public class WorkFormAccessServiceImpl implements WorkFormAccessService{
	@Autowired
	private cn.zup.workflow.dal.WF_FORM formDal;
	@Override
	public List<WF_FORM> listFormSub(int parentFormId) {
		List<WF_FORM>  list=new ArrayList<WF_FORM>();
		try {
			list=formDal.GetListArray( "  PARENT_FORM_ID=" + parentFormId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<WF_FORM_CONTROL> getWfFormControl(int formId) {
		return null;
	}
	@Override
	public String getControlCurrentNum(int controlId) {
		return null;
	}
	
	
}
