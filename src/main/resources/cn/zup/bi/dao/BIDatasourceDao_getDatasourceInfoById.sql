SELECT 
	bd.ds_ip,
	bd.ds_port,
    bd.ds_username,
    bd.ds_password,
    bd.ds_attr,
    bd.ds_name,
    bd.ds_dir
FROM bi_datasource bd
WHERE 1=1
AND bd.id = ${id}