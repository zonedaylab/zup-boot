package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "ENERY_DATA")
public class EnergyData implements Serializable {
	private Integer data_Id;
	private Integer park_Id;
	private Integer device_Id;
	private Integer device_Type;
	private Integer device_Param;
	private Integer energy_Type;
	private Date data_Date;
	private Double data_Value;
	private Double last_Data_Value;
	
	private String data_DateStr;
	private String deviceStr;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getData_Id() {
		return data_Id;
	}
	public void setData_Id(Integer dataId) {
		data_Id = dataId;
	}
	public Integer getPark_Id() {
		return park_Id;
	}
	public void setPark_Id(Integer parkId) {
		park_Id = parkId;
	}
	public Integer getDevice_Id() {
		return device_Id;
	}
	public void setDevice_Id(Integer deviceId) {
		device_Id = deviceId;
	}
	public Integer getDevice_Type() {
		return device_Type;
	}
	public void setDevice_Type(Integer deviceType) {
		device_Type = deviceType;
	}
	public Integer getDevice_Param() {
		return device_Param;
	}
	public void setDevice_Param(Integer deviceParam) {
		device_Param = deviceParam;
	}
	public Integer getEnergy_Type() {
		return energy_Type;
	}
	public void setEnergy_Type(Integer energyType) {
		energy_Type = energyType;
	}
	public Date getData_Date() {
		return data_Date;
	}
	public void setData_Date(Date dataDate) {
		data_Date = dataDate;
	}
	public Double getData_Value() {
		return data_Value;
	}
	public void setData_Value(Double dataValue) {
		data_Value = dataValue;
	}
	public Double getLast_Data_Value() {
		return last_Data_Value;
	}
	public void setLast_Data_Value(Double lastDataValue) {
		last_Data_Value = lastDataValue;
	}
	public String getData_DateStr() {
		return data_DateStr;
	}
	public void setData_DateStr(String dataDateStr) {
		data_DateStr = dataDateStr;
	}
	public String getDeviceStr() {
		return deviceStr;
	}
	public void setDeviceStr(String deviceStr) {
		this.deviceStr = deviceStr;
	}
	
}
