package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.rbac.entity.CodeSerial;
@MiniDao
public interface CodeSerialDao extends MiniDaoSupportHiber<CodeSerial> {
@Arguments("codetypestr2")
@ResultType(CodeSerial.class)
List<CodeSerial> getFromCodeSerial(String codetypestr2);

 @Arguments("codeserial")
 void updateCodeSerial(CodeSerial codeserial);

}
