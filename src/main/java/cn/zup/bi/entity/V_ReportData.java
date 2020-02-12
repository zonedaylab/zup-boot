package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class V_ReportData {
	private Integer bi_Page_Id;
	private Integer screen_Index;
	private Integer block_Id;
	private String drill_Name;
	private Object drill_Value;
	private List<String> key;
	private List<Object> value;
	private Integer block_Type;
	private Integer index;
}
