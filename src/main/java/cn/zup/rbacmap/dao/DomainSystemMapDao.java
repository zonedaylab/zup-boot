package cn.zup.rbacmap.dao;

import cn.zup.rbacmap.entity.DomainSystemMap;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface DomainSystemMapDao {
    List<DomainSystemMap> getDomainSystemList(@Param("relation_Id") Integer relation_Id);
}
