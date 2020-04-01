package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.service.BIDatasourceService;
import cn.zup.framework.common.vo.CommonResult;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

/**
 * BI数据源API接口
 * @author ucisoft
 */
@RestController
@RequestMapping("/rest/bi/BIDatasourceController")
public class BIDatasourceController {

    @Resource
    private BIDatasourceService biDatasourceService;

    @GetMapping("")
    public ModelAndView index(){
        return new ModelAndView("bi/biDatasourceManage");
    }

    /**
     * 保存数据源信息
     * @author 王朔
     */
    @RequestMapping("/saveDatasource")
    @ResponseBody
    public String saveReport(BI_Datasource bi_datasource){
        bi_datasource.setDs_create_time(new Date());
        int r = biDatasourceService.addDatasource(bi_datasource);
        JSONObject json = new JSONObject();
        if(r!=0) {
            json.put("data", "success");
        }else {
            json.put("data", "error");
        }
        return json.toString();
    }

    /**
     * 获取数据源信息
     * @author 王朔
     * */
    @RequestMapping("/getDatasourceInfo")
    @ResponseBody
    public String getDatasourceInfo(BI_Datasource datasource){
        BI_Datasource biDatasource = biDatasourceService.getDatasourceInfo(datasource.getId());
        JSONObject json = new JSONObject();
        json.put("data", biDatasource);
        return json.toString();
    }

    /**
     * 更新数据源
     * @author 王朔
     * */
    @RequestMapping("/updateDatasource")
    @ResponseBody
    public String updateReport(BI_Datasource datasource){
        int r = biDatasourceService.addDatasource(datasource);
        JSONObject json = new JSONObject();
        if(r!=0) {
            json.put("data", "success");
        }else {
            json.put("data", "error");
        }
        return json.toString();
    }

    /**
     * 获取数据源列表
     * @author 王朔
     */
    @RequestMapping("/getDatasourceList")
    @ResponseBody
    public CommonResult<BI_Datasource> getDatasourceList(BI_Datasource bi_datasource, int rows, int page){
        List<BI_Datasource> list = biDatasourceService.getDatasourcePagingList(bi_datasource);
        return CommonResult.successPage(list, page, rows);
    }

    /**
     * 获取数据源列表
     * @author gavin
     */
    @RequestMapping("/getDsList")
    @ResponseBody
    public CommonResult<BI_Datasource> getDatasourceList(){
        List<BI_Datasource> list = biDatasourceService.getDatasourcePagingList(new BI_Datasource());
        return CommonResult.success("查询成功", list);
    }

    /**
     * 删除数据源
     * @author 王朔
     * */
    @RequestMapping("/deleteDatasource")
    @ResponseBody
    public String deleteReport(@RequestParam("ids[]")Integer[] id){
        JSONObject json = new JSONObject();
        String arrs = "";
        int a = 0;
        for (int i = 0; i < id.length; i++) {
            System.err.println(id[i]);
            int r = biDatasourceService.deleteDatasource(id[i]);
            if(r==1 && a == 0){
                json.put("data", "success");
            }else{
                arrs += id[i] + ", ";
                json.put("data", "error");
                json.put("info", arrs);
                a++;
            }
        }
        return json.toString();
    }

}
