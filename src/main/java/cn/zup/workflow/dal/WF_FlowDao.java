package cn.zup.workflow.dal;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;

@MiniDao
public interface WF_FlowDao extends MiniDaoSupportHiber<cn.zup.workflow.model.WF_FLOW> {	

	@Arguments({"system_id"})
	public List<cn.zup.workflow.model.WF_FLOW> FlowList(Integer systemID);	
	
	@Arguments({ "queryParameter" ,"page", "rows" })
	@ResultType(cn.zup.workflow.model.FLOW_MANAGE.class)	
	public PagingData<cn.zup.workflow.model.FLOW_MANAGE> FlowPagingList(QueryParameter queryParameter, int page, int rows) ;

}
	