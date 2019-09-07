<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
		<meta charset='UTF-8'>
		<meta name="robots" content="noindex">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel='stylesheet prefetch' href='plug-in/ace/css/bootstrap.min.css'>
		<link rel='stylesheet prefetch' href='plug-in/ace/bi/css/loading.css'>
		<style class="cp-pen-styles">
			.table thead th {
				text-align: center;
				vertical-align: middle !important;
				padding: 3px;
				background-color: #eaeaea;
			}
			
			.table-bordered>thead>tr>td,
			.table-bordered>thead>tr>th {
				border-bottom-width: 1px;
				border-color: #d0d0d0;
			}
			td{
				white-space: nowrap !important;  
			}
			a{
				display: block !important;
			}
			@media screen and (max-width: 600px) {
			  table td:before {
			    content: attr(data-label);
			    float: left;
			    text-transform: uppercase;
			    font-weight: bold;
			  }
			}
		</style>
	</head>

	<body>
		<body>
			<input id="block_Id" type="hidden">
			<input id="report_Id" type="hidden">
			<div style="padding:10px;">
				<h3 style="text-align: center; margin: 20px 0 20px 0;">
				${pageTitle}
				</h3>
				<div class="form-group" style="height: 40px; margin-top: -46px;">
 					 <label class="control-label" style="text-align: left; float:left; width:98px; line-height: 30px">切换数据源</label>
					 <select class="form-control" id="dataSource" style="width:180px; float:left;">
					 	 <option value="0">请选择</option>
					 </select>
				</div>
				<button class="btn btn-primary btn-sm" id="btnExcel" style="position: fixed; top: 30px; right: 50px;">导出Excel</button>
				<table id="myTable" class="table table-bordered table-striped table-hover">
					<thead>
						
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</body>
		<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'></script>
		<script src='plug-in/ace/js/bootstrap.min.js'></script>
		<script src='plug-in/ace/bi/js/Blob.js'></script>
		<script src='plug-in/ace/bi/js/FileSaver.js'></script>
		<script src='plug-in/ace/bi/js/tableExport.js'></script>
		<script src="plug-in/layer/layer.js" type="text/javascript" charset="utf-8"></script><!-- layer弹窗 -->
		<script src='plug-in/ace/bi/js/loading.js'></script>
		<script>
			var pageid=0, screenIndex=0;
			$(document).ready(function() {
				var screen = JSON.parse('${screen}');
				pageid=${pageId};
				screenIndex=screen[0].screen_Index;
				getList();
				getReportListByPageId();//获取数据源
			});
			
			//选择数据源信息
			$("#dataSource").change(function(){
				var _this = $(this);
				var param = {};
				param.report_Id = _this.val();//报表id
				param.block_Id =  $("#block_Id").val();//区块ID
				param.x_Point = 1;//区块位置
				param.bi_Page_Id = '${pageId}';
				param.block_Type = 1;
				param.screen_Index = 1;
				
				if(param.block_Id == ""){ //保存
					ajaxfn("/rest/bi/biPageBlockController/saveBlock");
				} else {
					ajaxfn("/rest/bi/biPageBlockController/updateBlock");
				}
					
				function ajaxfn(url){
					$.ajax({
						type: "post",
						url: url,
						data:param,
						dataType: "json",
						success: function(result) {
							if(result.data == "success"){
								getList();
							}
						}, 
						error: function(error) {
							console.log(error)
						}
					});
				}
			});
			var index;
			function getList(id) {
				var loading = new Loading()
				var index = loading.start("#1c6bab"); //#1c6bab  如果不填写显示白色，填入颜色值，就显示对应颜色
				var keys=[],values=[];
				if((id+"").length == 2){
					keys[0] = "province";
		 			values[0] = id;
				} else if((id+"").length == 4){
					keys[0] = "city";
		 			values[0] = id;
				}
				var data={
					bi_Page_Id: pageid,
					screen_Index: screenIndex,
					block_Id: 0,
					key:keys,
					value:values,
					block_Type: 1
				}
				$.ajax({
					type: "post",
					url: "/Bi/getReportData?type=table",
					data:JSON.stringify(data),
					contentType:'application/json;charset=utf-8',
					dataType: "json",
					success: function(re) {
						if(re.data.length > 0){
							$("thead").empty();
							$("tbody").empty();
							console.log(re);
							$("#report_Id").val(re.data[0].blockInfo.report_Id);
							$("#block_Id").val(re.data[0].blockInfo.block_Id);
							$("#dataSource").val(re.data[0].blockInfo.report_Id);
							
							//准备表头
							var theadTr = "";
							var titleTr = "";
							for(var x = 0;x<re.data[0].dimHeader.length;x++){
								var theadTh = "";
								var titleTh = "";
								//判断有多少列标题，准备多少"<th></th>"
								for(var y = 0;y<re.data[0].dimField.length;y++){
									theadTh += "<th style='white-space: nowrap'></th>";
									titleTh += "<th style='font-size:18px;'>${pageTitle}</th>";
								}
								//获取th
								for(var y = 0;y<re.data[0].dimFieldHeader[x].length;y++){
									var thCon = re.data[0].dimFieldHeader[x][y]+"";
									if(thCon.indexOf("-") > -1){
										if((tdCon.split("-")[1]+"").length == 6)
											theadTh += "<th style='white-space: nowrap'>"+ thCon.split("-")[0] +"</th>";
										else
											theadTh += "<th style='white-space: nowrap'><a href='javascript:getList("+thCon.split("-")[1]+")'>"+ thCon.split("-")[0] +"</a></th>";
									}else
										theadTh += "<th style='white-space: nowrap'>"+ thCon +"</th>";
									titleTh += "<th style='font-size:18px;'>${pageTitle}</th>";
								}
								theadTr +="<tr>"+ theadTh +"</tr>";
							}
							titleTr +="<tr>"+ titleTh +"</tr>";
							$("thead").append(theadTr);
							var allRows = re.data[0].dimField.length + re.data[0].dimFieldHeader[re.data[0].dimFieldHeader.length-1].length;
							//准备内容
							for(var i = 0; i < re.data[0].tableData.length; i++){ //数据
								var tr = "<tr>";  //总
								for(var j = 0; j < allRows; j++){ //数据
									if(typeof(re.data[0].tableData[i][j]) === "undefined")
										tr += "<td></td>"
									else{
										var tdCon = re.data[0].tableData[i][j]+"";
										if(tdCon.indexOf("-") > -1){
											if((tdCon.split("-")[1]+"").length == 6)
												tr += "<td>"+tdCon.split("-")[0]+"</td>";
											else
												tr += "<td><a href='javascript:getList("+tdCon.split("-")[1]+")'>"+ tdCon.split("-")[0] +"</a></td>";
										}else
											tr += "<td>"+tdCon+"</td>"
									}
								}
								$("tbody").append(tr);
							}
							colspan("#myTable thead");
							for(var x=0; x<re.data[0].dimField.length; x++)
								rowspan("#myTable", x);
						}
						loading.stop(index);
					},
					error: function() {
					}
				});
			}
			

			//函数说明：合并指定表格（表格id为_w_table_id）指定列（列数为_w_table_colnum）的相同文本的相邻单元格
			//参数说明：_w_table_id 为需要进行合并单元格的表格的id。如在HTMl中指定表格 id="data" ，此参数应为 #data 
			//参数说明：_w_table_colnum 为需要合并单元格的所在列。为数字，从最左边第一列为1开始算起。
			function rowspan(_w_table_id, _w_table_colnum) {
				_w_table_firsttd = "";
				_w_table_currenttd = "";
				_w_table_SpanNum = 0;
				_w_table_Obj = $(_w_table_id + " tr *:nth-child(" + _w_table_colnum + ")");
				_w_table_Obj.css("text-align", "center")
				_w_table_Obj.each(function(i) {
					if(i == 0) {
						_w_table_firsttd = $(this);
						_w_table_SpanNum = 1;
					} else {
						_w_table_currenttd = $(this);
						if(_w_table_firsttd.text() == _w_table_currenttd.text()) {
							_w_table_SpanNum++;
							_w_table_currenttd.hide(); //remove();
							_w_table_firsttd.attr("rowSpan", _w_table_SpanNum);
							_w_table_firsttd.css("vertical-align", "middle");
						} else {
							_w_table_firsttd = $(this);
							_w_table_SpanNum = 1;
						}
					}
				});
			}
			//函数说明：合并指定表格（表格id为_w_table_id）
			function colspan(_w_table_id) {
				_w_table_firsttd = "";
				_w_table_currenttd = "";
				_w_table_SpanNum = 0;
				$(_w_table_id + " tr").each(function(i) {
					_w_table_Obj = $(this).children();
					_w_table_Obj.each(function(i) {
						if(i == 0) {
							_w_table_firsttd = $(this);
							_w_table_SpanNum = 1;
						} else {
							_w_table_currenttd = $(this);
							if(_w_table_firsttd.text() == _w_table_currenttd.text()) {
								_w_table_SpanNum++;
								_w_table_currenttd.hide(); //remove();
								_w_table_firsttd.attr("colSpan", _w_table_SpanNum);
							} else {
								_w_table_firsttd = $(this);
								_w_table_SpanNum = 1;
							}
						}
					});
				});
			}
			
			var $exportLink = document.getElementById('btnExcel');
		    $exportLink.addEventListener('click', function(e){
		    	var myDate = new Date();
		    	var time = myDate.toLocaleDateString(); //获取完整的年份(4位,1970-????)
		    	
		        e.preventDefault();
	            tableExport('myTable', time+"_"+myDate.getSeconds()+'${pageTitle}', "csv");
		    }, false);
		    
		    var keys = [];
		    var values = [];
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
						console.log(result)
						//$("#dataSource").empty();
						for(var i = 0;i<result.data.length;i++){
							$("#dataSource").append("<option value="+result.data[i].report_Id+">"+result.data[i].report_Name+"</option>");
						}
					}, 
					error: function(error) {
						console.log(error)
					}
				});
			}
		</script>
	</body>
</html>