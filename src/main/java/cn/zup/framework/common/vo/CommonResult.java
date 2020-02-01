package cn.zup.framework.common.vo;

import cn.zup.bi.entity.BI_Datasource;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 同意接口返回参数视图实体
 * @author gavin
 */
@Data
public class CommonResult<T> {
    private Integer page;
    private Integer rows;
    private Long total;
    private Integer code;
    private T data;
    private Long time = System.currentTimeMillis();
    private String message;

    public static <T> CommonResult success(String message){
        return success(message, null);
    }

    public static <T> CommonResult success(String message, T data){
        CommonResult commonResult = new CommonResult();
        commonResult.message = message;
        commonResult.data = data;
        commonResult.setCode(0);
        return commonResult;
    }

    public static <T> CommonResult successPage(List<T> data, int pageNum, int pageRows){
        PageHelper.startPage(pageNum, pageRows);
        PageInfo<T> pageinfo = new PageInfo<>(data);
        CommonResult commonResult = new CommonResult();
        commonResult.setPage(pageinfo.getPageNum());
        commonResult.setRows(pageinfo.getPageSize());
        commonResult.setTotal(pageinfo.getTotal());
        commonResult.setMessage("查询成功");
        commonResult.data = pageinfo.getList();
        commonResult.setCode(0);
        return commonResult;
    }

    public static <T> CommonResult error(String message){
        CommonResult commonResult = new CommonResult();
        commonResult.message = message;
        commonResult.setCode(1);
        return commonResult;
    }
}
