package cn.zup.workflow.wfInterface.wfService;
import java.util.List;
import cn.zup.workflow.model.*;


/** 
	工作流权限过滤通用接口
 	lixin
 	2018-4-2 15:58:59
*/
public interface WorkFormAccessService{
	/**
	 * 通过父级表单id获取所有的子表单
	 * lixin
	 * 2018-4-2 15:59:46
	 * @param systemId
	 * @param parentFormId
	 * @return
	 */
	//1
	List<WF_FORM> listFormSub(int parentFormId);
	
	/**
	 * 根据当前登录用户获取一个表单下有权限的表单控件
	 * lixn
	 * 2018-4-2 16:27:09
	 * @param formId
	 * @param userId
	 * @return
	 */
	
	List<WF_FORM_CONTROL> getWfFormControl(int formId);
	/**
	 * 根据控件id，获取该控件当前的值，用以判断应该往哪个节点跳转
	 * lixin
	 * 2018-4-2 16:30:18
	 * @param controlId
	 * @return
	 */
	//10
	String getControlCurrentNum(int controlId);
	
}
