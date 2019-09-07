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
							<label>交易市场：</label>
						</div>
						<div class="col-xs-6 col-md-8">
							<input id="marketNameHead" type="text" class="form-control" readonly="readonly"  />
							<input id="marketIdHead" type="text" class="form-control hide" readonly="readonly"  />
							<input id="cardinalIdHead" type="text" class="form-control hide" readonly="readonly"  />
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
							<div class="col-xs-4  text-right">
								<label>售电公司：</label>
							</div>
							<div class="col-xs-6  col-md-8">
								<input id="organName" type="text" class="form-control" readonly="readonly"  />
								<input id="organId" type="text" class="form-control hide" readonly="readonly"  />
							</div>
						</div>
					</div>
				<div class="col-md-6">
					<div class="form-group clearfix">
						<div class="col-xs-4 col-md-3 text-right">
							<label>交易品种：</label>
						</div>
						<div class="col-xs-6 col-md-8">
							<input type="text" class="form-control" readonly="readonly" id="tradeCategoryHead" />
							<input type="text" class="form-control hide" readonly="readonly" id="tradeCategoryIdHead" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 查询条件结束 -->
		<hr />
		<div class="row buttonGroup">
			<div class="col-xs-10">
				<button type="button" id="btnCondition" class="btn btn-primary btn-sm">选择交易市场</button>
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
					<th width="50px">序号</th>
					<th width="200px">用户名称</th>
					<th>1月</th>
					<th>2月</th>
					<th>3月</th>
					<th>4月</th>
					<th>5月</th>
					<th>6月</th>
					<th>7月</th>
					<th>8月</th>
					<th>9月</th>
					<th>10月</th>
					<th>11月</th>
					<th>12月</th>
				</tr>
			</thead>
			<tbody id="cardinalDataTable">
			<tr>
				<td colspan="14" align="center" class="noEdit">请选择交易市场</td>
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
									<label>交易市场：</label>
								</div>
								<div class="col-xs-8">
									<select class="form-control" id="marketQuery" type="text" >
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
			$("#organName").val("${organName}");
			$("#organId").val("${organId}");
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
				//$("tbody tr td").off('click'); //取消表格的编辑
				
			}
		}
		$('#btnCondition').click(function(){
			saleCardinalDialog(); //条件弹出框
			getPlanYear();// 拉取年份
			listEnergyMarket();//拉取交易市场
			$("#marketQuery").change(function(){
				var marketVal = $("#marketQuery").val();
				if(marketVal != 0)
					listTradeCategory(marketVal);//拉取交易市场下的交易品种
			})
			
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
				parent.bootbox.alert("<h4>请选择年份。</h4>请进入选择交易市场选择相应的年份");
				return;
			}
			if($("#marketNameHead").val() == "") {
				parent.bootbox.alert("<h4>请选择交易品种。</h4>请进入选择交易市场选择相应的交易市场");
				return;
			}
			if($("#tradeCategoryHead").val() == "") {
				parent.bootbox.alert("<h4>请选择交易品种。</h4>请进入选择交易市场选择相应的交易品种");
				return;
			}
			var flag = true;
			var trList = $("tbody1").children("tr");
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
			energyCardinal.trade_Category = $('#tradeCategoryIdHead').val();
			energyCardinal.user_Name = $('#userName').val();
			energyCardinal.create_Time =new Date($('#createTime').val());
			//封装明细信息
			var tb = document.getElementById("cardinalDataTable"); //根据id找到这个表格
			var rows = tb.rows;
			console.log(rows[0].cells[1])
			for(var i = 0; i < rows.length; i++) { //循环遍历所有的tr行
				energyCardinal.amounts[i] = "";
				for(var j = 1; j < rows[i].cells.length; j++) { //取得第几行下面的td个数，再次循环遍历该行下面的td元素
					var cell = rows[i].cells[j]; //获取某行下面的某个td元素
					var cellNum = cell.innerHTML;
					energyCardinal.amounts[i] += cellNum + ",";
				}
			}
			//隐藏保存、提交按钮
			$("#btnSave").css("display", "none");
			$("#btnCommit").css("display", "none");
			$.ajax({
				url: "rest/rbac/energySaleCardinalController/saveEnergySaleCardinal?flowID=${ flowRequest.flowID}&workID=${ flowRequest.workID}&workItemID=${ flowRequest.workItemID}&actionType=" + actionType+"&activityID=${flowRequest.activityID}",
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
				height: 320,
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
							if($("#marketQuery").val()==0){
								parent.bootbox.alert("请选择交易市场");
			   				 	return;
							}
							if($("#tradeCategoryQuery").val()==0){
								parent.bootbox.alert("请选择交易品种");
			   				 	return;
							}
							$('#planYearHead').val($('#planYearQuery option:checked').text());//头部年份
							$('#marketNameHead').val($('#marketQuery option:checked').text());//交易市场
							$('#marketIdHead').val($('#marketQuery').val());//交易市场ID
							$('#tradeCategoryHead').val($('#tradeCategoryQuery option:checked').text());//交易品种
							$('#tradeCategoryIdHead').val($('#tradeCategoryQuery').val());//交易品种ID
							$(this).dialog("close");
							ListMerchantName();
							//loadTableData();
						} 
					}
			]
			});
		}
		
		//加载所属交易市场
		function listEnergyMarket(){
	        $.ajax({
	        	type:"POST",
	        	url:"rest/rbac/MerchantRegistFlowController/listEnergyMarket",
	        	dataType:"json",
	        	cache: false,
	        	success:function (result){
	        		$('#marketQuery').html('');
	        		$('#marketQuery').append("<option value='0'>请选择</option>");	
	        		for(var i=0;i<result.data.length;i++){
	        			$('#marketQuery').append("<option value='"+result.data[i].market_Id+"'>"+result.data[i].market_Name+"</option>");
	            	}
	        		
	        	},
	        	error:function(){}
	        })
		}
		
        
		//交易品种
		 function listTradeCategory(marketId){
    	   $.ajax({
               type: "POST",
               url: "rest/rbac/energySaleCardinalController/listTradeCategory", 
               data: "market_Id="+marketId,
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
					//loadTableData();
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
							//$("tbody tr td").off('click');
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
		
		
		//获取该交易市场下的本公司用户
		function ListMerchantName(){
			var marketIdHeadVal = $('#marketIdHead').val();
			var organIdVal = $('#organId').val();
			$("#cardinalDataTable").html('');
			$.ajax({
				url:'rest/rbac/energySaleCardinalController/getEnergyMerchant',
				dataType: "JSON",
				data: {
					'marketId':marketIdHeadVal,
					'departmentId':organIdVal
				},
				method: "POST",
				async:false,
				success: function(data) {
					
					if(data.data.length>0){
						//循环该交易市场下的用户
						for(var i = 0 ;i < data.data.length; i++){
							$("#cardinalDataTable").append("<tr><td class='noEdit'>"+(i+1)+"</td><td class='noEdit'>" + data.data[i].merchant_Name + "</td><td style='display:none'>"+ data.data[i].organid +"</td><td></td><td></td><td></td><td></td><td></td><td></td>"
										+"<td></td><td></td><td></td><td></td><td></td><td></td></tr>")
						}
					} else {
						//提示该交易市场下暂无用户
						$("#cardinalDataTable").append('<tr><td colspan="14" align="center" class="noEdit">该交易市场下暂无本公司用户</td></tr>');
					}
				},
				error: function(data) {
					parent.bootbox.alert("获取交易市场下用户失败，请重试。");
					$("#cardinalDataTable").append('<tr><td colspan="14" align="center" class="noEdit">获取交易市场下用户失败，请重试。</td></tr>');
				}
			})
		}
	</script>
</body>
</html>
