package cn.zup.bi.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="bi_block")
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
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getBlock_Id() {
		return block_Id;
	}
	public void setBlock_Id(Integer block_Id) {
		this.block_Id = block_Id;
	}
	public String getBlock_Flag() {
		return block_Flag;
	}
	public void setBlock_Flag(String block_Flag) {
		this.block_Flag = block_Flag;
	}
	public Integer getX_Point() {
		return x_Point;
	}
	public void setX_Point(Integer x_Point) {
		this.x_Point = x_Point;
	}
	public Integer getY_Point() {
		return y_Point;
	}
	public void setY_Point(Integer y_Point) {
		this.y_Point = y_Point;
	}
	public Integer getWidth() {
		return width;
	}
	public void setWidth(Integer width) {
		this.width = width;
	}
	public Integer getHeight() {
		return height;
	}
	public void setHeight(Integer height) {
		this.height = height;
	}
	public Integer getReport_Id() {
		return report_Id;
	}
	public void setReport_Id(Integer report_Id) {
		this.report_Id = report_Id;
	}
	public Integer getBi_Page_Id() {
		return bi_Page_Id;
	}
	public void setBi_Page_Id(Integer bi_Page_Id) {
		this.bi_Page_Id = bi_Page_Id;
	}
	public Integer getBlock_Type() {
		return block_Type;
	}
	public void setBlock_Type(Integer block_Type) {
		this.block_Type = block_Type;
	}
	public Integer getScreen_Index() {
		return screen_Index;
	}
	public void setScreen_Index(Integer screen_Index) {
		this.screen_Index = screen_Index;
	}
	
}
