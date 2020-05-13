<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>ZUP云平台</title>
     <jsp:include page="../include/mainHead.jsp"></jsp:include>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		.img{
			margin:0 auto;
			padding:0;
			height:867px;
			width:1000px;
		}
	</style>
	<style type="text/css">
			/* 定义keyframe动画，命名为blink */
			@keyframes blink{
			  0%{opacity: 1;}
			  50%{opacity: 1;}
			  65.01%{opacity: 0;} /* 注意这里定义50.01%立刻透明度为０，可以设置闪烁效果 */
			  100%{opacity: 0;}
			}
			/* 添加兼容性前缀 */
			@-webkit-keyframes blink {
			    0% { opacity: 1; }
			    50% { opacity: 1; }
			    65.01% { opacity: 0; }
			    100% { opacity: 0; }
			}
			@-moz-keyframes blink {
			    0% { opacity: 1; }
			    50% { opacity: 1; }
			    65.01% { opacity: 0; }
			    100% { opacity: 0; }
			}
			@-ms-keyframes blink {
			    0% { opacity: 1; }
			    50% { opacity: 1; }
			    65.01% { opacity: 0; }
			    100% { opacity: 0; }
			}
			@-o-keyframes blink {
			    0% { opacity: 1; }
			    50% { opacity: 1; }
			    65.01% { opacity: 0; }
			    100% { opacity: 0; }
			}
			/* 定义blink类*/
			.blink{
			    animation: blink .75s linear infinite; 
			    /* 其它浏览器兼容性前缀 */
			    -webkit-animation: blink .75s linear infinite;
			    -moz-animation: blink .75s linear infinite;
			    -ms-animation: blink .75s linear infinite;
			    -o-animation: blink .75s linear infinite;
			    color: #dd4814;
			}
			
		</style>
  </head>
  	
  <body style="overflow-x : hidden ;overflow-y : hidden ;">
  	<div style="margin: 0 auto; width:800px; height:750px;">
  		<img alt="欢迎使用ZUP" src="plug-in\ace\assets\images\huanying.png" style="width:800px; height:800px;">
  	</div>
    
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>   
	<!-- 右下角弹窗开始 -->    
	<script language="JavaScript">
		//弹出消息窗口
		function loadWindowInfo(){

			window.onresize = resizeDiv;
			window.onerror = function(){}
		}
		//短信提示使用(asilas添加)
		var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer,i = 0;
		function getMsg() {
			try {
				divTop = parseInt(document.getElementById("eMeng").style.top, 10)
				divLeft = parseInt(document.getElementById("eMeng").style.left, 10)
				divHeight = parseInt(document.getElementById("eMeng").offsetHeight, 10)
				divWidth = parseInt(document.getElementById("eMeng").offsetWidth, 10)
				docWidth = document.body.clientWidth;
				docHeight = document.body.clientHeight;
				document.getElementById("eMeng").style.top = parseInt(document.body.scrollTop, 10) + docHeight + 10;// divHeight
				document.getElementById("eMeng").style.left = parseInt(document.body.scrollLeft, 10) + docWidth - divWidth
				document.getElementById("eMeng").style.visibility = "visible"
				objTimer = window.setInterval("moveDiv()", 10)
			} catch (e) {
			}
		}
		//调整div高，宽
		function resizeDiv()
		{
		  i+=1;//自动关闭时间
		  if(i>3000) closeDiv()
		  try{
		  divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
		  divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
		  docWidth = document.body.clientWidth;
		  docHeight = document.body.clientHeight;
		  document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
		  document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
		  }
		  catch(e){}
		}
		function moveDiv()
		{
		  try
		  {
			  if(parseInt(document.getElementById("eMeng").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10)))
			  {
			  window.clearInterval(objTimer);
			  objTimer = window.setInterval("resizeDiv()",1);
			  }
			  divTop = parseInt(document.getElementById("eMeng").style.top,10);
			  document.getElementById("eMeng").style.top = divTop - 1.5;//淡出速度
		  }
		  catch(e){}
		}
		function closeDiv()
		{
		  document.getElementById('eMeng').style.visibility='hidden';
		  if(objTimer) window.clearInterval(objTimer);
		}
	
	</script>
	
	<!-- 获取未处理的告警数量 -->
	<script language="JavaScript">

		 $(document).ready(function(){
		 	setTimeout(function(){
			  $("#eMeng").css("display", "none");
			}, 8000);
		});
		 


	</script>
	<div id="eMeng" style="width: 240px; height: 180px; bottom:10px; right:0px; border: 1px solid #2A6E92; position: absolute; Z-INDEX:99999; border-top-left-radius: 8px; border-top-right-radius: 8px;" class="hide">
        <div style="width: 100%; height: 30px; background-color: #2A6E92; line-height: 30px; text-align: center; color: #FFFFFF; border-top-left-radius: 5px; border-top-right-radius: 5px;">
            <span style="font-size: 14px;">消息提醒</span>
        </div>
        <div style="width: 100%; height: 150px; position: relative; background-color: #f5f3f0;">
            <span style="position: absolute; top: 50px; left: 13px; right: 10px; font-size: 14px;">${usersession.realName}你有<strong style="color: red;" id="warnCount"></strong> 条新的告警记录信息</span>
            <a href="javascript:openWindow();" class="blink" target="_blank" style="position: absolute; bottom: 15px; right: 15px; color: red; text-decoration: none;"><i class="glyphicon glyphicon-hand-up"></i>查看详情</a>
        </div>
    </div>

  </body>
</html>
