<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html> <html>
<head>
    <meta charset="UTF-8">
    <base href=" <%=basePath%>">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>微信系统账户绑定</title>
    <link rel="stylesheet" href="plug-in/public/css/weui.css"/>
    <link rel="stylesheet" href="plug-in/public/css/example.css"/>
    <link rel="stylesheet" href="plug-in/public/css/bootstrap.min.css"/>
    <script type="text/javascript" src="plug-in/public/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="plug-in/public/js/jweixin-1.1.0.js"></script>
    <script type="text/javascript" src="plug-in/public/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="plug-in/public/js/zepto.min.js"></script>
    <script type="text/javascript" src="plug-in/public/js/router.min.js"></script>
</head>
<body ontouchstart>
    <!--头部logo-->
    <div class="weui_cells" style=" margin:-5px auto;">
        <div class="weui_icon_area" style="height: 200px;">
            <img src="plug-in\public\image\logo.png?v=1.1" class="img-rounded img-responsive" style="width: 100%;" />
        </div>
    </div>
    <div class="weui_cells weui_cells_form" style="margin-top:-12px;">
        <!--选择框 开始-->
        <!--选择框 开始-->
        <div class="weui_cell weui_cell_select weui_select_after">
            <div class="weui_cell_hd">
                <label class="weui_label">系统选择</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <select class="weui_select" name="select2" id="selectBox">
               	<c:forEach items="${systems}" var="sys">
					<option value="${sys.company_Id }">${sys.company_Name }</option>
				</c:forEach>
                </select>
            </div>
        </div>
        <!--选择框 结束-->
        <!--输入框开始-->
        <div class="weui_cell">
            <div class="weui_cell_hd">
                <label class="weui_label">账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 户</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input type="text" placeholder="请输入账户名称" class="weui_input" id="bdUser" />
            </div>
        </div>

        <div class="weui_cell">
            <div class="weui_cell_hd">
                <label class="weui_label">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 码</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input type="password" placeholder="请输入账户密码" class="weui_input" id="bdPwd" />
            </div>
        </div>
        <!--输入框结束-->
    </div>
    <!--按钮开始-->
    <input type="submit" class="weui_btn weui_btn_primary" id="bdEnter" value="绑定">
    <input type="submit" class="weui_btn weui_btn_default" id="bdClose" value="取消">
	
	<!-- <a style="float:right;" href="webpage/public/lrSystemInfo.jsp" class="weui_btn weui_btn_mini weui_btn_default">录入系统</a> -->

    <!--弹出对话框 开始-->
    <div class="weui_dialog_alert" id="dialog" style="display: none;">
        <div class="weui_mask"></div>
        <div class="weui_dialog">
            <div class="weui_dialog_hd"><strong class="weui_dialog_title">系统绑定</strong></div>
            <div class="weui_dialog_bd">绑定成功，你下次就可以免密登录了</div>
            <div class="weui_dialog_ft">
                <a   onclick="WeixinJSBridge.call('closeWindow');" class="weui_btn_dialog primary" id="dEnter">确定</a>
            </div>
        </div>
    </div>
    
    <div class="weui_dialog_alert" id="xdialog" style="display: none;">
        <div class="weui_mask"></div>
        <div class="weui_dialog">
            <div class="weui_dialog_hd"><strong class="weui_dialog_title">系统提醒</strong></div>
            <div class="weui_dialog_bd" id="errormsg"></div>
            <div class="weui_dialog_ft">
                <a href="javascript:;" class="weui_btn_dialog primary" id="xdEnter">确定</a>
            </div>
        </div>
    </div>


	<div class="weui_dialog_alert" id="ajax" style="display: none;">
    <div class="weui_mask"></div>
    <div class="weui_dialog">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title">弹窗标题</strong></div>
        <div class="weui_dialog_bd">弹窗内容，告知当前页面信息等</div>
        <div class="weui_dialog_ft">
            <a href="javascript:;" class="weui_btn_dialog primary" id="aEnter">确定</a>
        </div>
    </div>
	</div>

    <div class="weui_dialog_confirm" id="fDialog" style="display: none;">
        <div class="weui_mask"></div>
        <div class="weui_dialog">
            <div class="weui_dialog_hd"><strong class="weui_dialog_title">系统提醒</strong></div>
            <div class="weui_dialog_bd">你的系统还尚未绑定，你确定要取消吗？</div>
            <div class="weui_dialog_ft">
                <a href="javascript:;" class="weui_btn_dialog default" id="fClose">取消</a>
                <a href="javascript:;" class="weui_btn_dialog primary" id="fEnter">确定</a>
            </div>
        </div>
    </div>


    <!--弹出对话框 结束-->

    <script type="text/javascript">
    	$(document).ready(function(){
			if("${ param.url}" != "")
				location.href = "${ param.url}";
		});
    
	    $("#bdEnter").click(function(){
	    	var openidStr = '<%=session.getAttribute("openid")%>';
	    	var uName = $("#bdUser").val();
	    	var uPwd = $("#bdPwd").val();
	    	var sid = parseInt($("#selectBox").val());
	       	$.ajax({ 
	       		type : "post",
				async : false, //异步执行  
	           url: "wechat/bind/register", 
	           dataType: "html",
	           //传送请求数据
	           data: {system_id: sid, openid : openidStr, register_name:uName, register_pwd: uPwd}, 
	           success: function (strValue) { //登录成功后返回的数据
	               //根据返回值进行状态显示
	               if (strValue == "true") {
           				$("#dialog").css('display', 'block');   //点击绑定按钮
	               }else if(strValue == "yes"){
	            	   	$("#errormsg").html("绑定失败，此用户已绑定");
           				$("#xdialog").css('display', 'block');   //点击绑定按钮
        				$("#xdEnter").click(function() {
            				$("#xdialog").css('display', 'none');  //点击弹出框按钮
        				});
	               }
	               else if(strValue == "false"){
	            	   	$("#errormsg").html("绑定失败，请重新关注公众号（未能获取微信账号）");
          				$("#xdialog").css('display', 'block');   //点击绑定按钮
       				$("#xdEnter").click(function() {
           				$("#xdialog").css('display', 'none');  //点击弹出框按钮
       				});
	               }
	               else if(strValue == "no"){
	            	   	$("#errormsg").html("绑定失败，用户名或密码错误（请注意账号密码大小写）");
         				$("#xdialog").css('display', 'block');   //点击绑定按钮
      				$("#xdEnter").click(function() {
          				$("#xdialog").css('display', 'none');  //点击弹出框按钮
      				});
	               }
	           }
	       })
	    });
        
        
        $("#bdClose").click(function(){
            $("#fDialog").css('display', 'block');   //点击取消按钮
        });
        $("#fClose, #fEnter").click(function(){
            $("#fDialog").css('display', 'none');   //点击弹出框按钮
        });
        $("#aEnter").click(function() {
            $("#ajax").css('display', 'none');  //点击弹出框按钮
        });
    </script>
</body>
</html>
