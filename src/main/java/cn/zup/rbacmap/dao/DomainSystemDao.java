package cn.zup.rbacmap.dao;

import cn.zup.rbacmap.entity.DomainSystem;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface DomainSystemDao {
    DomainSystem getDomainSystemByDomain(@Param("domain") String domain);
    DomainSystem getDomainSystemBySystemId(@Param("systemId") Integer systemId);
    List<DomainSystem> getDomainSystemList(@Param("domainSystem") DomainSystem domainSystem);
}
