SELECT 
	br.REPORT_ID, br.REPORT_NAME 
FROM bi_report br 
JOIN bi_page bp ON br.PAGE_ID = bp.BI_PAGE_ID
JOIN bi_screen bs ON bp.BI_PAGE_ID = bs.PAGE_ID
WHERE 1=1
AND bp.BI_PAGE_ID = ${pageId} 
AND bs.SCREEN_INDEX = ${screenIndex}
GROUP BY br.REPORT_ID, br.REPORT_NAME;