package cn.zup.utils.file.service.impl;
 


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream; 
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import cn.zup.utils.file.dao.FilePackageDao;
import cn.zup.utils.file.dao.FileVirtualDao;
import cn.zup.utils.file.dao.FilesDao;
import cn.zup.utils.file.entity.FilePackage;
import cn.zup.utils.file.entity.FileVirtual;
import cn.zup.utils.file.entity.Files;
import cn.zup.utils.file.service.FileService; 
import cn.zup.utils.utils.ToHtml;

 
@Service("fileService")
public class FileServiceImpl implements FileService{

	@Autowired
	private FilePackageDao filePackageDao;
	@Autowired
	private FileVirtualDao fileVirtualDao;
	@Autowired
	private FilesDao filesDao;


	@Override
	public void fileDownload(String businessKey,int packageId,HttpServletResponse response) {
		
		 OutputStream outputStream;
			try {
				outputStream = response.getOutputStream();
				//输出文件用的字节数组，每次向输出流发送600个字节  
		        byte b[] = new byte[600]; 	
		       String physicalpath=filesDao.getPhysicalpath(businessKey,packageId); 	    
		       System.out.println("测试输出读取的要下载的文件物理路径"+physicalpath);
		       
		        //要下载的文件  
		        File fileload = new File(physicalpath); 
		        //客服端使用保存文件的对话框  
			    String filename=filesDao.getFileName(businessKey,packageId);		
		        response.setHeader("Content-disposition", "attachment;filename="+new String(filename.getBytes("utf-8"),"ISO8859-1"));
		        //通知客服文件的MIME类型  
		        response.setContentType("application/msword");  
		        //通知客服文件的长度  
		        long fileLength = fileload.length();  
		        String length = String.valueOf(fileLength);  
		        response.setHeader("Content_length", length);  
		        //读取文件，并发送给客服端下载  
		        FileInputStream inputStream = new FileInputStream(fileload);  		       
		        int n = 0;  
		        while((n=inputStream.read(b))!=-1){  
		            outputStream.write(b,0,n);  
		        }
			} catch (IOException e) {				
				e.printStackTrace();
			} 
	}

	@Override
	public boolean fileUpLoad(String businessKey, int packageId,
			CommonsMultipartFile mFile,Integer accountId) {
		try{
		    //得到文件名称
		    String fileName =  mFile.getFileItem().getName();		  
		    fileName = System.currentTimeMillis()+accountId+"-"+fileName.trim();
		    if(fileName!=null && !fileName.equals("")){
		    	//获取对应包的ID的物理路径
		    	FilePackage filePackage = new FilePackage();
		    	filePackage.setFilePackageID(packageId);
		    	List<FilePackage> listFilePackage = filePackageDao.listByHiber(filePackage);
		    	if(listFilePackage==null || listFilePackage.get(0)==null)
		    		return false;
		    	//将文件保存到服务器
		    	 FileOutputStream os = new FileOutputStream(listFilePackage.get(0).getPhysicalPath()+fileName);
		    	 //FileOutputStream os = new FileOutputStream("E:\\Users\\iesies\\Workspaces\\MyEclipse 8.5\\projectmanage\\WebRoot\\uploads\\"+mFile.getOriginalFilename());
		  		 System.out.println("保存文件的路径"+listFilePackage.get(0).getPhysicalPath());
		         InputStream in = mFile.getInputStream();
		         int b = 0;
		         while((b=in.read())!=-1){ //读取文件 
		           os.write(b);
		         }
		         os.flush(); //关闭流 
		         in.close();
		         os.close();
		         
		         //转换文件
		         //InputStream is = new FileInputStream(listFilePackage.get(0).getPhysicalPath()+fileName);
		         //WordToHtml.convertDocx2Html(is,listFilePackage.get(0).getPhysicalPath());

		         //根据不同的文件
		 	    String urlName = fileName.substring(fileName.length()-4,fileName.length());
		        String nameType = urlName.substring(urlName.indexOf(".")+1,urlName.length());
		 		if(nameType.equals("doc")) 
		 		{
			         ToHtml.doc2Html(listFilePackage.get(0).getPhysicalPath()+fileName, packageId+"//"+fileName+".jsp");
		 		}
		 		else if(nameType.equals("docx"))
		 		{
			         ToHtml.docx2Html(listFilePackage.get(0).getPhysicalPath()+fileName, packageId+"//"+fileName+".jsp");
		 		}
		 		else
		 		{
		 			
		 		}
		 		
		        // 将文件信息保存到文件以及电子文件中
		         Files files = new Files();
		 		 files.setFileCode("1");
		         files.setFilePackageID(packageId);
		         files.setTotalNumber(1);
		         files.setFileName(fileName);
		         files.setCurrentNumber(1);
		         files.setFileCreateDate(new Date()); 		      
		         
		         filesDao.saveByHiber(files);
		         System.out.println("保存文件正常");
		         
		         FileVirtual fileVirtual = new FileVirtual();
		         fileVirtual.setVirtualFileCode("1");
		         fileVirtual.setFileVersion("1.0");
		         fileVirtual.setFileId(files.getFileId());
		         fileVirtual.setFileFormatId(1);
		         fileVirtual.setBusinessKey(businessKey);
		         fileVirtual.setPhysicalName(fileName);
		         fileVirtual.setFileHash("1");
		         fileVirtual.setUploader(1);
		         fileVirtual.setUploadTime(new Date());
		         fileVirtual.setVersionDescription("1.0");
		         
		         fileVirtualDao.saveByHiber(fileVirtual);
		         return true;		         
		    }
		    else{	    	
		    	 System.out.println("提交失败");
		    	 return  false;
		    }
	    }catch (Exception e) {
		    e.printStackTrace();
		    System.out.println("提交失败");
	    }
	    return false;
	}

	
	public void addFile(Files files) {
		filesDao.saveByHiber(files);		
	}


	public void addFileVirtual(FileVirtual fileVirtual) {
		fileVirtualDao.saveByHiber(fileVirtual);		
	}

	@Override
	public String getFileName(String businessKey, int packageId) {
		return filesDao.getFileName(businessKey,packageId);
	}

	@Override
	public String getPhysicalpath(String businessKey, int packageId) {
		return filesDao.getPhysicalpath(businessKey,packageId);
	}

}