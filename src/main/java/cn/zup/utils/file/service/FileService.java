package cn.zup.utils.file.service;


import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import cn.zup.utils.file.entity.FileVirtual;
import cn.zup.utils.file.entity.Files;


public interface FileService {
	/**
	 * 上传文件
	 * 
	 * @param businessKey 业务表名+业务主键Id
	 * @param packageId  业务对应的包Id
	 * @param mFile      文件对象 
	 *             
	 */
	boolean fileUpLoad(String businessKey,int packageId,CommonsMultipartFile mFile,Integer accountId);
	

	/**
	 * 下载文件
	 * 
	 * @param businessKey 业务表名+业务主键Id
	 * @param packageId  业务对应的包Id
	 * @param response    对象 
	 *             
	 */
	void fileDownload(String businessKey,int packageId,HttpServletResponse response);
	/**
	 * 获取要下载的文件名称
	 * @param businessKey
	 * @param packageId
	 * @return
	 */
	String getFileName(String businessKey,int packageId);
	/**
	 * 获取文件的物理路径
	 * @param businessKey
	 * @param packageId
	 * @return
	 */
	
	String getPhysicalpath(String businessKey,int packageId);
	/**
	 * 增加一个文件实体
	 * @param files
	 */
	void addFile(Files files);

	/**
	 * 增加一个虚拟文件
	 * @param files
	 */
	void addFileVirtual(FileVirtual fileVirtual);
	
}