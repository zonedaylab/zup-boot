package cn.zup.rbac.entity;

import java.io.Serializable;
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="energy_park")
public class EnergyPark implements Serializable {
	public EnergyPark() {
	} 
	private Integer park_Id;//园区id
	private Integer store_Id;//商城id
	private Integer region_Id;//区域id
	private Integer department_Id;//部门id
	private Integer sale_Supply_Area_Id;//供电区域id
	private String park_Name;//园区名字
	private Integer parent_Park_Id;//父园区id
	private Integer park_Type;//园区类型
	private String power_Company;//对应电网企业
	private String park_Address;
	private String park_Longitude;///经度
	private String park_Latitude; //纬度
	//scada_Park_Id为了跟monitor关联
	private Integer scada_Park_Id;
	
	//以下为冗余字段
	private Integer parkTypeConfig;
	private String parkTypeString;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getPark_Id() {
		return park_Id;
	}
	public void setPark_Id(Integer parkId) {
		park_Id = parkId;
	}
	public Integer getStore_Id() {
		return store_Id;
	}
	public void setStore_Id(Integer storeId) {
		store_Id = storeId;
	}
	public Integer getRegion_Id() {
		return region_Id;
	}
	public void setRegion_Id(Integer regionId) {
		region_Id = regionId;
	}
	public Integer getDepartment_Id() {
		return department_Id;
	}
	public void setDepartment_Id(Integer departmentId) {
		department_Id = departmentId;
	}
	public Integer getSale_Supply_Area_Id() {
		return sale_Supply_Area_Id;
	}
	public void setSale_Supply_Area_Id(Integer saleSupplyAreaId) {
		sale_Supply_Area_Id = saleSupplyAreaId;
	}
	public String getPark_Name() {
		return park_Name;
	}
	public void setPark_Name(String parkName) {
		park_Name = parkName;
	}
	public Integer getParent_Park_Id() {
		return parent_Park_Id;
	}
	public void setParent_Park_Id(Integer parentParkId) {
		parent_Park_Id = parentParkId;
	}
	public Integer getPark_Type() {
		return park_Type;
	}
	public void setPark_Type(Integer parkType) {
		park_Type = parkType;
	}
	public String getPower_Company() {
		return power_Company;
	}
	public void setPower_Company(String powerCompany) {
		power_Company = powerCompany;
	}
	public Integer getScada_Park_Id() {
		return scada_Park_Id;
	}
	public void setScada_Park_Id(Integer scadaParkId) {
		scada_Park_Id = scadaParkId;
	}
	public String getPark_Address() {
		return park_Address;
	}
	public void setPark_Address(String parkAddress) {
		park_Address = parkAddress;
	}
	public String getPark_Longitude() {
		return park_Longitude;
	}
	public void setPark_Longitude(String parkLongitude) {
		park_Longitude = parkLongitude;
	}
	public String getPark_Latitude() {
		return park_Latitude;
	}
	public void setPark_Latitude(String parkLatitude) {
		park_Latitude = parkLatitude;
	}
	@Transient
	public Integer getParkTypeConfig() {
		return parkTypeConfig;
	}
	public void setParkTypeConfig(Integer parkTypeConfig) {
		this.parkTypeConfig = parkTypeConfig;
	}
	@Transient
	public String getParkTypeString() {
		return parkTypeString;
	}
	public void setParkTypeString(String parkTypeString) {
		this.parkTypeString = parkTypeString;
	}
	
	
	
}