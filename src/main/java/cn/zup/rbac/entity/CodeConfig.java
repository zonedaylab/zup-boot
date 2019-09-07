package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "CodeConfig")
// 实体对象
public class CodeConfig implements Serializable {

	public CodeConfig() {
	}
	
	private Integer configid;
	private String configcode;
	private String memo;

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getConfigid() {
		return configid;
	}
	public void setConfigid(Integer configid) {
		this.configid = configid;
	}
	public String getConfigcode() {
		return configcode;
	}
	public void setConfigcode(String configcode) {
		this.configcode = configcode;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
	

}
