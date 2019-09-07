package cn.zup.utils.file.dao;
 
 
import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
 
import cn.zup.utils.file.entity.Files; 

@MiniDao
public interface FilesDao extends MiniDaoSupportHiber<Files> {	
	@Arguments({"businessKey","packageId"})
	String getPhysicalpath(String businessKey,Integer packageId);
	@Arguments({"businessKey","packageId"})
	String getFileName(String businessKey,Integer packageId);
}
