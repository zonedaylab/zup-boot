<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
	<meta charset="utf-8" />
	<base href=" <%=basePath%>">
	<title>交易市场认定基数配置</title>
	<!--	引入外部样式库css	-->
	<jsp:include page="../include/mainHead.jsp"></jsp:include>
	<!--        定义适应屏幕的css样式 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
</head>

<body style="background-color:#fff">
	<div class="container-fluid" style="margin-top: 15px;">
		<!-- 查询条件-->
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group clearfix">
						<div class="col-xs-4 text-right">
							<label>用户名称：</label>
						</div>
						<div class="col-xs-6 col-md-8">
							<input id="merchantName" type="text" class="form-control" readonly="readonly"  />
							<input id="merchantId" type="text" class="form-control hide" readonly="readonly"  />
							<input id="cardinalId" type="text" class="form-control hide" readonly="readonly"  />
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group clearfix">
						<div class="col-xs-4 col-md-3 text-right">
							<label>年份：</label>
						</div>
						<div class="col-xs-6 col-md-8">
							<input type="text" id="planYearHead" class="form-control" readonly="readonly" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group clearfix">
						<div class="col-xs-4 text-right">
							<label>交易品种：</label>
						</div>
						<div class="col-xs-6 col-md-8">
							<input type="text" class="form-control" readonly="readonly" id="tradeCategoryHead" />
							<input type="text" class="form-control hide" readonly="readonly" id="tradeCategoryId" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 查询条件结束 -->
		<hr />
		<div class="row buttonGroup">
			<div class="col-xs-10">
				<button type="button" id="btnCondition" class="btn btn-primary btn-sm">选择交易品种</button>
				<button type="button" id="btnSave" class="btn btn-primary btn-sm">保存</button>
				<button type="button" id="btnCommit" class="btn btn-primary btn-sm">提交</button>
			</div>
			<div class="col-xs-2">
				<label style="color: #999;">电量单位：兆瓦时</label>
			</div>
		</div>
		<table id="energyCardinalTable"
			class="table table-striped table-bordered table-hover"
			style="table-layout: fixed;">
			<thead>
				<tr>
					<th width="80px">月份</th>
					<th>认定基数</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="noEdit">1月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">2月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">3月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">4月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">5月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">6月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">7月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">8月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">9月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">10月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">11月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
				<tr>
					<td class="noEdit">12月</td>
					<td class="demandAmountDemand" name="demandAmountTd"></td>
					<td name="memo"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="form-group clearfix">
					<div class="col-xs-4 text-right">
						<label>制作人：</label>
					</div>
					<div class="col-xs-6 col-md-8">
						<input id="userName" type="text" class="form-control" readonly="readonly"  />
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group clearfix">
					<div class="col-xs-4 col-md-3 text-right">
						<label>制作时间：</label>
					</div>
					<div class="col-xs-6 col-md-8">
						<input type="text" class="form-control" readonly="readonly" id="createTime" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 弹出窗口 -->
	<div id="saleCardinalDialog" class="hide">
			<div class="container" style="margin-top:20px">
				<div class="row clearfix">
					<div class="col-xs-12 column">
						<div class="form-horizontal" role="form">
							<div class="form-group">
								<div class="col-xs-3 control-label">
									<label>年份：</label>
								</div>
								<div class="col-xs-8">
									<select class="form-control" id="planYearQuery" type="text" >
										<option value='0'>请选择</option>
									</select>
								</div>
								<div class="col-xs-1">
									<font color=red style="position: absolute; top: 7px; left: -2px;">*</font>
								</div>
							</div>
							<div class="form-group">	
								<div class="col-xs-3 control-label">
									<label>交易品种：</label>
								</div>
								<div class="col-xs-8">
									<select class="form-control" id="tradeCategoryQuery" type="text" >
									<option value='0'>请选择</option>
									</select>
								</div>
								<div class="col-xs-1">
									<font color=red style="position: absolute; top: 7px; left: -2px;">*</font>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>
	<!-- 引入可编辑table js -->
	<script type="text/javascript" src="plug-in/tools/function.js?date=<%=new Date()%>"></script>
	<script type="text/javascript" src="plug-in/ace/editTable/js/jqueryEditUseBlur.js?date=<%=new Date()%>"></script>
	<script type="text/javascript">
		//jquery ui  title html 
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if(("title_html" in this.options) && this.options.title_html == true)
					title.html($title);
				else title.text($title);
			}
		}));
		
		$(function(){
			$("#merchantName").val("${organName}");
			$("#merchantId").val("${organId}");
			$("#userName").val("${userName}");
			$("#createTime").val("${nowTime}");
			setBtnDisplayFlag();//在已办中隐藏保存提交按钮
			
		});
		
		//待办已办中隐藏保存提交按钮
		function setBtnDisplayFlag() {
			//待办中打开
			if("${ mainBizKey}") {
				$("#btnCondition").css("display", "none");
				$("#mainBizKey").val("${mainBizKey}");
				getMainBizInfo();
			}
			//已办中打开
			if("${param.flag}" == "2") {
				$("#btnCondition").css("display", "none");
				$("#btnSave").css("display", "none");
				$("#btnCommit").css("display", "none");
				$("tbody tr td").off('click'); //取消表格的编辑
				
			}
		}
		$('#btnCondition').click(function(){
			saleCardinalDialog(); //条件弹出框
			listTradeCategory();//拉取弹窗数据
			getPlanYear();// 拉取年份
		})
		
		//点击保存按钮
		$("#btnSave").click(function() {
			var actionType = "Save";
			isNotEmptyValidate(actionType);
		});
		
		//提交按钮
		$("#btnCommit").click(function() {
			var actionType = "Commit";
			isNotEmptyValidate(actionType);
		});
		
		//可编辑表格非空验证
		function isNotEmptyValidate(actionType) {
			if($("#planYearHead").val() == "") {
				parent.bootbox.alert("<h4>请选择年份。</h4>请进入电力用户详情选择相应的年份");
				return;
			}
			if($("#tradeCategoryHead").val() == "") {
				parent.bootbox.alert("<h4>请选择交易品种。</h4>请进入电力用户详情选择相应的交易品种");
				return;
			}
			var flag = true;
			var trList = $("tbody").children("tr");
			var num = 0
			trList.each(function() {
				if(num < (trList.length - 1)) {
					var tdList = $(this).find("td");
					var num2 = 0;
					tdList.each(function() {
						if(num2 < (tdList.length - 1)) {
							var thisTd = $(this).html();
							if(thisTd.length <= 0) {
								flag = false;
								return false;
							}
						}
						num2++;
					});
					if(flag == false) {
						parent.bootbox.alert("表格内容不允许有空值");
						return false;
					}
				}
				num++;
			});
			if(flag == true) {
				energyCardinalManage(actionType);
			}
		}
		
		var energyCardinal = {};
		//保存计划单
		function energyCardinalManage(actionType) {
			energyCardinal.amounts = new Array();
			if( $('#cardinalId').val() != null){
				energyCardinal.cardinal_Id = $('#cardinalId').val();
			}
			energyCardinal.plan_Year = $('#planYearHead').val();
			energyCardinal.merchant_Name = $('#merchantName').val();
			energyCardinal.merchant_Id = $('#merchantId').val();
			energyCardinal.trade_Category = $('#tradeCategoryId').val();
			energyCardinal.user_Name = $('#userName').val();
			energyCardinal.create_Time =new Date($('#createTime').val());
			//封装明细信息
			var tb = document.getElementById("energyCardinalTable"); //根据id找到这个表格
			var rows = tb.rows;
			for(var i = 1; i < rows.length; i++) { //循环遍历所有的tr行
				energyCardinal.amounts[i - 1] = "";
				for(var j = 0; j < rows[i].cells.length; j++) { //取得第几行下面的td个数，再次循环遍历该行下面的td元素
					var cell = rows[i].cells[j]; //获取某行下面的某个td元素
					var cellNum = cell.innerHTML;
					energyCardinal.amounts[i - 1] += cellNum + ",";
				}
			}
			//隐藏保存、提交按钮
			$("#btnSave").css("display", "none");
			$("#btnCommit").css("display", "none");
			$.ajax({
				url: "rest/rbac/saleCardinalManageController/saveEnergySaleCardinal?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}&actionType=" + actionType+"&activityID=${flowRequest.activityID}",
				dataType: "json",
				data: energyCardinal,
				method: "POST",
				success: function(result) {
					var workids = "${ flowRequest.workID}";
					if(result.result == "Success") {
						if(workids.length > 0) {
							window.close();
							window.opener.document.location.reload(); //刷新父窗体
						}else {
							if(actionType == "Save") {
								window.location.reload();
								parent.addTabs({id: 124,title: '待办理工作',close: true,url: 'rest/workflow/workPersonal/workList?menuid=124'});
							}else if(actionType == "Commit") {
								window.location.reload();
								parent.addTabs({id: 125,title: '已办理工作',close: true,url: 'rest/workflow/workPersonal/WorkFinish?menuid=125'});
							}
						}
					} else if(result.result =="noHandler" ){
						parent.bootbox.alert("抱歉，流程的下一个节点没有配置操作者，避免您的工作提交后无人接收，请在流程配置中配置相应的消息操作者。");
						$("#btnSave").css("display", "inline-block");
						$("#btnCommit").css("display", "inline-block");
						return;
					} else {
						$("#btnSave").css("display", "inline-block");
						$("#btnCommit").css("display", "inline-block");
						parent.bootbox.alert("驳回失败的信息：" + result, function() {});
					}
				},
				error: function(data) {
					$("#btnSave").css("display", "inline-block");
					$("#btnCommit").css("display", "inline-block");
					parent.bootbox.alert("保存出错，请刷新重试");
				}
			});
		}
		
		validate(); // 绑定表格所有单元格 change事件，请在表格所有数据加载完成后调用
		// 绑定表格所有单元格 change事件，请在表格所有数据加载完成后调用
		function validate() {
			$('table tr td').change(function() {
				if($("#planYearHead").val() == "") {
					parent.bootbox.alert("<h4>请选择年份。</h4>请进入电力用户详情选择相应的年份");
					return;
				}
				if($("#tradeCategoryHead").val() == "") {
					parent.bootbox.alert("<h4>请选择交易品种。</h4>请进入电力用户详情选择相应的交易品种");
					return;
				}
			})
		}
		
		//条件弹出框
		function saleCardinalDialog() {
			var dialog = $("#saleCardinalDialog").removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>认定基数配置选择</h4></div>",
				title_html: true,
				resizable:false, // 是否允许改变大小
				width: 500,
				height: 280,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn",
						click: function() {
							$(this).dialog("close");
						} 
					},
					{
						text: "确定",
						"class" : "btn btn-primary",
						click: function() {
							if($("#planYearQuery").val()==0){
								parent.bootbox.alert("请选择年份");
			   				 	return;
							}
							if($("#tradeCategoryQuery").val()==0){
								parent.bootbox.alert("请选择交易品种");
			   				 	return;
							}
							$('#planYearHead').val($('#planYearQuery option:checked').text());
							$('#tradeCategoryHead').val($('#tradeCategoryQuery option:checked').text());
							$('#tradeCategoryId').val($('#tradeCategoryQuery').val());
							$(this).dialog("close");
							loadTableData();
						} 
					}
			]
			});
		}
		
		//加载交易市场和交易品种
		 function listTradeCategory(){
    	   $.ajax({
               type: "POST",
               url: "rest/rbac/saleCardinalManageController/listTradeCategory", 
               cache: false,  //禁用缓存
               dataType: "json",
               async:false,
               success: function (result) {
          	    	$("#tradeCategoryQuery").html(""); 
          	    	$("#tradeCategoryQuery").append("<option value='0'>请选择</option>");
                   for(var i=0;i<result.data.length;i++){
	                   $("#tradeCategoryQuery").append("<option value='"+result.data[i].trade_Category_Id+"'>"+result.data[i].trade_Category+"</option>");
					}
               },
               error:function(){	            	
              	}
          	});
		}
		
		//获取所有的年份
		function getPlanYear() {
			$.ajax({
				url: "rest/rbac/saleCardinalManageController/listPlanYear",
				dataType: "JSON",
				method: "POST",
				async:false,
				success: function(data) {
					$("#planYearQuery").html("");
					$("#planYearQuery").append("<option value='0'>请选择</option>");
					for(var i = 0; i < data.data.length; i++) {
						$("#planYearQuery").append("<option value='" + data.data[i] + "'>" + data.data[i] + "</option>");
					}
				}
			});
		}
		
		//进入待办以办根据业务主键获取业务信息
		function getMainBizInfo() {
			$.ajax({
				type: "POST",
				url: "rest/rbac/saleCardinalManageController/getMainBizInfo",
				cache: false, //禁用缓存 
				data: "mainBizKey=${ mainBizKey}",
				dataType: "json",
				async: false,
				success: function(result) {
					$('#planYearHead').val(result.data[0].plan_Year);
					$('#merchantName').val(result.data[0].merchant_Name);
					$('#merchantId').val(result.data[0].merchant_Id);
					$('#tradeCategoryHead').val(result.data[0].tradeCategoryString);
					$('#tradeCategoryId').val(result.data[0].trade_Category);
					$('#userName').val(result.data[0].user_Name);
					$('#createTime').val(result.data[0].create_Time);
					loadTableData();
				}
			});
		}
		
		//加载表格数据
		function loadTableData() {
			var par = {};
			par.merchant_Id = $("#merchantId").val();
			par.trade_Category = $("#tradeCategoryId").val();
			par.plan_Year = $("#planYearHead").val();
			for(var i = 0; i<12; i++){
				var CardinalList = $("tbody").find("tr").find("td[name='demandAmountTd']"); //需求电量
				var memoList = $("tbody").find("tr").find("td[name='memo']"); //上年度用户结算电量汇总
				CardinalList.eq(i).text("");
				memoList.eq(i).text("");
			}
			$.ajax({
				url: "rest/rbac/saleCardinalManageController/loadTableData",
				dataType: "JSON",
				data: par,
				method: "POST",
				async:false,
				success: function(data) {
					//如果用户已经做过基数配置，赋值表格
					if(data.data != null){
						var CardinalList = $("tbody").find("tr").find("td[name='demandAmountTd']"); //需求电量
						var memoList = $("tbody").find("tr").find("td[name='memo']"); //上年度用户结算电量汇总
						for(var i = 0; i<CardinalList.length; i++){
							
							CardinalList.eq(i).text(toDecimal3(data.data[i].cardinal_Number));
							
							
							memoList.eq(i).text(data.data[i].detail_Memo);
						}
						//赋值基数Id
						$("#cardinalId").val(data.energySaleCardinalEntity.cardinal_Id);
						//如果做过认定基数且是在菜单中打开，取消编辑表格隐藏按钮。
						if("${ mainBizKey}" == ""){
							$("tbody tr td").off('click');
							$('#btnSave').addClass("hide");
							$('#btnCommit').addClass("hide");
						}
					//如果没有做过基数配置
					} else {
						//且是在菜单中打开，启用编辑表格，显示按钮
						if("${ mainBizKey}" == ""){
							$('td[class!="noEdit"]').click(tdClick);
							$('#btnSave').removeClass("hide");
							$('#btnCommit').removeClass("hide");
						} 
					}
				},
				error: function(data) {
					parent.bootbox.alert("数据加载失败，请刷新重试");
				}
			});
		}
		
	</script>
</body>
</html>
