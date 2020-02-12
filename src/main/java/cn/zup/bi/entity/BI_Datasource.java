package cn.zup.bi.entity;

import lombok.Data;

import java.util.Date;

@Data
public class BI_Datasource {
    private Integer id;
    private String ds_ip;
    private Integer ds_port;
    private String ds_username;
    private String ds_password;
    private String ds_attr;
    private String ds_name;
    private String ds_dir;
    private Date ds_create_time;
}
