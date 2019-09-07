select 
	rf.report_field_name,
	rf.title_field_id,
	bf.aggregate_type, 
	bf.field_caption, 
	bf.FIELD_TITLE as report_Field_Title,
	r.report_name, 
	r.report_title 
  from BI_REPORT_FIELD rf 
  join BI_REPORT r on r.report_id = rf.report_id  and r.report_id = ${ reportId} 
  join bi_topic_field bf on bf.topic_id = r.topic_id  and (rf.report_field_name = bf.field_title OR rf.report_field_name = bf.AGGREGATE_FIELD)
  order by rf.field_col 