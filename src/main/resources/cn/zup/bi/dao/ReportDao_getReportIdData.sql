select report_field_id, r.report_id, report_field_name, field_type, field_row, field_col, title_field_id, extend_type, drill_type, report_name, menu_id, report_title 
 from bi_report_field rf  join  bi_report r on 
  r.report_id = ${ report_Id}
  where rf.report_id = ${ report_Id}
 order  by field_col asc