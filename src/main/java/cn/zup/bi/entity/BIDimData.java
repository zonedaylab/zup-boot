package cn.zup.bi.entity;

import lombok.Data;

import java.util.List;

@Data
public class BIDimData {
	private int dimOrder;
	private Integer drill_Type;  //钻取类型
	private String field_Name;   //字段名称

	private String drill_Info;   //钻取信息

	private  Integer currentReportIndex;//当前主题表索引，针对钻取类型4.

	/**
	 * 维度对应的数据
	 */
	private List<String> listData;
}