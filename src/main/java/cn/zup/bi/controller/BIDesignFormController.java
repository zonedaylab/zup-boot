package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_Page;
import cn.zup.bi.entity.BI_REPORT;
import cn.zup.bi.entity.BI_REPORT_FIELD;
import cn.zup.bi.service.BIPageService;
import cn.zup.bi.service.ReportFieldService;
import cn.zup.bi.service.ReportService;
import cn.zup.framework.json.JsonDateValueProcessor;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/rest/bi/BIDesignFormController")
public class BIDesignFormController {

    @Resource
    private BIPageService biPageService;
    @Resource
    private ReportService reportService;
    @Resource
    private ReportFieldService reportFieldService;

    @GetMapping("")
    public ModelAndView index(){
        return new ModelAndView("bi/biDesignForm");
    }

    @GetMapping("/tree")
    public ModelAndView indexTree(){
        return new ModelAndView("bi/biDesignFormTree");
    }


    /***
     * 根据参数加载左侧列表
     * @param pageId
     * @param screenIndex
     * @param reportId
     * @param type 1 表单 2 报表 3 指标
     * @return
     */
    @GetMapping("/biEleList")
    @ResponseBody
    public JSONObject getBiEleList(@RequestParam(value = "pageId", required = false) Integer pageId,
                                   @RequestParam(value = "screenIndex", required = false) Integer screenIndex,
                                   @RequestParam(value = "reportId", required = false) Integer reportId,
                                   @RequestParam(value = "type") Integer type){
        JSONObject jsonObject = new JSONObject();
        try {
            switch (type){

                case 1:
                    BI_Page bi_Page = new BI_Page();
                    List<BI_Page> plist = biPageService.getBiPageList(bi_Page);
                    jsonObject.put("data", plist);
                    break;
                case 2:
                    List<BI_REPORT> rlist = reportService.getReportListByPageId(pageId, screenIndex);
                    //日期类型转换
                    JsonConfig jsonConfig = new JsonConfig();
                    jsonConfig.registerJsonValueProcessor(Date.class,
                            new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
                    JSONArray jsonArray = JSONArray.fromObject(rlist, jsonConfig);
                    jsonObject.put("data", jsonArray);
                    break;
                case 3:
                    BI_REPORT_FIELD reportField = new BI_REPORT_FIELD();
                    reportField.setReport_Id(reportId);
                    BI_REPORT biReport = reportService.getReportInfo(reportId);
                    List<BI_REPORT_FIELD> rflist = reportFieldService.getReportFieldList(reportField, 99999, 1);
                    jsonObject.put("data", rflist);
                    break;
            }
            jsonObject.put("code", 0);
            jsonObject.put("msg", "success");
        }catch (Exception e){
            jsonObject.put("code", 1);
            jsonObject.put("msg", "fail info:"+e.getMessage());
        }
        return jsonObject;
    }
}
