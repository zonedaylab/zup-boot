package cn.zup.utils.file.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name="file_package")
public class FilePackage implements Serializable {
	public FilePackage() {
	} 

    private Integer filePackageID; 
    private String filePackageName;
    private Integer parentID;
    private String physicalPath;
    private String createUser;
    private Date createDate;
    private Integer approveFlag;
    private String description;

    @Id
    @GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getFilePackageID() {
		return filePackageID;
	}
	public void setFilePackageID(Integer filePackageID) {
		this.filePackageID = filePackageID;
	}
	public String getFilePackageName() {
		return filePackageName;
	}
	public void setFilePackageName(String filePackageName) {
		this.filePackageName = filePackageName;
	}
	public Integer getParentID() {
		return parentID;
	}
	public void setParentID(Integer parentID) {
		this.parentID = parentID;
	}
	public String getPhysicalPath() {
		return physicalPath;
	}
	public void setPhysicalPath(String physicalPath) {
		this.physicalPath = physicalPath;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getApproveFlag() {
		return approveFlag;
	}
	public void setApproveFlag(Integer approveFlag) {
		this.approveFlag = approveFlag;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
    
	


    
    
}