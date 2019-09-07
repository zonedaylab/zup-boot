package cn.zup.utils.file.dao;
 
 
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
 
import cn.zup.utils.file.entity.FileVirtual; 

@MiniDao
public interface FileVirtualDao extends MiniDaoSupportHiber<FileVirtual> {	
	//@Arguments("projectId")
	//List<PmProject> getNodeByProject(Integer projectId);
	
}
