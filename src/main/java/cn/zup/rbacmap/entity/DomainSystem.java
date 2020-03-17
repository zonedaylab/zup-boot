package cn.zup.rbacmap.entity;


import lombok.Data;

import javax.persistence.Table;

@Data
@Table(name = "Domain_System")
public class DomainSystem {
	private Integer relation_Id;//关系id
	private Integer system_Id;//系统id
	private String system_Name;//系统名称
	private String domain;//域名
}