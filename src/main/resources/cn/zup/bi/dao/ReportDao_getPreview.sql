select ${ colName} from ${ topicName} a join ${ dimName} b on ${ and} where
  <#if aId?exists>
  	${aId}
  </#if>
  group by ${ groupBy}