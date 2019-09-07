<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<title>积成能源-光伏扶贫智能运维云平台</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	    <meta http-equiv="pragma" content="no-cache">
	    <meta http-equiv="cache-control" content="no-cache">
	    <meta http-equiv="expires" content="0">
	    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	    <meta http-equiv="description" content="This is my page">     
	    <link rel="stylesheet" type="text/css" href="plug-in/ace/mui_Style/css/mui.min.css">
	    <script type="text/javascript" src="plug-in/ace/mui_Style/js/mui.min.js"></script>
	    <script type="text/javascript" src="plug-in/ace/assets/js/jquery-1.10.2.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="plug-in/ace/mui_Style/css/topBarBgColor.css">
	</head>
<body>
		<header class="mui-bar mui-bar-nav">
	        <a href="rest/pms/mobileMainController" class="mui-icon mui-icon-back mui-pull-left" style="width:5%;float:left;margin-left:-10px;margin-right:10px;" id="btnReturn"></a>
	        <h1 class="mui-title">已办工作</h1>
<!--	        <a class="mui-icon mui-icon-search mui-pull-right" style="width:10%; margin-right:2%" id="btnSerach"></a>-->
    	</header>
	  	
		<div class="mui-content">
			<!--放置列表项-->
		    <ul class="mui-table-view" id="mainMenu">
		    </ul>
		</div>
		<div class="mui-content-padded">
			<div class="mui-row">
				<div class="mui-col-xs-2 mui-col-sm-2">
					<span style="line-height:30px; height:40px; text-align:center; color:#007aff;">第 <span id="ye">1</span> 页</span>
				</div>
				<div class="mui-col-xs-10 mui-col-sm-10">
					<ul class="mui-pagination" id="ps">
					
					</ul>
				</div>
			</div>
		</div>
	    <script type="text/javascript">
	       //获取待办工作的集合
		   var param={};
		   $(document).ready(function(e){
		   		mui.init();  
		   		param.page = 1;//初始化页码
  			    loadGrid(null);
    		});
			//点击办理
	        function btnHandle(obj){
				//workID//获取id之后传入后台根据workid查询itemid和活动id  然后返回到前台  拿着全部数据填充到里面
				window.open('rest/workflow/workFormAutoController?workID='+$(obj).parent().parent("li")[0].id, 'workflow', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
			}
			//点击查看详情
	        function btnDetail(obj){
				//workID//获取id之后传入后台根据workid查询itemid和活动id  然后返回到前台  拿着全部数据填充到里面
				window.open('rest/workflow/workFormAutoController?workID='+$(obj).parent().parent("li")[0].id, 'workflow', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	        }
	        var pa = 1;
	        //分页页数
	        function fpage(obj){
	        	var a = $(obj).text();
	        	$("#ye").html(a);
	        	if(a.length > 0){
	        		param.page = $(obj).text();//当前页码
	        	}else{
	        		param.page = 1;//初始化页码
	        	}
	        	loadGrid();
	        }
	        
	        //上一页
	        function downPage(){
	        	var a = parseInt($("#ye").html());
	        	a++;
	        	if(a> $("#ps li").length-2) return;
	        	$("#ye").html(a);
	        	if(a > 0){
	        		param.page = a;//当前页码
	        	}else{
	        		param.page = 1;//初始化页码
	        	}
	        	loadGrid();
	        }
	        
	        //下一页
	        function upPage(){
	        	var a = parseInt($("#ye").html());
	        	a--;
	        	if(a < 1) return;
	        	$("#ye").html(a);
	        	if(a > 0){
	        		param.page = a;//当前页码
	        	}else{
	        		param.page = 1;//初始化页码
	        	}
	        	loadGrid();
	        }
	        
	        //加载代办列表
	        function loadGrid(){
	           param.rows =  10;//页面显示记录条数，在页面显示每页显示多少项的时候
               param.start = 1;//开始的记录序号
               //param.page = 1;//当前页码
               param.SystemID = 1;
               $.ajax({
                   type: "POST",
                   url: "rest/workflow/workPersonal/WorkFinish/WorkFinishQuery",
                   cache: false,  //禁用缓存
                   data: param,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   	   var p = Math.ceil(result.total/10);
                   	   $("#ps").html("");
                   	   $("#ps").append('<li class="mui-previous" onclick="upPage()"><a>&laquo;</a></li>');
                   	   for(var i = 0; i<p; i++){
                   	   		if(i == 0){
                   	   			$("#ps").append('<li><a onclick="javascript:fpage(this);">1</a></li>');
                   	   		}else{
                   	   			$("#ps").append('<li><a onclick="javascript:fpage(this);">'+(i+1)+'</a></li>');
                   	   		}
                   	   }
                   	   $("#ps").append('<li class="mui-next" onclick="downPage()"><a>&raquo;</a></li>');
	                   $("#mainMenu").html("");
	                   if(result.data.length < 1){
	                	   $("#mainMenu").append("<div class='mui-row' style='margin-top:50px; align-text:center;'><span class='mui-title' style='color:#3c3c3c;'> 暂 无 工 作</span></div>");
		            		return;
		            	}
	                    for(var i=0;i<result.data.length;i++){
	                   		//$("#mainMenu").append("<li onmousedown=push("+result.data[i].WORK_ID+") id='"+result.data[i].WORK_ID+"' class='mui-table-view-cell' style='height: 68px;width:100%;font-family: 黑体;color:#119AE1;'><label style='color:#119AE1;'>["+result.data[i].WORK_NAME+"]-"+result.data[i].RECEIVER_NAME+"</label><br><label style='color:#165caa;'>"+result.data[i].WORK_ITEM_DATETIME+"</label></li>");
	                   		$("#mainMenu").append('<li class="mui-table-view-cell" id='+result.data[i].WORK_ID+'><div class="mui-slider-right mui-disabled"><a class="mui-btn mui-btn-yellow mui-icon  mui-icon-plus" style="font-size: 18px; padding: 5px;" onclick="javascript:btnHandle(this);">详情</a></div><div class="mui-slider-handle"><div class="mui-table-cell mui-text-left" style="float: left;"><span class="mui-ellipsis" style="font-family: "黑体"; font-size:18px;">['+result.data[i].WORK_NAME+']'+'</span><h5><span style="width: 200px; color: #000000; font-size:14px;">'+result.data[i].WORK_ITEM_DATETIME+'</span></h5></div></div></li>');
	                   } 
	                   mui.init();
                   }
               });
	        } 
     	</script>
	</body>
</html>

