<%@ page language="java" import="java.util.*, cn.zup.rbac.entity.UserSession" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<title>运维监控平台接收登记</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
       
</head>
<body style="background-color:#FFFFFF;  overflow-x : hidden ;" >
    <div class="row">
		<div class="col-md-12 col-xs-12 col-lg-12 widget-body">
<!--			<div class="page-header">-->
<!--				<div class="col-md-6 col-xs-6 col-lg-6">-->
					<div class="table-header">基本信息</div><!--<small>基本信息</small>-->
<!--				</div>-->
<!--			</div>-->
			<div class="row center center-block" style="margin-top:20px;">
				<div id="workFormAuto">${ html}</div>
				<input id="workids" style="display:none;" value="${ flowRequest.workID}" />
			</div>
			<!--<div class="table-header">原始记录</div>-->
			<hr/>
			<div class="row" style="margin-right:20px;height:30px; margin-bottom:10px; margin-top:5px; float:right;">
				<button class="btn btn-primary btn-sm" id="btnSave">保存</button>
				<button class="btn btn-primary btn-sm" id="btnCommit">提交</button>
				<button class="btn btn-primary btn-sm" id="btnReject">驳回</button>
			</div>
		</div>
	</div>
	<!-- 引入签字页面	-->
	<jsp:include page="wfCommonSign.jsp"></jsp:include>
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    <script type="text/javascript" src="plug-in/ace/js/uploadFileAjax/ajaxfileupload.js"></script>
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
	  //根据业务主键加载业务数据
		$(document).ready(function(){
			HidenBtn();
			$.ajax({
	       		type: "POST",
	            url: "rest/workflow/workFormAutoController/getMainBizInfo",
	            cache: false,  //禁用缓存 
	            data: "mainBizKey=${ mainBizKey}",
	            dataType: "json",
	            success: function (result) {
					for(var i =0;i<result.formAutoInfo.length;i++){
						var controlName = result.formAutoInfo[i].CONTROL_NAME;
		            	var controlValue = result.formAutoInfo[i].VALUE;
		            	var obj = $(":input[name='"+controlName+"']");
		            	if(obj.attr("type") == "radio" || obj.attr("type") == "checkbox"){
		            		obj.each(function(){
		            		    if($(this).attr("value") == controlValue){
		            		    	$(this).attr("checked","checked"); 
			            		}
		            		});
		            	}else if(obj.attr("plugins")=="select"){
		            		obj.find("option").each(function(){
								if($(this).attr("value") == controlValue){
									$(this).attr("selected","selected"); 
								}
			            	});
			            }else if(obj.attr("type") == "file"){
			            	if(controlValue.substring(0, 6) == "upload"){
			                	obj.replaceWith("<img id='upFile' src="+controlValue+" width='150' style=' float:left;' ><span id='closeFile' onclick='closeFile(this)' style='width:15px; height:15px; background:red; float:left; color:#fff; margin-top:4px; margin-left:10px; cursor:pointer;' title='重新上传'>×</span>");
		                	}
			            }
		            	else{
		            		obj.val(controlValue);
		            	}
					}
	            }
	    	});
	   	});
	   	
	   	//点击查号
	   	var i = 1;
		function closeFile(obj){
			console.log($("#"+obj.id).prev()[0].id);
			var pid = $("#"+obj.id).prev()[0].id;
			var n = "upFile"+(i++);
			$("#"+pid).replaceWith('<input name="upFile" id="upFile" type="file" title="上传控件" plugins="upload" fieldname="upFile" orghide="0" orgalign="left" orgwidth="150" style="text-align: left; width: 150px;">');
			obj.remove();
		}
	   	//判断是否有id参数 如果有就是查看详情，隐藏所有btn
   	   	function HidenBtn(){
   	   		if("${ id}" == "check"){
	   	   		$("#btnSave").css("display", "none");
	   	   		$("#btnCommit").css("display", "none");
	   	   		$("#btnReject").css("display", "none");
   	   		}
   	   	}
          
	</script>
	
	<!--  增删改查  js脚本实现-->
    <script type="text/javascript">
		//点击提交按钮触发的事件
		$( "#btnCommit" ).on('click', function(e) {
			var params = {};
			params.actionType = "Commit";
			subSave(params);
		});
		//点击保存
		$( "#btnSave" ).on('click', function(e) {
			var params = {};
			params.actionType = "Save";
			subSave(params);
		});
		//点击回驳触发的事件
		$("#btnReject").click(function(){
			var params = {};
			params.actionType = "Reject";
			subSave(params);
		});
		
		function subSave(params){
			var workids = $("#workids").val();
			params.workId = workids;
			params.mainBizKey="${ mainBizKey}";
			var input = $('#workFormAuto').find(':input');       //获取所有的input 包括select和textarea
			params.inputName = [];
			params.inputValue = [];
			var index = 0;
			for(var i=0; i<input.length; i++){
				var type = input[i].getAttribute('type');
				if(type == 'radio'){
					if(input[i].checked==true){
						params.inputName[index] = input[i].getAttribute('name');
						params.inputValue[index] = input[i].value;
						index++;
					}
				}else if(type == 'checkbox'){
					if(input[i].checked==true){
						params.inputName[index] = input[i].getAttribute('name');
						params.inputValue[index] = input[i].value;
						index++;
					}
				}else if(type == 'file'){
					params.inputName[i] = input[i].id;//input[i].getAttribute('name');
					params.inputValue[i] = input[i].id;
				}else{
					params.inputName[index] = input[i].getAttribute('name');
					params.inputValue[index] = input[i].value;
					index++;
				}
				params.formID = ${ formID};
				
				params.signUserID = $("#userIds").html();
				params.signUserName = $("#signName").html();
				params.signOpinion = $("#signOpinion").val();
			}
			//根据图片类型判断调用是否有上传文件的方法
			var ele = $("#upFile");
			console.log(ele);
		  	if(ele[0].localName=="input"){//图片方式为input
		  		if($("#upFile").val()==""){//还没选择图片，调用普通的方法
		  			params.inputName[index] = "upFile";
					params.inputValue[index] = "";
		  			saveNo();
		  		}else{//用户第一次选择了图片,调用含有上传文件的方法
		  			 picUp();
		  		}
		  	}else{
				var str=ele[0].src;
		  		var arr=str.split('/');//注split可以用字符或字符串分割
		  		var picStr=arr[arr.length-2]+"/"+arr[arr.length-1];
		  		params.inputName[index] = "upFile";
				params.inputValue[index] = picStr;
				saveNo();
		  	}
			function saveNo(){
				$.ajax({
		            type: "POST",
		            url: "rest/workflow/workFormAutoController/saveFormAutoInfoNoFile?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}", 
		            cache: false,  //禁用缓存
		            data: params,
		            dataType: "json",
		            success: function (result) {
		            	console.log(result);
		       			if(result.result == "Success"){
								if(workids.length > 0){
									window.close();
									window.opener.document.location.reload();  //调用子窗体的父窗体进行刷新 
								}else{
									if(params.actionType == "Save"){
										parent. addTabs({id:124,title:'待办理工作',close: true,url:'rest/workflow/workPersonal/workList?menuid=124'});
									}else if(params.actionType == "Commit"){
										parent. addTabs({id:125,title:'已办理工作',close: true,url:'rest/workflow/workPersonal/WorkFinish?menuid=125'});
									}
								}
		       			}else if(result.result == "Fail"){
		       				return;
		       			}else if(result.result == "SuccessAndRedo"){
		       				for(var i=0; i<input.length; i++){
		       					var type = input[i].getAttribute('type');
								if(type == 'radio'){
									if(input[i].checked==true){
										input.attr("checked",false); 
									}
								}else if(type == 'checkbox'){
									if(input[i].checked==true){
										input.attr("checked",false); 
									}
								}else{
									input.val("");
								}
		       				}
		       			}
		            }
		        });
		    }
	        console.log(params);
	        function picUp(){
	        	$.ajaxFileUpload({
	        		 type: "POST",
	                 url: 'rest/workflow/workFormAutoController/saveFormAutoInfo?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}', //用于文件上传的服务器端请求地址
	                 data: params,
	                 secureuri: false, //是否需要安全协议，一般设置为false
	                 fileElementId: 'upFile', //文件上传域的ID
	                 dataType: 'json', //返回值类型 一般设置为json
	                 success: function (result)  //服务器成功响应处理函数
	                 {
	                     if(result.result == "Success"){
								if(workids.length > 0){
									window.close();
									window.opener.document.location.reload();  //调用子窗体的父窗体进行刷新 
								}else{
									if(params.actionType == "Save"){
										parent. addTabs({id:124,title:'待办理工作',close: true,url:'rest/workflow/workPersonal/workList?menuid=124'});
									}else if(params.actionType == "Commit"){
										parent. addTabs({id:125,title:'已办理工作',close: true,url:'rest/workflow/workPersonal/WorkFinish?menuid=125'});
									}
								}
		       			 }else if(result.result == "Fail"){
		       				return;
		       			 }else if(result.result == "SuccessAndRedo"){
		       				for(var i=0; i<input.length; i++){
		       					var type = input[i].getAttribute('type');
								if(type == 'radio'){
									if(input[i].checked==true){
										input.attr("checked",false); 
									}
								}else if(type == 'checkbox'){
									if(input[i].checked==true){
										input.attr("checked",false); 
									}
								}else{
									input.val("");
								}
		       				}
		       			}
	                 },
	                 error: function ()//服务器响应失败处理函数
	                 {
	                    
	                 }
             	});
           	}
		}
		
		//附件上传
		/*function ajaxFileUpload() {
			$.ajaxFileUpload({
                 url: 'rest/workflow/workFormAutoController/upLoadFile?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}', //用于文件上传的服务器端请求地址
                 secureuri: false, //是否需要安全协议，一般设置为false
                 fileElementId: 'upFile', //文件上传域的ID
                 dataType: 'json', //返回值类型 一般设置为json
                 success: function (result, status)  //服务器成功响应处理函数
                 {
                     alert(result.data);
                 },
                 error: function (data, status, e)//服务器响应失败处理函数
                 {
                     alert(e);
                 }
             });
		}*/
		
	</script>
    
	</body>
</html>

