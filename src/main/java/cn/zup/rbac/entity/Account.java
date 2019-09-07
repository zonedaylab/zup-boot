package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
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
		
}