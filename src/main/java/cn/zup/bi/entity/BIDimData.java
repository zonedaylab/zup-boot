package cn.zup.bi.entity;

import lombok.Data;

import java.util.List;

@Data
public class BIDimData {
	private int dimOrder;
	private Integer drill_Type;  //钻取类型
	private String field_Name;   //字段名称

	//字段对应的中文别名，用于与维度连接后的字段名称
	public String getFieldNameChinese(){
		return  field_Name+"chinese";
	}
	//用于维度连接后的英文字段名称（编码）
	public String getFieldNameCode(){
		return  field_Name+"code";
	}

	private String drill_Info;   //钻取信息

	private  Integer currentReportIndex;//当前主题表索引，针对钻取类型4.

	/**
	 * 维度对应的数据 Chinese
	 */
	private List<String> listData;

	private List<String> listDataCode; //维度对应的数据code
}