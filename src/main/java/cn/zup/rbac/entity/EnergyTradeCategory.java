package cn.zup.rbac.entity;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="energy_trade_category")
public class EnergyTradeCategory implements Serializable{
  private Integer category_Config_Id;//交易品种配置Id
  private Integer market_Id;//交易市场Id
  private String market_Name;//交易市场Name
  private Integer trade_Category_Id;//交易品种Id
  private String trade_Category;//交易品种Name
  private Integer trade_Category_Level;//交易等级

  private Integer validflag;//有效性
  //扩展字段
  private String validflagString;//有效性String
  private Integer configId;//对应config表中的config_Id--有效性
  private Integer levelConfigId;//对应config表中的config_Id--交易等级
  private String tradeCategoryLevel;//交易等级Name


  @Id
  @GeneratedValue(generator="_native")
  @GenericGenerator(name="_native", strategy="native")
  public Integer getCategory_Config_Id()
  {
    return this.category_Config_Id;
  }
  public void setCategory_Config_Id(Integer category_Config_Id) {
    this.category_Config_Id = category_Config_Id;
  }
  public Integer getMarket_Id() {
    return this.market_Id;
  }
  public void setMarket_Id(Integer market_Id) {
    this.market_Id = market_Id;
  }
  public String getMarket_Name() {
    return this.market_Name;
  }
  public void setMarket_Name(String market_Name) {
    this.market_Name = market_Name;
  }
  public String getTrade_Category() {
    return this.trade_Category;
  }
  public void setTrade_Category(String trade_Category) {
    this.trade_Category = trade_Category;
  }
  public Integer getTrade_Category_Level() {
	return trade_Category_Level;
  }
  public void setTrade_Category_Level(Integer trade_Category_Level) {
	this.trade_Category_Level = trade_Category_Level;
  }
  public Integer getValidflag() {
    return this.validflag;
  }
  public void setValidflag(Integer validflag) {
    this.validflag = validflag;
  }
  public Integer getTrade_Category_Id() {
    return this.trade_Category_Id;
  }
  public void setTrade_Category_Id(Integer trade_Category_Id) {
    this.trade_Category_Id = trade_Category_Id;
  }
  
  @Transient
  public String getValidflagString() {
    return this.validflagString;
  }
  public void setValidflagString(String validflagString) {
    this.validflagString = validflagString;
  }
  @Transient
  public Integer getConfigId() {
    return this.configId;
  }
  public void setConfigId(Integer configId) {
    this.configId = configId;
  }
  @Transient
  public String getTradeCategoryLevel() {
	return tradeCategoryLevel;
  }
  public void setTradeCategoryLevel(String tradeCategoryLevel) {
	this.tradeCategoryLevel = tradeCategoryLevel;
  }
  @Transient
  public Integer getLevelConfigId() {
	return levelConfigId;
  }
  public void setLevelConfigId(Integer levelConfigId) {
	this.levelConfigId = levelConfigId;
  }
}