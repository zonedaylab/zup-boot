package cn.zup.workflow.controller.ViewEntity;

public class Line  
{
	private int lineid;
	private String name;
	private String type;
	private String from;
	private String to;
	private String marked;
	//private String m;
	
	public int getLineid() {
		return lineid;
	}
	public void setLineid(int lineid) {
		this.lineid = lineid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getMarked() {
		return marked;
	}
	public void setMarked(String marked) {
		this.marked = marked;
	}
//	public String getM() {
//		return m;
//	}
//	public void setM(String m) {
//		this.m = m;
//	}
	
}