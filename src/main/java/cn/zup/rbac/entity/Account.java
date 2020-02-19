package cn.zup.rbac.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
//账户
@Entity
@Table(name="account")
public class Account implements Serializable {
	public Account() {
	}
   
	private Integer accountId;
	private Integer userId;
	private String accountName;
	private String passWord;
	private Integer validFlag;
	private String validFlagString;
	private Integer validFlagConfig;
	private String accountUsed;//财务职能 如果拥有多种财务职能则用英文逗号分开 如   1,2 
	private String responsiblePersion;//责任人
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getAccountId() {
		return accountId;
	}
	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
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
	public String getAccountUsed() {
		return accountUsed;
	}
	public void setAccountUsed(String accountUsed) {
		this.accountUsed = accountUsed;
	}
	public String getResponsiblePersion() {
		return responsiblePersion;
	}
	public void setResponsiblePersion(String responsiblePersion) {
		this.responsiblePersion = responsiblePersion;
	}	
	
}