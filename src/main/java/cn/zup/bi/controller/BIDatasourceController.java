package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.entity.BI_REPORT;
import cn.zup.bi.service.BIDatasourceService;
import cn.zup.framework.json.JsonDateValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.Date;

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

//    @PostMapping("/saveDatasource")
//    public JSONObject saveDatasource(BI_Datasource bi_datasource){
//        int i = biDatasourceService.addDatasource(bi_datasource);
//        JSONObject json = new JSONObject();
//        if(i == 0){
//            json.put("data", "success");
//            return json;
//        }else{
//            json.put("data", "error");
//            return json;
//        }
//    }

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
        if(r!=0)
            json.put("data", "success");
        else
            json.put("data", "error");
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
        if(r!=0)
            json.put("data", "success");
        else
            json.put("data", "error");
        return json.toString();
    }



    /**
     * 获取数据源列表
     * @author 王朔
     */
    @RequestMapping("/getDatasourceList")
    @ResponseBody
    public String getDatasourceList(BI_Datasource bi_datasource, int rows, int page){
        MiniDaoPage<BI_Datasource> list = biDatasourceService.getDatasourcePagingList(bi_datasource, page, rows);
        JSONObject json = new JSONObject();
        json.put("rows", rows);
        json.put("page", list.getPages());
        json.put("total",list.getTotal());
        //日期类型转换
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class,
                new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
        JSONArray jsonArray = JSONArray.fromObject(list.getResults(), jsonConfig);
        json.put("data", jsonArray);
        return json.toString();
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
