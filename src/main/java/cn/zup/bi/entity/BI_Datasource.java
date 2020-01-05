package cn.zup.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name="bi_datasource")
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

    @Id
    @GeneratedValue(generator="_native")
    @GenericGenerator(name="_native",strategy="native")
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDs_ip() {
        return ds_ip;
    }

    public void setDs_ip(String ds_ip) {
        this.ds_ip = ds_ip;
    }

    public Integer getDs_port() {
        return ds_port;
    }

    public void setDs_port(Integer ds_port) {
        this.ds_port = ds_port;
    }

    public String getDs_username() {
        return ds_username;
    }

    public void setDs_username(String ds_username) {
        this.ds_username = ds_username;
    }

    public String getDs_password() {
        return ds_password;
    }

    public void setDs_password(String ds_password) {
        this.ds_password = ds_password;
    }

    public String getDs_attr() {
        return ds_attr;
    }

    public void setDs_attr(String ds_attr) {
        this.ds_attr = ds_attr;
    }

    public String getDs_name() {
        return ds_name;
    }

    public void setDs_name(String ds_name) {
        this.ds_name = ds_name;
    }

    public String getDs_dir() {
        return ds_dir;
    }

    public void setDs_dir(String ds_dir) {
        this.ds_dir = ds_dir;
    }

    public Date getDs_create_time() {
        return ds_create_time;
    }

    public void setDs_create_time(Date ds_create_time) {
        this.ds_create_time = ds_create_time;
    }
}
