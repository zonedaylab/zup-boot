<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<base href=" <%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="UTF-8">
		<title>用户登录-${ title}</title>
		<link href="plug-in/login/css/login.css" rel="stylesheet">
	</head>
	<body style="overflow:hidden;">
		<div id="head">
			<p>${ title}</p>
		</div>
		<div id="content" style="background: url(${ bgimg}) no-repeat center top;">
			<div class="content_wrap">
				<div class="login">
					<ul>
						<li>
							<span>用户名：</span>
							<input name="accountname" placeholder="请输入账户名" id="accountname" type="text" value=""></input>
						</li>
						<li>
							<span>密&nbsp;码：</span>
							<input  type="password" name="password" placeholder="请输入密码" id="password" value=""></input></li>
						<li>
							<span>验证码：</span>
							<input name="randCode" placeholder="不区分大小写" id="randCode" onkeydown="randCodeKeyDown()" style="width:68px;" class="login_code" type="text" value=""></input>
							<img id="randCodeImage" style="width:80px; margin-left: 5px;" alt="点击更换" title="点击更换" src="randCodeImage"/>
						</li>
						<li>
							<input type="checkbox" id="cbox" class="login_checkbox" name="vehicle" value="auto" />
							<span class="login_checkinfo">记住密码一周</span>
						</li>
						<li>
							<input class="login_btn" id="but_login" type="button" value="登 录"></input>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div id="info">
			<div class="info_wrap">
				<dl>
					<dt><img src="plug-in/login/newLogin/img03.png"/></dt>
					<dd>
						<h2>电站监控</h2>
						<span></span>
					</dd>
				</dl>
				<dl>
					<dt><img src="plug-in/login/newLogin/img04.png"/></dt>
					<dd>
						<h2>精准扶贫</h2>
						<span></span>
					</dd>
				</dl>
				<dl>
					<dt><img src="plug-in/login/newLogin/img01.png"/></dt>
					<dd>
						<h2>工程管理</h2>
						<span></span>
					</dd>
				</dl>
				<dl>
					<dt><img src="plug-in/login/newLogin/img02.png"/></dt>
					<dd>
						<h2>运营维护</h2>
						<span></span>
					</dd>
				</dl>
			</div>	
		</div>
		<div id="foot">
			<p>Copyright © ${ copyright}<a href="javascript:void(0);" id="links">联系我们</a>&nbsp;&nbsp;&nbsp;</p>
		</div>
		<!--linkNumber	-->
		<div id="linkDialog" style="display:none; width: 300px; height: 180px; background-color: rgba( 0,0,0,0.5); border-radius: 10px; position: absolute; z-index: 9999; top: 300px; left: 37%;">
	        <div style="width: 300px; height: 30px; background-color: rgba(128,209,255,0.9); line-height: 30px; text-align: center; border-top-left-radius: 10px; border-top-right-radius: 10px;">
	            <div style="color:#fff; font-family:'黑体'; float:left; margin-left:15px;">联系我们</div>
	            <div id="cl" style="border: 1px solid #fff; cursor: pointer; width: 20px; height: 20px; margin: 5px; line-height: 20px; text-align: center; border-radius: 15px; color: #ffffff; font-family: '黑体'; float: right;">×</div>
	        </div>
	        <div style="width: 300px; height: 150px; padding: 0px;">
	            <ul style="padding: 15px; text-align:left;" >
	                <li style="list-style: none; color:#ffffff; height: 24px; font-size:16px;">运维联系人员：王老师、张老师</li>
	                <li style="list-style: none; color:#ffffff; height: 24px; font-size:16px;">运维联系微信：18654539853</li>
	                <li style="list-style: none; color:#ffffff; height: 24px; font-size:16px;">运维联系手机：18654539853</li>
	                <li style="list-style: none; color:#ffffff; height: 24px; font-size:16px;">运维联系电话：0531-88018000转3216</li>
	            </ul>
	        </div>
	    </div>
		<jsp:include page="../include/mainFooter.jsp"></jsp:include>
		<script type="text/javascript" src="plug-in/login/sunStyle/js/jquery.form.js"></script>
		<script src="plug-in/tools/jquery.cookie.js" type="text/javascript"></script>
		<script src="plug-in/ace/main/js/jquery.md5.js" type="text/javascript"></script>
		<script type="text/javascript">
			var rrm = false;
			$(document).ready(function(){
				var Flag = false;
				Flag = IsPC();
				if(Flag){
					var isChrome = window.navigator.userAgent.indexOf("Chrome") !== -1;
			    	if(!isChrome)
			    		location.href = "/pms/browse.jsp";
			    	else
						readCookies();
				}
				function IsPC() {
				    var userAgentInfo = navigator.userAgent;
				    var Agents = ["Android", "iPhone",
				                "SymbianOS", "Windows Phone",
				                "iPad", "iPod"];
				    var flag = true;
				    for (var v = 0; v < Agents.length; v++) {
				        if (userAgentInfo.indexOf(Agents[v]) > 0) {
				            flag = false;
				            break;
				        }
				    }
				    return flag;
				}
			});
			
			//读取cookies
			function readCookies(){
				var adname = $.cookie('adname');
				var adpwd = $.cookie('adpwd');
				if(adname != null && adpwd != null){
					$("#accountname").val(adname);
					$("#password").val(adpwd);
					rrm = true;
					document.getElementById("cbox").checked=true;
				}
			}
			
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
			
	</script>
			<script type="text/javascript">
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
				setCookie();
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
				          		alert("验证码输入错误！请重新输入");
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
			//设置cookie
			function setCookie()
			{
				if ($('#on_off').val() == '1') {
					$("input[iscookie='true']").each(function() {
						$.cookie(this.name, $("#"+this.name).val(), "/",24);
						$.cookie("COOKIE_NAME","true", "/",24);
					});
				} else {
					$("input[iscookie='true']").each(function() {
						$.cookie(this.name,null);
						$.cookie("COOKIE_NAME",null);
					});
				}
			}
			//读取cookie
			$(document).ready(function getCookie(){
				var COOKIE_NAME=$.cookie("COOKIE_NAME");
				if (COOKIE_NAME !=null) {
					$("input[iscookie='true']").each(function() {
						$($("#accountname").val( $.cookie(this.name)));
			            if("admin" == $.cookie(this.name)) {
			                $("#randCode").focus();
			            } else {
			                $("#password").val("");
			                $("#password").focus();
			            }
			        });
					$("#on_off").attr("checked", true);
					$("#on_off").val("1");
				} 
				else
				{
					$("#on_off").attr("checked", false);
					$("#on_off").val("0");
			        $("#randCode").focus();
				}
			});
		
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
		          window.location.href="rest/pms/mainController";
		     };
			
			//联系我们点击事件
		      $("#links").click(function(e){
		      	   $("#linkDialog").css("display", "block");
		      });
		      $("#cl").click(function(e){
		      	   $("#linkDialog").css("display", "none");
		      });
			
		</script>
	</body>
</html>	
