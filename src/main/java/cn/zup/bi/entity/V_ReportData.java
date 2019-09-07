package cn.zup.bi.entity;

import java.util.List;

public class V_ReportData {
	private Integer bi_Page_Id;
	private Integer screen_Index;
	private Integer block_Id;
	private List<String> key;
	private List<Object> value;
	private Integer block_Type;
	public Integer getBi_Page_Id() {
		return bi_Page_Id;
	}
	public void setBi_Page_Id(Integer bi_Page_Id) {
		this.bi_Page_Id = bi_Page_Id;
	}
	public Integer getScreen_Index() {
		return screen_Index;
	}
	public void setScreen_Index(Integer screen_Index) {
		this.screen_Index = screen_Index;
	}
	public Integer getBlock_Id() {
		return block_Id;
	}
	public void setBlock_Id(Integer block_Id) {
		this.block_Id = block_Id;
	}
	public List<String> getKey() {
		return key;
	}
	public void setKey(List<String> key) {
		this.key = key;
	}
	public List<Object> getValue() {
		return value;
	}
	public void setValue(List<Object> value) {
		this.value = value;
	}
	public Integer getBlock_Type() {
		return block_Type;
	}
	public void setBlock_Type(Integer block_Type) {
		this.block_Type = block_Type;
	}
	
}
