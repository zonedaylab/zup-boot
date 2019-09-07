package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "RoleRelation")
// 角色关系
public class RoleRelation implements Serializable {
	public RoleRelation() {
	}
	
	private Integer roleid;//// 角色ID
	private Integer relationroleid;// 关系角色id
	private Integer relation;// 关系
	private Date timelimit;// 时限
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getRoleid() {
		return roleid;
	}
	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
	public Integer getRelationroleid() {
		return relationroleid;
	}
	public void setRelationroleid(Integer relationroleid) {
		this.relationroleid = relationroleid;
	}
	public Integer getRelation() {
		return relation;
	}
	public void setRelation(Integer relation) {
		this.relation = relation;
	}
	public Date getTimelimit() {
		return timelimit;
	}
	public void setTimelimit(Date timelimit) {
		this.timelimit = timelimit;
	}

}