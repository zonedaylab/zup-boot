<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    pageContext.setAttribute("basePath",basePath);
%>

<!DOCTYPE html>
<html>
    <head>
        <base href="<%=basePath%>">
        <title>BI 报表展示</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="BI Show Page">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
        <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
        <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
        <!--  import style	-->
        <script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts.min.js"></script>
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
    </head>
    <body style=" background:#ffffff;">
    <div class="container-fluid" style="height: 100%">
        <div class="row">
            <div class="col-xs-3">
                <div id="main" style="width: 100%; height:400px;">

                </div>
            </div>
            <div class="col-xs-6">
                <div id="main2" style="width: 100%; height:400px;">

                </div>
            </div>
            <div class="col-xs-3">
                <div id="main3" style="width: 100%; height:400px;">

                </div>
            </div>
        </div>
    </div>
    <!--  import javascript	-->
    <script src='plug-in/ace/js/bootstrap-select.min.js'></script>
    <script src='plug-in/ace/bi/js/Blob.js'></script>
    <script src='plug-in/ace/bi/js/FileSaver.js'></script>
    <script src='plug-in/ace/bi/js/tableExport.js'></script>
    <script src="plug-in/layer/layer.js" type="text/javascript" charset="utf-8"></script><!-- layer弹窗 -->
    <script src='plug-in/ace/bi/js/loading.js'></script>
    <script src='plug-in/ace/bi/js/loading.js'></script>
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    </body>
    <script>

    </script>
    <script type="text/javascript">

        var pageid=0, screenIndex=0;
        var definaReport = new Array(); //默认选中报表下拉框
        var loading = new Loading();

        var p1 = "", p2 = 0, c1 = "", c2 = 0, x1 = "", x2 = 0;

        $(document).ready(function() {
            pageid = "${param.pageId}";
            //loading.start("#1c6bab"); //#1c6bab  如果不填写显示白色，填入颜色值，就显示对应颜色
            //var screen = JSON.parse('${param.screen}');
            <%--pageid=${pageId};--%>
            screenIndex=1;
            getReportListByPageId();//获取数据源
            getList();
        });

        //获取报表的指标字段
        // param:  report_id报表Id  by liuxf
        function getDataIndex(report_id){
            $.ajax({
                type: "get",
                async: true,
                url: "rest/bi/biReportFieldController/getReportFieldList?report_Id="+report_id+"&field_Location=3&rows=99999&page=1",
                dataType: "json",
                success: function (re) {
                    $("#dataIndex").empty();
                    for (var i = 0; i <re.data.length ; i++) {
                        $("#dataIndex").append("<option value='"+re.data[i].field_Id+"'>"+re.data[i].field_Name+"</option>");
                    }
                }
            });
        }

        Array.prototype.remove = function(val) {
            var index = this.indexOf(val);
            if (index > -1) {
                this.splice(index, 1);
            }
        };
        var keys = new Array(), values = new Array();  //查询条件
        /*
        * id 表示维度钻取
        * 			例如id=3701，id.length=4,表示济南市，
        * indicators  指标列表
        * */
        function getList(id, indicators) {

            var drill_Name, drill_Value;
            if ((id + "").length == 2) {
                drill_Name = "province";
                drill_Value = id;
                p1 = "province";
                p2 = id;
            } else if ((id + "").length == 4) {
                drill_Name = "city";
                drill_Value = id;
                c1 = "city";
                c2 = id;
            }
            $('.filters').each(function () {
                var idn = this.id;
                if ($(this).val() != 0) {
                    for (var i = 0; i < keys.length; i++) { //避免条件重复
                        if (keys[i].indexOf(idn) > -1) {
                            keys.splice(i, 1);
                            values.splice(i, 1);
                        }
                    }
                    if (idn == "province" || idn == "city" || idn == "county") {
                        if (idn == "city") {
                            drill_Name = "province";
                            drill_Value = ($(this).val() + "").substring(0, 2);
                            p1 = "province";
                            p2 = ($(this).val() + "").substring(0, 2);//省是两个字符
                        } else if (idn == "county") {
                            drill_Name = "city";
                            drill_Value = ($(this).val() + "").substring(0, 4);
                            c1 = "city";
                            c2 = ($(this).val() + "").substring(0, 4);//city 用四个字符
                        }
                        keys.push("mine_survey_info." + idn);
                        values.push($(this).val());
                    }
                }
            });
            drill_Name = id;
            drill_Value = indicators;

            var data = {
                bi_Page_Id: pageid,
                screen_Index: screenIndex,
                block_Id: 0,
                key: keys,
                value: values,
                block_Type: 1,
                drill_Name: drill_Name,
                drill_Value: drill_Value
            }
            $.ajax({
                type:"POST",
                url:"/Bi/getReportData",
                cache: false,  //禁用缓存
                dataType: "json",
                data:JSON.stringify(data),
                contentType:'application/json;charset=utf-8',
                success:function (rs) {
                    console.log(rs);
                    console.log(rs.data[0].reportInfo.report_Name);

                    //div.main中的图表
                    var myChart = echarts.init(document.getElementById('main'));
                    var option = {
                        title: {
                            text: rs.data[0].reportInfo.report_Name
                        },
                        tooltip: {},
                        legend: {
                            data:[rs.data[0].unit[0]]
                        },
                        xAxis: {
                            data: rs.data[0].tableHeader[2]
                        },
                        yAxis: {},
                        series: [{
                            name: rs.data[0].unit[0],
                            type: 'bar',
                            data: rs.data[0].tableHeader[1]
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);

                    //div.main3中的图表
                    var myChart3 = echarts.init(document.getElementById('main3'));
                    var main3Legend = [];  //待整合名称
                    var main3Data = [];  //待整合数据
                    var rsData = rs.data[0].tableHeader[1];   //数据
                    main3Legend[0] = rs.data[0].tableHeader[2][0]; //名字
                    main3Data[0] = parseFloat(rsData[0]);  //数据
                    var ml = true;
                    var k=0;

                    for (var i = 0; i < rs.data[0].tableHeader[0].length; i++) {
                        ml = true;
                        k++;
                        for(var j = 0;j<main3Legend.length;j++){
                            if(main3Legend[j] == rs.data[0].tableHeader[2][i+1]){
                                ml = false;
                                main3Data[j] += parseFloat(rsData[i+1]);
                                k--;
                                break;
                            }
                        }
                        if (ml) {
                            main3Legend[k+1] = rs.data[0].tableHeader[2][i+1];
                            main3Data[k+1] = parseFloat(rsData[i+1]);
                        }
                    }
                    var main3DataName =[];
                    for (var i = 0; i < main3Data.length; i++) {
                        main3DataName[i] = {value: main3Data[i], name: main3Legend[i]}
                    }

                    option3 = {
                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b}: {c} ({d}%)'
                        },
                        legend: {
                            orient: 'vertical',
                            left: 1,
                            data: main3Legend
                        },
                        series: [
                            {
                                name: rs.data[0].unit[0],
                                type: 'pie',
                                radius: ['50%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    show: false,
                                    position: 'center'
                                },
                                emphasis: {
                                    label: {
                                        show: true,
                                        fontSize: '30',
                                        fontWeight: 'bold'
                                    }
                                },
                                labelLine: {
                                    show: false
                                },
                                data: main3DataName
                            }
                        ]
                    };
                    myChart3.setOption(option3);


                }
            });
        }



        //根据pageID获取报表列表（一个页面会有多个报表）
        function getReportListByPageId() {
            $.ajax({
                type: "GET",
                async: false,
                url: "rest/bi/biReportController/getReportListByPageId",
                data:{
                    pageId:'${pageId}',
                    screenIndex: screenIndex
                },
                dataType: "json",
                success: function(result) {
                    for(var i = 0;i<result.data.length;i++){
                        $("#reportList").append("<option value="+result.data[i].report_Id+">"+result.data[i].report_Name+"</option>");
                    }
                },
                error: function(error) {
                    console.log(error)
                }
            });
        }



    </script>
    <script type="text/javascript">
        var myChart2 = echarts.init(document.getElementById('main2'));
        var yearCount = 7;
        var categoryCount = 30;

        var xAxisData = [];
        var customData = [];
        var legendData = [];
        var dataList = [];

        legendData.push('trend');
        var encodeY = [];
        for (var i = 0; i < yearCount; i++) {
            legendData.push((2010 + i) + '');
            dataList.push([]);
            encodeY.push(1 + i);
        }

        for (var i = 0; i < categoryCount; i++) {
            var val = Math.random() * 1000;
            xAxisData.push('category' + i);
            var customVal = [i];
            customData.push(customVal);

            for (var j = 0; j < dataList.length; j++) {
                var value = j === 0
                    ? echarts.number.round(val, 2)
                    : echarts.number.round(Math.max(0, dataList[j - 1][i] + (Math.random() - 0.5) * 200), 2);
                dataList[j].push(value);
                customVal.push(value);
            }
        }

        function renderItem(params, api) {
            var xValue = api.value(0);
            var currentSeriesIndices = api.currentSeriesIndices();
            var barLayout = api.barLayout({
                barGap: '30%', barCategoryGap: '20%', count: currentSeriesIndices.length - 1
            });

            var points = [];
            for (var i = 0; i < currentSeriesIndices.length; i++) {
                var seriesIndex = currentSeriesIndices[i];
                if (seriesIndex !== params.seriesIndex) {
                    var point = api.coord([xValue, api.value(seriesIndex)]);
                    point[0] += barLayout[i - 1].offsetCenter;
                    point[1] -= 20;
                    points.push(point);
                }
            }
            var style = api.style({
                stroke: api.visual('color'),
                fill: null
            });

            return {
                type: 'polyline',
                shape: {
                    points: points
                },
                style: style
            };
        }

        option2 = {
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: legendData
            },
            dataZoom: [{
                type: 'slider',
                start: 50,
                end: 70
            }, {
                type: 'inside',
                start: 50,
                end: 70
            }],
            xAxis: {
                data: xAxisData
            },
            yAxis: {},
            series: [{
                type: 'custom',
                name: 'trend',
                renderItem: renderItem,
                itemStyle: {
                    borderWidth: 2
                },
                encode: {
                    x: 0,
                    y: encodeY
                },
                data: customData,
                z: 100
            }].concat(echarts.util.map(dataList, function (data, index) {
                return {
                    type: 'bar',
                    animation: false,
                    name: legendData[index + 1],
                    itemStyle: {
                        opacity: 0.5
                    },
                    data: data
                };
            }))
        };
        myChart2.setOption(option2);
    </script>
    <script type="text/javascript">


    </script>
</html>