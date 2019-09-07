package cn.zup.workflow.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class SaveAutoFormFile {
	
	/**
	 * 读取文件流，把文件存入返回存放文件地址
	 * @author 谢炎
	 * @date 2017-9-13 08:06:34
	 * */
	public static String readFileInputStram(String savePath, String folder, String fileNames, HttpServletRequest request) throws IOException{
		MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;//request强制转换注意
	    Iterator<String> fns = mRequest.getFileNames();
	    while (fns.hasNext()) {
	    	String fn = fns.next();
	    	System.err.println(fn);
	    	List<MultipartFile> file = mRequest.getFiles(fn);
	    	for (MultipartFile multipartFile : file) {
	    		String fileName = multipartFile.getOriginalFilename();
				System.err.println(fileName);
				boolean fileSaveState = saveFile(multipartFile.getInputStream(), savePath, fileName);
				if(fileSaveState)
					fileNames += folder+"/"+fileName+";";
			}
		}
	    fileNames = fileNames.substring(0, fileNames.length()-1);
	    return fileNames;
	}
	
	
	/**
	 * 文件存放方法
	 * @author 谢炎
	 * @throws IOException 
	 * @throws IOException 
	 * @date 2016-9-26 14:37:22
	 * 
	 * */
	public static boolean saveFile(InputStream stream,String path,String savefile) throws IOException{
		FileOutputStream fs=new FileOutputStream( path + savefile);
        System.out.println("文件存放路径：------------"+path + savefile);
        byte[] buffer =new byte[1024*1024];
        int bytesum = 0;
        int byteread = 0; 
        try {
			while ((byteread=stream.read(buffer))!=-1)
			{
			  bytesum+=byteread;
			  fs.write(buffer,0,byteread);
			  fs.flush();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} 
        fs.close();
        stream.close();
		return true;
	}
	
	/**
	 * 读取文件流，把文件存入返回存放文件地址(返回文件硬盘地址)
	 * @author 谢炎
	 * @date 2017-9-13 08:06:34
	 * */
	public static String readFileInputStramByRootPath(String savePath, String folder, String fileNames, HttpServletRequest request) throws IOException{
		MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;//request强制转换注意
	    Iterator<String> fns = mRequest.getFileNames();
	    while (fns.hasNext()) {
	    	String fn = fns.next();
	    	System.err.println(fn);
	    	List<MultipartFile> file = mRequest.getFiles(fn);
	    	for (MultipartFile multipartFile : file) {
	    		String fileName = multipartFile.getOriginalFilename();
				System.err.println(fileName);
				fileNames += saveFileByRootPath(multipartFile.getInputStream(), savePath, fileName)+",";
			}
		}
	    fileNames = fileNames.substring(0, fileNames.length()-1);
	    return fileNames;
	}
	
	
	/**
	 * 文件存放方法
	 * @author 谢炎
	 * @throws IOException 
	 * @throws IOException 
	 * @date 2016-9-26 14:37:22
	 * 
	 * */
	public static String saveFileByRootPath(InputStream stream,String path,String savefile) throws IOException{
		FileOutputStream fs=new FileOutputStream( path + savefile);
        System.out.println("文件存放路径：------------"+path + savefile);
        byte[] buffer =new byte[1024*1024];
        int bytesum = 0;
        int byteread = 0; 
        try {
			while ((byteread=stream.read(buffer))!=-1)
			{
			  bytesum+=byteread;
			  fs.write(buffer,0,byteread);
			  fs.flush();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		} 
        fs.close();
        stream.close();
		return path + savefile;
	}
}
