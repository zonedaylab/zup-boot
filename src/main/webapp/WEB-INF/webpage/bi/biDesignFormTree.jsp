<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!doctype html>
<html>

<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <link href="plug-in/ace/adIcon/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="//a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css">
    <link href="plug-in/gis/css/ol.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="plug-in/ace/css/multifunctionMap.css">
    <link rel="stylesheet" href="plug-in/ace/css/multifunctionMapBlue.css">
    <link rel="stylesheet" href="plug-in/ace/adIcon/css/loading.css">
    <link rel="stylesheet" href="plug-in/ace/adIcon/css/animate.css">
    <title>BI数据可视化展示</title>
    <style rel="stylesheet">
        .table thead th {
            text-align: center;
            vertical-align: middle !important;
            padding: 3px;
            background-color: #eaeaea;
        }
        .table-bordered>thead>tr>td,
        .table-bordered>thead>tr>th {
            border-bottom-width: 1px;
            border-color: #d0d0d0;
        }
        td{
            white-space: nowrap !important;
            text-align: center;
        }
        a{
            display: block !important;
        }
        .smallTotal{
            color: #003bc3;
        }
        .txtRight{
            text-align:right;
        }
        .sla{
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
            display: block !important;
            width: 60px !important;
        }
        .btn-excel{
            float: right!important;
            margin-top: -38px;
            margin-right: 10px;
        }
        select{
            width: 120px;
        }
        label{
            margin-left: 5px;
        }
        .fa-chevron-down,.fa-chevron-up{
            margin-left: 20px !important;
            position: fixed;
            z-index: 9999999999;
        }
        .slidbar{
            position: fixed;
            top: 16px;
            left: 230px;
            cursor: pointer;
            color: rgb(255, 255, 255);
            text-align: center;
            line-height: 30px;
            z-index: 99999;
            transition:all 0.5s;
        }
    </style>
    <script>
        if("${usersession.userId}" == ""){
            //alert("请先登录之后在查看此页面！");
            //window.close();
        }
    </script>
</head>

<body>
<span onclick="showHiddenSideBar(this)" class="slidbar">
    <i class='fa fa-chevron-left'></i>
</span>
<div id="nav" class="nav nav_left animated" style="width: 260px; transition:all 0.5s;">
    <div class="nav_tab on" id="tab1">
        <div class="nav_title">
            <i class="fa fa-database"></i>
            数据展示
        </div>
        <div class="nav_menu_content">
            <form class="nav_menu" id='resourceSelection'>
                <div class="nav_menu_item">
                    <div class="nav_menu_item_title" type="5" child="true">
                        <span title="展示方式">展示方式</span>
                        <i class="fa fa-angle-right" style=""></i>
                    </div>
                    <div class="nav_menu_subitem">
                        <div class="nav_menu_item">
                            <div class="nav_menu_item_title" type="51" child="true" style="color: #ff0;">
                                <span class="fa fa-table" style="margin-right: 5px;"></span>
                                <span title="表格">表格</span>
                            </div>
                        </div>
                        <div class="nav_menu_item">
                            <div class="nav_menu_item_title" type="52" child="true">
                                <span class="fa fa-bar-chart" style="margin-right: 5px;"></span>
                                <span title="柱状图">柱状图</span>
                            </div>
                        </div>
                        <div class="nav_menu_item">
                            <div class="nav_menu_item_title" type="53" child="true">
                                <span class="fa fa-line-chart" style="margin-right: 5px;"></span>
                                <span title="折线图">折线图</span>
                            </div>
                        </div>
                        <div class="nav_menu_item">
                            <div class="nav_menu_item_title" type="54" child="true">
                                <span class="fa fa-pie-chart" style="margin-right: 5px;"></span>
                                <span title="多维或单维饼图">饼图</span>
                            </div>
                        </div>
                        <%--<div class="nav_menu_item">--%>
                            <%--<div class="nav_menu_item_title" type="55" child="true">--%>
                                <%--<span class="fa fa-empire" style="margin-right: 5px;"></span>--%>
                                <%--<span title="雷达图">雷达图</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </div>
                </div>
                <div class="nav_menu_item">
                    <div class="nav_menu_item_title" type="1" child="true">
                    <span title="设置显示数据">设置显示数据</span>
                    <i class="fa fa-angle-right" style=""></i>
                </div>
                    <div class="nav_menu_subitem"></div>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="big-down-btn" style="display: none">
    <i class="fa fa-cloud-download" id="export-png"></i>
</div>


<div id="show" style="height: 100%; width: 80%; background-color: #ffffff !important; float: right;  overflow: hidden;">
    <div class="row" style="height:50px; padding:5px; display: none;" id="article">
        <div class="col-lg-10 col-md-10 col-sm-8" style="text-align: center; line-height: 30px;">
            <div class="form-group">
                <div class="form-group" id="filter">

                </div>
            </div>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-4">
            <div class="form-group" style="margin-top: 15px;">
                <button class="btn btn-primary btn-sm pull-left" id="btnSearch" style="margin-right:10px; float: left;">查询</button>
            </div>
        </div>
    </div>
    <div id="box" style="height: 98%; width: 98%; margin-left: 10px; text-align: center; margin-top: -20px;">
        <h1 style="color: #c5c5c5; margin-top: 20%;">请依次选择左侧展示方式（默认是表格）和设置显示数据</h1>
    </div>
</div>

<script src="plug-in/ace/adIcon/js/jquery-2.1.1.min.js"></script>
<script src="plug-in/ace/bootstrap/js/bootstrap.js"></script>
<script src="plug-in/ace/adIcon/js/echarts.min.js" type="text/javascript" charset="utf-8"></script>
<script src="plug-in/layer/layer.js" type="text/javascript" charset="utf-8"></script><!-- layer弹窗 -->
<script src="plug-in/ace/adIcon/js/halloween.js" type="text/javascript" charset="utf-8"></script>
<script src='plug-in/ace/bi/js/loading.js'></script>
<script src='plug-in/ace/bi/js/Blob.js'></script>
<script src='plug-in/ace/bi/js/FileSaver.js'></script>
<script src='plug-in/ace/bi/js/tableExport.js'></script>
<!-- 折叠插件 -->
<script type="text/javascript" src="plug-in\ace\js\readmore\readmore.min.js"></script>
<script>
    var loading = new Loading();
    $(function () {
        if("${param.pageId}" != ""){
            page_Id = "${param.pageId}";
            reportNameTitle = "${param.title}";
            getList("${param.id}", 0);
            $("#article").css("display", "block");
            $('#article').readmore({
                speed: 5,
                maxHeight: 5
            });
        }
        if("${param.areaId}" != ""){
            var data = "";
            var areaId = "${param.areaId}";
            switch (areaId.length) {
                case 2:
                    data = "provinces="+areaId;
                    break;
                case 4:
                    data = "citys="+areaId;
                    break;
                case 6:
                    data = "countys="+areaId;
                    break;
            }
            if(data != ""){
                getMine(data);
            }
        }

        $("[data-toggle='popover']").popover();
        $(".map_title,.mapToolbar").addClass("on");
        $(".nav_btn_icon").click();
    })

    //处理按钮缩进
    $(".nav_btn_icon").click(function () {
        var _this = $(this);
        if (_this.parents(".nav").hasClass("on")) {
            _this.removeClass("on");
            _this.parents(".nav").removeClass("on");
            _this.siblings(".nav_btn_title").removeClass("on");
            _this.find("i").attr("class", "fa fa-angle-double-left");
        } else {
            _this.addClass("on");
            _this.parents(".nav").addClass("on");
            _this.siblings(".nav_btn_title").addClass("on");
            _this.find("i").attr("class", "fa fa-angle-double-right");
        }
    })

    //打开资源目录子菜单
    $(".nav").on("click", ".nav_menu_item_title", function () {
        var _this = $(this);
        getSubGisMenu(_this); //获取子菜单
    })

    //全选与全部选
    $(".allCheckbox").click(function(){
        var _this = $(this);
        if (_this.prop("checked")) {
            _this.parents(".nav_tab").find("[type='checkbox']").prop("checked", true);
        } else {
            _this.parents(".nav_tab").find("[type='checkbox']").prop("checked", false);
        }
    });
    

    $(".nav").on("click", "[type='checkbox']", function (e) {
        e.stopPropagation();
        var _this = $(this);
        //设置全选
        if (_this.prop("checked")) {
            _this.parents(".nav_menu_item_title").next(".nav_menu_subitem").find("[type='checkbox']").prop("checked", true);
        } else {
            _this.parents(".nav_menu_item_title").next(".nav_menu_subitem").find("[type='checkbox']").prop("checked", false);
        }
    })

    var page_Id = 0, report_Id = 0, block_Type = 51;

    //获取子菜单菜单元素
    function getSubGisMenu(elem) {
        var type = $(elem).attr("type");
        if(block_Type == 0 && type < 5){
            alert("请先选择图表展示类型");
            return;
        } else if(block_Type == 51){
            $("#article").css("display", "block");
            $('#article').readmore({
                speed: 5,
                maxHeight: 5
            });
        }
        var pageId = $(elem).attr("data-id");//$("input[name='form']:checked").val();
        var reportId = $(elem).attr("data-id"); //$(".report:checked").val();
        //判断是否有子菜单
        if(type == 2 && typeof(pageId) == "undefined"){
            alert("请先选择表单");
            return;
        }
        if(type == 3 && typeof (reportId) == "undefined"){
            alert("请先选择表单");
            return;
        }
        if(type == 3){
            pageId = $(elem).attr("page-id");
        }
        if(type < 4){
            page_Id = pageId;
            report_Id = reportId;
        }
        //关闭子菜单
        if (elem.hasClass("on")) {
            elem.removeClass("on");
            return;
        } else {
            //打开子菜单
            elem.addClass("on");
            $(elem).parent(".nav_menu_item").siblings().find(".nav_menu_item_title").removeClass("on")
        }
        if(type >= 4){
            if(type > 50){
                $(elem).parent(".nav_menu_item").siblings().find(".nav_menu_item_title").removeAttr("style");
                $(elem).css("color", "#ff0");
                block_Type = $(elem).attr("type");
            }
            return;
        }
        //判断是否为获取行政区域下拉
        if (elem.attr("data-url") == "district") {
            var district = elem.attr("data-district") == undefined ? "province" : elem.attr("data-district");
            var areaNum = $(elem).attr("data-id");
            switch (district) {
                case 'province':
                    getProvince(elem); //获取省
                    break;
                case 'city':
                    getCity(elem, areaNum);//获取市
                    break;
                case 'county':
                    getCounty(elem, areaNum);//获取县区
                    break;
            }
        } else {
            $.ajax({
                type: "GET",
                url: "rest/bi/BIDesignFormController/biEleList",
                data: {
                    type: type,
                    pageId: pageId,
                    screenIndex: 1,
                    reportId: reportId
                },
                dataType: "json", //返回数据形式为json
                success: function (res) {
                    if (res.code == 0) {
                        if(type == 3){
                            res.data = res.data.results;
                        }
                        $(elem).next(".nav_menu_subitem").empty()
                        if (res.data != null && res.data.length > 0) {
                            var flag = true; //只有有一个子菜单有子元素，就为false;
                            for (var i = 0; i < res.data.length; i++) {
                                var icon = ""; //是否显示下拉箭头
                                var checked = ''; //是否显示多选框
                                var defaultChecked = "";
                                var redioOrCheck = "checkbox";
                                //判断是否有子元素
                                if (!res.data[i].childMenu) {
                                    flag = false;
                                    icon = 'visibility:hidden;';
                                } else {
                                    checked = 'visibility:hidden;';
                                }

                                var dom = '';
                                if (type == 1) {
                                    let showF = false;
                                    redioOrCheck = "radio";
                                    if((block_Type == 52 || block_Type == 53) && (res.data[i].page_Url == "bi/biLargeScreen" || res.data[i].page_Url == "bi/biFlowLayoutTemplate")){
                                        showF = true;
                                    } else if(block_Type == 51 && res.data[i].page_Url == "bi/biReportTemplate") {
                                        showF = true;
                                    } else if (block_Type == 54 && res.data[i].page_Url == "bi/biEchartsTemplate"){
                                        showF = true;
                                    } else if (block_Type == 55 && res.data[i].page_Url == "bi/biLargeScreen"){
                                        showF = true;
                                    }
                                    if(showF){
                                        dom = '<div class="nav_menu_item">' +
                                            '<div class="nav_menu_item_title" type="2" data-id="' + res.data[i].bi_Page_Id + '" page_Type="' + res.data[i].page_Type + '">' +
                                            '<i class="fa fa-angle-right"></i>'+
                                            '<i class="fa fa-angle-right" style="' + icon + '"></i>' +
                                            '<span title="' + res.data[i].page_Name + '">' + res.data[i].page_Name + '</span>' +
                                            '</div>' +
                                            '<div class="nav_menu_subitem"></div>' +
                                            '</div>';
                                    }
                                } else if (type == 2) {
                                    if(block_Type == 51) {
                                        reportNameTitle = $(elem).find("span").text();
                                        getList(0, 0);
                                    }
                                    dom = '<div class="nav_menu_item">' +
                                        '<div class="nav_menu_item_title" type="3" page-id="'+ res.data[i].page_Id +'" data-id="' + res.data[i].report_Id + '">' +
                                        '<i class="fa fa-angle-right" style="' + icon + '"></i>' +
                                        '<input type="' + redioOrCheck + '" class="report" value="' + res.data[i].report_Id + '" id="report' + res.data[i].report_Id + '" ' + defaultChecked + ' display="0" style="' + checked + 'margin-right: 10px;" onclick="displayReportChange(this)">' +
                                        '<span title="' + res.data[i].report_Name + '">' + res.data[i].report_Name + '</span>' +
                                        '</div>' +
                                        '<div class="nav_menu_subitem"></div>' +
                                        '</div>';
                                } else if (type == 3) {
                                    if(block_Type == 52 || block_Type == 53){
                                        getReportData();
                                    } else if (block_Type == 54){
                                        getEcharts();
                                    } else if (block_Type == 55){

                                    }
                                    if(res.data[i].display == 1){
                                        defaultChecked = "checked=\"checked\"";
                                    }
                                    if(1 == res.data[i].field_Location){ //行维
                                        dom = '<div class="nav_menu_item">' +
                                            '<div class="nav_menu_item_title" type="4" report-field-id="'+ res.data[i].report_Field_Id +'" page-id="'+ res.data[i].page_Id +'" data-id="' + res.data[i].report_Id + '">' +
                                            '<i class="fa fa-angle-right" style="' + icon + '"></i>' +
                                            '<input type="' + redioOrCheck + '" class="report" value="' + res.data[i].field_Id + '" ' + defaultChecked + ' style="' + checked + 'margin-right: 10px;" display="'+res.data[i].display+'" onchange="displayChange(this)">' +
                                            '<span title="' + res.data[i].field_Name + '(行维)">' + res.data[i].field_Name + '(行维)</span>' +
                                            '</div>' +
                                            '<div class="nav_menu_subitem"></div>' +
                                            '</div>';
                                    }else if(2 == res.data[i].field_Location){ //列维
                                        if(res.data[i].field_Name.indexOf("年") > -1){
                                            defaultChecked += " disabled='disabled' ";
                                        }
                                        dom = '<div class="nav_menu_item">' +
                                            '<div class="nav_menu_item_title" type="4" report-field-id="'+ res.data[i].report_Field_Id +'" page-id="'+ res.data[i].page_Id +'" data-id="' + res.data[i].report_Id + '">' +
                                            '<i class="fa fa-angle-right" style="' + icon + '"></i>' +
                                            '<input type="' + redioOrCheck + '" class="report" value="' + res.data[i].field_Id + '" ' + defaultChecked + ' style="' + checked + 'margin-right: 10px;" display="'+res.data[i].display+'" onchange="displayChange(this)">' +
                                            '<span title="' + res.data[i].field_Name + '(列维)">' + res.data[i].field_Name + '(列维)</span>' +
                                            '</div>' +
                                            '<div class="nav_menu_subitem"></div>' +
                                            '</div>';
                                    }else if(3 == res.data[i].field_Location){ //指标
                                        var name = "zhibiao"+res.data[i].report_Field_Id;
                                        if(block_Type == 51){
                                            redioOrCheck = "radio";
                                            name = "zhibiao";
                                            if(i != 0)
                                                defaultChecked = "";
                                        }
                                        dom = '<div class="nav_menu_item">' +
                                            '<div class="nav_menu_item_title" type="4" report-field-id="'+ res.data[i].report_Field_Id +'" page-id="'+ res.data[i].page_Id +'" data-id="' + res.data[i].report_Id + '">' +
                                            '<i class="fa fa-angle-right" style="' + icon + '"></i>' +
                                            '<input type="' + redioOrCheck + '" name="'+name+'" class="report" value="' + res.data[i].field_Id + '" ' + defaultChecked + ' style="' + checked + 'margin-right: 10px;" display="'+res.data[i].display+'" onchange="displayChange(this)">' +
                                            '<span title="' + res.data[i].field_Name + '(指标)">' + res.data[i].field_Name + '(指标)</span>' +
                                            '</div>' +
                                            '<div class="nav_menu_subitem"></div>' +
                                            '</div>';
                                    }
                                }
                                $(elem).next(".nav_menu_subitem").append(dom);
                                if (!flag) {
                                    $(elem).find("[type=checkbox]").attr("style", " ");
                                }
                            }

                            //判断所有有子菜单的菜单是否都有了子菜单
                            var flag2 = true;
                            $(elem).parents(".nav_menu_subitem").find("[child=true]").each(function () {
                                if ($(this).next(".nav_menu_subitem").find("div").length == 0) {
                                    flag2 = false;
                                }
                            })
                            //若都有了子菜单，显示父级多选按钮
                            if (flag2) {
                                $(elem).parents(".nav_menu_subitem").prev(".nav_menu_item_title").find("[type=checkbox]").attr("style", " ");
                            }

                        } else {
                            alert("此节点下无数据");
                        }
                    }
                }
            });
        }
    }

    //省获取
    function getProvince(elem) {
        $.ajax({
            type: "post",
            url: "rest/monitor/monitorSignMineController/getProCityCounty",
            data: "dicareaflag=1",
            dataType: "json",
            success: function (res) {
                var isChecked = '';
                //如果该tab标题为选中状态，那么下面全选
                if($(elem).parents(".nav_tab").find(".allCheckbox").prop("checked")){
                    isChecked = 'checked';
                }
                for (var i = 0; i < res.data.length; i++) {
                    var dom = '<div>' +
                        '<div class="nav_menu_item_title" data-url="district" data-district="city" data-id="' + res.data[i].areap + '" child="true">' +
                        '<i class="fa fa-angle-right"></i>' +
                        '<input type="checkbox" name="provinces" value="' + res.data[i].areap + '" '+ isChecked +'> ' +
                        '<span title="' + res.data[i].province + '">' + res.data[i].province + '</span>' +
                        '</div>' +
                        '<div class="nav_menu_subitem"></div>' +
                        '</div>';
                    $(elem).next(".nav_menu_subitem").append(dom);
                }
            }
        });
    }

    // 根据省取得市
    function getCity(elem, areaNum) {
        $.ajax({
            type: "post",
            url: "rest/monitor/monitorSignMineController/getProCityCounty",
            data: "dicareaflag=2&Area_Num=" + areaNum,
            dataType: "json", //返回数据形式为json
            success: function (res) {
                $(elem).find("input").val("");
                $(elem).find("input").attr("name","");
                var isChecked = '';
                if($(elem).find("input").prop("checked")){
                    isChecked = 'checked';
                }
                for (var i = 0; i < res.data.length; i++) {
                    var dom = '<div>' +
                        '<div class="nav_menu_item_title" data-url="district" data-district="county" data-id="' + res.data[i].areac + '" child="true">' +
                        '<i class="fa fa-angle-right"></i>' +
                        '<input type="checkbox" name="citys" value="' + res.data[i].areac + '" '+ isChecked +'> ' +
                        '<span title="' + res.data[i].city + '">' + res.data[i].city + '</span>' +
                        '</div>' +
                        '<div class="nav_menu_subitem"></div>' +
                        '</div>';
                    $(elem).next(".nav_menu_subitem").append(dom);
                }
            }
        });
    }

    // 根据省取得市
    function getCounty(elem, areaNum) {
        $.ajax({
            type: "post",
            url: "rest/monitor/monitorSignMineController/getProCityCounty",
            data: "dicareaflag=3&Area_Num=" + areaNum,
            dataType: "json", //返回数据形式为json
            success: function (res) {
                $(elem).find("input").val("");
                $(elem).find("input").attr("name","");
                var isChecked = '';
                if($(elem).find("input").prop("checked")){
                    isChecked = 'checked';
                }
                for (var i = 0; i < res.data.length; i++) {
                    var dom = '<div>' +
                        '<div class="nav_menu_item_title" data-url="district" data-district="county" data-id="' + res.data[i].areax + '" child="false">' +
                        '<i class="fa fa-angle-right" style="visibility:hidden"></i>' +
                        '<input type="checkbox" name="countys"value="' + res.data[i].areax + '" '+ isChecked +'>' +
                        '<span title="' + res.data[i].county + '">' + res.data[i].county + '</span>' +
                        '</div>' +
                        '<div class="nav_menu_subitem"></div>' +
                        '</div>';
                    $(elem).next(".nav_menu_subitem").append(dom);
                }
            }
        });
    }

    //echarts
    function areaEcharts(result) {
        $("#show").html("<div id=\"box\" style=\"height: 98%; width: 98%; margin-left: 10px; text-align: center;\"></div>");
        if(JSON.stringify(result) != "{}") {
            var myChart = echarts.init(document.getElementById("box"));
            var option = {
                title: {
                    text: '',
                    x: 'center',
                    y: 0,
                    textStyle: {
                        color: "#000",
                        fontWeight: 'normal',
                        fontSize: 16
                    }
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: { // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                    },
                    formatter: function(params) {
                        var res = params[0].name;
                        for(var i = 0; i < params.length; i++) {
                            var decimal = "";
                            if(String(params[i].value).indexOf('.') > -1) {
                                decimal = Number(params[i].value).toFixed(3)
                            } else {
                                decimal = params[i].value;
                            }
                            res += '<br/>' + params[i].marker + params[i].seriesName + ' : ' + decimal + ' / ' + result.yAxisNmae[i];
                        }
                        return res;
                    },
                    position: function(pos, params, dom, rect, size) {
                        // 鼠标在左侧时 tooltip 显示到右侧，鼠标在右侧时 tooltip 显示到左侧。
                        var obj = {
                            top: 60
                        };
                        obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 5;
                        return obj;
                    }
                },
                dataZoom: [{
                    show: true,
                    realtime: true,
                    start: 0,
                    end: 100,
                    height: 24,//组件高度
                    bottom:0
                }],
                legend: {
                    top: "3%",
                    data: [],
                    textStyle: {
                        color: "#000"
                    }
                },
                grid: {
                    left: '2%',
                    right: '0',
                    bottom: '6%',
                    containLabel: true
                },
                xAxis: [{
                    type: 'category',
                    name: '',
                    data: [],
                    axisLabel: {
                        color: "#000"
                    }
                }],
                yAxis: [{
                    type: 'value',
                    axisLabel: {
                        color: "#000"
                    }
                }],
                series: []
            };
            option.title.text = result.title; //图表标题
            option.xAxis[0].data = result.xAxisData; //赋值X轴
            option.series = result.seriess; //图表数据series对象
            option.legend.data = result.legendData; //图例
            option.xAxis[0].name = result.xAxisName; //X轴名称
            option.yAxis = result.yAxis;
            myChart.setOption(option);
            $(window).resize(function() {
                myChart.resize();
            })
        }
    }

    //图表数据对象
    function getData(resultData) {
        var result = {
            title: '',
            xAxisName: '',
            yAxisNmae: [],
            legendData: [],
            xAxisData: [],
            seriess: [],
            yAxis: []
        }
        var data,dimField,topicField,topicFieldName,reportInfo,unit,blockType;
        for (var i = 0; i < resultData.data.length; i++) {
            if(resultData.data[i]["reportInfo"].report_Id == report_Id){
                var obj = resultData.data[i]; //当前数据对象
                data = obj["data"],//数据
                    dimField = obj["dimHeader"],//X坐标map对象名称
                    topicField = obj["topicField"],// Y坐标map对象名称
                    topicFieldName = obj["topicFieldName"], // 数据汉字名称
                    reportInfo = obj["reportInfo"], //数据对象
                    unit = obj["unit"], //单位
                    blockType = 1;
            }
        }

        //获取title
        result.title = reportInfo.report_Title;

        //处理x轴
        for(var x = 0; x < data.length; x++) {
            result.xAxisData.push(data[x][dimField[0]]);
        }

        //处理y轴
        for(var y = 0; y < topicField.length; y++) {
            let yaxis = {
                type: 'value',
                name: '',
                position: 'left',
                axisLabel: {
                    formatter: '{value} 个'
                }
            };
            let series = {
                name: '',
                type: 'bar',
                data: []
            }
            if(block_Type == 52)
                series.type = "bar";
            else if(block_Type == 53)
                series.type = "line";
            //Y轴数值
            for(var i = 0; i < data.length; i++) {
                series.data.push(data[i][topicField[y]]);
            }

            yaxis.name = topicFieldName[y];
            yaxis.axisLabel.formatter = "{value} "+unit[y];
            result.yAxisNmae.push(unit[y]);

            //Y轴数值name
            series.name = topicFieldName[y];
            result.legendData.push(topicFieldName[y]);
            if(topicField.length > 1 && y > 0){
                yaxis.position = "right";
                series.yAxisIndex = y;
            }
            result.yAxis.push(yaxis);
            result.seriess.push(series);
        }
        return result;
    }
    var keys=[],values=[];
    var drill_Name, drill_Value;
    //柱状图、折线图
    function getReportData() {
        keys = [];
        values = [];
        var index = loading.start("#1c6bab");
        var data={
            bi_Page_Id: page_Id,
            screen_Index: 1,
            block_Id: 0,
            key:keys,
            value:values,
            block_Type: block_Type,
            drill_Name: drill_Name,
            drill_Value: drill_Value
        };
        $.ajax({
            type: "post",
            url: "/Bi/getReportData",
            data:JSON.stringify(data),
            contentType:'application/json;charset=utf-8',
            dataType: "json",
            success: function(result) {
                areaEcharts(getData(result));
                loading.stop(index);
            },
            error: function() {
                layer.close(index);
            }
        });
    }

    /***
     * 多维饼图
     */
    function getEcharts() {
        getPie();
        getMuitlDimPie();
    }

    function getMuitlDimPie(){
        var keys = [], values = [];
        var drill_Name, drill_Value;
        var data = {
            bi_Page_Id: page_Id,
            screen_Index: 1,
            key: keys,
            value: values,
            block_Type: 0,
            block_Id: 0,
            drill_Name: drill_Name,
            drill_Value: drill_Value
        };
        $.ajax({
            type: "post",
            url: "/Bi/getReportData",
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function(result) {
                var scource = result.data[0].data;
                if(result.data.length > 0){
                    var type = {}; // 内部对象
                    var yearType = {}; //外部对象
                    var types = []; //用于存放内部对象KEY
                    var yearTypes = []; //用于存放内部对象KEY
                    //检测是否为单维数据，单维就不进行展示多维饼图，采用饼图
                    for (var i = 0; i < result.data.length; i++) {
                        if(result.data[i].reportInfo.report_Id == report_Id){
                            if(result.data[i].dimField.length <= 1){
                                return;
                            }
                        }
                    }
                    $("#show").html("<div id=\"box\" style=\"height: 98%; width: 98%; margin-left: 10px; text-align: center;\"></div>");
                    var index = loading.start("#1c6bab");
                    var myChart = echarts.init(document.getElementById("box"), "halloween");
                    var option = {
                        tooltip: {
                            trigger: 'item',
                            formatter: "{b} <br/> {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            x: 'left',
                            data: []
                        },
                        series: [{
                            name: '',
                            type: 'pie',
                            selectedMode: 'single',
                            radius: [0, '25%'],

                            label: {
                                normal: {
                                    position: 'inner'
                                }
                            },
                            labelLine: {
                                normal: {
                                    show: false
                                }
                            },
                            data: []
                        },
                            {
                                name: '',
                                type: 'pie',
                                radius: ['33%', '45%'],
                                label: {
                                    normal: {
                                        formatter: '{b|{b}} \n  {c}  {per|{d}%}  ',
                                        backgroundColor: 'rgba(0,0,0,.8)',
                                        borderColor: '#aaa',
                                        padding: [2, 4],
                                        borderWidth: 1,
                                        borderRadius: 4,
                                        rich: {
                                            a: {
                                                color: '#999',
                                                lineHeight: 22,
                                                align: 'center'
                                            },
                                            hr: {
                                                borderColor: '#aaa',
                                                width: '100%',
                                                borderWidth: 0.5,
                                                height: 0
                                            },
                                            b: {
                                                align: 'center',
                                                lineHeight: 22,
                                                fontSize: 16,
                                                lineHeight: 33
                                            },
                                            per: {
                                                color: '#eee',
                                                backgroundColor: '#334455',
                                                padding: [2, 4],
                                                borderRadius: 2
                                            }
                                        }
                                    }
                                },
                                data: []
                            }
                        ]
                    };
                    for(var i = 0; i < scource.length; i++) {
                        //如果type中没有该Key，则新建
                        if(typeof type[scource[i].economic_type_nm] == "undefined") {
                            //创建对象中的KEY
                            type[scource[i][result.data[0].dimField[1]]] = Number(scource[i][result.data[0].topicField[0]])
                            //将key存入数组
                            types.push(scource[i].economic_type_nm)
                        } else {
                            //如果有，取出来，+=
                            type[scource[i][result.data[0].dimField[1]]] += Number(scource[i][result.data[0].topicField[0]])
                        }
                    }

                    //求各类型中每年占比
                    for(var i = 0; i < scource.length; i++) {
                        //如果yearType中没有该Key，则新建
                        if(typeof yearType[scource[i].economic_type_nm + "-" + scource[i].survey_year] == "undefined") {
                            //创建对象中的KEY
                            yearType[scource[i][result.data[0].dimField[1]] + "-" + scource[i][result.data[0].dimField[0]]] = Number(scource[i][result.data[0].topicField[0]])
                            //将key存入数组
                            yearTypes.push(scource[i][result.data[0].dimField[1]] + "-" + scource[i][result.data[0].dimField[0]])
                        } else {
                            //如果有，取出来，+=
                            type[scource[i][result.data[0].dimField[1]] + "-" + scource[i][result.data[0].dimField[0]]] += Number(scource[i][result.data[0].topicField[0]])
                        }
                    }
                    //对数组进行排序
                    types = types.sort();
                    yearTypes = yearTypes.sort();
                    option.legend.data = types.concat(yearTypes);

                    //从数组中取出KEY
                    for(var i = 0; i < types.length; i++) {
                        var obj = {
                            value: type[types[i]],
                            name: types[i],
                            selected: true
                        }
                        option.series[0].data.push(obj)
                    }

                    for(var i = 0; i < yearTypes.length; i++) {
                        var obj = {
                            value: yearType[yearTypes[i]],
                            name: yearTypes[i]
                        }
                        option.series[1].data.push(obj)
                    }

                    myChart.clear();
                    myChart.setOption(option);
                    $(window).resize(function() {
                        myChart.resize();
                    })
                }
                loading.stop(index);
            },
            error: function() {

            }
        });
    }

    function getPie() {
        var keys = [], values = [];
        var drill_Name, drill_Value;
        var data = {
            bi_Page_Id: page_Id,
            screen_Index: 1,
            key: keys,
            value: values,
            block_Type: 0,
            block_Id: 0,
            drill_Name: drill_Name,
            drill_Value: drill_Value
        };
        $.ajax({
            type: "post",
            url: "/Bi/getReportData",
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function(result) {
                if(result.data.length > 0){
                    //检测是否为多维数据，多维就不进行展示饼图，采用多维饼图
                    for (var i = 0; i < result.data.length; i++) {
                        if(result.data[i].reportInfo.report_Id == report_Id){
                            if(result.data[i].dimField.length > 1 && result.data[i].dimHeader.length != 1){
                                return;
                            } else if(result.data[i].dimField.length < 1 && result.data[i].dimHeader.length != 1){
                                alert("请选择维度");
                            }
                        }
                    }
                    $("#show").html("<div id=\"box\" style=\"height: 98%; width: 98%; margin-left: 10px; text-align: center;\"></div>");
                    var index = loading.start("#1c6bab");
                    var myChart = echarts.init(document.getElementById("box"), "halloween");
                    var option = {
                        title : {
                            text: '',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            textStyle: {
                                color: "#000"
                            },
                            data: ['']
                        },
                        series : [
                            {
                                name: '',
                                type: 'pie',
                                radius : '55%',
                                center: ['50%', '60%'],
                                data:[
                                    {value:335, name:''}
                                ],
                                itemStyle: {
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                },
                                label: {
                                    color: "#000"
                                }
                            }
                        ]
                    };
                    var data = getData(result);
                    console.log(data)
                    option.title.text = data.title;
                    option.legend.data = data.xAxisData;
                    for(let i=0; i<data.xAxisData.length; i++){
                        var ops = {
                            value: data.seriess[0].data[i],
                            name: data.xAxisData[i]
                        };
                        option.series[0].data.push(ops);
                    }

                    myChart.setOption(option);
                    $(window).resize(function() {
                        myChart.resize();
                    })
                }
                loading.stop(index);
            },
            error: function() {

            }
        });
    }

    /***
     * 表格展示
     * @param id
     * @param indexs
     */
    var filterNm = {
        survey_year: "调查年份",
        mine_method_nm: "开采方式",
        province: "所属省",
        mine_scale_nm: "矿山规模",
        city: "所属市",
        county: "所属县",
        economic_type_nm: "经济类型",
        production_status_nm: "生产状态",
        minerals_type_name: "矿类",
        minerals_variety_name: "矿种"
    };

    var reportNameTitle = "";
    function getList(id, indexs) {
        if(id == 0 && "${usersession.userId}" == "21844"){
            id = 15;
        }
        keys = [], values = [];
        keys.push("survey_year");
        values.push(2017);
        var index = loading.start("#1c6bab");
        $("#box").html("<h3 id=\"title\" style='margin: 10px;'></h3><button class=\"btn btn-primary btn-sm btn-excel\" id=\"btnExcel\" style=\"margin-right:10px;\">导出Excel</button>" +
            "<table id=\"myTable\" class=\"table table-bordered table-striped table-hover\">\n" +
            "    <thead> " +
            "    </thead> " +
            "    <tbody> " +
            "    </tbody> " +
            "</table> ");
        var drill_Name, drill_Value;
        if((id+"").length == 2){
            drill_Name = "province";
            drill_Value = id;
            p1 = "province";
            p2 = id;
        } else if((id+"").length == 4){
            drill_Name = "city";
            drill_Value = id;
            c1 = "city";
            c2 = id;
        }
        $('.filters').each(function(){
            var idn = this.id;
            if($(this).val() != 0){
                for (var i = 0; i < keys.length; i++) { //避免条件重复
                    if (keys[i].indexOf(idn) > -1) {
                        keys.splice(i, 1);
                        values.splice(i, 1);
                    }
                }
                if(idn == "province" || idn == "city" || idn == "county") {
                    if(idn == "city"){
                        drill_Name = "province";
                        drill_Value = ($(this).val()+"").substring(0, 2);
                        p1 = "province";
                        p2 = ($(this).val()+"").substring(0, 2);
                    }else if(idn == "county"){
                        drill_Name = "city";
                        drill_Value = ($(this).val()+"").substring(0, 4);
                        c1 = "city";
                        c2 = ($(this).val()+"").substring(0, 4);
                    }
                    keys.push("mine_survey_info."+idn);
                    values.push($(this).val());
                } else {
                    if(idn.indexOf("_nm") > -1){
                        idn = " mine_survey_info."+idn.replace("_nm", "");
                    }
                    keys.push(idn);
                    values.push($(this).val());
                }
            }else{
                if(idn.indexOf("_nm") > -1){
                    idn = " mine_survey_info."+idn.replace("_nm", "");
                }
                //values.remove(keys.indexOf(idn));
                //keys.remove(idn);
            }
        });
        var data={
            bi_Page_Id: page_Id,
            screen_Index: 1,
            block_Id: 0,
            key: keys,
            value: values,
            block_Type: 1,
            drill_Name: drill_Name,
            drill_Value: drill_Value
        }
        if(indexs != 0)
            data.index = indexs;
        $.ajax({
            type: "post",
            async: true,
            url: "/Bi/getReportData?type=table",
            data:JSON.stringify(data),
            contentType:'application/json;charset=utf-8',
            dataType: "json",
            success: function(re) {
                $("#box").css("overflow","scroll");
                if(re.data.length > 0){
                    var year = "";
                    for(var i=0; i<keys.length; i++){
                        if(keys[i].indexOf("survey_year") > -1){
                            year = values[keys[i].indexOf("survey_year")] + "年 ";
                        }
                    }
                    if(indexs != 0){
                        $("#title").text(year+"调查"+reportNameTitle+"统计表 （"+re.data[0].unit[0]+"）");
                    }else{
                        $("#title").text(year+reportNameTitle+"（"+re.data[0].unit[0]+"）");
                    }
                    //显示查询条件
                    $("#filter").empty();
                    for(var i=0; i<re.data[0].dimHeader.length; i++){
                        if(re.data[0].dimHeader[i] != "sub_nm"){
                            var hf = '<label class="control-label lab pull-left" '+
                            'style="font-size: 16px;">'+filterNm[re.data[0].dimHeader[i]]+'：</label>'+
                                '<select class="form-control filters pull-left" id="'+re.data[0].dimHeader[i]+'" style="width:160px; float:left;">'+
                                '<option value="0">全部</option>'+
                                '</select>';
                            $("#filter").append(hf);
                            if(re.data[0].dimHeader[i] == "province"){
                                getFilterInfo(re.data[0].dimHeader[i], 0);
                            }else if(re.data[0].dimHeader[i] == "city"){
                                getFilterInfo(re.data[0].dimHeader[i], id);
                            }else if(re.data[0].dimHeader[i] == "county"){
                                getFilterInfo(re.data[0].dimHeader[i], id);
                            }else{
                                getFilterInfo(re.data[0].dimHeader[i], 0);
                            }
                        }
                    }
                    for(var i=0; i<re.data[0].dimField.length; i++){
                        if(re.data[0].dimField[i] != "sub_nm"){
                            var hf = '<label class="control-label lab pull-left" style="' +
                                '    font-size: 16px;">'+filterNm[re.data[0].dimField[i]]+'：</label>'+
                                '<select class="form-control filters pull-left" id="'+re.data[0].dimField[i]+'" style="width:160px; float:left;">'+
                                '<option value="0">全部</option>'+
                                '</select>';
                            $("#filter").append(hf);
                            if(re.data[0].dimField[i] == "province"){
                                getFilterInfo(re.data[0].dimField[i], 0);
                            }else if(re.data[0].dimField[i] == "city"){
                                getFilterInfo(re.data[0].dimField[i], id);
                            }else if(re.data[0].dimField[i] == "county"){
                                getFilterInfo(re.data[0].dimField[i], id);
                            }else{
                                getFilterInfo(re.data[0].dimField[i], 0);
                            }
                        }
                    }

                    $("thead").empty();
                    $("tbody").empty();

                    //准备表头
                    var theadTr = "";
                    var titleTr = "";
                    for(var x = 0;x<re.data[0].dimHeader.length;x++){
                        var theadTh = "";
                        var titleTh = "";
                        //判断有多少列标题，准备多少"<th></th>"
                        for(var y = 0;y<re.data[0].dimField.length;y++){
                            theadTh += "<th style='white-space: nowrap'></th>";
                            titleTh += "<th style='font-size:18px;'>${pageTitle}</th>";
                        }
                        //获取th
                        for(var y = 0;y<re.data[0].dimFieldHeader[x].length;y++){
                            if(typeof(re.data[0].dimFieldHeader[x][y]) === "undefined")
                                tr += "<th></th>"
                            else{
                                var thCon = re.data[0].dimFieldHeader[x][y]+"";
                                if(thCon.indexOf("-") > -1){
                                    if((thCon.split("-")[1]+"").length == 6){
                                        let year = 2017;
                                        if(values.length > 0){
                                            if(keys[0] == "survey_year")
                                                year = values[0];
                                        }
                                        theadTh += "<th title='"+thCon.split("-")[0]+"'><a class='sla' target='_blank' href='rest/mgeids/mgeidsMineInfoListController?county="+thCon.split("-")[1]+"&year="+year+"'>" + thCon.split("-")[0]+"</a></th>";
                                    }else{
                                        theadTh += "<th title='"+thCon.split("-")[0]+"'><a class='sla' href='javascript:getList("+thCon.split("-")[1]+")'>"+ thCon.split("-")[0] +"</a></th>";
                                    }
                                }else
                                    theadTh += "<th title='"+thCon+"'><span class='sla'>"+ thCon +"</span></th>";
                            }
                            titleTh += "<th style='font-size:18px;'>${pageTitle}</th>";
                        }
                        var heji = "";
                        if(x == 0)
                            heji = "<th>合计</th>";
                        else
                            heji = "<th></th>";
                        theadTr +="<tr>"+ theadTh+heji+"</tr>";
                    }
                    titleTr +="<tr>"+ titleTh +"</tr>";
                    $("thead").append(theadTr);
                    //准备内容
                    for (var z = 0; z < re.data.length; z++) {
                        $("#report"+re.data[z].reportInfo.report_Id).attr("checked", "checked");
                        $("#report"+re.data[z].reportInfo.report_Id).attr("display", "1");
                        $("#report"+re.data[z].reportInfo.report_Id).attr("block_Id", re.data[z].blockInfo.block_Id);
                        var smallTotal = new Array(), reSmallTotal = new Array();
                        var allRows = re.data[z].dimField.length + re.data[z].dimFieldHeader[re.data[z].dimFieldHeader.length-1].length;
                        for(var i = 0; i < re.data[z].tableData.length; i++){ //数据
                            var tr = "<tr>";  //总
                            var heji = 0, flag = 0;
                            for(var j = 0; j < allRows; j++){ //数据
                                if(typeof(re.data[z].tableData[i][j]) === "undefined"){
                                    tr += "<td></td>";
                                } else {
                                    var tdCon = re.data[z].tableData[i][j];
                                    if(tdCon.indexOf("-") > -1){
                                        if((tdCon.split("-")[1]+"").length == 6){
                                            let year = 2017;
                                            if(values.length > 0){
                                                if(keys[0] == "survey_year")
                                                    year = values[0];
                                            }
                                            tr += "<td><a target='_blank' href='rest/mgeids/mgeidsMineInfoListController?county="+tdCon.split("-")[1]+"&year="+year+"'>" + tdCon.split("-")[0]+"</a></td>";
                                        }else{
                                            tr += "<td><a href='javascript:getList("+tdCon.split("-")[1]+")'>"+ tdCon.split("-")[0] +"</a></td>";
                                        }
                                    }else{
                                        if(j > re.data[z].dimField.length-1){
                                            tr += "<td class='txtRight'>"+tdCon+"</td>";
                                        } else{
                                            tr += "<td>"+tdCon+"</td>";
                                        }
                                        var dl = re.data[z].dimField.length;
                                        if(j >= dl){
                                            if(!isNaN(parseInt(tdCon)) || !isNaN(parseInt(tdCon))){
                                                if((tdCon+"").indexOf(".")==-1){
                                                    heji += parseInt(tdCon);
                                                }else{
                                                    heji += parseFloat(tdCon);
                                                }
                                                if(i == 0){  //小计计算
                                                    smallTotal.push(Number(tdCon));
                                                }else{
                                                    smallTotal[j-dl] = smallTotal[j-dl]+parseInt(tdCon);
                                                }
                                            }else{
                                                if(i == 0){
                                                    smallTotal.push(0);
                                                }else{
                                                    smallTotal[j-dl] = smallTotal[j-dl]+0;
                                                }
                                            }
                                            flag = 1;
                                        }
                                    } //else -
                                }  //undefinal else
                            } //for 数据
                            if(flag == 1)
                                tr += "<td class='txtRight'>"+heji+"</td>";
                            $("tbody").append(tr);
                        }
                        //追加小计dom元素
                        var stTr = "<tr class='smallTotal'>";
                        for(var idim = 0; idim<re.data[z].dimField.length; idim++){
                            if(idim == re.data[z].dimField.length-1)
                                stTr += "<td>小计("+re.data[z].reportInfo.report_Title+")</td>";
                            else
                                stTr += "<td></td>";
                        }
                        var stotal = 0;
                        for(var ii = 0; ii<smallTotal.length; ii++){
                            if(String(smallTotal[ii]).indexOf('.')>-1)
                                smallTotal[ii] = smallTotal[ii].toFixed(6);
                            stTr += "<td class='txtRight'>"+smallTotal[ii]+"</td>";
                            if(!isNaN(tdCon)){
                                if((smallTotal[ii]+"").indexOf(".")==-1){
                                    stotal+=parseInt(smallTotal[ii]);
                                }else{
                                    stotal+=parseFloat(smallTotal[ii]);
                                }
                            }
                        }
                        if(String(smallTotal[ii]).indexOf('.')>-1)
                            stotal = stotal.toFixed(6);
                        stTr += "<td class='txtRight'>"+stotal+"</td>";  //小计的合计
                        stTr += "</tr>";
                        $("tbody").append(stTr);
                    }  //追加表格身体
                    //合并单元格
                    colspan("#myTable thead");
                    for(var x=0; x<re.data[0].dimField.length; x++)
                        rowspan("#myTable", x);
                }
                loading.stop(index);
                var $exportLink = document.getElementById('btnExcel');
                $exportLink.addEventListener('click', function(e){
                    var myDate = new Date();
                    var time = myDate.toLocaleDateString(); //获取完整的年份(4位,1970-????)
                    e.preventDefault();
                    tableExport('myTable', $("#title").text()+time+"_"+myDate.getSeconds(), "xls", $("#title").text());
                }, false);
            },
            error: function() {
            }
        });
    }

    //函数说明：合并指定表格（表格id为_w_table_id）指定列（列数为_w_table_colnum）的相同文本的相邻单元格
    //参数说明：_w_table_id 为需要进行合并单元格的表格的id。如在HTMl中指定表格 id="data" ，此参数应为 #data
    //参数说明：_w_table_colnum 为需要合并单元格的所在列。为数字，从最左边第一列为1开始算起。
    function rowspan(_w_table_id, _w_table_colnum) {
        _w_table_firsttd = "";
        _w_table_currenttd = "";
        _w_table_SpanNum = 0;
        _w_table_Obj = $(_w_table_id + " tr *:nth-child(" + _w_table_colnum + ")");
        _w_table_Obj.css("text-align", "center")
        _w_table_Obj.each(function(i) {
            if(i == 0) {
                _w_table_firsttd = $(this);
                _w_table_SpanNum = 1;
            } else {
                _w_table_currenttd = $(this);
                if(_w_table_firsttd.text() == _w_table_currenttd.text()) {
                    _w_table_SpanNum++;
                    _w_table_currenttd.hide(); //remove();
                    _w_table_firsttd.attr("rowSpan", _w_table_SpanNum);
                    _w_table_firsttd.css("vertical-align", "middle");
                } else {
                    _w_table_firsttd = $(this);
                    _w_table_SpanNum = 1;
                }
            }
        });
    }
    //函数说明：合并指定表格（表格id为_w_table_id）
    function colspan(_w_table_id) {
        _w_table_firsttd = "";
        _w_table_currenttd = "";
        _w_table_SpanNum = 0;
        $(_w_table_id + " tr").each(function(i) {
            _w_table_Obj = $(this).children();
            _w_table_Obj.each(function(i) {
                if(i == 0) {
                    _w_table_firsttd = $(this);
                    _w_table_SpanNum = 1;
                } else {
                    _w_table_currenttd = $(this);
                    if(_w_table_firsttd.text() == _w_table_currenttd.text()) {
                        _w_table_SpanNum++;
                        _w_table_currenttd.hide(); //remove();
                        _w_table_firsttd.attr("colSpan", _w_table_SpanNum);
                    } else {
                        _w_table_firsttd = $(this);
                        _w_table_SpanNum = 1;
                    }
                }
            });
        });
    }

    function displayChange(obj){
        let then = $(obj), dis;
        if(block_Type == 51 && then.attr("type") != "checkbox") {
            getList(0, then.val());
            return;
        }
        if(Number(then.attr("display")) == 1){
            dis = 0;
        }else{
            dis = 1;
        }
        $.ajax({
            type: "post",
            url: "rest/bi/biReportFieldController/updateReportField",
            data: {
                "report_Field_Id": then.parent().attr("report-field-id"),
                "display": dis,
                "report_Id": then.parent().attr("data-id")
            },
            dataType: "json",
            success: function(result){
                if(then.attr("display") == 1) {
                    then.attr("display", 0);
                } else {
                    then.attr("display", 1);
                }
                if(block_Type == 52 || block_Type == 53) {
                    getReportData();
                } else if (block_Type == 54) {
                    getEcharts();
                } else if (block_Type == 55) {

                } else if (block_Type == 51 && then.attr("type") == "checkbox") {
                    getList(0, 0);
                }
            }, error: function(error, info){
                then.attr("checked", "checked");
                alert("保存出错");
            }
        });
        /*
        *  else if(block_Type == 51) {
                    // var radios = $("input[name=zhibiao]");
                    // for(let i=0; i<radios.length; i++){
                    //     console.log($($("input:radio[name='zhibiao']")[i]).parent().attr("data-id"));
                    //     console.log($($("input:radio[name='zhibiao']")[i]).attr("checked"));
                    // }
                    getList(0, then.val());
                }
        *
        *
        * */
    }

    function displayReportChange(obj){
        let then = $(obj), dis = Number(then.attr("display")), param = {};
        if(dis == 1){
            param.blockId = [];
            param.blockId[0] = then.attr("block_Id");
            url = "rest/bi/biPageBlockController/deleteBlock";
        } else if(dis == 0) {
            param.block_Id = then.attr("block_Id");//区块ID
            param.x_Point = 1; //区块位置
            param.bi_Page_Id = then.parent().attr("page-id");
            param.block_Type = 1;
            param.screen_Index = 1;
            param.report_Id = then.val();
            url = "rest/bi/biPageBlockController/saveBlock";
        }
        $.ajax({
            type: "post",
            async: false,
            url: url,
            data: param,
            dataType: "json",
            success: function(result) {
                if(result.data == "success"){
                    getList(0, 0);
                }
            }, error: function(error, info){
                then.attr("checked", "checked");
                alert("切换出错,请重新勾选");
            }
        });
    }

    //获取过滤信息
    function getFilterInfo(filterName, areaId) {
        $.ajax({
            type: "GET",
            url: "/Bi/getFilterValue",
            data:{
                filterName: filterName,
                areaId: areaId
            },
            dataType: "json",
            success: function(result) {
                $("#filter"+filterName).empty();
                $("#filter"+filterName).append("<option value='0'>全部</option>");
                if(filterName == "survey_year"){
                    for (var item in result.data) {
                        $("#"+filterName).append("<option value="+result.data[item]+">"+result.data[item]+"</option>");
                    }
                }else{
                    for (var item in result.data) {
                        $("#"+filterName).append("<option value="+result.data[item]+">"+item+"</option>");
                    }
                }
            },
            error: function(error) {
                //console.log(error)
            }
        });
    }

    $("#btnSearch").on("click", function () {
        getList(0);
    });

    /***
     * 左侧菜单栏，显示隐藏方法
     * @author andot
     * @type {boolean}
     */
    var sbflag = true;
    function showHiddenSideBar (obj) {
        if(sbflag){
            $("#show").css("width", "100%");
            $("#nav").css("left", "-260px");
            $(obj).css("left", "10px");
            $(obj).html("<i style='color: #000;' class='fa fa-chevron-right'></i>");
            sbflag = false;
        }else{
            $("#show").css("width", "80%");
            $("#nav").css("left", "0px");
            $(obj).css("left", "230px");
            $(obj).html("<i class='fa fa-chevron-left'></i>");
            sbflag = true;
        }
    }
</script>
</body>

</html>