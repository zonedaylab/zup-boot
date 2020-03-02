select DIM_ID,DIM_NAME,BIZ_TABLE_NAME,TEXT_FIELD,ID_FIELD,DRILL_TYPE,DRILL_INFO, ds.ds_name
 from bi_dim
 JOIN bi_datasource ds ON bi_dim.DS_ID = ds.id
where 1=1
<#if dsId ? exists>
	AND DS_ID = ${ds_Id}
</#if>

ORDER BY DIM_ID DESC