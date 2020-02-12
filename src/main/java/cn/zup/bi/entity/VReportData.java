package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

/**
 * 传输实体，用于页面显示报表数据
 * 
 * 
 * */
@Setter
@Getter
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
}
