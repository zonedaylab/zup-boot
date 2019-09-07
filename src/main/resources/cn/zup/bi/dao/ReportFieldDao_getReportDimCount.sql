SELECT COUNT(*) AS DimCount FROM bi_report_field
WHERE 1=1 
AND REPORT_ID = ${ reportId}
AND FIELD_LOCATION = 1 