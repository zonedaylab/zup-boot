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
//账户
@Entity
@Table(name="ENERGY_MERCHANT")
public class EnergyMerchant implements Serializable {
	public EnergyMerchant() {
	}
	private Integer    organid; //部门ID
	private String     region_Code;  //区域编号
	private String     merchant_Name; //商户名称
	private String     merchant_Code; //商户编号
	private Integer    merchant_Type; //商户类型
	private Integer    check_State; //审核状态
	private String     reg_Number; //三证合一
	private double     reg_Capital; //注册资本
	private String     legal_Person;//法定代表人
	private String     phone;  //联系电话
	private String     fax;  //传真
	private Integer    credit;  //信用等级
	private String     postcode;  //邮政编码
	private String     public_Number;//企业公众号
	private String     deposit_Bank; //开户银行
	private String     email; //公司邮箱
	private String     bank_Accout; //银行账户
	private String     account_Name; //开户名称
	private Integer    industry_Category; //行业类别
	private Integer    trade_Flag; //交易资格
	private String     address; //商户地址
	private String     latitude; //纬度
	private String     longitude; //经度
	private Integer    merchant_Scale; //商户规模
	private Integer    energy_Property; //用电性质
	private Integer    reg_User_Id; //登记人ID
	private String     reg_User_Name; //登记人姓名
	private Date       reg_Date; //登记日期
	
	
	//以下为冗余字段
	private Integer merchantTypeConfig;
	private String merchantTypeString;
	private Integer energyPropertyConfig;
	private String energyPropertyString;
	private Integer tradeFlagConfig;
	private String tradeFlagString;	
	private Integer checkStateConfig;
	private String checkStateString;
	private String regDateString;
	private Integer parentOrganFlag;//权限问题涉及经营商户标识
	private Integer organFlag;//普通商户标识
	private Integer marketId;//所属交易市场
	private String marketName;//交易市场名称
	 private String summaryMerchantIds;
	@Id
	public Integer getOrganid() {
		return organid;
	}
	public void setOrganid(Integer organid) {
		this.organid = organid;
	}
	public String getRegion_Code() {
		return region_Code;
	}
	public void setRegion_Code(String regionCode) {
		region_Code = regionCode;
	}
	public String getMerchant_Name() {
		return merchant_Name;
	}
	public void setMerchant_Name(String merchantName) {
		merchant_Name = merchantName;
	}
	public String getMerchant_Code() {
		return merchant_Code;
	}
	public void setMerchant_Code(String merchantCode) {
		merchant_Code = merchantCode;
	}
	
	public Integer getCheck_State() {
		return check_State;
	}
	public void setCheck_State(Integer checkState) {
		check_State = checkState;
	}
	public String getReg_Number() {
		return reg_Number;
	}
	public void setReg_Number(String regNumber) {
		reg_Number = regNumber;
	}
	public double getReg_Capital() {
		return reg_Capital;
	}
	public void setReg_Capital(double regCapital) {
		reg_Capital = regCapital;
	}
	public String getLegal_Person() {
		return legal_Person;
	}
	public void setLegal_Person(String legalPerson) {
		legal_Person = legalPerson;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public Integer getCredit() {
		return credit;
	}
	public void setCredit(Integer credit) {
		this.credit = credit;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getPublic_Number() {
		return public_Number;
	}
	public void setPublic_Number(String publicNumber) {
		public_Number = publicNumber;
	}
	
	public String getDeposit_Bank() {
		return deposit_Bank;
	}
	public void setDeposit_Bank(String depositBank) {
		deposit_Bank = depositBank;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBank_Accout() {
		return bank_Accout;
	}
	public void setBank_Accout(String bankAccout) {
		bank_Accout = bankAccout;
	}
	public String getAccount_Name() {
		return account_Name;
	}
	public void setAccount_Name(String accountName) {
		account_Name = accountName;
	}
	public Integer getIndustry_Category() {
		return industry_Category;
	}
	public void setIndustry_Category(Integer industryCategory) {
		industry_Category = industryCategory;
	}
	public Integer getTrade_Flag() {
		return trade_Flag;
	}
	public void setTrade_Flag(Integer tradeFlag) {
		trade_Flag = tradeFlag;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	public Integer getEnergy_Property() {
		return energy_Property;
	}
	public void setEnergy_Property(Integer energyProperty) {
		energy_Property = energyProperty;
	}
	public Date getReg_Date() {
		return reg_Date;
	}
	public void setReg_Date(Date regDate) {
		reg_Date = regDate;
	}
	public Integer getMerchant_Type() {
		return merchant_Type;
	}
	public void setMerchant_Type(Integer merchantType) {
		merchant_Type = merchantType;
	}
	public Integer getMerchant_Scale() {
		return merchant_Scale;
	}
	public void setMerchant_Scale(Integer merchantScale) {
		merchant_Scale = merchantScale;
	}
	public Integer getReg_User_Id() {
		return reg_User_Id;
	}
	public void setReg_User_Id(Integer regUserId) {
		reg_User_Id = regUserId;
	}
	public String getReg_User_Name() {
		return reg_User_Name;
	}
	public void setReg_User_Name(String regUserName) {
		reg_User_Name = regUserName;
	}
	
	@Transient
	public Integer getMerchantTypeConfig() {
		return merchantTypeConfig;
	}
	public void setMerchantTypeConfig(Integer merchantTypeConfig) {
		this.merchantTypeConfig = merchantTypeConfig;
	}
	@Transient
	public String getMerchantTypeString() {
		return merchantTypeString;
	}
	public void setMerchantTypeString(String merchantTypeString) {
		this.merchantTypeString = merchantTypeString;
	}
	@Transient
	public Integer getEnergyPropertyConfig() {
		return energyPropertyConfig;
	}
	public void setEnergyPropertyConfig(Integer energyPropertyConfig) {
		this.energyPropertyConfig = energyPropertyConfig;
	}
	@Transient
	public String getEnergyPropertyString() {
		return energyPropertyString;
	}
	public void setEnergyPropertyString(String energyPropertyString) {
		this.energyPropertyString = energyPropertyString;
	}
	@Transient
	public Integer getTradeFlagConfig() {
		return tradeFlagConfig;
	}
	public void setTradeFlagConfig(Integer tradeFlagConfig) {
		this.tradeFlagConfig = tradeFlagConfig;
	}
	@Transient
	public String getTradeFlagString() {
		return tradeFlagString;
	}
	public void setTradeFlagString(String tradeFlagString) {
		this.tradeFlagString = tradeFlagString;
	}
	@Transient
	public Integer getCheckStateConfig() {
		return checkStateConfig;
	}
	public void setCheckStateConfig(Integer checkStateConfig) {
		this.checkStateConfig = checkStateConfig;
	}
	@Transient
	public String getCheckStateString() {
		return checkStateString;
	}
	public void setCheckStateString(String checkStateString) {
		this.checkStateString = checkStateString;
	}
	@Transient
	public String getRegDateString() {
		return regDateString;
	}
	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}
	@Transient
	public Integer getParentOrganFlag() {
		return parentOrganFlag;
	}
	public void setParentOrganFlag(Integer parentOrganFlag) {
		this.parentOrganFlag = parentOrganFlag;
	}
	@Transient
	public Integer getOrganFlag() {
		return organFlag;
	}
	public void setOrganFlag(Integer organFlag) {
		this.organFlag = organFlag;
	}
	@Transient
	public Integer getMarketId() {
		return marketId;
	}
	public void setMarketId(Integer marketId) {
		this.marketId = marketId;
	}
	@Transient
	public String getSummaryMerchantIds() {
		return summaryMerchantIds;
	}
	public void setSummaryMerchantIds(String summaryMerchantIds) {
		this.summaryMerchantIds = summaryMerchantIds;
	}
	@Transient
	public String getMarketName() {
		return marketName;
	}
	public void setMarketName(String marketName) {
		this.marketName = marketName;
	}
	
	
}