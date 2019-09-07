SELECT bd.TEXT_FIELD AS text_Field, bd.BIZ_TABLE_NAME AS biz_Table_Name, bda.ATTRIBUTE_CAPTION_FIELD AS dim_Name
FROM bi_dim_attribute bda
JOIN bi_dim bd ON bda.DIM_ID = bd.DIM_ID
JOIN bi_topic_field btf ON bd.DIM_ID = btf.DIM_ID
JOIN bi_topic bt ON btf.TOPIC_ID = bt.TOPIC_ID
JOIN bi_report br ON bt.TOPIC_ID = br.TOPIC_ID
WHERE 1=1
AND br.REPORT_ID = ${reportId}