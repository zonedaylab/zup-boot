package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
//域名系统关系表
@Entity
@Table(name = "Domain_System")
public class DomainSystem implements Serializable {
	public DomainSystem() {
	}
	private Integer relation_Id;//关系id
	private Integer system_Id;//系统id
	private String system_Name;//系统名称
	private String domain;//域名
	private String login_Logo;//登录注册Logo
	private String home_Logo;//首界面Logo
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	
	public Integer getRelation_Id() {
		return relation_Id;
	}
	public void setRelation_Id(Integer relationId) {
		relation_Id = relationId;
	}
	public Integer getSystem_Id() {
		return system_Id;
	}
	public void setSystem_Id(Integer systemId) {
		system_Id = systemId;
	}
	public String getSystem_Name() {
		return system_Name;
	}
	public void setSystem_Name(String systemName) {
		system_Name = systemName;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getLogin_Logo() {
		return login_Logo;
	}
	public void setLogin_Logo(String login_Logo) {
		this.login_Logo = login_Logo;
	}
	public String getHome_Logo() {
		return home_Logo;
	}
	public void setHome_Logo(String home_Logo) {
		this.home_Logo = home_Logo;
	}
	
}