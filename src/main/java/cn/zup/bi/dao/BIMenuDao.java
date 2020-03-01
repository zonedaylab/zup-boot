package cn.zup.bi.dao;

import cn.zup.bi.entity.BiMenu;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface BIMenuDao {
    List<BiMenu> getBiMenuList(@Param("accountId") Integer accountId);
}
