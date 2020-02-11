<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>zup平台登录</title>
		<base href=" <%=basePath%>">
		<meta name="viewport"
			content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<link rel="stylesheet" href="plug-in/ace/css/bootstrap.css" />
		<link rel="stylesheet" href="plug-in/ace/css/font-awesome.css" />
		<!-- text fonts -->
		<link rel="stylesheet" href="plug-in/ace/css/ace-fonts.css" />

		<link rel="stylesheet" href="plug-in/ace/css/jquery-ui.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="plug-in/ace/css/ace.css"
			class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
	    <link rel="stylesheet" href="plug-in/ace/css/ace-part2.css" class="ace-main-stylesheet" />
	    <![endif]-->
	
		<!--[if lte IE 9]>
	    <link rel="stylesheet" href="plug-in/ace/css/ace-ie.css" />
	    <![endif]-->
		<!-- ace settings handler -->
		<script src="plug-in/ace/js/ace-extra.js"></script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lte IE 8]>
	    <script src="plug-in/ace/js/html5shiv.js"></script>
	    <script src="plug-in/ace/js/respond.js"></script>
	    <![endif]-->
	</head>
	<body class="login-layout light-login">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
								<h1 id="id-text2" class="grey">
									<i class="ace-icon fa fa-leaf green"></i> ZUP快速开发平台
								</h1>
								<h4 class="blue" id="id-company-text">
									Zoneday Unified Platform
								</h4>
							</div>
							<div class="space-6"></div>
							<div class="position-relative">
								<div id="login-box"
									class="login-box visible widget-box no-border">
									<div class="widget-body">
										<form id="loinForm" class="form-horizontal" check=""
											role="form" action="loginController.do?login" method="post">
											<div class="widget-main">
												<div class="alert alert-warning alert-dismissible"
													role="alert" id="errMsgContiner">
													<button type="button" class="close" data-dismiss="alert"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<div id="showErrMsg"></div>
												</div>
												<h4 class="header blue lighter bigger">
													<i class="ace-icon fa fa-coffee green"></i> 用户登录
												</h4>
												<div class="space-6"></div>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right"> <input
															type="text" name="accountname" class="form-control"
															placeholder="请输入账户名" id="accountname" value="admin" /> <i
														class="ace-icon fa fa-user"></i> </span>
												</label>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right"> <input
															type="password" name="password" class="form-control"
															placeholder="请输入密码" id="password" value="" /> <i
														class="ace-icon fa fa-lock"></i> </span>
												</label>
												<label class="block clearfix">
													<div class="input-group">
														<input type="text" style="width: 150px" name="randCode"
															class="form-control" placeholder="请输入验证码" id="randCode"
															onkeydown="randCodeKeyDown()" />
														<span class="input-group-addon" style="padding: 0px;"><img
																id="randCodeImage" src="randCodeImage" />
														</span>
													</div>
												</label>
												<div class="space"></div>
												<div class="clearfix">
													<label class="inline">
														<input type="checkbox" class="ace" id="cbox"
															name="remember" value="yes" />
														<span class="lbl">记住密码一周</span>
													</label>
													<button type="button" id="but_login"
														" class="width-35 pull-right btn btn-sm btn-primary">
														<i class="ace-icon fa fa-key"></i>
														<span class="bigger-110">登录</span>

													</button>
												</div>
												<div class="space-4"></div>
											</div>
										</form>
									</div>
								</div>
								<div class="center">
									<h4 class="blue" id="id-company-text">
										&copy; freeZUP  v1.1.0
									</h4>
								</div>
								<div class="navbar-fixed-top align-right">
									<br />
									&nbsp;
									<a id="btn-login-dark" class="blue" href="#"
										onclick="darkStyle()">Dark</a> &nbsp;
									<span class="blue">/</span> &nbsp;
									<a id="btn-login-blur" class="blue" href="#"
										onclick="blurStyle()">Blur</a> &nbsp;
									<span class="blue">/</span> &nbsp;
									<a id="btn-login-light" class="blue" href="#"
										onclick="lightStyle()">Light</a> &nbsp; &nbsp; &nbsp;
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript"
			src="plug-in/jquery/jquery-1.8.3.min.js"></script>
		<!-- <script type="text/javascript" src="plug-in/login/js/login.js"></script> -->
		<script src="plug-in/ace/js/jquery-2.0.3.min.js"
			type="text/javascript"></script>
		<script src="plug-in/tools/jquery.cookie.js" type="text/javascript"></script>
		<script type="text/javascript" src="plug-in/ace/login/js/jquery.md5.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				readCookies();
			});
			// 重置
			$('#forgetpass').click(function(e) {
				$(":input").each(function() {
					$('#'+this.name).val("");
				});
			});
			// 点击登录
			$('#but_login').click(function(e) {
				saveCookies();
				submit();
			});
			//回车登录
			$(document).keydown(function(e){
				if(e.keyCode == 13) {
					saveCookies();
					submit();
				}
			});
			$(function(){
				optErrMsg();
			});
			$("#errMsgContiner").hide();
				$('#login').show().animate({
				opacity : 1
			}, 2000);
			$('.logo').show().animate({
				opacity : 1,
				top : '32%'
			}, 800, function() {
				$('.logo').show().delay(1200).animate({
					opacity : 1,
					top : '1%'
				}, 300, function() {
					$('.formLogin').animate({
						opacity : 1,
						left : '0'
					}, 300);
					$('.userbox').animate({
						opacity : 0
					}, 200).hide();
				});
			});
			
			$('.userload').click(function(e) {
				$('.formLogin').animate({
					opacity : 1,
					left : '0'
				}, 300);
				$('.userbox').animate({
					opacity : 0
				}, 200, function() {
					$('.userbox').hide();
				});
			});
			$('#randCodeImage').click(function(){
			    reloadRandCodeImage();
			});
				//点击消息关闭提示
			$('#alertMessage').click(function() {
				hideTop();
			});
			
			//读取cookies
			function readCookies(){
				var adname = $.cookie('adname');
				var adpwd = $.cookie('adpwd');
				if(adname != null && adpwd != null){
					$("#accountname").val(adname);
					$("#password").val(adpwd);
					rrm = false;
					document.getElementById("cbox").checked=true;
				}else{
					rrm = true;
				}
			}
			
			//存cookies，根据是否选中记住密码  存储cookies只能为一周
			function saveCookies(){
				if(document.getElementById("cbox").checked==true){
					var md5pwd = "";
					if($.cookie('adpwd') != $("#password").val()){
						rrm = true;
						md5pwd = $.md5($("#password").val());
					}else{
						rrm = false;
					}
					var p = md5pwd;
					var n = $("#accountname").val();
					
					if($("#accountname").val() == $.cookie('adname') && $("#password").val() == $.cookie('adpwd')){
						rrm = false;
					}else{
						$.cookie('adname', '', { expires: -1 });
						$.cookie('adpwd', '', { expires: -1 });
						$.cookie("adname", n, { expires: 7 });
						$.cookie("adpwd", p, { expires: 7 });
					}
				}else{
					if($.cookie('adpwd') != "" || $.cookie('adname').length != ""){
						$.cookie('adname', '', { expires: -1 });
						$.cookie('adpwd', '', { expires: -1 });
					}
				}
			}
			
			$('#password').change(function() {
				rrm = true;
			});
			function optErrMsg(){
				$("#showErrMsg").html('');
				$("#errMsgContiner").hide();
			};						
		
		  //验证码输入框按下回车
		  function randCodeKeyDown(){
			  var lKeyCode = (navigator.appname=="Netscape")?event.which:window.event.keyCode; //event.keyCode按的建的代码，13表示回车
				if(lKeyCode == 13){
					checkUser();
				}else{
					return false;
				}
		  }
		//表单提交
		function submit()
		{
			var submit = true;
			$("input[nullmsg]").each(function() {
				if ($("#" + this.name).val() == "") {
					showError($("#" + this.name).attr("nullmsg"), 500);					
					submit = false;
					return false;
				}
			});
			if (submit) {
				hideTop();					
				if(checkUser()){
				Login();
				};
			}
		
		}
		  //验证用户信息
		  function checkUser(){
		    if(!validForm()){
		      return false;
		    }
		   return true;
		  }
		  //表单验证
		  function validForm(){
		    if($.trim($("#accountname").val()).length==0){
		      alert("请输入账户名");
		      return false;
		    }
		
		    if($.trim($("#password").val()).length==0){
		      alert("请输入密码");
		      return false;
		    }
		
		    if($.trim($("#randCode").val()).length==0){
		     alert("请输入验证码");
		      return false;
		    }
		    return true;
		  }
		/**
		 * 刷新验证码
		 */
		function reloadRandCodeImage() {
		    var date = new Date();
		    var img = document.getElementById("randCodeImage");
		    img.src='randCodeImage?a=' + date.getTime();
		}
	
		//登录处理函数
		function Login(orgId) {
			var formData = new Object();
			var data=$(":input").each(function() {
				 formData[this.name] =$("#"+this.name ).val();
				 if(this.name == "password" && rrm){
					 formData[this.name] = $.md5($("#"+this.name ).val());
				 }
			});
		    formData['orgId'] = orgId ? orgId : "";
			formData['langCode']=$("#langCode").val();
			formData['langCode'] = $("#langCode option:selected").val();			
			$.ajax({
			      async : false,
			      cache : false,
			      type : 'POST',
			      url : 'rest/rbac/loginController/login',// 请求的路径
			      data : formData,
			      dataType:"json",
			      error : function() {// 请求失败处理函数
			      	alert("您输入的账户名或密码不正确，请重新输入");
			      },
			      success : function(data) {
			      	  if (data.msg=="randCode") {//返回值为success          
			          		alert("验证码输入错误！请注意区分大小写");
			          		return;			          		
	                   	}	      
			          if (data.msg=="success") {//返回值为success        
			          		loginSuccess();
	                   	}
	                   if(data.msg=="pswFail"){
		                   	alert("您输入的密码不正确，请重新输入");
		                   }
	                   if(data.msg=="fail"){
	                   	alert("您输入的账户名或密码不正确，请重新输入");
	                   }
	               }		          				
			});
		}
		//显示错误提示
		function showError(str) {
			$('#alertMessage').addClass('error').html(str).stop(true, true).show().animate({
				opacity : 1,
				right : '0'
			}, 500);
		
		}
		
		function showSuccess(str) {
			$('#alertMessage').removeClass('error').html(str).stop(true, true).show().animate({
				opacity : 1,
				right : '0'
			}, 500);
		}

		function hideTop() {
			$('#alertMessage').animate({
				opacity : 0,
				right : '-20'
			}, 500, function() {
				$(this).hide();
			});
		}
		//加载信息
		function loading(name, overlay) {
			$('body').append('<div id="overlay"></div><div id="preloader">' + name + '..</div>');
			if (overlay == 1) {
				$('#overlay').css('opacity', 0.1).fadeIn(function() {
					$('#preloader').fadeIn();
				});
				return false;
			}
			$('#preloader').fadeIn();
		}

		function unloading() {
			$('#preloader').fadeOut('fast', function() {
				$('#overlay').fadeOut();
			});
		}
		
	 	//登陆成功以后跳转页面
		function loginSuccess(){
		//登陆成功以后，根据userid，获取该用户可以访问的资源	
	          window.location.href="rest/rbac/homeController";
	     };

	</script>
	</body>
</html>