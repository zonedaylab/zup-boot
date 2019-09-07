package cn.zup.rbac.controller.ViewEntity;

import java.util.ArrayList;
import java.util.List;

public class TreeView {
	private Integer id;
	private String name;
	private String type = "item";
	
	//岗位类型（或自行扩展）
	private Integer postMark;
	//父节点ID
	private Integer belongId;
	//规格型号（或自行扩展）
	private Integer modelMark;
	
	private TreeViewChecked additionalParameters= new TreeViewChecked();
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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
	public TreeViewChecked getAdditionalParameters() {
		return additionalParameters;
	}
	public void setAdditionalParameters(TreeViewChecked additionalParameters) {
		this.additionalParameters = additionalParameters;
	}
	public Integer getPostMark() {
		return postMark;
	}
	public void setPostMark(Integer postMark) {
		this.postMark = postMark;
	}
	public Integer getBelongId() {
		return belongId;
	}
	public void setBelongId(Integer belongId) {
		this.belongId = belongId;
	}

	public Integer getModelMark() {
		return modelMark;
	}

	public void setModelMark(Integer modelMark) {
		this.modelMark = modelMark;
	}
	
}
