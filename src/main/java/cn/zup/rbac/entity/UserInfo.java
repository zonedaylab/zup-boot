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
@Table(name = "userinfo")
//用户信息
public class UserInfo implements Serializable {
	public UserInfo() {
	}
	
	private Integer userId;// 用户ID
	private Integer organId;// 组织机构ID
	private Integer postId;// 岗位ID
	private String realName;// 真实姓名
	private Integer sex;// 性别
	private Date birthday;// 出生日期
	private String identitycard;// 身份证号
	private String nativeplace;// 籍贯
	private String address;// 家庭住址
	private String phone;// 联系电话
	private String cellphone;// 手机
	private String education;// 学历
	private Date graduationDate;// 毕业日期
	private Integer politicsStatus;// 政治面貌
	private Integer contractType;// 合同类型
	private Date contractStartDate;// 合同起始日期
	private Date contractTerminationDate;// 合同终止日期
	private String professionalInfo;// 专业技术资格信息	
	private Date createDate;// 创建日期
	private Integer validFlag;//是否有效
	private String organName;
	private String postName;
	
	private String sexString;
	private Integer sexConfig;
	private String validFlagString;
	private Integer validFlagConfig;
	private String politicsStatusString;
	private Integer politicsStatusConfig;//政治面貌的config
	private Integer contractTypeConfig;
	private String contractTypeString;
	private Integer educationConfig;
	private String educationString;
	private String birthdayString;
	
	//冗余字段
	private String stationName;//所属电站
	private String county;//所属区县
	private String town;//所属乡镇
	//展示权限内的用户使用
	private String organIds;
	private String postIds;
	private String userIds;
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getOrganId() {
		return organId;
	}
	public void setOrganId(Integer organId) {
		this.organId = organId;
	}
	public Integer getPostId() {
		return postId;
	}
	public void setPostId(Integer postId) {
		this.postId = postId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getIdentitycard() {
		return identitycard;
	}
	public void setIdentitycard(String identitycard) {
		this.identitycard = identitycard;
	}
	public String getNativeplace() {
		return nativeplace;
	}
	public void setNativeplace(String nativeplace) {
		this.nativeplace = nativeplace;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public Date getGraduationDate() {
		return graduationDate;
	}
	public void setGraduationDate(Date graduationDate) {
		this.graduationDate = graduationDate;
	}	
	public Integer getContractType() {
		return contractType;
	}
	public void setContractType(Integer contractType) {
		this.contractType = contractType;
	}
	public Date getContractStartDate() {
		return contractStartDate;
	}
	public void setContractStartDate(Date contractStartDate) {
		this.contractStartDate = contractStartDate;
	}
	public Date getContractTerminationDate() {
		return contractTerminationDate;
	}
	public void setContractTerminationDate(Date contractTerminationDate) {
		this.contractTerminationDate = contractTerminationDate;
	}
	public String getProfessionalInfo() {
		return professionalInfo;
	}
	public void setProfessionalInfo(String professionalInfo) {
		this.professionalInfo = professionalInfo;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(Integer validFlag) {
		this.validFlag = validFlag;
	}	

	public Integer getPoliticsStatus() {
		return politicsStatus;
	}
	public void setPoliticsStatus(Integer politicsStatus) {
		this.politicsStatus = politicsStatus;
	}
	@Transient
	public String getPoliticsStatusString() {
		return politicsStatusString;
	}
	public void setPoliticsStatusString(String politicsStatusString) {
		this.politicsStatusString = politicsStatusString;
	}
	@Transient
	public Integer getPoliticsStatusConfig() {
		return politicsStatusConfig;
	}
	public void setPoliticsStatusConfig(Integer politicsStatusConfig) {
		this.politicsStatusConfig = politicsStatusConfig;
	}
	@Transient 
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	} 
	@Transient 
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	} 
	@Transient 
	public String getSexString() {
		return sexString;
	}
	public void setSexString(String sexString) {
		this.sexString = sexString;
	}
	@Transient 
	public String getValidFlagString() {
		return validFlagString;
	}
	public void setValidFlagString(String validFlagString) {
		this.validFlagString = validFlagString;
	}
	@Transient 
	public Integer getValidFlagConfig() {
		return validFlagConfig;
	}
	public void setValidFlagConfig(Integer validFlagConfig) {
		this.validFlagConfig = validFlagConfig;
	}//是否有效
	@Transient
	public Integer getSexConfig() {
		return sexConfig;
	}
	public void setSexConfig(Integer sexConfig) {
		this.sexConfig = sexConfig;
	}
	@Transient
	public Integer getContractTypeConfig() {
		return contractTypeConfig;
	}
	public void setContractTypeConfig(Integer contractTypeConfig) {
		this.contractTypeConfig = contractTypeConfig;
	}
	@Transient
	public String getContractTypeString() {
		return contractTypeString;
	}
	public void setContractTypeString(String contractTypeString) {
		this.contractTypeString = contractTypeString;
	}
	@Transient
	public Integer getEducationConfig() {
		return educationConfig;
	}
	public void setEducationConfig(Integer educationConfig) {
		this.educationConfig = educationConfig;
	}
	@Transient
	public String getEducationString() {
		return educationString;
	}
	public void setEducationString(String educationString) {
		this.educationString = educationString;
	}
	@Transient
	public String getBirthdayString() {
		return birthdayString;
	}
	public void setBirthdayString(String birthdayString) {
		this.birthdayString = birthdayString;
	}
	@Transient
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	@Transient
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	@Transient
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	@Transient
	public String getOrganIds() {
		return organIds;
	}
	public void setOrganIds(String organIds) {
		this.organIds = organIds;
	}
	@Transient
	public String getPostIds() {
		return postIds;
	}
	public void setPostIds(String postIds) {
		this.postIds = postIds;
	}
	@Transient
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
}