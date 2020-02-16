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
		<meta charset="utf-8" />
		<title>zup首页</title>
		<base href=" <%=basePath%>">
		<meta name="description" content="积成能源 运维监控平台" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!--   引入外部样式库css  -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
	</head>

	<body>
		<div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand"> <small> <i
							class="icon-leaf"></i> ZUP 快速开发平台 </small> </a>
					<!-- /.brand -->
				</div>
				<!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#"> <i
								class="icon-tasks"></i> <span class="badge badge-grey">0</span>
							</a>
							
							<ul
								class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-ok"></i> 0个任务
								</li>
								<!-- 
								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">软件更新</span>
											<span class="pull-right">65%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width: 65%" class="progress-bar "></div>
										</div> </a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">硬件更新</span>
											<span class="pull-right">35%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width: 35%"
												class="progress-bar progress-bar-danger"></div>
										</div> </a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">单元测试</span>
											<span class="pull-right">15%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width: 15%"
												class="progress-bar progress-bar-warning"></div>
										</div> </a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">错误修复</span>
											<span class="pull-right">90%</span>
										</div>

										<div class="progress progress-mini progress-striped active">
											<div style="width: 90%"
												class="progress-bar progress-bar-success"></div>
										</div> </a>
								</li>
								-->
								<li class="dropdown-content">
									<ul class="dropdown-menu dropdown-navbar navbar-pink"
										id="noticeContent">
										<!-- ajax加载 -->
									</ul>
								</li>

								<li>
									<a href="#" id="noticeContent"> </a>
								</li>
								<li>
									<a href="javascript:goAllNotice();"> 查看任务详情 <i class="icon-arrow-right"></i> </a>
								</li>
							</ul>
							 
						</li>

						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#"> <i
								class="icon-bell-alt icon-animated-bell"></i> <span
								class="badge badge-important" id="noticeCount">0</span> </a>

							<ul
								class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header" id="noticeTip">
									<i class="icon-warning-sign"></i> 0条公告
								</li>

								<li class="dropdown-content">
									<ul class="dropdown-menu dropdown-navbar navbar-pink"
										id="noticeContent">
										<!-- ajax加载 -->
									</ul>
								</li>

								<li>
									<a href="#" id="noticeContent"> </a>
								</li>

								<li>
									<a href="javascript:goAllNotice();" id="noticeFooter"> 查看全部
										<i class="icon-arrow-right"></i> </a>
								</li>
							</ul>
						</li>

						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#"> <i
								class="icon-envelope icon-animated-vertical"></i> <span
								class="badge badge-success" id="messageCount">0</span> </a>

							<ul
								class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header" id="messageTip">
									<i class="icon-envelope-alt"></i> 0条消息
								</li>

								<li>
									<a href="#" id="messageContent"> </a>
								</li>



								<li>
									<a href="javascript:goAllMessage();" id="messageFooter">
										查看所有消息 <i class="icon-arrow-right"></i> </a>
								</li>
							</ul>
						</li>

						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle"> <img
									class="nav-user-photo" src="plug-in/ace/avatars/avatar2.png"
									alt="Jason's Photo" /> <span class="user-info"> <small>${ usersession.realName}</small>
									<span style="color: #666633">${ usersession.postName}</span> </span> <i
								class="icon-caret-down"></i> </a>

							<ul
								class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<!-- 
								<li>
									<a
										href="javascript:add('修改密码','userController.do?changepassword','',550,200)">
										<i class="icon-cog"></i> 修改密码 </a>
								</li>

								<li>
									<a
										href="javascript:openwindow('个人信息','userController.do?userinfo')">
										<i class="icon-user"></i> 个人信息 </a>
								</li>
								<li>
									<a
										href="javascript:openwindow('系统消息','tSSmsController.do?getSysInfos')">
										<i class="icon-cog"></i> 系统消息 </a>
								</li>
								<li>
									<a
										href="javascript:add('切换页面风格','userController.do?changestyle','',550,250)">
										<i class="icon-cog"></i> 首页风格 </a>
								</li>

								<li>
									<a href="javascript:clearLocalstorage()"> <i
										class="icon-cog"></i> 清除缓存 </a>
								</li>
								 -->
								<li class="divider"></li>
								<li id="btnUDialog">
									<a href="javascript:void();"> <i class="icon-on"></i> 修改密码 </a>
								</li>
								<li>
									<a href="javascript:logout()"> <i class="icon-off"></i> 注销登录 </a>
								</li>
							</ul>
						</li>
					</ul>
					<!-- /.ace-nav -->
				</div>
				<!-- /.navbar-header -->
			</div>
			<!-- /.container -->
		</div>

		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#"> <span
					class="menu-text"></span> </a>

				<div class="sidebar" id="sidebar">
					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
					</script>

					<div class="sidebar-shortcuts" id="sidebar-shortcuts">
						<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
							<button class="btn btn-success">
								<i class="icon-signal"></i>
							</button>

							<button class="btn btn-info">
								<i class="icon-pencil"></i>
							</button>

							<button class="btn btn-warning">
								<i class="icon-group"></i>
							</button>

							<button class="btn btn-danger">
								<i class="icon-cogs"></i>
							</button>
						</div>

						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div>
					<!-- #sidebar-shortcuts -->

					<ul class="nav nav-list" id="mainMenu">
						<c:forEach items="${ parmenulist}" var ="menu">
						<li>
							<c:if test="${menu.menuId == 245}">
								<a href="javascript:addTabs({id:'${menu.menuId}',title:'${menu.menuName }',close: true,url:'rest/rbac/homeController/welcome?menuid=8'})" class="dropdown-toggle" onclick="showSubMenu(this)" id="${menu.menuId}">
								<i class="glyphicon glyphicon-home"></i>
								<span class="menu-text">${menu.menuName }</span>
								</a>
							</c:if>
							<c:if test="${menu.menuId != 245}">
								<a href="javascript:addTabs({id:'${menu.menuId}',title:'${menu.menuName }',close: true,url:'${menu.formAddress }'})" class="dropdown-toggle" onclick="showSubMenu(this)" id="${menu.menuId}">
								<i class="glyphicon glyphicon-cog"></i><!--<img src="${menu.iconStyle}" width="30" style="height: 30;" /> -->
								<span class="menu-text">${menu.menuName }</span>
								<b id="arrowDown${menu.menuId}" class="arrow icon-angle-down"></b>
								</a>
								<ul class="submenu" id="subMenu${menu.menuId}">
								</ul>
							</c:if>
						</li>
						</c:forEach>
					</ul>
						
					<!-- /右侧菜单结束-->
					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>

					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>

				<div class="main-content">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12" style="width: 99%;" id="tabs">
								<ul class="nav nav-tabs" role="tablist">
									<!-- <li class="active"><a href="#Index" role="tab" data-toggle="tab">首页</a></li> -->
								</ul>
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane active" id="Index">
									</div>
								</div>
							</div>
						</div>
						<!-- /.row -->
					</div>
					<!-- /.page-content -->
				</div>
				<!-- /.main-content -->

				<div class="ace-settings-container" id="ace-settings-container">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn"
						id="ace-settings-btn">
						<i class="icon-cog bigger-150"></i>
					</div>

					<div class="ace-settings-box" id="ace-settings-box">
						<div>
							<div class="pull-left">
								<select id="skin-colorpicker" class="hide">
									<option data-skin="default" value="#438EB9">
										#438EB9
									</option>
									<option data-skin="skin-1" value="#222A2D">
										#222A2D
									</option>
									<option data-skin="skin-2" value="#C6487E">
										#C6487E
									</option>
									<option data-skin="skin-3" value="#D0D0D0">
										#D0D0D0
									</option>
								</select>
							</div>
							<span>&nbsp; 选择皮肤</span>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2"
								id="ace-settings-navbar" />
							<label class="lbl" for="ace-settings-navbar">
								固定导航条
							</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2"
								id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar">
								固定滑动条
							</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2"
								id="ace-settings-breadcrumbs" />
							<label class="lbl" for="ace-settings-breadcrumbs">
								固定面包屑
							</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2"
								id="ace-settings-rtl" />
							<label class="lbl" for="ace-settings-rtl">
								切换到左边
							</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2"
								id="ace-settings-add-container" />
							<label class="lbl" for="ace-settings-add-container">
								切换窄屏
								<b></b>
							</label>
						</div>
					</div>
				</div>
				<!-- /#ace-settings-container -->
			</div>
			<!-- /.main-container-inner -->

			<a href="#" id="btn-scroll-up"
				class="btn-scroll-up btn btn-sm btn-inverse"> <i
				class="icon-double-angle-up icon-only bigger-110"></i> </a>
		</div>
		<!-- /.main-container -->

		<div id="changestylePanel" style="display: none">
			<form id="formobj" action="userController.do?savestyle"
				name="formobj" method="post">
				<table style="width: 550px" cellpadding="0" cellspacing="1"
					class="formtable">
					<tr>
						<td>
							风格
						</td>
					</tr>
					<tr>
						<td class="value">
							<input type="radio" value="default" name="indexStyle" />
							<span>经典风格</span>
						</td>
					</tr>
					<!--
					<tr>
						<td class="value"><input type="radio" value="bootstrap" name="indexStyle" /> <span>BootStrap风格</span></td>
					</tr>
					-->
					<!-- update-start--Author:gaofeng  Date:2014-01-10 for:新增首页风格  -->
					<tr>
						<td class="value">
							<input type="radio" value="shortcut" name="indexStyle" />
							<span>ShortCut风格</span> 
						</td>
					</tr>
					<!-- update-start--Author:gaofeng  Date:2014-01-24 for:新增首页风格  -->
					<tr>
						<td class="value">
							<input type="radio" value="sliding" name="indexStyle" />
							<span>Sliding云桌面</span>
						</td>
					</tr>
					<!-- update-end--Author:longjb  Date:2013-03-15 for:新增首页风格  -->
					<tr>
						<td class="value">
							<input type="radio" value="ace" name="indexStyle" />
							<span>ACE平面风格</span>
						</td>
					</tr>
				</table>
			</form>
		</div>
		
		<!--修改密码弹出框-->
	    <div id="fromUpdatePwd" class="hide">
	    	<div class="container">
				<div class="row" style="padding:0px;">
					<strong>原始密码</strong><input type="text" id="oldPwd" style="margin:5px;"/><sup>*</sup>
					<strong>设置密码</strong><input type="password" id="newPwd" style="margin:5px;"/><sup>*</sup>
					<strong>确认密码</strong><input type="password" id="rePwd" style="margin:5px;"/><sup>*</sup>
					<input type="button" id="btnClose" class="btn btn-samll btn-danger" style="float: left;" value="关闭">
           			<input type="button" id="btnUpwd" class="btn btn-samll btn-primary" style="float: right;" value="修改">
				</div>
			</div> 
		</div>
		
		<!--  引入js存放的外部脚本库  -->
		<jsp:include page="../include/mainFooter.jsp"></jsp:include> 
		<script type="text/javascript">
			window.jQuery || document.write("<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>
		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='plug-in/ace/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		<![endif]-->
		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='plug-in/ace/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
		<script src="plug-in/ace/assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<!--[if lte IE 8]>
		  <script src="plug-in/ace/assets/js/excanvas.min.js"></script>
		<![endif]-->
		<script src="plug-in/ace/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="plug-in/ace/assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="plug-in/ace/assets/js/jquery.slimscroll.min.js"></script>
		<script src="plug-in/ace/assets/js/jquery.easy-pie-chart.min.js"></script>
		<script src="plug-in/ace/assets/js/jquery.sparkline.min.js"></script>
		<!-- ace scripts -->
		<script src="plug-in/ace/assets/js/ace-elements.min.js"></script>
		<script src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
		<script type="text/javascript" src="plug-in/ace/assets/js/bootstrap-tab.js"></script>
		<script src="plug-in/jquery/jquery.contextmenu.js"></script>
		<script src="plug-in/layer/layer.js"></script>
		<script src="plug-in/ace/js/bootbox.js"></script>
		<!-- inline scripts related to this page -->
		<script>
			jQuery(function($) {
				//$( "#tabs" ).tabs();
				addTabs({id:'245',title:'系统首页',close: false,url: 'rest/rbac/homeController/welcome?menuid=8'});
				$('.theme-poptit .close').click(function(){
		    		$('.theme-popover-mask').fadeOut(100);
		    		$('.theme-popover').slideUp(200);
		    	});
		    	$('#closeBtn').click(function(){
		    		$('.theme-popover-mask').fadeOut(100);
		    		$('.theme-popover').slideUp(200);
		    	});
		    	//$('#ace-settings-sidebar').click();
		    	//$('#sidebar').addClass('compact');
				$('#sidebar li').addClass('hover').filter('.open').removeClass('open').find('> .submenu').css('display', 'none');
			});
			
			$("#btnUDialog").on("click", function(e){
				msgDialogss(e, "修改密码", "#fromUpdatePwd", 270);
			});
			
			$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
				_title: function(title) {
					var $title = this.options.title || '&nbsp;'
					if( ("title_html" in this.options) && this.options.title_html == true )
						title.html($title);
					else title.text($title);
				}
			}));
			
			//修改密码
			$("#btnUpwd").on("click", function(){
				var userAccountId=${ usersession.accountId};//账户id
				var newPass1=$("#newPwd").val();
				var newPass2=$("#rePwd").val();
				var oddPass = $("#oldPwd").val();
				if(newPass1==newPass2){//若用户输入的新密码相同
					$.ajax( {
						type : "post",
						async: false,
						url : "rest/rbac/userController/editPassword",
						data :'accountId='+userAccountId+'&password='+newPass1+"&oldPwd="+oddPass,
						dataType : "json", //返回数据形式为json  
						success : function(result) {
							if(result.info == "oldError"){
								parent.bootbox.alert("原始密码错误", function(){});
							}else if(result.info == "success"){
								$("#fromUpdatePwd").dialog("close");
								parent.bootbox.alert("修改密码成功", function(){});
								window.location ="rest/rbac/loginController";
							}else{
								parent.bootbox.alert("修改密码失败", function(){});
							}
						},
						error: function(){
							parent.bootbox.alert("修改密码出错", function(){});
						}
					});
				}else{
					parent.bootbox.alert("两次密码不一致", function(){});
				}
			});
			
			$("#btnClose").on("click", function(){
				$("#updatePwd").dialog("close");
			});
			
			function msgDialogss(e, title, thisid, kuan){
				e.preventDefault();
				var dialog = $( thisid ).removeClass('hide').dialog({
					modal: true,
					width:kuan,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-cog'></i>"+title+"</h4></div>",
					title_html: true
				});
			}
		</script>

		
		<script type="text/javascript">
		    //获取子菜单的方法 
			function showSubMenu(v)
			{  
		        $.ajax({
		            type: "POST",
		            url: "rest/rbac/homeController/getPermitSubMenu", 
		            data: 'menuID='+v.id,
		            cache: false,  //禁用缓存
		            dataType: "json",
		            success: function (result) {
		        		$("#subMenu"+v.id).html("");
		        		if(result.submenulist.length>0)
		        		{
		            		for(var i=0;i<result.submenulist.length;i++){
								//$("#subMenu"+v.id).append("<li><a href=\"javascript:addTabs({id:"+result.submenulist[i].menuId+",title:'"+result.submenulist[i].menuName+"',close: true,url:'"+result.submenulist[i].urlAddress+"?menuid="+result.submenulist[i].menuId+"'})\" title=\""+result.submenulist[i].menuName+"\"><i class=\"icon-double-angle-right\"></i>"+result.submenulist[i].menuName+"</a></li> ");
								$("#subMenu"+v.id).append("<li><a href=\"javascript:addTabs({id:"+result.submenulist[i].menuId+
										",title:'"+result.submenulist[i].menuName+"',close: true,url:'"+
										result.submenulist[i].urlAddress.replace("@ip", "http://").replace("@uname", "&user_name=").replace("@pwd", "&password=").replace("{{menuid}}", result.submenulist[i].menuId).replace("@bi", "/Bi/MenuShow")+
										"?menuid=" + result.submenulist[i].menuId + "'})\" title=\""+result.submenulist[i].menuName+"\">"+result.submenulist[i].menuName+"</a></li> ");

							}
		            	}
		        		else{
		        			$("#arrowDown"+v.id).hide();
						}


		        		// ///////////////////////////////////////////
						//
						// level=2;
						//
						// $("#subMenu"+v.id).html("");
						// $("#sanMenu"+v.id).html("");
						//
						// if($(v).attr("href") != "javascript:void(0);"){
						// 	var pars = $(v).attr("href").split("-");
						// 	addTabs({id:pars[0],title:pars[1],close: true,url: pars[2]});
						// }
						// if(result.submenulist.length>0){
						// 	for(var i=0;i<result.submenulist.length;i++){
						// 		if(level == 2){
						// 			if(result.submenulist[i].mobileFlagConfig == 3){
						// 				var addtab = "javascript:void(0);";
						// 				if(result.submenulist[i].urlAddress != "1"){
						// 					addtab = result.submenulist[i].menuId+"-"+result.submenulist[i].menuName+"-"+result.submenulist[i].urlAddress;
						// 				}
						// 				var subMenu = "";
						// 				subMenu += "<li class='esale-dianji'>";
						// 				subMenu += "	<a href='"+addtab+"' onclick='showSubMenu(this, 3)' id='"+result.submenulist[i].menuId+"' title='"+result.submenulist[i].menuName+"' class='dropdown-toggle subsub'>";
						// 				subMenu += "		<i class='san'></i>"+result.submenulist[i].menuName+"</a>";
						// 				subMenu += "	<ul class='submenu' id='sanMenu"+result.submenulist[i].menuId+"' style='display: none;'> ";
						// 				subMenu += "	</ul> </li>";
						// 				$("#subMenu"+v.id).append(subMenu);
						// 				$("#subMenu1"+v.id).append(subMenu);
						// 			}else{
						// 				$("#subMenu"+v.id).append("<li><a href=\"javascript:addTabs({id:"+result.submenulist[i].menuId+
						// 						",title:'"+result.submenulist[i].menuName+"',close: true,url:'"+
						// 						result.submenulist[i].urlAddress.replace("@ip", "http://").replace("@uname", "&user_name=").replace("@pwd", "&password=").replace("{{menuid}}", result.submenulist[i].menuId).replace("@bi", "/Bi/MenuShow")+
						// 						"?menuid=" + result.submenulist[i].menuId + "'})\" title=\""+result.submenulist[i].menuName+"\">"+result.submenulist[i].menuName+"</a></li> ");
						// 				$("#subMenu1"+v.id).append("<li><a href=\"javascript:addTabs({id:"+result.submenulist[i].menuId+
						// 						",title:'"+result.submenulist[i].menuName+"',close: true,url:'"+
						// 						result.submenulist[i].urlAddress.replace("@ip", "http://").replace("@uname", "&user_name=").replace("@pwd", "&password=").replace("{{menuid}}", result.submenulist[i].menuId).replace("@bi", "/Bi/MenuShow")+
						// 						"?menuid=" + result.submenulist[i].menuId + "'})\" title=\""+result.submenulist[i].menuName+"\">"+result.submenulist[i].menuName+"</a></li> ");
						// 			}
						// 		}else{  //3级
						// 			if(result.submenulist[i].urlAddress == "@@")
						// 				$("#sanMenu"+v.id).append("<li><a href=\"javascript:yaogan()\" title=\""+result.submenulist[i].menuName+
						// 						"\" style='padding-left: 32%; text-decoration: none;'>"+
						// 						result.submenulist[i].menuName+"</a></li> ");
						// 			else{
						// 				var ap = "";
						// 				if((result.submenulist[i].urlAddress).indexOf("?") > -1)
						// 					ap = "";
						// 				else
						// 					ap = "&n="+result.submenulist[i].menuName;
						// 				$("#sanMenu"+v.id).append("<li><a href=\"javascript:addTabs({id:"+result.submenulist[i].menuId+
						// 						",title:'"+result.submenulist[i].menuName+"',close: true,url:'"+
						// 						result.submenulist[i].urlAddress.replace("@ip", "http://").replace("@uname", "&user_name=").replace("@pwd", "&password=").replace("@bi", "/Bi/MenuShow")+"?menuid=" + result.submenulist[i].menuId+
						// 						ap + "'})\" title=\""+result.submenulist[i].menuName+"\" style='padding-left: 32%; text-decoration: none;'>"+
						// 						result.submenulist[i].menuName+"</a></li> ");
						// 			}
						// 		}
						// 	}
						// }else{
						// 	$("#arrowDown"+v.id).hide();
						// }





						//---------------------------------------
		        	},
		            error:function(){	            	
		            }
		        }); 
			} 
			
			jQuery(function($) {
				$('.easy-pie-chart.percentage').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
					var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
					var size = parseInt($(this).data('size')) || 50;
					$(this).easyPieChart({
						barColor: barColor,
						trackColor: trackColor,
						scaleColor: false,
						lineCap: 'butt',
						lineWidth: parseInt(size/10),
						animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
						size: size
					});
				})
			
				$('.sparkline').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
					$(this).sparkline('html', {tagValuesAttribute:'data-values', type: 'bar', barColor: barColor , chartRangeMin:$(this).data('min') || 0} );
				});
			
				$("#updatePwd").on("click", function(e){
				$("#fromEdit").dialog("close");
					msgDialogss(e, "修改密码", "#fromUpdatePwd", 270);
				});
				//修改密码
				$("#btnUpwd").on("click", function(){
					var userAccountId="${ usersession.accountId}";//账户id
					var newPass1=$("#newPwd").val();
					var newPass2=$("#rePwd").val();
					var oddPass = $("#oldPwd").val();
					alert(userAccountId);
					if(newPass1==newPass2){//若用户输入的新密码相同
						$.ajax( {
							type : "post",
							async: false,
							url : "rest/rbac/userController/editPassword",
							data :'accountId='+userAccountId+'&password='+newPass1+"&oldPwd="+oddPass,
							dataType : "json", //返回数据形式为json  
							success : function(result) {
								if(result.info == "oldError"){
									parent.bootbox.alert("原始密码错误", function(){});
								}else if(result.info == "success"){
									$("#fromUpdatePwd").dialog("close");
									parent.bootbox.alert("修改密码成功", function(){});
									window.location ="rest/rbac/loginController";
								}else{
									parent.bootbox.alert("修改密码失败", function(){});
								}
							},
							error: function(){
								parent.bootbox.alert("修改密码出错", function(){});
							}
						});
					}else{
						parent.bootbox.alert("两次密码不一致", function(){});
					}
				});
			
			  var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
			  var data = [
				{ label: "social networks",  data: 38.7, color: "#68BC31"},
				{ label: "search engines",  data: 24.5, color: "#2091CF"},
				{ label: "ad campaigns",  data: 8.2, color: "#AF4E96"},
				{ label: "direct traffic",  data: 18.6, color: "#DA5430"},
				{ label: "other",  data: 10, color: "#FEE074"}
			  ]
			  
			
			 /**
			 we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
			 so that's not needed actually.
			 */
			 placeholder.data('chart', data);
			
			
			
			  var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
			  var previousPoint = null;
			
			  placeholder.on('plothover', function (event, pos, item) {
				if(item) {
					if (previousPoint != item.seriesIndex) {
						previousPoint = item.seriesIndex;
						var tip = item.series['label'] + " : " + item.series['percent']+'%';
						$tooltip.show().children(0).text(tip);
					}
					$tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
				} else {
					$tooltip.hide();
					previousPoint = null;
				}
				
			 });
			
			var d1 = [];
			for (var i = 0; i < Math.PI * 2; i += 0.5) {
				d1.push([i, Math.sin(i)]);
			}
		
			var d2 = [];
			for (var i = 0; i < Math.PI * 2; i += 0.5) {
				d2.push([i, Math.cos(i)]);
			}
		
			var d3 = [];
			for (var i = 0; i < Math.PI * 2; i += 0.2) {
				d3.push([i, Math.tan(i)]);
			}
			
		
		
			$('#recent-box [data-rel="tooltip"]').tooltip({placement: tooltip_placement});
			function tooltip_placement(context, source) {
				var $source = $(source);
				var $parent = $source.closest('.tab-content')
				var off1 = $parent.offset();
				var w1 = $parent.width();
		
				var off2 = $source.offset();
				var w2 = $source.width();
		
				if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
				return 'left';
			}
		
		
			$('.dialogs,.comments').slimScroll({
				height: '300px'
		    });
			
			
			//Android's default browser somehow is confused when tapping on label which will lead to dragging the task
			//so disable dragging when clicking on label
			var agent = navigator.userAgent.toLowerCase();
			if("ontouchstart" in document && /applewebkit/.test(agent) && /android/.test(agent))
			  $('#tasks').on('touchstart', function(e){
				var li = $(e.target).closest('#tasks li');
				if(li.length == 0)return;
				var label = li.find('label.inline').get(0);
				if(label == e.target || $.contains(label, e.target)) e.stopImmediatePropagation() ;
			});
		
			$('#tasks').sortable({
				opacity:0.8,
				revert:true,
				forceHelperSize:true,
				placeholder: 'draggable-placeholder',
				forcePlaceholderSize:true,
				tolerance:'pointer',
				stop: function( event, ui ) {//just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
					$(ui.item).css('z-index', 'auto');
				}
				}
			);
			$('#tasks').disableSelection();
				$('#tasks input:checkbox').removeAttr('checked').on('click', function(){
					if(this.checked) $(this).closest('li').addClass('selected');
					else $(this).closest('li').removeClass('selected');
				});
			})
		</script>

		<script type="text/javascript">

			function loadModule(title,url,target){
			    $("#mainTitle").text(title);
	     		$("#center").attr("src",url);
	      	}
	
		  	function logout(){
		  		bootbox.confirm("确定退出该系统吗 ?", function(result) {
		  			if(result)
			  			location.href="rest/rbac/loginController/logout";
		  		});
	  		}
			function opendialog(title,url,target){
				//$("#dialog").attr("src",url);
				bootbox.dialog({
					message:$("#changestylePanel").html(),
					title:title,
					buttons:{
					OK:{
					label: "OK", 
					callback:function(){
						    var indexStyle = $('input[name="indexStyle"]:checked').val();
						    if(indexStyle==undefined||indexStyle==""){
						    	indexStyle = "ace";
						    }
						    var cssTheme = $('input[name="cssTheme"]:checked').val();
						    if(cssTheme==undefined){
						    	cssTheme = "";
						    }
							var form = $("#formobj");//取iframe里的form
							$.ajax({
			        			url:form.attr('action'),
			        			type:form.attr('method'),
			        			data:"indexStyle="+indexStyle,//+"&cssTheme="+cssTheme,
			        			success:function(data){
									var d = $.parseJSON(data);
									if (d.success) {
										var msg = d.msg;
										bootbox.alert(msg);
									}else{
										bootbox.alert(d.msg);
									}
			        			},
			        			error:function(e){
			        				bootbox.alert("出错了哦");
			        			}
							});
						}
				},Cancel: {label: "CLOSE", 
					callback:function() {
							//alert('close');//$("#dialog").dialog("close");
						}
					}
				}});
	  		}
	  		
			function changepass(title,url,target){
				//$("#dialog").attr("src",url);
				bootbox.dialog({
					message:'<form id="formobj2"  action="userController.do?savenewpwd" name="formobj2" method="post">'
						+$("#changepassword").html()+'</form>',
					title:title,
					buttons:{
					OK:{
					label: "OK", 
					callback:function(){
						//alert('not implement');
							$.ajax({
			        			url:"userController.do?savenewpwd",
			        			type:"post",
			        			data:$('#formobj2').serialize(),// 要提交的表单 ,
			        			success:function(data){
									var d = $.parseJSON(data);
									if (d.success) {
										var msg = d.msg;
										bootbox.alert(msg);
									}else{
										bootbox.alert(d.msg);
										}
			        			},
			        			error:function(e){
			        				bootbox.alert("出错了哦");
			        			}
							});
						}
				},Cancel: {label: "CLOSE", 
					callback:function() {
							alert('close');//$("#dialog").dialog("close");
						}
					}
				}});
	  		}
			function profile(title,url,target){
				//$("#dialog").attr("src",url);
				bootbox.dialog({
					message:'<iframe width="100%" height="300px" src="'+url+'" style="border:1px #fff solid; background:#CCC;" id="myframe"></iframe>',
					title:title,
					buttons:{
					OK:{
					label: "OK"},Cancel: {label: "CLOSE"
					}
				}});
	  			
	  		}
			//：清除浏览器缓存
			function clearLocalstorage(){
				var storage=$.localStorage;
				if(!storage)
					storage=$.cookieStorage;
				storage.removeAll();
				bootbox.alert( "浏览器缓存清除成功!");
				alertTipTop("浏览器缓存清除成功!","10%");
			}

			$(document).ready(function(){
				//加载公告，后期备用
				/*
				var url = "noticeController.do?getNoticeList";
				jQuery.ajax({
		    		url:url,
		    		type:"GET",
		    		dataType:"JSON",
		    		async: false,
		    		success:function(data){
		    			if(data.success){
		    				var noticeList = data.attributes.noticeList;
		    				var noticeCount = data.obj;
		    				//加载公告条数
		    				if(noticeCount>99){
		    					$("#noticeCount").html("99+");
		    				}else{
		    					$("#noticeCount").html(noticeCount);
		    				}
		    				//加载公告提示
		    				var noticeTip = "";
		    				noticeTip += "<i class='icon-warning-sign'></i>";
		    				noticeTip += noticeCount+" "+data.attributes.tip;
		    				$("#noticeTip").html(noticeTip);
		    				
		    				//加载公告条目
		    				var noticeContent = "";
		    				if(noticeList.length > 0){
		    					for(var i=0;i<noticeList.length;i++){
		    						noticeContent +="<li><a href='javascript:goNotice(&quot;"+noticeList[i].id+"&quot;)' ";
		    						noticeContent +="style='word-break:keep-all;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;'>";
		    						noticeContent +="<i class='btn btn-xs btn-primary fa fa-user'></i>";
		    						noticeContent +="&nbsp;"+noticeList[i].noticeTitle + "</a></li></ul></li>";
		        				}
		    				}
		    				alert(noticeContent);
		    				$("#noticeContent").html(noticeContent);
		    				
		    				//加载公告底部文字
		    				var noticeSeeAll = data.attributes.seeAll +"<i class='ace-icon fa fa-arrow-right'></i>";
		    				$("#noticeFooter").html(noticeSeeAll);
		    			}
		    		}
		    	});
				*/
				
				//加载消息，后期备用
				/*
				var url = "tSSmsController.do?getMessageList";
				$.ajax({
		    		url:url,
		    		type:"GET",
		    		dataType:"JSON",
		    		async: false,
		    		success:function(data){
		    			if(data.success){
		    				var messageList = data.attributes.messageList;
		    				var messageCount = data.obj;
		    				//加载消息条数
		    				if(messageCount>99){
		    					$("#messageCount").html("99+");
		    				}else{
		    					$("#messageCount").html(messageCount);
		    				}
		    				//加载消息tip提示
		    				var messageTip = "";
							messageTip += "<i class='ace-icon fa fa-envelope-o'></i>";
							messageTip += messageCount+" "+data.attributes.tip;
		    				$("#messageTip").html(messageTip);
		    				
		    				//加载消息条目（有限）
		    				var messageContent = "";
		    				if(messageList.length > 0){
		    					for(var i=0;i<messageList.length;i++){
		    						messageContent +="<li><a href='javascript:goMessage(&quot;"+messageList[i].id+"&quot;)' class='clearfix'>";
		    						messageContent +="<img src='plug-in/ace/avatars/avatar3.png' class='msg-photo' alt='Alex’s Avatar' />";
		    						messageContent +="<span class='msg-body'><span class='msg-title'>";
		    						messageContent +="<span class='blue'>"+messageList[i].esSender+":</span>";
		    						messageContent += messageList[i].esTitle + "</span>";
		    						messageContent +="<span class='msg-time'><i class='ace-icon fa fa-clock-o'></i><span>"+messageList[i].esSendtimeTxt+"</span></span>";
		    						messageContent +="</span></a><input id='"+messageList[i].id+"_title' type='hidden' value='"+messageList[i].esTitle+"'>";
		    						messageContent +="<input id='"+messageList[i].id+"_status' type='hidden' value='"+messageList[i].esStatus+"'>";
		    						messageContent +="<input id='"+messageList[i].id+"_content' type='hidden' value='"+messageList[i].esContent+"'></li>";
		        				}
		    				}
		    				$("#messageContent").html(messageContent);
		    				
		    				//加载消息底部文字
		    				var messageSeeAll = data.attributes.seeAll +"<i class='ace-icon fa fa-arrow-right'></i>";
		    				$("#messageFooter").html(messageSeeAll);
		    			}
		    		}
		    	});
				*/
			});
		
		    function goAllNotice(){
		    	var addurl = "noticeController.do?noticeList";
		  		createdetailwindow("公告", addurl, 800, 400);
		    }
		
		    function goNotice(id){
		  		var addurl = "noticeController.do?goNotice&id="+id;
				createdetailwindow("通知公告详情", addurl, 750, 600);
		    }
		    
		    function goAllMessage(){
		    	var addurl = "tSSmsController.do?getSysInfos";
		  		createdetailwindow("消息", addurl, 800, 400);
		    }
		    
		    function goMessage(id){
		    	var title = $("#"+id+"_title").val();
		    	var content = $("#"+id+"_content").val();
		    	$("#msgId").val(id);
		    	$("#msgTitle").html(title);
		    	$("#msgContent").html(content);
		    	var status = $("#"+id+"_status").val();
		    	if(status==1){
		    		$("#msgStatus").html("未读");
		    	}else{
		    		$("#msgStatus").html("已读");
		    	}
		    	$('.theme-popover-mask').fadeIn(100);
		    	$('.theme-popover').slideDown(200);
		    }
		    
		    function readMessage(){
		    	var msgId = $("#msgId").val();
		  		  var url = "tSSmsController.do?readMessage";
		  			$.ajax({
		  	    		url:url,
		  	    		type:"GET",
		  	    		dataType:"JSON",
		  	    		data:{
		  	    			messageId:msgId
		  	    		},
		  	    		success:function(data){
		  	    			if(data.success){
		  	    				$("#msgStatus").html("已读");
		  	    				$("#"+msgId+"_status").val('2');
		  	    			}
		  	    		}
		  	    	});
		    }
		</script>
	</body>
</html>



