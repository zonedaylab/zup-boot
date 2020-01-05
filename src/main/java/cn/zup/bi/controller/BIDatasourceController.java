package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Datasource;
import cn.zup.bi.service.BIDatasourceService;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

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

    @PostMapping("/add")
    public JSONObject add(BI_Datasource bi_datasource){
        int i = biDatasourceService.addDatasource(bi_datasource);
        JSONObject json = new JSONObject();
        if(i == 0){
            json.put("data", "success");
            return json;
        }else{
            json.put("data", "error");
            return json;
        }
    }
}
