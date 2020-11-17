package cn.zup.bi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/rest/bi/biEchartsController")
public class BiEcharts {



    /**
     * 返回首页
     * @author 段延玉
     * */
    @RequestMapping("")
    public ModelAndView index(HttpServletRequest request){
        return new ModelAndView("bi/biEcharts");
    }
}
