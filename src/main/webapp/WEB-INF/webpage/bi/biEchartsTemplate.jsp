<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<link href="plug-in/ace/adIcon/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link rel='stylesheet prefetch' href='plug-in/ace/css/bootstrap.min.css'>
		<style type="text/css">
			* {
				padding: 0;
				margin: 0;
			}
			
			body {
				background-color: #0a2c47;
			}
			
			body,
			html,
			#myEcharts {
				height: 100%;
			}
			#dataSource option {
			    background: #092d47;
			}
		</style>
	</head>

	<body>
		<input id="block_Id" type="hidden">
			<input id="report_Id" type="hidden">
		<div id="myEcharts"></div>
		<div class="form-group" style="position: fixed; top: 20px; right: 30px">
			<label class="control-label" style="color: #FFF; text-align: left; float: left; width: 98px; line-height: 34px">切换数据源</label>
			<select class="form-control" id="dataSource" style="width: 180px; float: left; background: transparent; color: #fff">
				
			</select>
		</div>
	</body>
	<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'></script>
	<script src="plug-in/ace/adIcon/js/echarts.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="plug-in/ace/adIcon/js/halloween.js" type="text/javascript" charset="utf-8"></script>
	<!-- echarts皮肤 -->
	<script type="text/javascript">
		var pageid=0, screenIndex=0;
		$(document).ready(function() {
			var screen = JSON.parse('${screen}');
			pageid=${pageId};
			screenIndex=screen[0].screen_Index;
			getEcharts();
			getReportListByPageId();
		});
		//获取数据源信息
		function getReportListByPageId() {
			$.ajax({
				type: "get",
				url: "/rest/bi/biReportController/getReportListByPageId",
				data:{
					pageId:'${pageId}',
					screenIndex: screenIndex
				},
				dataType: "json",
				success: function(result) {
					$("#dataSource").empty();
					$("#dataSource").append("<option value='0'>请选择</option>");
					for(var i = 0;i<result.data.length;i++){
						$("#dataSource").append("<option value="+result.data[i].report_Id+">"+result.data[i].report_Name+"</option>");
					}
				}, 
				error: function(error) {
					console.log(error)
				}
			});
		}
		
		$("#dataSource").change(function() {
			var _this = $(this);
			var param = {};
			param.report_Id = _this.val(); //报表id
			param.block_Id = $("#block_Id").val(); //区块ID
			param.x_Point = 1; //区块位置
			param.bi_Page_Id = '${pageId}';
			param.block_Type = 1;
			param.screen_Index = screenIndex;

			if(param.block_Id == "") { //保存
				ajaxfn("/rest/bi/biPageBlockController/saveBlock");
			} else {
				ajaxfn("/rest/bi/biPageBlockController/updateBlock");
			}

			function ajaxfn(url) {
				$.ajax({
					type: "post",
					url: url,
					data: param,
					dataType: "json",
					success: function(result) {
						if(result.data == "success") {
							getEcharts();
						}
					},
					error: function(error) {
						console.log(error)
					}
				});
			}
		});

		function getEcharts() {
			var myChart = echarts.init($('#myEcharts').get(0), "halloween");
			var option = {
				tooltip: {
					trigger: 'item',
					formatter: "{b} <br/> {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					x: 'left',
					data: []
				},
				series: [{
						name: '',
						type: 'pie',
						selectedMode: 'single',
						radius: [0, '25%'],

						label: {
							normal: {
								position: 'inner'
							}
						},
						labelLine: {
							normal: {
								show: false
							}
						},
						data: []
					},
					{
						name: '',
						type: 'pie',
						radius: ['33%', '45%'],
						label: {
							normal: {
								formatter: '{b|{b}} \n  {c}  {per|{d}%}  ',
								backgroundColor: 'rgba(0,0,0,.8)',
								borderColor: '#aaa',
								padding: [2, 4],
								borderWidth: 1,
								borderRadius: 4,
								rich: {
									a: {
										color: '#999',
										lineHeight: 22,
										align: 'center'
									},
									hr: {
										borderColor: '#aaa',
										width: '100%',
										borderWidth: 0.5,
										height: 0
									},
									b: {
										align: 'center',
										lineHeight: 22,
										fontSize: 16,
										lineHeight: 33
									},
									per: {
										color: '#eee',
										backgroundColor: '#334455',
										padding: [2, 4],
										borderRadius: 2
									}
								}
							}
						},
						data: []
					}
				]
			};
			var keys = [],
				values = [];
			var data = {
				bi_Page_Id: '${pageId}',
				screen_Index: screenIndex,
				key: keys,
				value: values,
				block_Type: 0,
				block_Id: 0
			};
			$.ajax({
				type: "post",
				url: "/Bi/getReportData",
				data: JSON.stringify(data),
				contentType: 'application/json;charset=utf-8',
				dataType: "json",
				success: function(result) {
					console.log(result)
					var scource = result.data[0].data;
					if(result.data.length > 0){
						$("#report_Id").val(result.data[0].blockInfo.report_Id);
						$("#block_Id").val(result.data[0].blockInfo.block_Id);
						$("#dataSource").val(result.data[0].blockInfo.report_Id);
						var type = {}; // 内部对象
						var yearType = {}; //外部对象
						var types = []; //用于存放内部对象KEY
						var yearTypes = []; //用于存放内部对象KEY
	
						for(var i = 0; i < scource.length; i++) {
							//如果type中没有该Key，则新建
							if(typeof type[scource[i].economic_type_nm] == "undefined") {
								//创建对象中的KEY
								type[scource[i][result.data[0].dimField[1]]] = Number(scource[i][result.data[0].topicField[0]])
								//将key存入数组
								types.push(scource[i].economic_type_nm)
							} else {
								//如果有，取出来，+=
								type[scource[i][result.data[0].dimField[1]]] += Number(scource[i][result.data[0].topicField[0]])
							}
						}
	
						//求各类型中每年占比
						for(var i = 0; i < scource.length; i++) {
							//如果yearType中没有该Key，则新建
							if(typeof yearType[scource[i].economic_type_nm + "-" + scource[i].survey_year] == "undefined") {
								//创建对象中的KEY
								yearType[scource[i][result.data[0].dimField[1]] + "-" + scource[i][result.data[0].dimField[0]]] = Number(scource[i][result.data[0].topicField[0]])
								//将key存入数组
								yearTypes.push(scource[i][result.data[0].dimField[1]] + "-" + scource[i][result.data[0].dimField[0]])
							} else {
								//如果有，取出来，+=
								type[scource[i][result.data[0].dimField[1]] + "-" + scource[i][result.data[0].dimField[0]]] += Number(scource[i][result.data[0].topicField[0]])
							}
						}
						console.log(type)
						console.log(types)
						console.log(yearType)
						console.log(yearTypes)
						//对数组进行排序
						types = types.sort();
						yearTypes = yearTypes.sort();
						option.legend.data = types.concat(yearTypes)
	
						//从数组中取出KEY
						for(var i = 0; i < types.length; i++) {
							var obj = {
								value: type[types[i]],
								name: types[i],
								selected: true
							}
							option.series[0].data.push(obj)
						}
	
						for(var i = 0; i < yearTypes.length; i++) {
							var obj = {
								value: yearType[yearTypes[i]],
								name: yearTypes[i]
							}
							option.series[1].data.push(obj)
						}
	
						myChart.clear();
						myChart.setOption(option);
						$(window).resize(function() {
							myChart.resize();
						})
					}
				},
				error: function() {

				}
			});
		}
	</script>

</html>