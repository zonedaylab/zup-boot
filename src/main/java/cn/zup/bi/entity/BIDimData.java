package cn.zup.bi.entity;

import java.util.List;

public class BIDimData {

	int dimOrder;
	public int getDimOrder() {
		return dimOrder;
	}
	public void setDimOrder(int dimOrder) {
		this.dimOrder = dimOrder;
	}
	public List<String> getListData() {
		return listData;
	}
	public void setListData(List<String> listData) {
		this.listData = listData;
	}
	List<String>listData;//维度对应的数据
}