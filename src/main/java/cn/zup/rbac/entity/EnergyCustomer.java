package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "energy_customer")
public class EnergyCustomer  implements Serializable{
	private Integer customer_Id;//客户ID
	private String region_Code;//区域编号
	private Integer check_State;//审核状态
	private String customer_Name;//客户名称&&公司名称
	private Integer customer_Type;//客户类型
	private String rge_Number;//三合一登记号
	private Integer voltage_Class;//电压等级
	private String year_Quantity;//年用电量
	private Double reg_Capital;//注册资本
	private String legal_Person;//法定代表人
	private String phone;//电话
	private String fax;//传真
	private Integer credit;//信用等级
	private String project_Situation;//项目概况
	private String postcode;//邮政编号
	private String public_Number;//企业公众号
	private String deposit_Bank;//开户银行
	private String email;//公司邮箱
	private String bank_Account;//银行账户
	private String account_Name;//开户名称
	private Integer industry_Category;//行业类别
	private Integer trade_Flag;//交易资格
	private String address;//客户地址
	private String latitude;//纬度
	private String longitude;//经度
	private Integer customer_Scale;//客户规模
	private Integer energy_Property;//用电性质
	private String reg_User_Id;//登记人ID
	private String reg_User_Name;//登记人名称
	private Date reg_Date;//登记时间
	
	//扩展字段
	private String startDate;
	private String endDate;
	private String provinceString;
	

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getCustomer_Id() {
		return customer_Id;
	}
	public void setCustomer_Id(Integer customer_Id) {
		this.customer_Id = customer_Id;
	}
	public String getRegion_Code() {
		return region_Code;
	}
	public void setRegion_Code(String region_Code) {
		this.region_Code = region_Code;
	}
	public Integer getCheck_State() {
		return check_State;
	}
	public void setCheck_State(Integer check_State) {
		this.check_State = check_State;
	}
	public String getCustomer_Name() {
		return customer_Name;
	}
	public void setCustomer_Name(String customer_Name) {
		this.customer_Name = customer_Name;
	}
	public Integer getCustomer_Type() {
		return customer_Type;
	}
	public void setCustomer_Type(Integer customer_Type) {
		this.customer_Type = customer_Type;
	}
	public String getRge_Number() {
		return rge_Number;
	}
	public void setRge_Number(String rge_Number) {
		this.rge_Number = rge_Number;
	}
	public Integer getVoltage_Class() {
		return voltage_Class;
	}
	public void setVoltage_Class(Integer voltage_Class) {
		this.voltage_Class = voltage_Class;
	}
	public String getYear_Quantity() {
		return year_Quantity;
	}
	public void setYear_Quantity(String year_Quantity) {
		this.year_Quantity = year_Quantity;
	}
	public Double getReg_Capital() {
		return reg_Capital;
	}
	public void setReg_Capital(Double reg_Capital) {
		this.reg_Capital = reg_Capital;
	}
	public String getLegal_Person() {
		return legal_Person;
	}
	public void setLegal_Person(String legal_Person) {
		this.legal_Person = legal_Person;
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
	public String getProject_Situation() {
		return project_Situation;
	}
	public void setProject_Situation(String project_Situation) {
		this.project_Situation = project_Situation;
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
	public void setPublic_Number(String public_Number) {
		this.public_Number = public_Number;
	}
	public String getDeposit_Bank() {
		return deposit_Bank;
	}
	public void setDeposit_Bank(String deposit_Bank) {
		this.deposit_Bank = deposit_Bank;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBank_Account() {
		return bank_Account;
	}
	public void setBank_Account(String bank_Account) {
		this.bank_Account = bank_Account;
	}
	public String getAccount_Name() {
		return account_Name;
	}
	public void setAccount_Name(String account_Name) {
		this.account_Name = account_Name;
	}
	public Integer getIndustry_Category() {
		return industry_Category;
	}
	public void setIndustry_Category(Integer industry_Category) {
		this.industry_Category = industry_Category;
	}
	public Integer getTrade_Flag() {
		return trade_Flag;
	}
	public void setTrade_Flag(Integer trade_Flag) {
		this.trade_Flag = trade_Flag;
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
	public Integer getCustomer_Scale() {
		return customer_Scale;
	}
	public void setCustomer_Scale(Integer customer_Scale) {
		this.customer_Scale = customer_Scale;
	}
	public Integer getEnergy_Property() {
		return energy_Property;
	}
	public void setEnergy_Property(Integer energy_Property) {
		this.energy_Property = energy_Property;
	}
	public String getReg_User_Id() {
		return reg_User_Id;
	}
	public void setReg_User_Id(String reg_User_Id) {
		this.reg_User_Id = reg_User_Id;
	}
	public String getReg_User_Name() {
		return reg_User_Name;
	}
	public void setReg_User_Name(String reg_User_Name) {
		this.reg_User_Name = reg_User_Name;
	}
	public Date getReg_Date() {
		return reg_Date;
	}
	public void setReg_Date(Date reg_Date) {
		this.reg_Date = reg_Date;
	}
	@Transient
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	@Transient
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	@Transient
	public String getProvinceString() {
		return provinceString;
	}
	public void setProvinceString(String provinceString) {
		this.provinceString = provinceString;
	}
}