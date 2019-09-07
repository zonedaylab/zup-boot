<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<title>积成能源 运维监控平台接收登记</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
       
</head>
<body style="background-color:#FFFFFF;  overflow-x : hidden ;" >
    <div class="row">
		<div class="col-md-12 col-xs-12 col-lg-12 widget-body">
			<div class="table-header">基本信息</div><!--<small>基本信息</small>-->
			<div class="row center center-block" style="margin-top:20px;">
				<form class="form-horizontal" action="rest/workflowdemo/sampleReceiveRegister/saveSampleInfo?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}" role="form" id="demoform" method="post">
					<div class="form-group">
						<div class="row" style="margin-left:25px;">
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label" for="SampleStartTime" style="float:left;">采样时间：</label>
								<div class="input-group" style="width:120px; float:left;">
									<input class="form-control date-picker" id="SampleStartTime" name="sample_Start_Time" style="width:120px;" type="text" data-date-format="yyyy-mm-dd" value="${ demo.sample_Start_Time}">
									<span class="input-group-addon">
										<i class="icon-calendar bigger-110"></i>
									</span>
								</div>
					        </div>
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label"  style="float:left;">结束时间：</label>
								<div class="input-group" style="width:120px; float:left;">
									<input class="form-control date-picker" id="SampleEndTime" name="sample_End_Time" style="width:120px;" type="text" data-date-format="dd-mm-yyyy" value="${ demo.sample_End_Time}">
									<span class="input-group-addon">
										<i class="icon-calendar bigger-110"></i>
									</span>
								</div>
				            </div>
				            <div class="col-md-3 col-xs-12 col-lg-3">
				                <label class="control-label"  style="float:left; width:70px;">采样人：</label>
								<div class="input-group" style="width:158px; float:left;">
									<input class="form-control" name="sample_Peoper" id="SamplePeoper" style="width:158px;" type="text" value="${ demo.sample_Peoper}"/>
								</div>
				            </div>
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label"  style="float:left;">接收时间：</label>
								<div class="input-group" style="width:120px; float:left;">
									<input class="form-control date-picker" id="ReceiveTime" name="receive_Time" style="width:120px;" type="text" data-date-format="dd-mm-yyyy" value="${ demo.receive_Time}">
									<span class="input-group-addon">
										<i class="icon-calendar bigger-110"></i>
									</span>
								</div>
				            </div>
						</div>
						<div class="row" style="margin-left:25px; margin-top:5px;">
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label"  style="float:left; width:70px;">接收人：</label>
								<div class="input-group" style="width:158px; float:left;">
									<input class="form-control" name="receive_Peoper" id="ReceivePeoper" style="width:158px;" type="text" value="${ demo.receive_Peoper}"/>
								</div>
				            </div>
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label"  style="float:left;">容器种类：</label>
								<div class="input-group" style="width:158px; float:left;">
									<input class="form-control" name="container_Type" id="ContainerType" style="width:158px;" type="text" value="${ demo.container_Type}"/>
								</div>
				            </div>
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label"  style="float:left;">容器规格：</label>
								<div class="input-group" style="width:158px; float:left;">
									<input class="form-control" name="container_Specification" id="ContainerSpecification" style="width:158px;" type="text" value="${ demo.container_Specification}"/>
								</div>
				            </div>
				            <div class="col-md-3 col-xs-12 col-lg-3">
				            	<label class="control-label"  style="float:left;">样品来源：</label>
								<div class="input-group" style="width:158px; float:left;">
									<select class="form-control" name="sample_Source" id="SampleSource" style="width:158px;">
										<option id="s1" value='1'>送样</option>
					                    <option id="s2" value='2'>取样</option>
					                    <option id="s3" value='3'>现场检测</option>
									</select>
								</div>
				            </div>
				        </div>
				        <div class="row" style="margin-left:25px; margin-top:5px;">
				            <div class="col-md-6 col-xs-12 col-lg-6">
				            	<label class="control-label"  style="float:left;">样品外观：</label>
								<div class="input-group" style="width:308px; float:left;">
									<input class="form-control" name="sample_Face" id="SampleFace" style="width:100%;" type="text" value="${ demo.sample_Face}"/>
								</div>
				            </div>
				            <div class="col-md-6 col-xs-12 col-lg-6">
				            	<label class="control-label"  style="float:left;">样品用途：</label>
								<div class="input-group" style="width:308px; float:left;">
									<input class="form-control" name="sample_Use" id="SampleUse" style="width:100%;" type="text" value="${ demo.sample_Use}"/>
								</div>
				            </div>
				        </div>
					</div>
					<input type="hidden" id="actionType" name="actionType" />
					<input id="workids" style="display:none;" value="${ flowRequest.workID}" />
				</form>
			</div>
			<!-- 查询条件结束 -->
			<!-- 菜单操作项tables开始 -->
			<div class="table-header">原始记录</div>
			<div class="row">
				<div class="col-md-8" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button
						<c:forEach items="${ actionNames}" var="actionName">
							<c:if test="${ actionName.CONTROL_NAME == 'btnAdd'}">
								<c:if test="${ actionName.STATE == 3}">
									style="display:none;"
								</c:if>
								<c:if test="${ actionName.STATE == 2}">
									class="btn btn-primary btn-sm disabled"
								</c:if>
							</c:if>
						</c:forEach>
					class="btn btn-primary btn-sm" id="btnAdd">添加</button>

					<button
						<c:forEach items="${ actionNames}" var="actionName">
							<c:if test="${ actionName.CONTROL_NAME == 'btnDelete'}">
								<c:if test="${ actionName.STATE == 3}">
									style="display:none;"
								</c:if>
								<c:if test="${ actionName.STATE == 2}">
									class="btn btn-primary btn-sm disabled"
								</c:if>
							</c:if>
						</c:forEach>
					class="btn btn-primary btn-sm" id="btnDelete">删除</button>
					
					<button
						<c:forEach items="${ actionNames}" var="actionName">
							<c:if test="${ actionName.CONTROL_NAME == 'btnSave'}">
								<c:if test="${ actionName.STATE == 3}">
									style="display:none;"
								</c:if>
								<c:if test="${ actionName.STATE == 2}">
									class="btn btn-primary btn-sm disabled"
								</c:if>
							</c:if>
						</c:forEach>
					class="btn btn-primary btn-sm" id="btnSave">保存</button>
					
					<button
						<c:forEach items="${ actionNames}" var="actionName">
							<c:if test="${ actionName.CONTROL_NAME == 'btnCommit'}">
								<c:if test="${ actionName.STATE == 3}">
									style="display:none;"
								</c:if>
								<c:if test="${ actionName.STATE == 2}">
									class="btn btn-primary btn-sm disabled"
								</c:if>
							</c:if>
						</c:forEach>
					class="btn btn-primary btn-sm" id="btnCommit">提交</button>
					
					<button
						<c:forEach items="${ actionNames}" var="actionName">
							<c:if test="${ actionName.CONTROL_NAME == 'btnReject'}">
								<c:if test="${ actionName.STATE == 3}">
									style="display:none;"
								</c:if>
								<c:if test="${ actionName.STATE == 2}">
									class="btn btn-primary btn-sm disabled"
								</c:if>
							</c:if>
						</c:forEach>
					class="btn btn-primary btn-sm" id="btnReject">驳回</button>
					
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive">
				<table id="gridDealt" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>采样地点</th>
							<th>样品编号</th>
							<th>水样类别</th>
						</tr>
					</thead>
					<tbody id="appendTable">
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 菜单操作项信息datables结束 -->
	</div>
	<jsp:include page="wfCommonSign.jsp"></jsp:include>
	
	<!--弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="formEdit" class="hide">
		<form class="bootbox-form" id="addOrEditForm">
            <strong>采样时间：</strong><input name="FROM_TIME" id="FROM_TIME" type="date" style="height: 30px; width: 160px; margin-bottom:5px;"/><br/>
            <strong>采样地点：</strong><input name="date-picker" id="FROM_ADDRESS" type="text" style="height: 30px; width: 160px; margin-bottom:5px;"/><br/>
            <strong>水样类别：</strong><input name="FROM_TYPE" id="FROM_TYPE" type="text" style="height: 30px; width: 160px; margin-bottom:5px;"/>
        </form>
	</div>
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
		//根据业务主键加载业务数据
		$(document).ready(function(){
			//点击日期控件图标可以显示
			$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
				$(this).prev().focus();
			});
			dateDom();
			getFlag();
			
			$.ajax({
           		type: "POST",
	            url: "rest/workflowdemo/sampleReceiveRegister/getMainBizInfo",
	            cache: false,  //禁用缓存 
	            data: "mainBizKey=${ mainBizKey}",
	            dataType: "json",
	            success: function (result) {
   					$("#ContainerSpecification").val(result.demo[0].container_Specification);
	   				$("#ContainerType").val(result.demo[0].container_Type);
	   				$("#ReceivePeoper").val(result.demo[0].receive_Peoper);
	   				$("#ReceiveTime").val(result.demo[0].receive_Time);
	   				$("#SampleEndTime").val(result.demo[0].sample_End_Time);
	   				$("#SampleFace").val(result.demo[0].sample_Face);
	   				$("#SamplePeoper").val(result.demo[0].sample_Peoper);
	   				$("#SampleStartTime").val(result.demo[0].sample_Start_Time);
	   				$("#SampleUse").val(result.demo[0].sample_Use);
	   				//加载时下拉框选中
            		$("#s"+result.demo[0].sample_Source).attr("selected", "selected");
	            }
        	});
   	   	});
   	   	
   	   	
   	   	function getFlag(){
	 		if("${ flag}" == "2"){
	 			$("#btnAdd").css("display", "none");
	   	   		$("#btnDelete").css("display", "none");
	   	   		$("#btnSave").css("display", "none");
	   	   		$("#btnCommit").css("display", "none");
	   	   		$("#btnReject").css("display", "none");
	 		}
	 	}
   	
   		//datables表复选框全选
   		var param = {};
   		var pars = {};
		$("#allCheck").on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
		});
	
        //加载datables表数据js
   		function dateDom(){
   			$.datepicker.regional['zh-CN'] = { 
			  clearText: '清除', 
			  clearStatus: '清除已选日期', 
			  closeText: '关闭', 
			  closeStatus: '不改变当前选择', 
			  prevText: '<上月', 
			  prevStatus: '显示上月', 
			  prevBigText: '<<', 
			  prevBigStatus: '显示上一年', 
			  nextText: '下月>', 
			  nextStatus: '显示下月', 
			  nextBigText: '>>', 
			  nextBigStatus: '显示下一年', 
			  currentText: '今天', 
			  currentStatus: '显示本月', 
			  monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'], 
			  monthNamesShort: ['一','二','三','四','五','六', '七','八','九','十','十一','十二'], 
			  monthStatus: '选择月份', 
			  yearStatus: '选择年份', 
			  weekHeader: '周', 
			  weekStatus: '年内周次', 
			  dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'], 
			  dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'], 
			  dayNamesMin: ['日','一','二','三','四','五','六'], 
			  dayStatus: '设置 DD 为一周起始', 
			  dateStatus: '选择 m月 d日, DD', 
			  dateFormat: 'yy-mm-dd', 
			  firstDay: 1, 
			  initStatus: '请选择日期', 
			  isRTL: false};
			$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
   			//日期框
			$('.date-picker').datepicker({
                language: 'zh-CN',
                autoclose: true,
                todayHighlight: true
            })
   		}
	</script>
	
	<!--  增删改查  js脚本实现-->
    <script type="text/javascript">
    	var params = {};
    	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
		
		var rows = 0;
		var rowd = 0;
		//弹出框js方法
		function msgDialog(e){
			e.preventDefault();
				var dialog = $( "#formEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>表单字段设置</h4></div>",
					title_html: true,
					buttons: [ 
						{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" );
							} 
						},
						{
							text: "保存",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								var time = $("#FROM_TIME").val();
								var address = $("#FROM_ADDRESS").val();
								var type = $("#FROM_TYPE").val();
								$("#appendTable").append("<tr><td><label><input type='checkbox' class='ace' id='rs' value="+(rowd++)+"><span class='lbl'></span></label></td><td>"+time+"</td><td>"+address+"</td><td>"+type+"</td></tr>");
								$(this).dialog( "close" );
							} 
						}
					]
				});
		}
		
    	//点击添加按钮触发的事件
		$( "#btnAdd" ).on('click', function(e) {
			$("#FROM_TIME").val("");
			$("#FROM_ADDRESS").val("");
			$("#FROM_TYPE").val("");
			msgDialog(e);
		});
		//点击删除按钮触发的事件
		$( "#btnDelete" ).on('click', function(e) {
			if($("#rs:checked").length < 1){
				parent.bootbox.alert("至少选择表格中的一项", function(){});
				return;
			}else{
				$("#rs:checked").each(function() {
					$(this).parents("tr").remove();
				});
	   	    }
		});
		
		//点击提交按钮触发的事件
		$( "#btnCommit" ).on('click', function(e) {
			var params = {};
			params.actionType = "Commit";
			subSave(params);
		});
		
		//点击保存按钮触发的事件
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
			params.mainBizKey="${ mainBizKey}";
			params.signUserID = $("#userIds").html();
			params.signUserName = $("#signName").html();
			params.signOpinion = $("#signOpinion").val();
			var workids = $("#workids").val();
			params.formID = ${ formID};
			params.Sample_Start_Time = $("#SampleStartTime").val();
			params.Sample_End_Time = $("#SampleEndTime").val();
			params.Sample_Peoper = $("#SamplePeoper").val();
			params.Receive_Time = $("#ReceiveTime").val();
			params.Receive_Peoper = $("#ReceivePeoper").val();
			params.Container_Type = $("#ContainerType").val();
			params.Container_Specification = $("#ContainerSpecification").val();
			params.Sample_Source = $("#SampleSource").val();
			params.Sample_Face = $("#SampleFace").val();
			params.Sample_Use = $("#SampleUse").val();
			$.ajax({
	            type: "POST",
	            url: "rest/workflowdemo/sampleReceiveRegister/saveSampleInfo?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}", 
	            cache: false,  //禁用缓存
	            data: params,
	            dataType: "json",
	            success: function (result) {
	            console.log(result);
                     if(result.result == "Success"){
                     	  if(workids.length > 0){
								window.close();
								window.opener.document.location.reload(); //刷新父窗体
							}else{
								parent.addTabs({id:'workList',title:'待办理工作',close: true,url: 'rest/workflow/workPersonal/workList?menuid=104'});
							}
                     }else if(result.result == "Fail"){
                          return;
                     }else if(result.result == "SuccessAndRedo"){
                           $("#SampleStartTime").val("");
		                   $("#SampleEndTime").val("");
		                   $("#SamplePeoper").val("");
		                   $("#ReceiveTime").val("");
		                   $("#ReceivePeoper").val("");
		                   $("#ContainerType").val("");
		                   $("#ContainerSpecification").val("");
		                   $("#SampleSource").val("");
		                   $("#SampleFace").val("");
		                   $("#SampleUse").val("");
                     }else{
                     	/*if(){
                     		parent.bootbox.alert("驳回意见必须填写："+result, function(){});
                     	}else if(){
                     		parent.bootbox.alert("驳回失败的信息："+result, function(){});
                     	}else if(){
                     		window.close();
							window.opener.document.location.reload(); //刷新父窗体
                     	}*/
                     	parent.bootbox.alert("驳回失败的信息："+result, function(){});
                     }
	            },
	            error:function(){
	            	parent.bootbox.alert("操作失败：", function(){});
	            }
	        });
		}
		
	</script>
    
	</body>
</html>

