package cn.zup.bi.entity;

import java.util.List;
import java.util.Map;

/**
 * 传输实体，用于页面显示报表数据
 * 
 * 
 * */
public class VReportData {
	private String hidden; //前台需要隐藏的列
	private String ahref;  //前台超链接的列
	private String address; //超链接地址
	private String cur;  //当前页面所取的属性名称，比如：proid cityid qreid
	private String parm;  //当前页面的参数名称，比如：p c q
	private List<String> col;  //当前页面的列名
	private List<Map> list;   //当前页面的表格数据
	private String[] colTH;  //传入表头别名
	private String reportName;  //表名称
	private String reportTitle; //表标题
	public String getHidden() {
		return hidden;
	}
	public void setHidden(String hidden) {
		this.hidden = hidden;
	}
	public String getAhref() {
		return ahref;
	}
	public void setAhref(String ahref) {
		this.ahref = ahref;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCur() {
		return cur;
	}
	public void setCur(String cur) {
		this.cur = cur;
	}
	public String getParm() {
		return parm;
	}
	public void setParm(String parm) {
		this.parm = parm;
	}
	public List<String> getCol() {
		return col;
	}
	public void setCol(List<String> col) {
		this.col = col;
	}
	public List<Map> getList() {
		return list;
	}
	public void setList(List<Map> list) {
		this.list = list;
	}
	public String[] getColTH() {
		return colTH;
	}
	public void setColTH(String[] colTH) {
		this.colTH = colTH;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}
}
