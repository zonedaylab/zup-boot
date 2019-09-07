package cn.zup.rbac.entity;

import java.io.Serializable;
import javax.persistence.Entity;  
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="energy_Consume_Conf")
public class EnergyConsumeConf implements Serializable {
	public EnergyConsumeConf() {
	} 
	private Integer park_Id;//园区id
	private String supply_Location;//供电地点
	private Integer voltage_Class;//电压等级
	private Integer energy_Property;//用电性质
	private Double volume;//容量
	private Integer price_Mode;//电价方式
	private Double capacity_Price;//容量电价
	private Double catalog_Price;//目录电价
	private Double peak_Price;//峰电价
	private Double flat_Price;//平电价
	private Double valley_Price;//谷电价
	//一下为冗余字段
	private String voltageClassString;
	private Integer voltageClassConfig;
	private String energyPropertyString;
	private Integer energyPropertyConfig;
	private String priceModeString;
	private Integer priceModeConfig;
	private String parkIds;//用于加载多个园区的多个用电配置信息
	
	@Id
	public Integer getPark_Id() {
		return park_Id;
	}
	public void setPark_Id(Integer parkId) {
		park_Id = parkId;
	}
	public String getSupply_Location() {
		return supply_Location;
	}
	public void setSupply_Location(String supplyLocation) {
		supply_Location = supplyLocation;
	}
	public Integer getVoltage_Class() {
		return voltage_Class;
	}
	public void setVoltage_Class(Integer voltageClass) {
		voltage_Class = voltageClass;
	}
	public Integer getEnergy_Property() {
		return energy_Property;
	}
	public void setEnergy_Property(Integer energyProperty) {
		energy_Property = energyProperty;
	}
	public Double getVolume() {
		return volume;
	}
	public void setVolume(Double volume) {
		this.volume = volume;
	}
	public Integer getPrice_Mode() {
		return price_Mode;
	}
	public void setPrice_Mode(Integer priceMode) {
		price_Mode = priceMode;
	}
	public Double getCapacity_Price() {
		return capacity_Price;
	}
	public void setCapacity_Price(Double capacityPrice) {
		capacity_Price = capacityPrice;
	}
	public Double getCatalog_Price() {
		return catalog_Price;
	}
	public void setCatalog_Price(Double catalogPrice) {
		catalog_Price = catalogPrice;
	}
	public Double getPeak_Price() {
		return peak_Price;
	}
	public void setPeak_Price(Double peakPrice) {
		peak_Price = peakPrice;
	}
	public Double getFlat_Price() {
		return flat_Price;
	}
	public void setFlat_Price(Double flatPrice) {
		flat_Price = flatPrice;
	}
	public Double getValley_Price() {
		return valley_Price;
	}
	public void setValley_Price(Double valleyPrice) {
		valley_Price = valleyPrice;
	}
	
	
	
	@Transient
	public String getVoltageClassString() {
		return voltageClassString;
	}
	public void setVoltageClassString(String voltageClassString) {
		this.voltageClassString = voltageClassString;
	}
	@Transient
	public Integer getVoltageClassConfig() {
		return voltageClassConfig;
	}
	public void setVoltageClassConfig(Integer voltageClassConfig) {
		this.voltageClassConfig = voltageClassConfig;
	}
	@Transient
	public String getEnergyPropertyString() {
		return energyPropertyString;
	}
	public void setEnergyPropertyString(String energyPropertyString) {
		this.energyPropertyString = energyPropertyString;
	}
	@Transient
	public Integer getEnergyPropertyConfig() {
		return energyPropertyConfig;
	}
	public void setEnergyPropertyConfig(Integer energyPropertyConfig) {
		this.energyPropertyConfig = energyPropertyConfig;
	}
	@Transient
	public String getPriceModeString() {
		return priceModeString;
	}
	public void setPriceModeString(String priceModeString) {
		this.priceModeString = priceModeString;
	}
	@Transient
	public Integer getPriceModeConfig() {
		return priceModeConfig;
	}
	public void setPriceModeConfig(Integer priceModeConfig) {
		this.priceModeConfig = priceModeConfig;
	}	
	@Transient
	public String getParkIds() {
		return parkIds;
	}
	public void setParkIds(String parkIds) {
		this.parkIds = parkIds;
	}
}