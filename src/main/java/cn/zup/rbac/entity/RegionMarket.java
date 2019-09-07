package cn.zup.rbac.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
/**
 * 
 * @author zxy
 *
 */
@Entity
@Table(name = "REGION_MARKET")
public class RegionMarket {

	private Integer region_Market_Id;//关系id
	private String region_Code;//区域编号
	private Integer market_Id;//交易市场ID
	
	/**
	 * 扩展字段
	 */
	//市场名称
	private String marketName;
	//创建时间
	private Date createTime;
	//区域名称
	private String regionName;//区域名称
	private String marketCode;//市场编号
	
	
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getRegion_Market_Id() {
		return region_Market_Id;
	}
	public void setRegion_Market_Id(Integer region_Market_Id) {
		this.region_Market_Id = region_Market_Id;
	}
	public String getRegion_Code() {
		return region_Code;
	}
	public void setRegion_Code(String region_Code) {
		this.region_Code = region_Code;
	}
	public Integer getMarket_Id() {
		return market_Id;
	}
	public void setMarket_Id(Integer market_Id) {
		this.market_Id = market_Id;
	}
	
	@Transient
	public String getMarketName() {
		return marketName;
	}
	public void setMarketName(String marketName) {
		this.marketName = marketName;
	}
	@Transient
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	@Transient
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	@Transient
	public String getMarketCode() {
		return marketCode;
	}
	public void setMarketCode(String marketCode) {
		this.marketCode = marketCode;
	}
	
}
