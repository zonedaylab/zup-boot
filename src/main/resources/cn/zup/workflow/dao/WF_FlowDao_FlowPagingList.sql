
select A.FLOW_ID,A.FLOW_NAME,A.FLOW_STATE,C.SUB_NAME as FLOW_STATE_NAME, A.FLOW_TYPE,A.SYSTEM_ID from WF_FLOW as A 
inner join WF_CONFIG  as C on C.ID= 4   <!--数据字典  流程状态FlowState(4)-->
and A.FLOW_STATE=C.SUB_ID
where 1=1
<#if queryParameter.privateSystemID ?exists>
	and A.SYSTEM_ID = ${queryParameter.privateSystemID}
</#if>
<#if queryParameter.FLOW_NAME ?exists>
	and A.FLOW_NAME LIKE  '%${queryParameter.privateFlowName}%'
</#if>

<#if queryParameter.FLOW ?exists>
	and A.FLOW_STATE = ${queryParameter.privateFlowState}
</#if>
order by FLOW_ID,FLOW_STATE