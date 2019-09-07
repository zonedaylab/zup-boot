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
		
		
		
	</script>
    
	</body>
</html>

