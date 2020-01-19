SELECT bs.SCREEN_ID,
	bs.SCREEN_INDEX,
	bs.SCREEN_NAME,
	bs.PAGE_ID,
	bp.PAGE_NAME
FROM bi_screen bs
LEFT JOIN bi_page bp ON bs.PAGE_ID = bp.BI_PAGE_ID
WHERE 1=1
AND PAGE_ID=${biScreen.page_Id}
