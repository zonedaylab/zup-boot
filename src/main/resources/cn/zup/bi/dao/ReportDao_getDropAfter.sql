 select
	 report_field_id, r.report_id, report_field_name, 
	 rf.FIELD_TYPE, field_row, field_col, rf.title_field_id,
	 extend_type, drill_type, report_name, menu_id, 
	 report_title ,btf.FIELD_CAPTION as report_Field_Caption
  from bi_report_field rf 
  join  bi_report r on  r.report_id = ${ reportId}
  JOIN bi_topic_field btf ON rf.REPORT_FIELD_NAME = btf.TITLE_FIELD_NAME
  where rf.report_id in (
    select r.report_id from bi_report 
  	where  r.report_id = ${ reportId}
  )
  order  by field_col asc