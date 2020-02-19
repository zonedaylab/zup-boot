<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" /> 
		<base href=" <%=basePath%>">
		<title>${ title} 审批过程</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<script src="plug-in/gooflow/jquery.min.js"></script>
		<script src="plug-in/gooflow/GooFunc.js"></script>
    	<link rel="stylesheet" href="plug-in/gooflow/GooFlow.css" type="text/css"></link>
		<script src="plug-in/gooflow/GooFlowWorkflowRight.js"></script>
		<!--        引入外部样式库css        -->
        <jsp:include page="../include/relativeMainHead.jsp"></jsp:include>
	    
	    <!--[if lt IE 9]>
    <?import namespace="v" implementation="#default#VML" ?>
    <![endif]-->
    <script type="text/javascript">
   	var params = {};    
    var property = {
        width: $(window).width(),
        height: $(window).height(),
        toolBtns: ["task", "node", "chat", "state", "plug"],
        haveHead: true,
        headBtns: [], //如果haveHead=true，则定义HEAD区的按钮
        initLabelText: "审批过程",
        haveTool: false,
        useOperStack: false
    };
    var remark = {
    };
    var demo;

    $(document).ready(function () {
        demo = $.createGooFlow($("#demo"), property);
        demo.setNodeRemarks(remark);

        var nodeattribute = {};
        var node = {};
        var arr = {};
        nodeattribute["name"] = "工程测量";
        nodeattribute["left"] = 5;
        nodeattribute["top"] = 80;
        nodeattribute["type"] = "node";
        nodeattribute["state"] = "nodeState.Normal";
        node["node1"] = nodeattribute;
        arr["nodes"] = node;
        arr["title"] = "项目图"


        function showDraw(jsondata) {
            demo.loadData(jsondata);
        }
        function pageInit() {
            var flowID = 0;
            var jsondata;
            var arr = {};
            jsondata = getJsonData(flowID);
            var cs=JSON.stringify(jsondata);
			cs = cs.replace(/\[/g,'');
			cs = cs.replace(/\]/g,'');
			cs = cs.replace(/\}\,\{/g,',');
            arr = eval('(' + cs + ')');
            demo.loadData(arr);
        }
        function getJsonData(flowID) {  
        	params.workID=GetQueryString("workID"); 
            var jsondata=""; 
            $.ajax({
                type: "post",
                cache: false,  //禁用缓存
                async: false,
	            dataType: 'json',
                url: "rest/workflow/WorkHistoryInfo/getWorkHistoryInfo", 
                data:params,
   	            success: function (result) {
   	            	params.title = result.attributes.data
                    jsondata = result.attributes.data;
   	            },
   	            error: function (result) {
   	            	parent.bootbox.alert("数据加载出错", function(){});
   	            }
            });  
            return jsondata;
        }
        $(document).ready(function () {
            pageInit();
            //禁用鼠标右键菜单
            $(document).bind("contextmenu", function (e) { return false; });
            $(".GooFlow_item").bind("mouseenter", function (e) { 
				GetActivityInfo(e.currentTarget.id, e);
			 });
			 $(".GooFlow_item").bind("mouseleave", function (e) { 
				$(".title").css("display", "none");
			 });
        });
    });

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }

     //获取悬浮框信息
     function GetActivityInfo(activityID, e) {
         var dataInfo = "";
         $.ajax({
             type: "post",
             dataType: "json",
             async: false,
             url: "rest/workflow/WorkHistoryInfo/GetActivityInfo",
             data: "activityID="+activityID + "&workID="+GetQueryString("workID"),
             success: function (data)
             {
                 dataInfo= data.data[0];
                 my = e.clientY;
   				 mx = e.clientX;
                 $(".title").css("margin-top", my+15);
                 $(".title").css("margin-left", mx-110);
                 $(".title").css("display", "block");
                 $(".title").html("");
                 if(data.data[0].WORK_ITEM_STATE == 0){
                 	$(".title").css("display", "none");
                 }else{
                 	if(typeof(data.data[0].RECEIVER_NAME)=="undefined"){
                 		$(".title").append("<ul><li style='list-style-type:none; margin-left:-13px; color:#FFFFFF;'>经办人：</li>");
                	}else{
                 		$(".title").append("<ul><li style='list-style-type:none; margin-left:-13px; color:#FFFFFF;'>经办人："+data.data[0].RECEIVER_NAME+"</li>");
                 	}
                 	$(".title").append("<li style='list-style-type:none; color:#FFFFFF;'>经办时间"+data.data[0].WORK_ITEM_DATETIME+"</li></ul>");
                 }
             }
         });
         return dataInfo;
     }
    </script>
    <style type="text/css">
    	*{
	    margin: 0;
	    padding: 0;
    }
    .title{
        width: auto;
        border: 2px solid #137671;
        position: absolute;
        display:none;
        padding:10px;
        z-index:1;
        background-color: #000000;
        opacity: 0.5;
    }
    </style>
    
    </head>
   <body>
    	<div id="demo" style="position: absolute; z-index:-1;">
    	</div>
    	<div class="iconOperate"></div>
    	<div class="title">
		</div>
	</body>
	
</html>
