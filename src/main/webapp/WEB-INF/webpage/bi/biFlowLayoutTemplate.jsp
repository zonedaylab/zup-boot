<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="plug-in/ace/flowLayout/css/bootstrap.min.css" >
		<link rel="stylesheet" type="text/css" href="plug-in/ace/flowLayout/css/sub-station.css" />
		<link rel="stylesheet" type="text/css" href="plug-in/ace/flowLayout/css/gridstack.min.css" />
		<link rel="stylesheet" type="text/css" href="plug-in/ace/flowLayout/css/flowLayout.css"/>
		<link rel="stylesheet" href="plug-in/ace/flowLayout/css/bootstrap.min.css" >
		<link rel="stylesheet" type="text/css" href="plug-in/ace/flowLayout/css/bootstrap-select.min.css" />
		<link href="plug-in/ace/adIcon/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			.btn-default-none{
				padding: 0;
			    border: 0;
			    background: transparent;
			}
			.panel-heading .fa {
			    font-size: 15px;
			    margin-right: 5px;
			    vertical-align: initial;
			}
			.panel-default>.panel-heading{
				background-color: #e0e0e0;
				border-color:#bbb;
			}
			.panel-default {
			    border-color: #bbb;
			}
		</style>
	</head>

	<body>
		<div>
			<div class="subNav ">
				<div class="subNavLeft pull-left">
					<div>
						<i class="glyphicon glyphicon-globe"></i>
						<span>${pageTitle}</span>
					</div>
				</div>
				<div class="subNavCenter pull-left">
					<div>
						<i class="fa fa-pied-piper"></i>
						<span>当前时间：</span>
						<small id="dateTime"></small>
					</div>
				</div>
				<div class="pull-right" style="margin-top: 20px">
					<button type="button" class="btn btn-default pull-right" id="btn_add"><span class="glyphicon glyphicon-plus"></span></button>
				</div>
			</div>
			<!--内容板块-->
			<div id="main" style="margin-top: 20px;">
				<div class="grid-stack"></div>
			</div>
		</div>

		<div class="utils hidden">
			<div class="util" id="saveLayout">
				<span class="glyphicon glyphicon-floppy-saved"></span>
				<p>保存</p>
			</div>
			<!-- <div class="util">
				<span class="glyphicon glyphicon-floppy-remove"></span>
				<p>重置</p>
			</div> -->
		</div>
		<!--内容板块end-->
		<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'></script>
		<script src="plug-in/ace/adIcon/js/echarts.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="plug-in/ace/flowLayout/js/shine.js" type="text/javascript" charset="utf-8"></script><!-- echarts皮肤 -->
		<script src="plug-in/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
		<script src="plug-in/ace/js/day.js"></script>
		<script src="plug-in/ace/flowLayout/js/jquery-ui.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="plug-in/ace/flowLayout/js/lodash.min.js"></script>
		<script src="plug-in/ace/flowLayout/js/gridstack.js" type="text/javascript" charset="utf-8"></script>
		<script src="plug-in/ace/flowLayout/js/gridstack.jQueryUI.js" type="text/javascript" charset="utf-8"></script>
		<script src="plug-in/ace/flowLayout/js/bootstrap-select.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="plug-in/ace/flowLayout/js/defaults-zh_CN.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			var screen = JSON.parse('${screen}');
			$(function() {
				setInterval(() => {
					$("#dateTime").text(dayjs().format("YYYY-MM-DD HH:mm:ss"));
				}, 1000);
				getReportData(); //获取数据
			});
			
			//触发布局改变事件
			$("#main").on('change',".grid-stack", function(event, items) {
				if(items != "undefined" && $(".utils").hasClass("hidden")) {
					$(".utils").removeClass("hidden");
				}
			});

			/**
			 * 保存布局
			 */
			$("#saveLayout").click(function() {
				saveLayout();
				$(".utils").addClass("hidden");
			})
			
			//保存布局的方法
			function saveLayout(flag = true){
				$("[data-gs-x]").each(function() {
					var $this = $(this);
					var param = {};
						param.report_Id = $this.attr("data-reportId");//报表id
						param.block_Id =  $this.attr("data-blick");//区块ID
						param.x_Point = $this.attr("data-gs-x");
						param.y_Point = $this.attr("data-gs-y");
						param.width = $this.attr("data-gs-width");
						param.height = $this.attr("data-gs-height");
						param.bi_Page_Id = '${pageId}';
						param.block_Type =  $this.attr("data-blicktype");
						param.screen_Index = screen[0].screen_Index;
					if(param.report_Id == "" || param.report_Id == null){
						return true; 
					}
					console.log(param)
					$.ajax({
						type: "post",
						url: "/rest/bi/biPageBlockController/updateBlock",
						async:false,
						data:param,
						dataType: "json",
						success: function(result) {
							if(flag){
								layer.msg("保存成功！");
							}
						}, 
						error: function(error) {
							layer.msg("保存失败！");
						}
					});
				})
			}

			$(window).on('beforeunload',function(){
				if(!$(".utils").hasClass("hidden")){
					return false;
				}
			});
			
			
			var keys=[],values=[];
			//获取图表数据
			function getReportData() {
				$("#main").html('<div class="grid-stack"></div>');
				index = layer.load(0, {
					skin: 'i-loading',
					shade: 0.1,
					content: '<div class="sk-wave"><div class="sk-rect sk-rect1"></div><div class="sk-rect sk-rect2"></div><div class="sk-rect sk-rect3"></div><div class="sk-rect sk-rect4"></div><div class="sk-rect sk-rect5"></div></div>'
				});
				
				var data={
					bi_Page_Id: ${pageId},
					screen_Index: screen[0].screen_Index,
					block_Id: 0,
					key:keys,
					value:values,
					block_Type: 0
				};
				$.ajax({
					type: "post",
					url: "/Bi/getReportData",
					data:JSON.stringify(data),
					contentType:'application/json;charset=utf-8',
					dataType: "json",
					success: function(result) {
						var resultData = result.data
						//准备DOM
						for(var i = 0; i < resultData.length; i++) {
							var blockInfo = resultData[i].blockInfo;
							var btn = '<button type="button" class="btn btn-default-none blick-close dropdown-toggle pull-right" style="margin-left:10px">'+
									'<span class="glyphicon glyphicon-remove"></span>'+
								 	 '</button>'+
								 	 '<div class="btn-group pull-right">'+
									  '<button type="button" class="btn btn-default-none dropdown-toggle btn-source" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-left:10px">'+
									  ' <span class="glyphicon glyphicon-cog"></span>'+
									  '</button>'+
									 ' <ul class="dropdown-menu repurt">'+
									  '</ul>'+
									' </div>'+
									'<div class="btn-group pull-right">'+
									  '<button type="button" class="btn btn-default-none dropdown-toggle btn-chartsType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-left:10px">'+
									  '<i class="fa fa-bar-chart"></i>'+
									  '</button>'+
									 ' <ul class="dropdown-menu chartsType">'+
									 ' <li><a href="javascript:;" chartsType="3">折线图</a></li>'+
									 ' <li><a href="javascript:;" chartsType="2">柱状图</a></li>'+
									  '</ul>'+
								' </div>';
							var dom = '<div data-blick="'+ blockInfo.block_Id +'" data-reportId="'+blockInfo.report_Id+'" data-blickType="'+blockInfo.block_Type+'" class="grid-stack-item" data-gs-x="'+ blockInfo.x_Point +'" data-gs-y="'+ blockInfo.y_Point +'" data-gs-width="'+ blockInfo.width +'" data-gs-height="'+ blockInfo.height +'">'+
								'<div class="panel panel-default grid-stack-item-content" style="overflow: visible;">'+
								'<div class="panel-heading"><i class="fa fa-tachometer"></i>'+resultData[i].reportInfo.report_Title+btn+'</div>'+
								'<div class="xy_hidden">'+
								'<div class="echarts" style="height: 100%;">'+
								'</div></div></div></div>';
							$("#main").find(".grid-stack").append(dom);
						}
						
						$('.grid-stack').gridstack({
							cell_height: 1,
							vertical_margin: 0
						});
						var grid = $("#main").find(".grid-stack").data('gridstack');
						grid.minHeight($("[data-gs-height]"), 140);
						
						//准备Echarts
						for(var i = 0; i < resultData.length; i++) {
							console.log(resultData[i])
							var result = getData(resultData[i]);
							areaEcharts(resultData[i]["blockInfo"].block_Id,result);
						}
						layer.close(index);
						getReportListByPageId(); //获取数据源
						$(".utils").addClass("hidden");
					},
					error: function() {
							layer.close(index);
					}
				});
			}
			
			//图表数据对象
			function getData(resultData) {
				var result = {
					title: '',
					xAxisName: '',
					yAxisNmae: [],
					legendData: [],
					xAxisData: [],
					seriess: []
				}
				var obj = resultData, //当前数据对象
					data = obj["data"],//数据
					dimField = obj["dimHeader"],//X坐标map对象名称
					topicField = obj["topicField"],// Y坐标map对象名称
					topicFieldName = obj["topicFieldName"], // 数据汉字名称
					reportInfo = obj["reportInfo"], //数据对象
					unit = obj["unit"], //单位
					blockType = obj.blockInfo.block_Type;
				//获取title
				result.title = reportInfo.report_Title;

				//处理x轴
				for(var x = 0; x < data.length; x++) {
					result.xAxisData.push(data[x][dimField[0]]);
				}

				//处理y轴
				for(var y = 0; y < topicField.length; y++) {
					var series = {
						name: '',
						type: '',
						data: []
					}
					//Y轴数值
					for(var i = 0; i < data.length; i++) {
						series.data.push(data[i][topicField[y]]);
					}
					series.type = (blockType == 3 ? "line":"bar");
					result.yAxisNmae.push(unit[y]);
					
					//Y轴数值name
					series.name = topicFieldName[y];
					result.legendData.push(topicFieldName[y]);
					result.seriess.push(series);
				}
				//处理name值

				return result;
			}
			
			//新建echarts的方法
			function areaEcharts(id,result) {
				if(JSON.stringify(result) != "{}") {
					var myChart = echarts.init($('[data-blick="'+id+'"] .echarts').get(0),"shine");
					var option = {
						tooltip: {
							trigger: 'axis',
							axisPointer: { // 坐标轴指示器，坐标轴触发有效
								type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
							},
							formatter: function(params) {
								var res = params[0].name;
								for(var i = 0; i < params.length; i++) {
									var decimal = "";
									if(String(params[i].value).indexOf('.') > -1) {
										decimal = Number(params[i].value).toFixed(3)
									} else {
										decimal = params[i].value;
									}
									res += '<br/>' + params[i].marker + params[i].seriesName + ' : ' + decimal + ' / ' + result.yAxisNmae[i];
								}
								return res;
							},
							position: function(pos, params, dom, rect, size) {
								// 鼠标在左侧时 tooltip 显示到右侧，鼠标在右侧时 tooltip 显示到左侧。
								var obj = {
									top: 60
								};
								obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 5;
								return obj;
							}
						},
						dataZoom: [{
							show: true,
							realtime: true,
							
						}],
						legend: {
							data: []
						},
						grid: {
							left: '20px',
							right: '20px',
							bottom: '50px',
							containLabel: true
						},
						xAxis: [{
							type: 'category',
							name: '',
							data: []
						}],
						yAxis: [{
							type: 'value',
						}],
						series: []
					};
					myChart.clear();
					option.xAxis[0].data = result.xAxisData; //赋值X轴
					option.series = result.seriess; //图表数据series对象
					option.legend.data = result.legendData; //图例
					option.xAxis[0].name = result.xAxisName; //X轴名称
					myChart.setOption(option);
					$(window).resize(function() {
						myChart.resize();
					})
				}
			}
			
			//获取数据源信息
			function getReportListByPageId() {
				$.ajax({
					type: "get",
					url: "/rest/bi/biReportController/getReportListByPageId",
					data:{
						pageId:'${pageId}',
						screenIndex: JSON.parse('${screen}')[0].screen_Index
					},
					dataType: "json",
					success: function(result) {
						$('.repurt').empty()
						for(var i = 0;i<result.data.length;i++){
							$('.repurt').append("<li><a href='javascript:;' repurtId="+result.data[i].report_Id+">"+result.data[i].report_Name+"</a></li>");
						}
					}, 
					error: function(error) {
						console.log(error)
					}
				});
			}
			
			//添加新图表
			$("#btn_add").click(function(){
				var mark = true;
				$("[data-gs-x]").each(function() {
					var reportId = $(this).attr("data-reportId");//报表id;
					if(reportId == ""){
						layer.alert("您有空白项，请选择报表完成后再添加。");
						mark = false;
						return false;
					}
				})
				if(mark){
					var btn = '<button type="button" class="btn btn-default-none blick-close dropdown-toggle pull-right" style="margin-left:10px">'+
						'<span class="glyphicon glyphicon-remove"></span>'+
					 	 '</button>'+
					 	 '<div class="btn-group pull-right">'+
						  '<button type="button" class="btn btn-default-none dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'+
						  ' <span class="glyphicon glyphicon-cog"></span>'+
						  '</button>'+
						 ' <ul class="dropdown-menu repurt">'+
						  '</ul>'+
					' </div>'+
					'<div class="btn-group pull-right">'+
					  '<button type="button" class="btn btn-default-none dropdown-toggle btn-chartsType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-left:10px">'+
					  '<i class="fa fa-bar-chart"></i>'+
					  '</button>'+
					 ' <ul class="dropdown-menu chartsType">'+
					 ' <li><a href="javascript:;" chartsType="3">折线图</a></li>'+
					 ' <li><a href="javascript:;" chartsType="2">柱状图</a></li>'+
					  '</ul>'+
				' </div>';
					var dom = '<div data-blick data-reportId class="grid-stack-item" data-gs-x=0 data-gs-y=0 data-gs-width=3 data-gs-height=300>'+
					'<div class="panel panel-default grid-stack-item-content" style="overflow: visible;">'+
					'<div class="panel-heading"><i class="fa fa-tachometer"></i><span>新增</span>'+btn+'</div>'+
					'<div class="xy_hidden">'+
					'<div class="echarts" style="height: 100%;">'+
					'</div></div></div></div>';
		 			$('.grid-stack').data('gridstack').addWidget($(dom));
		 			getReportListByPageId(); //获取数据源
				}
			});
			
			//选择数据源信息
			$("body").on("click",".repurt li a",function(){
				var $this = $(this);
				if($this.parent().hasClass("disabled")){
					return false;
				}
				var param = {};
				param.report_Id = $this.attr("repurtid");//报表id
				param.block_Id =  $this.parents(".grid-stack-item").attr("data-blick");//区块ID
				param.x_Point = $this.parents(".grid-stack-item").attr("data-gs-x");//区块位置
				param.y_Point = $this.parents(".grid-stack-item").attr("data-gs-y");
				param.width = $this.parents(".grid-stack-item").attr("data-gs-width");
				param.height = $this.parents(".grid-stack-item").attr("data-gs-height");
				param.bi_Page_Id = '${pageId}';
				param.block_Type = $this.parents(".grid-stack-item").attr("data-blickType");
				param.screen_Index = JSON.parse('${screen}')[0].screen_Index;
				if(param.block_Id == ""){ //保存
					saveLayout(false);
					ajaxfn("/rest/bi/biPageBlockController/saveBlock",$this.parents(".grid-stack-item"));
				} else { //更新
					ajaxfn("/rest/bi/biPageBlockController/updateBlock");
				}
				
				function ajaxfn(url,dom){
					$.ajax({
						type: "post",
						url: url,
						data:param,
						dataType: "json",
						success: function(result) {
							if(result.data == "success"){
								if(dom){
									dom.attr("data-blick",result.blcokId);
								}
								
								var data={
										bi_Page_Id:'${pageId}',
										screen_Index: screen[0].screen_Index,
										block_Id:(result.blcokId == null)?param.block_Id:result.blcokId,
										key:keys,
										value:values,
										block_Type: 0
									};
									$.ajax({
										type: "post",
										url: "/Bi/getReportData",
										data:JSON.stringify(data),
										contentType:'application/json;charset=utf-8',
										dataType: "json",
										success: function(re) {
											var result = getData(re.data[0]);
											if(dom){
												dom.attr("data-reportid",re.data[0]["blockInfo"].report_Id);
												dom.find(".panel-heading>span").text(re.data[0]["reportInfo"].report_Title);
											}
											areaEcharts(re.data[0]["blockInfo"].block_Id,result);
											layer.close(index);
										},
										error: function() {
											layer.close(index);
										}
									});
							}
						}, 
						error: function(error) {
							console.log(error)
						}
					});
				}
			});
			
			//删除图表
			$("#main").on("click",".blick-close",function(){
				var $this = $(this);
				var blockId = $this.parents(".grid-stack-item").attr("data-blick");
				if(blockId != "" && blockId != "undefend"){
					var blockIds = [];
					blockIds.push(blockId);
					layer.confirm('确定要删除吗？', {
					  btn: ['确定','取消'] //按钮
					}, function(){
						$.ajax({
							type: "post",
							url: "/rest/bi/biPageBlockController/deleteBlock",
							data:{
								blockId:blockIds
							},
							dataType: "json",
							success: function(result) {
								if(result.data == "success"){
									layer.msg("删除成功");
									$this.parents(".grid-stack-item").remove();
								} else {
									layer.msg("删除失败");
								}
							},
							error: function(error) {
								layer.msg("删除失败");
							}
						});
					});
				} else {
					layer.msg("删除成功");
					$this.parents(".grid-stack-item").remove();
				}
			});
			
			//更换图表类型
			$("#main").on("click",".chartsType a",function() {
				var $this = $(this);
				if($this.parent().hasClass("disabled")){
					return false;
				}
				if($this.parents(".grid-stack-item").attr("data-reportid") == ""){
					layer.alert("请先选择报表。")
					return false;
				}
				
				var param = {};
				param.report_Id = $this.parents(".grid-stack-item").attr("data-reportid");//报表id
				param.block_Id =  $this.parents(".grid-stack-item").attr("data-blick");//区块ID
				param.x_Point = $this.parents(".grid-stack-item").attr("data-gs-x");//区块位置
				param.y_Point = $this.parents(".grid-stack-item").attr("data-gs-y");
				param.width = $this.parents(".grid-stack-item").attr("data-gs-width");
				param.height = $this.parents(".grid-stack-item").attr("data-gs-height");
				param.bi_Page_Id = '${pageId}';
				param.block_Type = $this.attr("chartstype");
				param.screen_Index = JSON.parse('${screen}')[0].screen_Index;
				$this.parents(".grid-stack-item").attr("data-blicktype",$this.attr("chartstype"));
				$.ajax({
					type: "post",
					url: "/rest/bi/biPageBlockController/updateBlock",
					data:param,
					dataType: "json",
					success: function(result) {
						var keys=[],values=[];
						if(result.data == "success"){
							
							index = layer.load(0, {
								skin: 'i-loading',
								shade: 0.1,
								content: '<div class="sk-wave"><div class="sk-rect sk-rect1"></div><div class="sk-rect sk-rect2"></div><div class="sk-rect sk-rect3"></div><div class="sk-rect sk-rect4"></div><div class="sk-rect sk-rect5"></div></div>'
							});
							var data={
								bi_Page_Id:'${pageId}',
								screen_Index: param.screen_Index,
								block_Id:param.block_Id,
								key:keys,
								value:values,
								block_Type: 0
							};
							$.ajax({
								type: "post",
								url: "/Bi/getReportData",
								data:JSON.stringify(data),
								contentType:'application/json;charset=utf-8',
								dataType: "json",
								success: function(re) {
									var result = getData(re.data[0]);
									areaEcharts(re.data[0]["blockInfo"].block_Id,result);
									layer.close(index);
								},
								error: function(result) {
									layer.close(index);
								}
							});
						}
					}, 
					error: function(error) {
						console.log(error)
					}
				});
			});
			
			$("#main").on("click",".btn-chartsType",function(){
				var $this = $(this);
				var chartstype = $this.parents(".grid-stack-item").attr("data-blicktype");
				$this.next("ul").find("[chartstype="+chartstype+"]").parent().addClass("disabled");
			});
			
			$("#main").on("click",".btn-source",function(){
				var $this = $(this);
				var reportid = $this.parents(".grid-stack-item").attr("data-reportid");
				$this.next("ul").find("[repurtid="+reportid+"]").parent().addClass("disabled");
			});
		</script>
	</body>

</html>