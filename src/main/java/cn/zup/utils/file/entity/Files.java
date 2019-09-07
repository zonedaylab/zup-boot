package cn.zup.utils.file.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name="files")
public class Files implements Serializable {
	public Files() {
	} 
	private Integer fileId;
    private String fileCode; 
    private Integer filePackageID;
    private String fileName;
    private Integer totalNumber;
    private Integer currentNumber;
    private String description;
    private String fileCreater;
    private Date fileCreateDate;
    

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getFileId() {
		return fileId;
	}
	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}	
	public String getFileCode() {
		return fileCode;
	}	
	public void setFileCode(String fileCode) {
		this.fileCode = fileCode;
	}
	public Integer getFilePackageID() {
		return filePackageID;
	}
	public void setFilePackageID(Integer filePackageID) {
		this.filePackageID = filePackageID;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getTotalNumber() {
		return totalNumber;
	}
	public void setTotalNumber(Integer totalNumber) {
		this.totalNumber = totalNumber;
	}
	public Integer getCurrentNumber() {
		return currentNumber;
	}
	public void setCurrentNumber(Integer currentNumber) {
		this.currentNumber = currentNumber;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getFileCreater() {
		return fileCreater;
	}
	public void setFileCreater(String fileCreater) {
		this.fileCreater = fileCreater;
	}
	public Date getFileCreateDate() {
		return fileCreateDate;
	}
	public void setFileCreateDate(Date fileCreateDate) {
		this.fileCreateDate = fileCreateDate;
	}
	   
}