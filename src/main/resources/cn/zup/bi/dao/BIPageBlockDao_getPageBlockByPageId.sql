SELECT 
	bb.BLOCK_ID, bb.BLOCK_FLAG, bb.HEIGHT, bb.WIDTH, bb.REPORT_ID, bb.X_POINT, bb.Y_POINT, bb.BI_PAGE_ID, bb.BLOCK_TYPE 
FROM bi_block bb
WHERE 1=1 
AND bb.BI_PAGE_ID = ${bi_Page_Id} 
AND bb.SCREEN_INDEX = ${screen_Index}
<#if block_Id?exists>
AND bb.BLOCK_ID = ${block_Id}
</#if>
;