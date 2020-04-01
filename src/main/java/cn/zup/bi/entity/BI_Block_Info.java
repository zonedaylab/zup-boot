package cn.zup.bi.entity;

import lombok.Data;

@Data
public class BI_Block_Info {
	private Integer block_Id;  //区块ID
	private String block_Flag;  //区块标识
	private Integer x_Point;  //X坐标
	private Integer y_Point;  //Y坐标
	private Integer width;  //宽
	private Integer height;  //高
	private Integer report_Id;  //报表id
	private Integer bi_Page_Id;  //页面id
	private Integer block_Type;  //图表类型
	private Integer screen_Index; //屏幕索引
}
