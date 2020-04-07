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
		<link rel='stylesheet prefetch' href='plug-in/ace/css/bootstrap-select.min.css'>
		<link rel='stylesheet prefetch' href='plug-in/ace/bi/css/loading.css'>
		<link href="plug-in/ace/adIcon/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
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
			    text-align: center;
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
			.lab{
				text-align: right; 
				float:left; 
				width:80px; 
				line-height: 30px
			}
			.bootstrap-select {
				width: 160px !important;
	    		float: left !important;
    		}
    		.smallTotal{
    			color: #003bc3;
    		}
    		.txtRight{
				text-align:right;
			}
			.sla{
			    overflow: hidden !important;
			    text-overflow: ellipsis !important;
			    white-space: nowrap !important;
			    display: block !important;
			    width: 60px !important;
			}
		</style>
	</head>

	<body>
		<body>
			<input id="block_Id" type="hidden">
			<input id="report_Id" type="hidden">
			<div class="container-fluid">
				<div class="row" style="height:50px; padding:5px;" id="article">
					<div class="col-lg-10 col-md-10 col-sm-8">
						<div class="form-group">
							 <div class="form-group" id="filter">
		 					 	
							 </div>
						</div>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-4">
						<div class="form-group" style="margin-top: 15px;">
							<button class="btn btn-primary btn-sm pull-left" id="btnSearch" style="margin-right:10px;">查询</button>
							<button class="btn btn-primary btn-sm pull-left" id="btnExcel" style="margin-right:10px;">导出Excel</button>
						</div>
					</div>
				</div>
				
				<div class="row" style="margin-top:-30px;">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<div class="pull-right">
							<label class="control-label" style="text-align: left; float:left; width:50px; line-height: 30px">报表：</label>
							<select class="form-control selectpicker" id="dataSource"  multiple data-live-search="true" data-selected-text-format="count">
							</select>
							<label class="control-label" style="text-align: center; float:left; width:60px; line-height: 30px">指标：</label>
							<select class="form-control" id="dataIndex" title="报表只能选择一项才可以" style="width: 120px; float: left;">
							</select>
							<button class="btn btn-primary btn-sm" id="btnLoadReport" style="margin-left:10px;">加载报表</button>
						</div>
						<h3 style="text-align: center; margin: 5px 0 20px 50px;" id="title">
						</h3>
					</div>
					<div class="col-lg-12 col-md-12 col-sm-12" style="margin-top: 20px;">
						<a href="javascript:onBack();" style="font-size: 24px; position: fixed; margin-top: 2px; margin-left: 6px;" title="点击返回上一级">
							<i class="fa fa-arrow-circle-left"></i>
						</a>
						<table id="myTable" class="table table-bordered table-striped table-hover">
							<thead>
								
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</body>
		<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'></script>
		<script src='plug-in/ace/js/bootstrap.min.js'></script>
		<script src='plug-in/ace/js/bootstrap-select.min.js'></script>
		<script src='plug-in/ace/bi/js/Blob.js'></script>
		<script src='plug-in/ace/bi/js/FileSaver.js'></script>
		<script src='plug-in/ace/bi/js/tableExport.js'></script>
		<script src="plug-in/layer/layer.js" type="text/javascript" charset="utf-8"></script><!-- layer弹窗 -->
		<script src='plug-in/ace/bi/js/loading.js'></script>
		<!-- 折叠插件 -->
		<script type="text/javascript" src="plug-in\ace\js\readmore\readmore.min.js"></script>
		<script>
			var pageid=0, screenIndex=0;
			var definaReport = new Array(); //默认选中报表下拉框
			var loading = new Loading();

			var p1 = "", p2 = 0, c1 = "", c2 = 0, x1 = "", x2 = 0;

			$(document).ready(function() {
				index = loading.start("#1c6bab"); //#1c6bab  如果不填写显示白色，填入颜色值，就显示对应颜色
				$('#article').readmore({
   				  speed: 5,
   				  maxHeight: 5
   				});
				var screen = JSON.parse('${screen}');
				pageid=${pageId};
				screenIndex=screen[0].screen_Index;
				getReportListByPageId();//获取数据源
				getList(0);
			});

			//获取指定报表的指标字段  report_id报表Id  by liuxf
			function getDataIndex(report_id){
                $.ajax({
                    type: "get",
                    async: true,
                    url: "rest/bi/biReportFieldController/getReportFieldList?report_Id="+report_id+"&field_Location=3&rows=99999&page=1",
                    dataType: "json",
                    success: function (re) {
                        $("#dataIndex").empty();
                        for (var i = 0; i <re.data.length ; i++) {
                            $("#dataIndex").append("<option value='"+re.data[i].field_Id+"'>"+re.data[i].field_Name+"</option>");
                        }
                    }
                });
			}

			//选择报表模块
			function datasourceReload(reportIdArr){
				var _this = $(this);
				var param = {};
				definaReport = new Array();
				param.block_Id =  $("#block_Id").val();//区块ID
				param.x_Point = 1;//区块位置
				param.bi_Page_Id = '${pageId}';
				param.page_Id = '${pageId}';
				param.block_Type = 1;
				param.screen_Index = 1;
				ajaxfn("rest/bi/biPageBlockController/deleteBlockByPageId");
				for (var i = 0; i < reportIdArr.length; i++) {
					param.report_Id = reportIdArr[i];//报表id
					ajaxfn("rest/bi/biPageBlockController/saveBlock");//保存数据块saveBlock
				}

				function ajaxfn(url){
					$.ajax({
						type: "post",
						async: false,
						url: url,
						data:param,
						dataType: "json",
						success: function(result) {
							if(result.data == "success"){
								getList(0, $("#dataIndex").val());
							}
						}, 
						error: function(error) {
							console.log(error)
						}
					});
				}
			}
			
			var filterNm = {
				survey_year: "调查年份",
				mine_method_nm: "开采方式",
				province: "所属省",
				mine_scale_nm: "矿山规模",
				city: "所属市",
				county: "所属县",
				economic_type_nm: "经济类型",
				production_status_nm: "生产状态",
				minerals_type_name: "矿类",
				minerals_variety_name: "矿种"
			};
			
			var index;
			Array.prototype.remove = function(val) { 
				var index = this.indexOf(val); 
				if (index > -1) { 
					this.splice(index, 1); 
				} 
			};
			var keys = new Array(), values = new Array();  //查询条件
			var index = 0;
			/*
			* id      表示维度钻取  例如id=3701，id.length=4,表示济南市，
			* indexs  指标列表*/
			function getList(id, indexs) {
				var drill_Name, drill_Value;
				if((id+"").length == 2){
					drill_Name = "province";
					drill_Value = id;
					p1 = "province";
					p2 = id;
				} else if((id+"").length == 4){
					drill_Name = "city";
					drill_Value = id;
					c1 = "city";
					c2 = id;
				}
				$('.filters').each(function(){
					var idn = this.id;
					if($(this).val() != 0){
						for (var i = 0; i < keys.length; i++) { //避免条件重复
			                if (keys[i].indexOf(idn) > -1) {
			                	keys.splice(i, 1);
			                	values.splice(i, 1);
			                }
			            }
						if(idn == "province" || idn == "city" || idn == "county") {
							if(idn == "city"){
								drill_Name = "province";
								drill_Value = ($(this).val()+"").substring(0, 2);
								p1 = "province";
								p2 = ($(this).val()+"").substring(0, 2);//省是两个字符
							}else if(idn == "county"){
								drill_Name = "city";
								drill_Value = ($(this).val()+"").substring(0, 4);
								c1 = "city";
								c2 = ($(this).val()+"").substring(0, 4);//city 用四个字符
							}
							keys.push("mine_survey_info."+idn);
					 		values.push($(this).val());
						} else {
							if(idn.indexOf("_nm") > -1){
								idn = " mine_survey_info."+idn.replace("_nm", "");
							}
							keys.push(idn);
					 		values.push($(this).val());
						}
					}else{
						if(idn.indexOf("_nm") > -1){
							idn = " mine_survey_info."+idn.replace("_nm", "");
						}
					}
		 		});

				var data={
					bi_Page_Id: pageid,
					screen_Index: screenIndex,
					block_Id: 0,
					key: keys,
					value: values,
					block_Type: 1,
					drill_Name: drill_Name,
					drill_Value: drill_Value
				}
				if(indexs != 0)
				    data.index = indexs;
				//获取报数据数据
				$.ajax({
					type: "post",
					async: true,
					url: "/Bi/getReportData",
					data:JSON.stringify(data),
					contentType:'application/json;charset=utf-8',
					dataType: "json",
					success: function(re) {
						if(re.data.length > 0){
							var year = "";
							for(var i=0; i<keys.length; i++){
								if(keys[i].indexOf("survey_year") > -1){
									year = values[keys[i].indexOf("survey_year")] + "年 ";
								}
							}
							if(indexs != 0){
                                $("#title").text(year+"调查"+$("#dataIndex option:selected").text()+"统计表 （"+re.data[0].unit[0]+"）");
							}else{
                                $("#title").text(year+"${pageTitle} （"+re.data[0].unit[0]+"）");
							}
							//1.显示查询条件
							$("thead").empty();
							$("tbody").empty();
							$("#report_Id").val(re.data[0].blockInfo.report_Id);
							$("#block_Id").val(re.data[0].blockInfo.block_Id);
							$("#filter").empty();
							for(var i=0; i<re.data[0].dimHeader.length; i++){
								if(re.data[0].dimHeader[i] != "sub_nm"){
									var hf = '<label class="control-label lab">'+filterNm[re.data[0].dimHeader[i]]+'：</label>'+
											 '<select class="form-control filters" id="'+re.data[0].dimHeader[i]+'" style="width:160px; float:left;">'+
											 	 '<option value="0">全部</option>'+
											 '</select>';
									 $("#filter").append(hf);

									 if(re.data[0].dimHeader[i] == "province"){
									 	getFilterInfo(re.data[0].dimHeader[i], 0);
									 }else if(re.data[0].dimHeader[i] == "city"){
										getFilterInfo(re.data[0].dimHeader[i], id);
									 }else if(re.data[0].dimHeader[i] == "county"){
										getFilterInfo(re.data[0].dimHeader[i], id);
									 }else{
										getFilterInfo(re.data[0].dimHeader[i], 0);
									 }
								}
							}
							//2.列维度 by liuxf
							for(var i=0; i<re.data[0].dimField.length; i++){
								if(re.data[0].dimField[i] != "sub_nm"){

									var hf = '<label class="control-label lab">'+filterNm[re.data[0].dimField[i]]+'：</label>'+
											 '<select class="form-control filters" id="'+re.data[0].dimField[i]+'" style="width:160px; float:left;">'+
											 	 '<option value="0">全部</option>'+
											 '</select>';
									 $("#filter").append(hf);

									 if(re.data[0].dimField[i] == "province"){
									 	getFilterInfo(re.data[0].dimField[i], 0);
									 }else if(re.data[0].dimField[i] == "city"){
										getFilterInfo(re.data[0].dimField[i], id);
									 }else if(re.data[0].dimField[i] == "county"){
										getFilterInfo(re.data[0].dimField[i], id);
									 }else{
										getFilterInfo(re.data[0].dimField[i], 0);
									 }
								}
							}
							
							//3.准备表头
							var theadTr = "";
							var titleTr = "";
							for(var x = 0;x<re.data[0].dimHeader.length;x++){//x表示一个维度，y表示维度中的每一列数据 by liuxf
								var theadTh = "";
								var titleTh = "";
								//判断有多少列标题，准备多少"<th></th>"
								for(var y = 0;y<re.data[0].dimField.length;y++){
									theadTh += "<th style='white-space: nowrap'></th>";
									titleTh += "<th style='font-size:18px;'>${pageTitle}</th>";
								}
								//获取th  dimFieldHeader  行维度 对应 java listRowHeader
								for(var y = 0;y<re.data[0].dimFieldHeader[x].length;y++){
									if(typeof(re.data[0].dimFieldHeader[x][y]) === "undefined")
										tr += "<th></th>"
									else{
										var thCon = re.data[0].dimFieldHeader[x][y]+"";
										if(thCon.indexOf("-") > -1){
											if((thCon.split("-")[1]+"").length == 6){//表示是县级单位（第三级 长度为6  .xxxxxx.
												theadTh += "<th title='"+thCon.split("-")[0]+"'><a class='sla' target='_blank' href='rest/mgeids/mgeidsMineInfoListController?county="+thCon.split("-")[1]+"&year="+year+"'>" + thCon.split("-")[0]+"</a></th>";
											}else{
												theadTh += "<th title='"+thCon.split("-")[0]+"'><a class='sla' href='javascript:getList("+thCon.split("-")[1]+")'>"+ thCon.split("-")[0] +"</a></th>";
											}
										}
										else {
											/*
											   by liuxf   drill_type=4 按照不同的主题进行钻取
											   getList (drill_name ,drill_value

										       getList(dim_name - current_topic_index,  dim_data) 生成连接进行钻取。
											*/
											if(re.data[0].BIRowDimDatas[x].dill_type==4){
												param=re.data[0].BIRowDimDatas[x].field_name+'-' +re.data[0].BIRowDimDatas[x].currentTableIndex+","+thCon;
												theadTh += "<th title='"+thCon.split("-")[0]+"'><a class='sla' href='javascript:getList("+param+")'>"+ thCon.split("-")[0] +"</a></th>";
											}
											else
												theadTh += "<th title='" + thCon + "'><span class='sla'>" + thCon + "</span></th>";
										}
									}
									titleTh += "<th style='font-size:18px;'>${pageTitle}</th>";
								}
								var heji = "";
								if(x == 0)
									heji = "<th>合计</th>";
								else
									heji = "<th></th>";
								theadTr +="<tr>"+ theadTh+heji+"</tr>";
							}
							titleTr +="<tr>"+ titleTh +"</tr>";
							$("thead").append(theadTr);
							//4.准备业务数据内容
							for (var z = 0; z < re.data.length; z++) {
								definaReport.push(re.data[z].reportInfo.report_Id); 
								var smallTotal = new Array(), reSmallTotal = new Array();
								//dimField---->colDimFields
								//allDataCols  是所有的列数据，包括列维度个数+ 业务数据的列数 by liuxf
								var allDataCols = re.data[z].dimField.length ;//列维度个数 一个列维度占据一列
								if (re.data[z].dimFieldHeader!=null &&re.data[z].dimFieldHeader.length>0)//判断表头是否为空，如果为空，则不计算在内
									allDataCols+= re.data[z].dimFieldHeader[re.data[z].dimFieldHeader.length-1].length;
								else
									allDataCols+=1;//只有一列数据
								for(var i = 0; i < re.data[z].tableData.length; i++){ //数据
									var tr = "<tr>";  //总
									var heji = 0, flag = 0;
									for(var j = 0; j < allDataCols; j++){ //数据
										if(typeof(re.data[z].tableData[i][j]) === "undefined"){
											tr += "<td></td>";
										} else {
											var tdCon = re.data[z].tableData[i][j];
											if(tdCon.indexOf("-") > -1){
												if((tdCon.split("-")[1]+"").length == 6){
													tr += "<td><a target='_blank' href='rest/mgeids/mgeidsMineInfoListController?county="+tdCon.split("-")[1]+"&year="+year+"'>" + tdCon.split("-")[0]+"</a></td>";
												}else{
													tr += "<td><a href='javascript:getList("+tdCon.split("-")[1]+")'>"+ tdCon.split("-")[0] +"</a></td>";
												}
											}else{
												if(j > re.data[z].dimField.length-1){
													tr += "<td class='txtRight'>"+tdCon+"</td>";
												} else{
													tr += "<td>"+tdCon+"</td>";
												}
												var dl = re.data[z].dimField.length;
												if(j >= dl){
                                                    if(!isNaN(parseInt(tdCon)) || !isNaN(parseInt(tdCon))){
                                                        if((tdCon+"").indexOf(".")==-1){
                                                            heji += parseInt(tdCon);
                                                        }else{
                                                            heji += parseFloat(tdCon);
                                                        }
														if(i == 0){  //小计计算
															smallTotal.push(Number(tdCon));
														}else{
															smallTotal[j-dl] = smallTotal[j-dl]+parseInt(tdCon);
														}
													}else{
														if(i == 0){
															smallTotal.push(0);
														}else{
															smallTotal[j-dl] = smallTotal[j-dl]+0;
														}
													}
													flag = 1;
												}
											} //else -
										}  //undefinal else
									} //for 数据
									if(flag == 1)
										tr += "<td class='txtRight'>"+heji+"</td>";
									$("tbody").append(tr);
								}
								
								//追加小计dom元素
								var stTr = "<tr class='smallTotal'>";
								for(var idim = 0; idim<re.data[z].dimField.length; idim++){
									if(idim == re.data[z].dimField.length-1)
										stTr += "<td>小计("+re.data[z].reportInfo.report_Title+")</td>";
									else
										stTr += "<td></td>";
								}
								var stotal = 0;
								for(var ii = 0; ii<smallTotal.length; ii++){
									if(String(smallTotal[ii]).indexOf('.')>-1)
										smallTotal[ii] = smallTotal[ii].toFixed(6);
									stTr += "<td class='txtRight'>"+smallTotal[ii]+"</td>";
									if(!isNaN(tdCon)){
                                        if(!isNaN(tdCon)){
                                            if((smallTotal[ii]+"").indexOf(".")==-1){
                                                stotal+=parseInt(smallTotal[ii]);
                                            }else{
                                                stotal+=parseFloat(smallTotal[ii]);
                                            }
                                        }
									}
								}
								if(String(smallTotal[ii]).indexOf('.')>-1)
									stotal = stotal.toFixed(6);
								stTr += "<td class='txtRight'>"+stotal+"</td>";  //小计的合计
								stTr += "</tr>";
								$("tbody").append(stTr);
							}  //追加表格身体
							//合并单元格
							colspan("#myTable thead");
							for(var x=0; x<re.data[0].dimField.length; x++)
								rowspan("#myTable", x);
						}

						$('.selectpicker').selectpicker({
							'liveSearch': true
						});
						if(definaReport.length > 0){
							$('.selectpicker').selectpicker('val', definaReport);  //为下拉框赋默认值
							getDataIndex(definaReport[0]);
						}
                        loading.stop(index);
					},
					error: function() {
					}
				});
			}
			
		 	//根据pageID获取报表列表（一个页面会有多个报表）
			function getReportListByPageId() {
				$.ajax({
					type: "GET",
					async: false,
					url: "rest/bi/biReportController/getReportListByPageId",
					data:{
						pageId:'${pageId}',
						screenIndex: screenIndex
					},
					dataType: "json",
					success: function(result) {
						for(var i = 0;i<result.data.length;i++){
							$("#dataSource").append("<option value="+result.data[i].report_Id+">"+result.data[i].report_Name+"</option>");
						}
					}, 
					error: function(error) {
						console.log(error)
					}
				});
			}
		 	
			$('#btnLoadReport').on('click', function () {
				index = loading.start("#1c6bab");
				var reportIdArr = $("#dataSource").val();
			  	if(reportIdArr == null)
			  		parent.bootbox.alert("至少选择一项");
			  	else{
			  		index = loading.start("#1c6bab");
					if(definaReport.length>1){
						$("#dataIndex").css("disable", "disable");
						$("#dataIndex option:first").prop("seleced", "selected");
					}
					datasourceReload(reportIdArr);
			  	}
			});

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
	            tableExport('myTable', $("#title").text()+time+"_"+myDate.getSeconds(), "csv");
		    }, false);
		    
		 	//获取过滤信息
			function getFilterInfo(filterName, areaId) {
				$.ajax({
					type: "GET",
					url: "/Bi/getFilterValue",
					data:{
						filterName: filterName,
						areaId: areaId
					},
					dataType: "json",
					success: function(result) {
						$("#filter"+filterName).empty();
						$("#filter"+filterName).append("<option value='0'>全部</option>");

						if(filterName == "survey_year"){
							for (var item in result.data) {
								$("#"+filterName).append("<option value="+result.data[item]+">"+result.data[item]+"</option>");
							}
						}else{
							for (var item in result.data) {
								$("#"+filterName).append("<option value="+result.data[item]+">"+item+"</option>");
							}
						}
					}, 
					error: function(error) {
						//console.log(error)
					}
				});
			}
		 	
		 	$("#btnSearch").on("click", function () {
		 		getList(0);
		 	});
		 	
		 	function onBack(){
		 		if(p1 == ""){
		 			parent.bootbox.alert("你已经在最顶层，无法后退了");
		 		}else if(c1 == ""){
		 			getList(0);
		 			p1 = "";
		 			p2 = 0;
		 		}else if(x1 == ""){
		 			getList(p2);
		 			c1 = "";
		 			c2 = 0;
		 		}
		 	}
		</script>
	</body>
</html>