package cn.zup.rbac.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@IdClass(EnergyRelationPK.class)
@Table(name = "ENERGY_RELATION")
public class EnergyRelation implements Serializable {
	private Integer  common_Organ_Id;//普通公司id
	private Integer  department_Id;//经营公司id
	@Id
 	@Column(length=20,name="common_Organ_Id")
	public Integer getCommon_Organ_Id() {
		return common_Organ_Id;
	}
	public void setCommon_Organ_Id(Integer commonOrganId) {
		common_Organ_Id = commonOrganId;
	}
	@Id
 	@Column(length=20,name="department_Id")
	public Integer getDepartment_Id() {
		return department_Id;
	}
	public void setDepartment_Id(Integer departmentId) {
		department_Id = departmentId;
	}  
}