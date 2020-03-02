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
    <div class="row" style="margin: 0 15px;">
		<div>
			<div class="page-header">
				<div class="table-header">签字信息</div>
			</div>
			<div class="row" style="margin-top:20px;">
				<form class="form-horizontal" action="" role="form" id="demoform" method="post">
					<div class="form-group">
						<div class="row" style="margin-left:25px;">
							<label class="control-label"  style="float:left;">意见：</label>
							<textarea rows="5" id="signOpinion" style="width:92%; min-width:92%; max-width:92%;"></textarea>
			        	</div>
			        	<%
			        		//获取session中的用户名称
			        		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		                    String userName = userSession.getRealName();
		                    int userIds = userSession.getUserId();
			        	 %>
			        	 <span style="display:none;" id="userIds"><%=userIds %></span>
			        	<div class="row" style="margin-left:25px;">
			        		<div style="float:left; margin-left:75px;">
								<label class="control-label">签字人：</label>
								<label class="control-label" id="signName"><%=userName %></label>
							</div>
							<div style="float:right; margin-right:100px;">
								<label class="control-label" >签字日期：</label>
								<label class="control-label" id="signTime"></label>
							</div>
			        	</div>
					</div>
				</form>
			</div>
			<!-- 查询条件结束 -->
			<!-- 菜单操作项tables开始 -->
			<div class="table-header">流程环节</div>
			<div class="table-responsive">
				<table id="gridSign" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>活动名称</th>
<!--							<th>操作岗位</th>-->
							<th>签字人</th>
							<th>签字意见</th>
							<th>签字时间</th>
						</tr>
					</thead>
					<tbody id="SignTable">
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 菜单操作项信息datables结束 -->
	</div>
	
	<!--弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="nextSelect" class="hide">
		<form class="bootbox-form" id="nextSelectForm">
           	<div id="nextActivityList" style="margin-bottom:5px; margin-top:5px; border:1px solid #cccccc; padding:10px;">		
           	</div>
        </form>
	</div>
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
   		$(document).ready(function(){
   			if("${ flowRequest.workID}".length > 0){
	   			$.ajax({
		            type: "POST",
		            url: "rest/workflow/workForm/WorkSignList", 
		            cache: false,  //禁用缓存
		            data: "workId=${ flowRequest.workID}",
		            dataType: "json",
		            success: function (result) {
		            	if(result.data.length <= 0){
		            		$("#SignTable").append("<strong style='font-size:14px; margin-left:50px;'>数据为空</strong>");
		            		$("#signOpinion").val("");
		            	}else{
		            		for(var i=0; i<result.data.length; i++){
		            			$("#SignTable").append("<tr><td>"+result.data[i].ACTIVITY_NAME+"</td><td>"+result.data[i].SIGN_NAME+"</td><td>"+result.data[i].SIGN_OPINION+"</td><td>"+result.data[i].SIGN_DATE+"</td></tr>");
		            		}
		            		$("#signOpinion").val(result.data[result.data.length-1].SIGN_OPINION);
		            	}
		            },
		            error:function(){
		            	alert("历史签名数据加载失败");
		            }
		        });
		     }
   		});
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
		var mydate = new Date();
        var year = mydate.getFullYear() + "-";
        var month = (mydate.getMonth() + 1) + "-";
        var day = mydate.getDate() + " ";
        var ymd = year + month + day;
		$("#signTime").html(ymd);
	
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

		var nextActivityflag="";//返回标识
		//弹出框js方法
		function getNextActivityInfo(){
			//获取节点信息
			var paramActivity = {};
			paramActivity.FlowID="${ flowRequest.flowID}";
			paramActivity.ActivityID="${flowRequest.activityID}";
			$.ajax({
				cache: true,
				type: "POST",
				url:"rest/workflow/workPersonal/gvwActivitySel_onDataBound",
				data: paramActivity,// 你的formid
				async: false,
				dataType:"json",
				success: function(data) {
					//如果是结束节点则直接返回
					if(data.activityType==3)//3代表结束节点
					{
						nextActivityflag="Default";
						return;
					}
					var selectType ;
					if(data.batchType==3)//多选
					{
						nextActivityflag="Multiple";
						selectType = "checkbox";
					}
					else if(data.batchType==2)//单选
					{
						nextActivityflag="Single";
						selectType = "radio";
					}
					else//默认
					{
						nextActivityflag="Default";
						return;
					}
					$("#nextActivityList").html("");
					//遍历下一节点
					for(var i=0; i<data.data.length; i++){
						//遍历节点的经办人
						for(var j=0; j<data.data[i].handerList.length; j++){
								$("#nextActivityList").append('<div style="width:100%; height:30px;" class="list-item"><input id="handlerId" class="ace" type="'+selectType+'" name="activityHandlerId" value='+data.data[i].activityID+"-"+data.data[i].activityCode+"-"+data.data[i].handerList[j].HANDLER_ID+"-"+data.data[i].handerList[j].HANDLER+"-"+data.data[i].handerList[j].HANDLER_TYPE+'><span class="lbl" style="white-space:nowrap;">'+data.data[i].activityName+"--"+data.data[i].handerList[j].HANDLER_NAME+'</span></div>');	
							}
					}
					var dialog = $( "#nextSelect" ).removeClass('hide').dialog({
						modal: true,
						title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>下一流程节点操作者选择</h4></div>",
						title_html: true,
						width:450,
						height:450,
						buttons: [ 
							{
								text: "取消",
								"class" : "btn btn-xs",
								click: function() {
									$( this ).dialog( "close" );
								} 
							},
							{
								text: "提交",
								"class" : "btn btn-primary btn-xs",
								click: function() {
									if($("#handlerId:checked").length <= 0){
										parent.bootbox.alert("请选择操作者", function(){});
										return;
									}
									var activityHandlerStr="";
									for(var i=0; i<$("#handlerId:checked").length;i++){
										activityHandlerStr += $("#handlerId:checked")[i].defaultValue+",";
									}
									nextActivityCommit(activityHandlerStr);
									$(this).dialog( "close" );
								} 
							}
						]
					})
				},
	            error:function(){
					flag="Default";
					return;
	            }
			});
			return nextActivityflag;
		}
		
		
		
	</script>
    
	</body>
</html>

