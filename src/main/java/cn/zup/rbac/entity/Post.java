package cn.zup.rbac.entity;


import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "POST")
//岗位
public class Post implements Serializable {
	public Post() {
	}
	
	private Integer postId;// 岗位ID
	private Integer organId;// 组织机构ID
	private String postName;// 岗位名称
	private String postDuty;// 岗位职责
	private Integer standardNumber;// 标准人数
	private Integer validFlag;// 有效性
	private String validFlagString;
	private Integer validFlagConfig;
	private String organName;
	//扩展字段
	private String myOrganIds;
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getPostId() {
		return postId;
	}
	public void setPostId(Integer postId) {
		this.postId = postId;
	}
	public Integer getOrganId() {
		return organId;
	}
	public void setOrganId(Integer organId) {
		this.organId = organId;
	}
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public String getPostDuty() {
		return postDuty;
	}
	public void setPostDuty(String postDuty) {
		this.postDuty = postDuty;
	}
	public Integer getStandardNumber() {
		return standardNumber;
	}
	public void setStandardNumber(Integer standardNumber) {
		this.standardNumber = standardNumber;
	}
	public Integer getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(Integer validFlag) {
		this.validFlag = validFlag;
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
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	@Transient
	public String getMyOrganIds() {
		return myOrganIds;
	}
	public void setMyOrganIds(String myOrganIds) {
		this.myOrganIds = myOrganIds;
	}
	
}