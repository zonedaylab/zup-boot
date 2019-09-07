package cn.zup.rbac.entity;

/**
 * 复合主键的主键pojo类
 * lixin
 * 2017-3-3 15:22:24
 */
import java.io.Serializable;

public class EnergyRelationPK implements Serializable {
	private Integer  common_Organ_Id;//普通公司id
	private Integer  department_Id;//经营公司id
	public Integer getCommon_Organ_Id() {
		return common_Organ_Id;
	}
	public void setCommon_Organ_Id(Integer commonOrganId) {
		common_Organ_Id = commonOrganId;
	}
	public Integer getDepartment_Id() {
		return department_Id;
	}
	public void setDepartment_Id(Integer departmentId) {
		department_Id = departmentId;
	}
}
