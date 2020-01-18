<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<link href="plug-in/ace/adIcon/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="plug-in/ace/adIcon/css/bilargeScreen.css" />
		<style type="text/css">
			.button-group .dropdown-menu>ul{
				max-width: 150px;
				max-height: 300px;
				overflow-y: auto;
			}
			.button-group .dropdown-menu ul li{
				padding:0;
			}
			.button-group .dropdown-menu>ul a{
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
				width: 100%;
				display: inline-block;
				padding: 6px 8px;
 				box-sizing: border-box;
			}
			[datasource] .active{
				background-color: #ededee;
				cursor: not-allowed;
				
			}
			.bi-utils{
				position: fixed;
				left: 50%;
				bottom: -36px;
				z-index: 999;
				transform: translateX(-50%);
				height: 20px;
				background-color: rgba(0,0,0,.7);
				padding:8px 30px;
				border-top-left-radius: 10px;
				border-top-right-radius: 10px;
			}
			.bi-utils a{
				color: #fff;
			}
			.bi-utils a+a{
				margin-left: 10px;
			}
			.bi-utils .fa{
				position: absolute;
				top: -40px;
				left: 50%;
				transform: translateX(-50%);
				color: #fff;
				font-size: 40px;
				cursor: pointer;
			}
			
			/**
			 * loading 动画
			 */
			.i-loading .layui-layer-content {
				width: auto !important;
				height: auto !important;
				background: none !important;
			}
			
			.i-loading .layui-layer-content .sk-cube-grid {
				margin: 0;
			}
			.sk-wave {
				margin: 40px auto;
				width: 50px;
				height: 40px;
				text-align: center;
				font-size: 10px;
			}
			
			.sk-wave .sk-rect {
				box-shadow: 0 0 2px rgba(255,255,255,.5);
				background-color: #FFF;
				height: 100%;
				width: 3px;
				margin-right: 3px;
				display: inline-block;
				-webkit-animation: sk-waveStretchDelay 1.2s infinite ease-in-out;
				animation: sk-waveStretchDelay 1.2s infinite ease-in-out;
			}
			
			.sk-wave .sk-rect1 {
				-webkit-animation-delay: -1.2s;
				animation-delay: -1.2s;
			}
			
			.sk-wave .sk-rect2 {
				-webkit-animation-delay: -1.1s;
				animation-delay: -1.1s;
			}
			
			.sk-wave .sk-rect3 {
				-webkit-animation-delay: -1s;
				animation-delay: -1s;
			}
			
			.sk-wave .sk-rect4 {
				-webkit-animation-delay: -0.9s;
				animation-delay: -0.9s;
			}
			
			.sk-wave .sk-rect5 {
				-webkit-animation-delay: -0.8s;
				animation-delay: -0.8s;
			}
			
			@-webkit-keyframes sk-waveStretchDelay {
				0%,
				40%,
				100% {
					-webkit-transform: scaleY(0.4);
					transform: scaleY(0.4);
				}
				20% {
					-webkit-transform: scaleY(1);
					transform: scaleY(1);
				}
			}
			
			@keyframes sk-waveStretchDelay {
				0%,
				40%,
				100% {
					-webkit-transform: scaleY(0.4);
					transform: scaleY(0.4);
				}
				20% {
					-webkit-transform: scaleY(1);
					transform: scaleY(1);
				}
			}
			.main {
			    position: relative;
			    height: 91%;
			    top: 1%;
			}
			.none .title {
				display: none;
			}
			
			.none .main {
				height: 100%;
			}
			/**
			 * 新样式 --- 
			 */
			 body{
			 	background-image: url("../plug-in/ace/bi/img/bg.jpg");
			 }
			 .area,.title{
			 	  border: 1px solid rgba(59,142,255,.15);
    			  background-color: rgba(5,27,63,.5);
			 }
			 #amap{
			 	overflow: hidden;
			 }
			 .title	{
			 	height: 8%;
		 	    left: 1%;
			    right: 1%;
			    width: 98%;
			 }	 
			.area:nth-child(1) {
				top: 0;
				left: 1%;
				width: 24%;
				height: 31.33%
			}
			
			.area:nth-child(2) {
				top: 0;
				left: 26%;
				width: 48%;
				height: 64.66%;
			}
			
			.area:nth-child(3) {
				top: 0;
				left: 75%;
				width: 24%;
				height: 31.33%
			}
			
			.area:nth-child(4) {
				top: 33.33%;
				left: 1%;
				width: 24%;
				height: 31.33%
			}
			
			.area:nth-child(5) {
				top: 33.33%;
				left: 75%;
				width: 24%;
				height: 31.33%
			}
			
			.area:nth-child(6) {
				top: 66.66%;
				left: 1%;
				width: 28%;
				height: 31.33%
			}
			
			.area:nth-child(7) {
				top: 66.66%;
				left: 30%;
				width: 19.5%;
				height: 31.33%
			}
			
			.area:nth-child(8) {
				top: 66.66%;
				left: 50.5%;
				width: 19%;
				height: 31.33%
			}
			
			.area:nth-child(9) {
				top: 66.66%;
				left: 70.5%;
				width: 28.5%;
				height: 31.33%
			}
			.border-top-left {
				width:10px;
				height:10px;
			    border-left: 2px solid #006cff;
			    border-top: 2px solid #006cff;
			    position: absolute;
			    left: -2px;
			    top: -2px
			}
			.border-top-right {
				width:10px;
				height:10px;
			    border-right: 2px solid #006cff;
			    border-top: 2px solid #006cff;
			    position: absolute;
			    right: -2px;
			    top: -2px
			}
			
			.border-bottom-left {
				width:10px;
				height:10px;
			    border-bottom: 2px solid #006cff;
			    border-left: 2px solid #006cff;
			    position: absolute;
			    left: -2px;
			    bottom: -2px
			}
			
			.border-bottom-right {
				width:10px;
				height:10px;
			    border-bottom: 2px solid #006cff;
			    border-right: 2px solid #006cff;
			    position: absolute;
			    right: -2px;
			    bottom: -2px
			}
			.button-group{
				background-color:#112a65
			}	 
			.area.zoom {
			    position: fixed;
			    height: 100%;
			    width: 100%;
			    top: 0;
			    left: 0;
			    bottom: 0;
			    right: 0;
			    z-index: 999999;
			    background: url("../plug-in/ace/bi/img/bg.jpg")
			}
			
		</style>
	</head>
	<!-- body添加none类可去掉title -->

	<body class="none">
		<div class="title" id="title">
			
		</div>
		<div class="main" >
			<div class="area" areaId='1'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="1" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area" style="padding: 0;">
				<div class="button-group">
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div id="amap"></div>
			</div>
			<div class="area" areaId='2'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="2" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area"  areaId='3'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="3" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area" areaId='4'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="4" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area" areaId='5'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="5" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area" areaId='6'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="6" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area" areaId='7'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="7" draggable="true" blickId='' reportId=''></div>
			</div>
			<div class="area" areaId='8'>
				<div class="button-group">
					<i class="fa fa-repeat btn-refresh"></i>
					<i class="fa fa-glass"></i>
					<div class="dropdown-menu" >
						<i class="fa fa-area-chart btn-dropdown"></i>
						<ul>
							<li>
								<a class="btn-line" chartsType="3">折线图</a>
							</li>
							<li>
								<a class="btn-bar" chartsType="2">柱状图</a>
							</li>
						</ul>
					</div>
					<div class="dropdown-menu" >
						<i class="fa fa-cog btn-dropdown"></i>
						<ul dataSource>
							<li>
								<a title=""></a>
							</li>
						</ul>
					</div>
					<i class="fa fa-expand btn-zoomed"></i>
				</div>
				<div data-area="8" draggable="true" blickId='' reportId=''></div>
			</div>
		</div>
		<div class="bi-utils" id="screenList">
			<span class="fa fa-caret-up" id="utils"></span>
		</div>
	</body>
	<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'></script>
	<script src="http://webapi.amap.com/maps?v=1.4.0&key=c7664ec0fefe51dcc7385f081f3b20d9"></script>
	<script src="plug-in/ace/adIcon/js/echarts.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="plug-in/ace/adIcon/js/halloween.js" type="text/javascript" charset="utf-8"></script><!-- echarts皮肤 -->
	<script src="plug-in/layer/layer.js" type="text/javascript" charset="utf-8"></script><!-- layer弹窗 -->
	<script src="plug-in/ace/adIcon/js/china.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(".area").append('<div class="border-top-left"></div><div class="border-top-right"></div><div class="border-bottom-left"></div><div class="border-bottom-right"></div>')
	
		var resultData = {};
		var pageid=0, screenIndex=0;
		var index = null;
		var pinyin = {};  //echarts地图json文件载体 
		var param = {}, GloabParam = {
			id: 0,
			type: 0,
			area: "china",
			areaName: "全国"
		};  //后端所用参数载体
		$(function() {
			//添加标题
			if("${ pageType}" == "1"){
				$("body").removeClass("none");
				$("#title").text("— ${pageTitle} —");
			}
			var screen = JSON.parse('${screen}');
			for(var i=0; i<screen.length; i++){
				$("#screenList").append('<a href="javascript:screenSwitch('+screen[i].screen_Index+');">'+screen[i].screen_Name+'</a>');
				if(i == 0){
					pageid=${pageId};
					screenIndex=screen[i].screen_Index;
				}
			}
			fun(GloabParam.id, GloabParam.type, GloabParam.area, GloabParam.areaName);
		});
		
		//工具箭头
		$(".bi-utils #utils").click(function(){
			var _this = $(this);
			if(_this.hasClass("fa-caret-up")){
				_this.removeClass("fa-caret-up").addClass("fa-caret-down")
				_this.parent().css("bottom",0);
			} else {
				_this.removeClass("fa-caret-down").addClass("fa-caret-up")
				_this.parent().css("bottom","-40px");
			}
		});
		//选项点击
		function screenSwitch(index){
			var _this = $(this);
			_this.siblings("#utils").removeClass("fa-caret-down").addClass("fa-caret-up");
			_this.parent().css("bottom", "-40px");
			pageid=${pageId};
			screenIndex=index;
			getReportData();
		};

		//允许放入  
		$(".area").on("dragover","[data-area]:not(#amap)", function(ev) {
			ev.preventDefault();
		})

		//拖放开始
		$(".area").on("dragstart","[data-area]", function(ev) {
			//放入dataID
			ev.originalEvent.dataTransfer.setData("areaId", $(this).attr("data-area"));
			ev.originalEvent.dataTransfer.setData("blickid", $(this).attr("blickid"));
			ev.originalEvent.dataTransfer.setData("reportId", $(this).attr("reportId"));
			ev.originalEvent.dataTransfer.setData("boxAreaId", $(this).parent().attr("areaId"));
		});

		//放下事件  
		$(".area").on("drop", "[data-area]",function(ev) {
			ev.preventDefault();
			var dropBoxAreaId = $(this).parent().attr("areaId");
			var dragBoxAreaId = ev.originalEvent.dataTransfer.getData("boxAreaId");
			
			var thisAraeId = $(this).attr("data-area"),
				//获取传递的areaID值
				areaId = ev.originalEvent.dataTransfer.getData("areaId"),
				//放下时候元素的父元素
				dropParentObj = $("[data-area=" + thisAraeId + "]").parent(),
				//放下时候元素的父元素的所有子元素
				dropFindObj = dropParentObj.children(),
				//点击开始拖时元素父元素
				dragParentObj = $("[data-area=" + areaId + "]").parent(),
				//点击开始拖时元素父元素的所有子元素
				dragFindObj = dragParentObj.children();
				console.log(dropBoxAreaId+"-------"+dragBoxAreaId); 
				var dragBlickid = ev.originalEvent.dataTransfer.getData("blickid"); //点击时的blickid
				var dragReportId = ev.originalEvent.dataTransfer.getData("reportId"); //点击时的blickid
				var dropBlickid = $("[data-area=" + thisAraeId + "]").attr("blickid");//放下时的blickid
				var dropReportId = $("[data-area=" + thisAraeId + "]").attr("reportId");//放下时的reportId
				//判断开始与结束的位置是否一致，同一位置不更新
				if(thisAraeId != areaId){
					if(dragBlickid != ""){
						console.log(dragBlickid+"-"+dropBoxAreaId+"-"+dragReportId); 
						dragDropUpdateBlock(dragBlickid,dropBoxAreaId,dragReportId);//更新开始拖放元素的位置
					}
					if(dropBlickid != ""){
						console.log(dropBlickid+"-"+dragBoxAreaId+"-"+dropReportId);
						dragDropUpdateBlock(dropBlickid,dragBoxAreaId,dropReportId);//更新结束拖放元素的位置
					}
				} else {
					console.log("位置一致，不更新");
				}
				
			//互换位置
			dropParentObj.append(dragFindObj);
			dragParentObj.append(dropFindObj);
			$(window).resize(); //触发resize事件调整Echarts
			
		});

		//操作按钮的点击
		$("body").on("click", ".button-group .fa", function() {
			var $this = $(this);
			//放大缩小
			if($this.hasClass("btn-zoomed")) {
				if(!$this.parents(".area").hasClass("zoom")) {
					$this.parents(".area").addClass("zoom");
					$this.removeClass("fa-expand").addClass("fa-compress");
				} else {
					$this.parents(".area").removeClass("zoom");
					$this.removeClass("fa-compress").addClass("fa-expand");
				}
				$(window).resize(); //触发resize事件调整Echarts
				return false;
			}

			//刷新
			if($this.hasClass("btn-refresh")) {
				var blockId = $(this).parents(".area").find("[data-area]").attr("blickid");
				if(blockId == ""){
					return false;
				}
				index = layer.load(0, {
					skin: 'i-loading',
					shade: 0.1,
					content: '<div class="sk-wave"><div class="sk-rect sk-rect1"></div><div class="sk-rect sk-rect2"></div><div class="sk-rect sk-rect3"></div><div class="sk-rect sk-rect4"></div><div class="sk-rect sk-rect5"></div></div>'
				});
				var data={
					bi_Page_Id:'${pageId}',
					screen_Index: screenIndex,
					block_Id:blockId,
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
						areaEcharts(re.data[0]["blockInfo"].x_Point,result);
						//console.log(data);
						layer.close(index);
					},
					error: function() {
						layer.close(index);
					}
				});
				return false;
			}
			//带下拉按钮的图标
			if($this.hasClass("btn-dropdown")) {
				if(!$this.parent().hasClass("open")) {
					var li = $this.siblings("ul").find("li");
					var reportid = $this.parents(".area").find("[data-area]").attr("reportid");
					if(reportid != ""){
						li.each(function(){
							if(reportid == $(this).find("a").attr("reportid")){
								$(this).addClass("active");
							}
						});
					}
					var left = $(window).width()-($this.offset().left+$this.siblings("ul").width());
					var top = $(window).height()-($this.offset().top+$this.siblings("ul").height());
					if(left < 0){
						$this.siblings("ul").css("left",left-10)
					}
					if(top < 0){
						$this.siblings("ul").css("height",$this.siblings("ul").height() + top -60 );
					}
					$this.parent().addClass("open");
					$("body").one("click", function() {
						if(!$(this).parent().hasClass("active")){
							$this.parent().removeClass("open");
						}
					});
				} else {
					$this.parent().removeClass("open");
				}
			}
		});

		//echarts
		function areaEcharts(area,result) {
			if(JSON.stringify(resultData) != "{}") {
				var myChart = echarts.init($('[areaId='+area+'] [data-area]').get(0), "halloween");
				var option = {
					title: {
						text: '',
						x: 'center',
						y: 0,
						textStyle: {
							color: "#fff",
							fontWeight: 'normal',
							fontSize: 16
						}
					},
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
						start: 25,
						end: 75,
						height: 18,//组件高度 
						bottom:0
					}],
					legend: {
						top: "15%",
						data: []
					},
					grid: {
						left: '0',
						right: '3%',
						bottom: '10%',
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
				option.title.text = result.title; //图表标题
				option.xAxis[0].data = result.xAxisData; //赋值X轴
				option.series = result.seriess; //图表数据series对象
				option.legend.data = result.legendData; //图例
				option.xAxis[0].name = result.xAxisName; //X轴名称
				myChart.setOption(option);
				$(window).resize(function() {
					myChart.resize();
				})
			}else{
				alert(1)
			}
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
					type: 'bar',
					data: []
				}
				series.type = (blockType == 3 ? "line":"bar");
				//Y轴数值
				for(var i = 0; i < data.length; i++) {
					series.data.push(data[i][topicField[y]]);
				}
				
				result.yAxisNmae.push(unit[y]);
				
				//Y轴数值name
				series.name = topicFieldName[y];
				result.legendData.push(topicFieldName[y]);
				result.seriess.push(series);
			}
			//处理name值

			return result;
		}
		var keys=[],values=[];
		//获取图表数据
		function getReportData() {
			index = layer.load(0, {
				skin: 'i-loading',
				shade: 0.1,
				content: '<div class="sk-wave"><div class="sk-rect sk-rect1"></div><div class="sk-rect sk-rect2"></div><div class="sk-rect sk-rect3"></div><div class="sk-rect sk-rect4"></div><div class="sk-rect sk-rect5"></div></div>'
			});
			var data={
				bi_Page_Id: pageid,
				screen_Index: screenIndex,
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
					resultData = {};
					resultData = result.data
					if(resultData.length < 8)
						for(var i = 1; i <= 8; i++) {
							$('[data-area='+i+']').replaceWith("<div data-area='"+i+"' draggable='true' blickId='' reportId='' block_Type=''></div>");
						}
					//准备位置
					for(var i = 0; i < resultData.length; i++) {
						var div = $("[draggable='true']").eq(Number(resultData[i]["blockInfo"].x_Point)-1,i);
						div.attr('reportId',resultData[i]["blockInfo"].report_Id);
						div.attr("blickId",resultData[i]["blockInfo"].block_Id);
						div.attr("block_Type",resultData[i]["blockInfo"].block_Type);
						var result = getData(resultData[i]);
						areaEcharts(resultData[i]["blockInfo"].x_Point,result);
					}
					layer.close(index);
					getReportListByPageId();//获取数据源信息
				},
				error: function() {
						layer.close(index);
				}
			});
		}
		
		//获取数据源信息
		function getReportListByPageId() {
			$.ajax({
				type: "get",
				url: "rest/bi/biReportController/getReportListByPageId",
				data:{
					pageId:'${pageId}',
					screenIndex: screenIndex
				},
				dataType: "json",
				success: function(result) {
					console.log(result)
					$("[dataSource]").empty();
					for(var i = 0;i<result.data.length;i++){
						$("[dataSource]").append("<li><a class='setDataSouce' title='"+result.data[i].report_Name+"' reportId='"+result.data[i].report_Id+"'>"+result.data[i].report_Name+"</a></li>");
					}
					$("[dataSource]").append("<li><a class='deleteDataSouce' title='移除该图表' reportId=''>移除图表</a></li>");
				}, 
				error: function(error) {
					console.log(error)
				}
			});
		}
		
		//删除该数据源图表
		$("[dataSource]").on("click",".deleteDataSouce",function(){
			if(param.block_Id != ""){
				var thisBlickId = $(this).parents(".button-group").siblings("[data-area]").attr("blickId");
				var blockId = [];
					blockId.push(thisBlickId);
				$.ajax({
					type: "post",
					url: "rest/bi/biPageBlockController/deleteBlock",
					data:{
						blockId:blockId
					},
					dataType: "json",
					success: function(result) {
						if(result.data == "success"){
							getReportData();
						}
					},
					error: function(error) {
						console.log(error)
					}
				});
			}
		});
		
		
		//选择数据源信息
		$("[dataSource]").on("click",".setDataSouce",function(){
			var blockType = $(this).parents(".button-group").siblings("[data-area]").attr("block_Type");
			var param = {};
			param.report_Id = $(this).attr("reportId");//报表id
			param.block_Id =  $(this).parents(".button-group").siblings("[data-area]").attr("blickId");//区块ID
			param.x_Point = $(this).parents(".button-group").parent().attr("areaId");//区块位置
			param.bi_Page_Id = '${pageId}';
			param.block_Type = blockType == "" ? 2 : blockType;//图表类型
			param.screen_Index = screenIndex;
			if($(this).parent().hasClass("active")){
				return false;
			}
			$(this).parent().siblings("li").removeClass("active");
			if(param.block_Id == ""){ //保存
				ajaxfn("rest/bi/biPageBlockController/saveBlock");
			} else {
				ajaxfn("rest/bi/biPageBlockController/updateBlock");
			}
				
			function ajaxfn(url){
				$.ajax({
					type: "post",
					url: url,
					data:param,
					dataType: "json",
					success: function(result) {
						if(result.data == "success"){
							getReportData();
						}
					}, 
					error: function(error) {
						console.log(error)
					}
				});
			}
		});
		
		//拖放时更新
		function dragDropUpdateBlock(blickId,areaId,reportId){
			$.ajax({
				type: "post",
				url: "rest/bi/biPageBlockController/updateBlock",
				data:{
					block_Id:blickId,
					screen_Index : screenIndex,
					x_Point:areaId,
					report_Id:reportId,
					bi_Page_Id:'${pageId}',
					block_Type : 1,
					type: 1
				},
				dataType: "json",
				success: function(result) {
					console.log(result);
				}, 
				error: function(error) {
					console.log(error);
				}
			});
		}
		
		var mapEcharts = echarts.init(document.getElementById('amap'));
	    var areaId = {};
		function echartsInit(areaMineId, areaType, area){
			var uploadedDataURL = "plug-in/ace/adIcon/json/code/"+area+".json";
			mapEcharts.showLoading({
				maskColor: 'rgba(0,0,0,0)',
				text: '正在加载地图。。。',
			  	textColor: '#00db2e',
			  	color: '#00db2e'
			});
			$.getJSON(uploadedDataURL, function(geoJson) {
			    echarts.registerMap(area, geoJson);
			    mapEcharts.hideLoading();
			    var max = 480, min = 9; // todo 
			    var maxSize4Pin = 100, minSize4Pin = 20;
			    var param = {};
			    param.areaType = areaType;
		        param.type = 0;
			    param.areaMineId = areaMineId;
				$.ajax({
					type : "POST",
					async: false,
					url : "#请修改为自己获取区域地址的地址",
					data : param,
					dataType : "json", //返回数据形式为json  
					success : function(result) {
						var memo = result.attributes.memoMap;
						var data = result.attributes.dataList;
						var geoCoordMap = result.attributes.positionMap;
						areaId = result.attributes.areaId;
						pinyin = result.attributes.pinyinMap;
						var convertData = function (data) {
						    var res = [];
						    for (var i = 0; i < data.length; i++) {
						        var geoCoord = geoCoordMap[data[i].name];
						        if (geoCoord) {
						            res.push({
						                name: data[i].name,
						                value: geoCoord.concat(data[i].value)
						            });
						        }
						    }
						    return res;
						};
					    option = {
					        title: {
					            text: '',
					            subtext: '',
					            x: 'center',
					            textStyle: {
					                color: '#ccc'
					            }
					        },
					        tooltip: {
					            trigger: 'item',
					            formatter: function (params) {
					              if(typeof(memo[params.name]) == "undefined")
					              	return params.name+" 没有矿山";
					              else
					              	return params.name + " " + memo[params.name];
					            }
					        },
					        legend: {
					            orient: 'vertical',
					            y: 'bottom',
					            x: 'right',
					            data: ['credit_pm2.5'],
					            textStyle: {
					                color: '#fff'
					            }
					        },
					        visualMap: {
					            show: false,
					            min: 0,
					            max: 500,
					            left: 'left',
					            top: 'bottom',
					            text: ['高', '低'], // 文本，默认为数值文本
					            calculable: true,
					            seriesIndex: [1],
					            inRange: {
					                color: ['#0f0c29', '#302b63', '#24243e'] // 黑紫黑
					            }
					        },
					        geo: {
					            show: true,
					            map: area,
					            label: {
					                normal: {
					                    show: false
					                },
					                emphasis: {
					                    show: false,
					                }
					            },
					            itemStyle: {
					                normal: {
					                    areaColor: 'transparent',
					                    borderColor: '#3fdaff',
					                    borderWidth: 2,
					                    shadowColor: 'rgba(63, 218, 255, 0.5)',
					                    shadowBlur: 10
					                },
					                emphasis: {
					                    areaColor: '#2B91B7',
					                }
					            }
					        },
					        series : [{
			                  name: 'light',
			                  type: 'scatter',
			                  coordinateSystem: 'geo',
			                  itemStyle: {
			                      normal: {
			                          color: '#05C3F9'
			                      }
			                   }
			              	},
			                {
			                  type: 'map',
			                  map: area,
			                  geoIndex: 0,
			                  aspectScale: 0.75, //长宽比
			                  showLegendSymbol: false, // 存在legend时显示
			                  label: {
			                      normal: {
			                          show: false
			                      },
			                      emphasis: {
			                          show: false,
			                          textStyle: {
			                              color: '#fff'
			                          }
			                      }
			                  },
			                  roam: true,
			                  itemStyle: {
			                      normal: {
			                          areaColor: '#031525',
			                          borderColor: '#3B5077',
			                      },
			                      emphasis: {
			                          areaColor: '#2B91B7'
			                      }
			                  },
			                  animation: false,
			                  data: data
			              },
			              {
			                  name: 'Top 5',
			                  type: 'effectScatter',
			                  coordinateSystem: 'geo',
			                  data: convertData(data.sort(function (a, b) {
			                      return b.value - a.value;
			                  }).slice(0, 100)),
			                  symbolSize: function (val) {
			                      return val[2] / 30;
			                  },
			                  showEffectOn: 'render',
			                  rippleEffect: {
			                      brushType: 'stroke'
			                  },
			                  hoverAnimation: true,
			                  label: {
			                      normal: {
			                          formatter: '{b}',
			                          position: 'right',
			                          show: true
			                      }
			                  },
			                  itemStyle: {
			                      normal: {
			                          color: '#FFFFFF',
			                          shadowBlur: 10,
			                          shadowColor: '#FFFFFF'
			                      }
			                  },
			                  zlevel: 1
			              }
			          	]};
					    mapEcharts.setOption(option);
					},
					error:function(result){
						layer.msg("此区域没有子区域，请重试");
					}
				});
			    
			});
			
			$(window).resize(function(){
				mapEcharts.resize();
			})
		}
		mapEcharts.on('click', function (params) {
			$(".areaNames").text(params.data.name);
			var upname = GloabParam.areaName;
			var uparea = GloabParam.area;
		    GloabParam = {
	    		id: areaId[params.data.name],
	    		type: (areaId[params.data.name]+"").length,
	    		area: pinyin[params.data.name],
	    		areaName: params.data.name
		    }
		    if(GloabParam.type == 2){
		    	propy = GloabParam.area;
		    	pron = GloabParam.areaName;
		    	keys.splice(0, 1, "@province");
		    	values.splice(0, 1, GloabParam.id);
		    }else if(GloabParam.type == 4){
		    	citypy = GloabParam.area;
		    	cityn = GloabParam.areaName;
		    	keys.splice(0, 1, "@city");
			    values.splice(0, 1, GloabParam.id);
		    }
		    if(GloabParam.type == 6)
				location.href = "rest/mgeids/mgeidsChinaUni/map?id="+GloabParam.id+
						"&type="+GloabParam.type+"&areaName="+GloabParam.areaName+
						"&upname="+upname+"&pinyin="+uparea+"&propinyin="+propy+"&proname="+pron;
			else
		    	fun(GloabParam.id, GloabParam.type, GloabParam.area, GloabParam.areaName);
		});
		
		function fun(id, type, area, areaName){
			getReportData();
			setTimeout(() => {
				echartsInit(id, type, area);
			}, 400);
		}
		
		
		//更换图表类型
		$("[chartsType]").on("click", function() {
			var $this = $(this);
			if($this.parents(".button-group").siblings("[data-area]").attr("blickId") == ""){
				return false;
			}
			
			var param = {};
			param.report_Id = $this.parents(".button-group").siblings("[data-area]").attr("reportid");//报表id
			param.block_Id =  $this.parents(".button-group").siblings("[data-area]").attr("blickId");//区块ID
			param.x_Point = $this.parents(".button-group").parent().attr("areaId");//区块位置
			param.bi_Page_Id = '${pageId}';
			param.block_Type = $this.attr("chartstype");//图表类型
			param.screen_Index = screenIndex;
			$this.parents(".button-group").siblings("[data-area]").attr("block_Type",$this.attr("chartstype"));
			console.log(param)
			$.ajax({
				type: "post",
				url: "rest/bi/biPageBlockController/updateBlock",
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
								areaEcharts(re.data[0]["blockInfo"].x_Point,result);
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
	</script>

</html>