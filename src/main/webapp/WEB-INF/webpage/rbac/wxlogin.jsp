<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html> <html>
<head>
    <meta charset="UTF-8">
    <base href=" <%=basePath%>">
    <title>账户绑定</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" type="text/css" href="plug-in/ace/weui_Style/css/weui.min.css">
    <link rel="stylesheet" type="text/css" href="plug-in/ace/weui_Style/css/example.css">
	<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.min.js"></script>
</head>
<body>

	<div id="loading" class="weui_loading_toast" style="display:none;">
	    <div class="weui_mask_transparent"></div>
	    <div class="weui_toast">
	        <div class="weui_loading">
	            <!-- :) -->
	            <div class="weui_loading_leaf weui_loading_leaf_0"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_1"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_2"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_3"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_4"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_5"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_6"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_7"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_8"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_9"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_10"></div>
	            <div class="weui_loading_leaf weui_loading_leaf_11"></div>
	        </div>
	        <p class="weui_toast_content">正在跳转中</p>
	    </div>
	</div>


    <div id="login-box" class="login-box visible widget-box no-border" style="display:none;">
    	<input type="hidden" id="mark" value = "${ mark}"/> 
              <div class="widget-body">
                <form id="loinForm" class="form-horizontal"  check="loginController.do?checkuser"  role="form" action="loginController.do?login"  method="post">
                <div class="widget-main">
                 <div class="alert alert-warning alert-dismissible" role="alert" id="errMsgContiner">
				  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">do&times;</span></button>
				  <div id="showErrMsg"></div>
				</div>
                  <h4 class="header blue lighter bigger">
                    <i class="ace-icon fa fa-coffee green"></i>
                	    用户登录
                  </h4>
                  <div class="space-6"></div>
                      <label class="block clearfix">
								<span class="block input-icon input-icon-right">
									<input type="text"  name="userName" class="form-control"   id="userName" value="<%=request.getParameter("userName") %>"/>
									<i class="ace-icon fa fa-user"></i>
								</span>
                      </label>
                      <label class="block clearfix">
								<span class="block input-icon input-icon-right">
									<input type="password" name="password" class="form-control" id="password" value="<%=request.getParameter("password") %>"/>
									<i class="ace-icon fa fa-lock"></i>
								</span>
                      </label>
                      <label class="block clearfix">
                        <div class="input-group">
                          <input type="text" style="width:150px" name="randCode" class="form-control"   id="randCode" onkeydown="randCodeKeyDown()"/>
                          <span class="input-group-addon" style="padding: 0px;"><img id="randCodeImage" src="randCodeImage"  /></span>
                        </div>
                      </label>
                      <div class="space"></div>
                      <div class="clearfix">
                        <label class="inline">
                          <input type="checkbox" class="ace" id="on_off"  name="remember" value="yes"/>
                          <span class="lbl">记住用户名</span>
                        </label>
                        <button type="button" id="but_login"  onclick="checkUser()" class="width-35 pull-right btn btn-sm btn-primary">
                          <i class="ace-icon fa fa-key"></i>
                          <span class="bigger-110" >登录</span>
                        </button>
                      </div>
                      <div class="space-4"></div>

                </div>
                <div class="toolbar clearfix">
                  <div style="float: right">
                    <a href="#"  class="forgot-password-link">
                    	  语言
                      <i class="ace-icon fa fa-arrow-right"></i>
                      <t:dictSelect id="langCode" field="langCode" typeGroupCode="lang" hasLabel="false" extendJson="{style:'padding:2px; width:80px;'}" defaultVal="zh-cn"></t:dictSelect>
                    </a>
                  </div>
                </div>
                </form>
              </div>
            </div>
</body>

<script type="text/javascript">
	 $(document).ready(function(){
	 	$("#loading").show();
　　    }); 

  Login();
  //登录处理函数
  function Login(orgId) {
    $.ajax({
      async : false,
      cache : false,
      type : 'POST',
      url : 'rest/rbac/loginController/wxlogins?accountname=${ userName}&password=${ password}',// 请求的action路径
      error : function() {// 请求失败处理函数
      },
      success : function(data) {
	     if('${ mark}'!=""){
	     	window.location.href='${ mark}';
	     }      	
        else{//手机端访问
        	window.location.href="rest/pms/mobileMainController";
        }
       }
    });
  }

</script>
</html>
