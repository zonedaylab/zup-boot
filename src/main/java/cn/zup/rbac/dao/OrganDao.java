package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserInfo;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import java.util.List;


@MiniDao
public interface OrganDao extends MiniDaoSupportHiber<Organ>{ 
	@Arguments({"organId","parentOrganId","organName"})
	public List<Organ> getOrganRepeatVerify(Integer organId, Integer parentOrganId, String organName);
	@Arguments({"parentOrganId","validFlag","organType"})
	public List<Organ> getSubOrganList(Integer parentOrganId, Integer validFlag, Integer organType);
	@Arguments("organ")
	public Organ getOrganInfo(Organ organ);
	@Arguments({"organId","parentOrganId","orderCode"})
	public List<Organ> getOrderCodeRepeatVerify(Integer organId, Integer parentOrganId, Integer orderCode);
	@Arguments({"organ"})
	@ResultType(Organ.class)
	public List<Organ> getOperateOrganList(Organ organ); 
	@Arguments({"ui"})
	@ResultType(Organ.class)
	public Organ getOrganName(UserInfo ui);
	@Arguments({"validFlag","organType","parentOrganId","myOrganIds"})
	@ResultType(Organ.class)
	public List<Organ> getMySubOrganList(int validFlag, int organType, Integer parentOrganId, String myOrganIds);
	@Arguments({"validFlag","organType","parentOrganId","myOrganIds","excludeOrganIds"})
	@ResultType(Organ.class)
	public List<Organ> getMyPermissionOrganList(int validFlag, int organType, Integer parentOrganId, String myOrganIds, String excludeOrganIds);
	@Arguments({"parentOrganId","usedStr"})
	public List<Organ> getSubOrganByUsedList(int parentOrganId, String usedStr);
}
