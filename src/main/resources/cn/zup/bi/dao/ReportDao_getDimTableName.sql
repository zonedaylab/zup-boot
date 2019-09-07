 select 
 	d.biz_table_name,
 	d.drill_info,
 	d.dim_id,
 	id_field 
 	from bi_topic_field tf  
 	join bi_dim d on d.dim_id = tf.dim_id
 	WHERE tf.TITLE_FIELD_ID = ${titleFieldId}
    GROUP BY
    d.biz_table_name,
 	d.drill_info,
 	d.dim_id,
 	id_field 