package cn.zup.utils.file.dao;
 
 
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
 
import cn.zup.utils.file.entity.FilePackage; 

@MiniDao
public interface FilePackageDao extends MiniDaoSupportHiber<FilePackage> {	
	//@Arguments("projectId")
	//List<PmProject> getNodeByProject(Integer projectId);
	
}
