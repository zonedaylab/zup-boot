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
@Table(name="file_Virtual")
public class FileVirtual implements Serializable {
	public FileVirtual() {
	} 
	private Integer virtualFileId; 
    private String virtualFileCode; 
    private String fileVersion; 
    private Integer fileId;
    private Integer fileFormatId;
    private String businessKey;
    private String PhysicalName;
    private String realName;
    private Integer uploader;
    private Date uploadTime;
    private String FileHash; 
    private String versionDescription;
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getVirtualFileId() {
		return virtualFileId;
	}
	public void setVirtualFileId(Integer virtualFileId) {
		this.virtualFileId = virtualFileId;
	}
	public String getVirtualFileCode() {
		return virtualFileCode;
	}	
	public void setVirtualFileCode(String virtualFileCode) {
		this.virtualFileCode = virtualFileCode;
	}
	
	public String getFileVersion() {
		return fileVersion;
	}
	public void setFileVersion(String fileVersion) {
		this.fileVersion = fileVersion;
	}
	
	
	public Integer getFileId() {
		return fileId;
	}
	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}
	public Integer getFileFormatId() {
		return fileFormatId;
	}
	public void setFileFormatId(Integer fileFormatId) {
		this.fileFormatId = fileFormatId;
	}
	public String getBusinessKey() {
		return businessKey;
	}
	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
	}
	public String getPhysicalName() {
		return PhysicalName;
	}
	public void setPhysicalName(String physicalName) {
		PhysicalName = physicalName;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public Integer getUploader() {
		return uploader;
	}
	public void setUploader(Integer uploader) {
		this.uploader = uploader;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getFileHash() {
		return FileHash;
	}
	public void setFileHash(String fileHash) {
		FileHash = fileHash;
	}
	public String getVersionDescription() {
		return versionDescription;
	}
	public void setVersionDescription(String versionDescription) {
		this.versionDescription = versionDescription;
	}
    
	
    
}