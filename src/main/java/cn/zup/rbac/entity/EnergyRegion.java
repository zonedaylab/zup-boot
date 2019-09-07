package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "ENERGY_REGION")
public class EnergyRegion implements Serializable {
	private String  region_Code;//区域编号
	private String  region_Name;  //区域名称
	private String  address; //区域具体地址
	@Id
	public String getRegion_Code() {
		return region_Code;
	}
	public void setRegion_Code(String regionCode) {
		region_Code = regionCode;
	}
	public String getRegion_Name() {
		return region_Name;
	}
	public void setRegion_Name(String regionName) {
		region_Name = regionName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
