package cn.zup.rbac.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "ORGAN")

//组织机构
public class Organ implements Serializable {

	public Organ() {
	}	
	private Integer organId;//组织机构ID
	private Integer parentOrganId;//父级组织
	private String organCode; //组织编号
	private String organName;//组织名称
	private String shortName;//简称
	private Integer orderCode;//序号
	private Integer organType;//组织类型
	private String governor;//主管人员
	private Integer validFlag;
	//扩展字段
	private Integer childCounts;//标志该organ下是否有子组织的标志，0,：没有子组织item，否则有子组织 folder
	private String organTypeString;
	private String validFlagString;
	private Integer validFlagConfig;
	private Integer organTypeConfig;
	private String  organUsed;//财务职能 -资金项目特殊字段
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getOrganId() {
		return organId;
	}
	public void setOrganId(Integer organId) {
		this.organId = organId;
	}
	public Integer getParentOrganId() {
		return parentOrganId;
	}
	public void setParentOrganId(Integer parentOrganId) {
		this.parentOrganId = parentOrganId;
	}
	public String getOrganCode() {
		return organCode;
	}
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public Integer getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(Integer orderCode) {
		this.orderCode = orderCode;
	}
	public Integer getOrganType() {
		return organType;
	}
	public void setOrganType(Integer organType) {
		this.organType = organType;
	}
	public String getGovernor() {
		return governor;
	}
	public void setGovernor(String governor) {
		this.governor = governor;
	}
	public Integer getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(Integer validFlag) {
		this.validFlag = validFlag;
	}
	@Transient
	public String getOrganTypeString() {
		return organTypeString;
	}
	public void setOrganTypeString(String organTypeString) {
		this.organTypeString = organTypeString;
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
	}
	@Transient
	public Integer getOrganTypeConfig() {
		return organTypeConfig;
	}
	public void setOrganTypeConfig(Integer organTypeConfig) {
		this.organTypeConfig = organTypeConfig;
	}
	@Transient
	public Integer getChildCounts() {
		return childCounts;
	}
	public void setChildCounts(Integer childCounts) {
		this.childCounts = childCounts;
	}
	@Transient
	public String getOrganUsed() {
		return organUsed;
	}
	public void setOrganUsed(String organUsed) {
		this.organUsed = organUsed;
	}	
	
	
	
}