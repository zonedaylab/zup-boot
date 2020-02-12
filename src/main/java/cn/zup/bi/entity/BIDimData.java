package cn.zup.bi.entity;

import lombok.Data;

import java.util.List;

@Data
public class BIDimData {
	private int dimOrder;
	/**
	 * 维度对应的数据
	 */
	private List<String> listData;
}