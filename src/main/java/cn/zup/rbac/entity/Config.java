package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity; 
import javax.persistence.Id; 
import javax.persistence.Table;
@Entity
@Table(name="config")
public class Config implements Serializable {
	public Config() {
	}
	private Integer configid;//字典ID
	private Integer subid;//字典项ID
	private String name;//字典名称
	private String subname;//字典项名称 
	@Id
	public Integer getConfigid() {
		return configid;
	}
	public void setConfigid(Integer configid) {
		this.configid = configid;
	}
	@Id
	public Integer getSubid() {
		return subid;
	}
	public void setSubid(Integer subid) {
		this.subid = subid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubname() {
		return subname;
	}
	public void setSubname(String subname) {
		this.subname = subname;
	}
	

}