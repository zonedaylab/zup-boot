<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>表单布局设置管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"><link href="plug-in/ace/adIcon/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
      <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-treeview/1.2.0/bootstrap-treeview.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
    <style>
		#table-select ul{
			margin : 0;
			padding: 0;
		}
		ul li{
			list-style-type:none;
		}
		div.table-data{
			float: left;
		}
		div.data-search-show{
			float: right;
		}
		div.data-title{
			border: #0b6cbc 1.5px solid;
			height: 2.5em;
			height: 48px;
			line-height: 42px;
		}
		div.data-line{
			height: 2.5em;
			line-height: 2.5em;
			margin: 0.5em 0;
			margin-top: 23px;
		}
	</style>
	<!--  import style	-->
	<jsp:include page="../include/mainHead.jsp"></jsp:include>
<%--	  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">--%>
      <%--	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">--%>
  </head>
  <body style="width:97%; margin-left:20px; background:#ffffff; overflow-x: hidden;">
  	<!--  BI Content	-->
  	<div class="row">
  		<!-- datables开始 -->
		<div class="table-header">图表设计</div>
		<div class="row">
			<div class="col-md-6" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加数据源</button>
<%--				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>--%>
			</div>
			<div class="col-md-7"></div>
		</div>
  	</div>
  	<div class="row col-md-2 table-data " >
		<ul class=" nav nav-list " id="table-select">
		</ul>
	</div>

	<div class="data-search-show col-md-10">
		<div class="row data-line">
			<div class="col-md-2 text-right"><b>列：</b></div>
			<div class="col-md-10 data-title mubiao" ondrop="drop(event)" ondragover="allowDrop(event)" id="column">

			</div>
		</div>
		<div class="row data-line">
			<div class="col-md-2 text-right"><b>行：</b></div>
			<div class="col-md-10 data-title mubiao" ondrop="drop(event)" ondragover="allowDrop(event)" id="row">

			</div>
		</div>
		<div class="row data-line">
			<div class="col-md-2 text-right"><b>值：</b></div>
			<div class="col-md-10 data-title mubiao" ondrop="drop(event)" ondragover="allowDrop(event)" id="value"></div>
		</div>
		<div class="row data-line">
			<iframe id="mainContent" width="100%" height="1000px" scrolling="auto" frameborder="0"></iframe>
		</div>
	</div>
	<!--弹出框放置位置  添加 删除  查看详情-->
	<div id="fromEdit" class="hide">
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >报表名称：</strong>
							<input class="form-control" id="report_Name" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >报表标题：</strong>
							<input class="form-control" id="report_Title" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">关联数据表：</strong>
							<select class="form-control" id="biz_Table_Name" style="width:180px; float:left;"></select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">所属表单：</strong>
							<select class="form-control" id="bi_Page" style="width:180px; float:left;"  disabled="disabled"></select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
    <!--弹出框放置位置  添加 删除  查看详情-->
    <div id="fromEdit2" class="hide">
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-6 column">
                    <form class="form-horizontal" role="form">
                        <%--<div class="form-group row">
                             <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段选择：</strong>
                             <select class="form-control" id="field_Id" style="width:200px; float:left;"></select>
                             <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div> --%>
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段名称：</strong>
                            <select class="form-control" id="field_Name" type="text" style="width:200px; float:left;">
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段别名：</strong>
                            <input class="form-control" id="field_Caption" type="text" style="width:200px; float:left;"/>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段标题：</strong>
                            <input class="form-control" id="field_Title" type="text" style="width:200px; float:left;"/>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >数据类型：</strong>
                            <select class="form-control" id="data_Type" style="width:200px; float:left;">
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段类型：</strong>
                            <select class="form-control" id="field_Type" style="width:200px; float:left;">
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                    </form>
                </div>
                <div class="col-md-6 column">
                    <form class="form-horizontal" role="form">
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段位置：</strong>
                            <select class="form-control" id="field_Location" style="width:200px; float:left;">
                                <option value="1">行维</option>
                                <option value="2">列维</option>
                                <option value="3">指标</option>
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>

                        <div class="form-group row" id="dim">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;">维度顺序：</strong>
                            <input class="form-control" id="dim_Order" style="width:200px; float:left;" type="number" />
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                        <div class="form-group row">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >可见性：</strong>
                            <select class="form-control" id="display" style="width:200px; float:left;">
                                <option value="1">显示</option>
                                <option value="0">不显示</option>
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>

                        <div class="form-group row unit">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >数据单位：</strong>
                            <input class="form-control" id="unit" type="text" style="width:200px; float:left;" value=""/>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>

                        <div class="form-group row dim_Id">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >对应维表：</strong>
                            <select class="form-control" id="dimId" style="width:200px; float:left;">
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>

                        <div class="form-group row aggregate_Type">
                            <strong class="control-label" style="text-align: left; float:left; width:78px;" >聚合类型：</strong>
                            <select class="form-control" id="aggregate_Type" style="width:200px; float:left;">
                                <option value="0">请选择</option>
                                <option value='AVG_'>AVG</option>
                                <option value='COUNT_'>COUNT</option>
                                <option value='MAX_'>MAX</option>
                                <option value='MIN_'>MIN</option>
                                <option value='SUM_'>SUM</option>
                            </select>
                            <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>

  	<!--  import javascript	-->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-treeview/1.2.0/bootstrap-treeview.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>


	<%--<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>--%>
    <script>
        //增加右键功能
        $(function(){
            //注册右键菜单的项与动作
            $("#table-select").contextMenu({
                selector: '.context-menu-one', // 选择器，为某一类元素绑定右键菜单
                callback: function(key, options) {
                    if(key == 'delete'){
                    	var btn = window.confirm("确定要删除此报表吗？");
                    	if (btn){
							var reportId = $(this).find("ul").attr("value");
							deleteReportData(reportId);
							$(this).remove();
						} else {
                    		return
						}

                    }
                    if(key == 'edit'){
						par.thisid = 'btnEdit';
						var reportId = $(this).find("ul").attr("value");
						par.report_Id = reportId;
						e = window.event;
						getReportData(e);
					}
                    if(key == 'config'){
                        var reportId = $(this).find("ul").attr("value");
                        loadReportFieldList(reportId);
                    }
                },
                items: {
                    "delete": {name: "删除", icon: "delete"},
					"edit":{name:"编辑", icon:"edit"},
                    "config": {name: "配置字段", icon:function () {
                            return 'context-menu-icon context-menu-icon-loading'; }}
                }
            });
        });
    </script>
    <script type="text/javascript">
	        var pageID=null;
			var langData;
			var par = {};   //声明ajax传输参数的数组变量
			$.ajax({
				url: "plug-in/ace/adIcon/lang/zh-cn.json",//json文件位置
				async: false,
				type: "GET",//请求方式为get
				dataType: "json", //返回数据格式为json
				success: function(data) {//请求成功完成后要执行的方法
					langData = data;
				}
			});
    		$(document).ready(function(){
                pageID="${pageId}";
                loadTableList();
                loadTableName(-1);//加载数据表名
                getDataType();//数据类型
                getFieldType();//字段类型
                getBiDimName();//获取维表名称
    		});

			//iframe数据展示

			//iframe数据展示
			function calcPageHeight(doc){
				var cHeight = Math.max(doc.body.clientHeight, doc.documentElement.clientHeight)
				var sHeight = Math.max(doc.body.scrollHeight, doc.documentElement.scrollHeight)
				var height = Math.max(cHeight, sHeight)
				return height;
			}
			var ifr = document.getElementById("mainContent")
			ifr.src = "/Bi/BIPageShow?pageId=${pageId}"
			ifr.onload = function () {
				//解决打开高度太高的页面后再打开高度较小的页面滚动条不收缩
				ifr.style.height='0px';
				var iDoc = ifr.contentDocument || ifr.document
				var height = calcPageHeight(iDoc)
				if(height < 850){
					height = 850;
				}
				ifr.style.height = height + 'px'
			}
			document.ondrop = function (e) {
				var id = e.dataTransfer.getData("text/html");
				//@吴登亮为div添加了title属性afterStyle
				var dom_html='<div class="btn-group" title="afterStyle" draggable="true">\n ' +
						'     <button data-toggle="dropdown" class="btn btn-warning dropdown-to">'+
						'        '+(dom.innerText)+'\n' +
						'         <span class="ace-icon fa fa-caret-down icon-on-right"></span>\n'+
						'     </button>\n' +
						'     <ul class="dropdown-menu dropdown-warning"  id="'+id+'">\n'+
						'         <li>\n'+
						'             <a href="javascript:void(0);" onclick="biReportFieldEdit(this)">编辑</a>\n'+
						'         </li>\n'+
						'         <li>\n'+
						'             <a href="javascript:void(0);" onclick="deleteReportField(this)">移除</a>\n'+
						'         </li>\n'+
						'       </ul>\n'+
						'</div>';
				document.getElementById(id).innerHTML=dom_html;
				e.target.appendChild(document.getElementById(id));
				//实时保存数据
				ifr.src = "/Bi/BIPageShow?pageId=${pageId}"
			}

    		//@段延玉，加载报表字段
            function loadTableList(){
				$.ajax({
					type: "POST",
					url: "rest/bi/biReportController/getTableName",
					cache: false, //禁用缓存
					data: {
						page_Id:${pageId}
					},
					dataType: "json",
					success: function (resulet) {
						//加载报表
						//console.log(resulet);

						var table_column = $("#column");
						var table_row = $("#row");
						var table_value = $("#value");

						//拿到返回的map<key,val>  每一个key都是Report_Id:而Report_Id对应着
						var  biReportFieldMaps = resulet.biReportFieldMaps;
                        var biReportFieldMapsLength = Object.keys(biReportFieldMaps).length;

						if (biReportFieldMapsLength == 1) {
                            for (var key in biReportFieldMaps) {

                                var biReportFields = biReportFieldMaps[key];

                                //加载已经添加的字段 行 列 值
                                for (var i = 0; i < biReportFields.length; i++) {
                                    var dataname = "";
                                    // var d_val = (biReportFields[i].field_Title==null || biReportFields[i].field_Title==""?biReportFields[i].field_Name:biReportFields[i].field_Title);

                                    //构造Dom元素
                                    var dom_html = buildDomHtml(biReportFields[i].report_Field_Id,biReportFields[i].report_Id,biReportFields[i].field_Name,biReportFields[i].field_Title,biReportFields[i].report_Id);

                                    switch (biReportFields[i].field_Location) {
                                        case 1:
                                            dataname = "行维";
                                            table_row.append(dom_html);
                                            break;
                                        case 2:
                                            dataname = "列维";
                                            table_column.append(dom_html);
                                            break;
                                        case 3:
                                            dataname = "指标";
                                            table_value.append(dom_html);
                                            break;
                                        default:
                                            dataname = "指标";
                                            table_value.append(dom_html);
                                            break;
                                    }
                                }
                            }
                        }

						//加载数据列表
						for (var i = 0; i < resulet.biReportLists.length; i++) {
							var reportId = resulet.biReportLists[i].report_Id;
							var myTree ='<li class="context-menu-one">'+'<a class="dropdown-toggle">'+'<span class="menu-text">'+resulet.biReportLists[i].report_Title+'</span>'+'</a>'+'<ul id=table'+reportId+' class="" style="display:none" value='+reportId+'>'+'</ul>' + '</li>';
							$("#table-select").append(myTree);
							var tableName = resulet.biReportLists[i].biz_Table_Name;
							//为了解决异步加载的问题单独拿出一个方法
							loadTableListData(tableName,reportId,resulet.mapMap[resulet.biReportLists[i].report_Id]);
						}
					},
					error:function () {
						alert('报表数据加载失败！');
					}
				});
            }

            //构造Dom元素
            function buildDomHtml(report_Field_Id,report_Id,field_Name,field_Title) {
				//@吴登亮为div添加了title属性afterStyle
				var dom_html = '\t<div class="btn-group" title="afterStyle" id="'+field_Name+'" draggable="true" ondragstart="drag(e)">\n' +
						'\t'+'<input class="hidden_report_Field_Id" hidden value="'+report_Field_Id+'">'+
						'\t'+'<input class="hidden_report_Id" hidden value="'+report_Id+'">'+
						'\t<button data-toggle="dropdown" class="btn btn-warning dropdown-toggle" aria-expanded="false">\n' +
						'\t\t'+(field_Title==null || field_Title==""?field_Name:field_Title)+'\n' +
						'\t\t<span class="ace-icon fa fa-caret-down icon-on-right"></span>\n' +
						'\t</button>\n' +
						'\t<ul class="dropdown-menu dropdown-warning"  id="'+report_Field_Id+'" value="'+report_Id+'">\n' +
						'\t<li>\n' +
						'\t\t\t<a href="javascript:void(0);"  onclick="biReportFieldEdit(this)">编辑</a>\n' +
						'\t\t</li>\n' +
						'\t\t<li>\n' +
						'\t\t\t<a href="javascript:void(0);" onclick="deleteReportField(this)">移除</a>\n' +
						'\t\t</li>\n' +
						'\t</ul>\n' +
						'\t</div>\n';

				return dom_html;
			}

			//为了解决异步加载的问题单独拿出一个方法
            function loadTableListData(tableName,reportId,mapMap) {
				//获取该表的所有字段名
				$.ajax({
					type: "POST",
					url: "rest/bi/BIDimController/getTableData?tableName="+tableName,
					cache: false, //禁用缓存
					data: "",
					dataType: "json",
					success: function (result) {
						//console.log(result);
						var data = result.data;
						for (var i=0;i <  data.length;i++) {
							//过滤数据，如果map中为null，代表没添加到行列值中，否则相反
							if(mapMap[data[i].dim_Field_Name]==null){
								var c_val = (data[i].field_Desc==null || data[i].field_Desc=="" ? data[i].dim_Field_Name : data[i].field_Desc);
								//@吴登亮 （为字段添加的title属性default)
								var colums = '<li>'+'<a title="default" value='+data[i].dim_Field_Name+' id='+result.data[i].dim_Field_Name+' draggable="true" ondragstart="drag(event)">'+c_val +'</a>'+'<b class="arrow">'+'</b>'+'</li>';
								$("#table"+reportId).append(colums);
							}
						}
					},
					error: function(){
						alert("字段添加失败");
					}
				});
			}

			//单独加载各个报表中字段的方法
			function loadReportFieldList(reportId){
			    var parm = {};
                parm.rows = 1;//页面显示记录条数，在页面显示每页显示多少项的时候
                parm.start = 1;//开始的记录序号
                parm.page = 2;//当前页码
                parm.report_Id = reportId;
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biReportFieldController/getReportFieldList",
                    cache: false,  //禁用缓存
                    data: parm,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                        console.log(result);
                        var table_column = $("#column");
                        var table_row = $("#row");
                        var table_value = $("#value");

                        table_column.empty();
                        table_row.empty();
                        table_value.empty();
                        //构造Dom元素
                        var biReportFields = result.data;
                        for (let i = 0; i < biReportFields.length; i++) {
                            var dom_html = buildDomHtml(biReportFields[i].report_Field_Id,biReportFields[i].report_Id,biReportFields[i].field_Name,biReportFields[i].field_Title,biReportFields[i].report_Id);
                            switch (biReportFields[i].field_Location) {
                                case 1:
                                    dataname = "行维";
                                    table_row.append(dom_html);
                                    break;
                                case 2:
                                    dataname = "列维";
                                    table_column.append(dom_html);
                                    break;
                                case 3:
                                    dataname = "指标";
                                    table_value.append(dom_html);
                                    break;
                                default:
                                    dataname = "指标";
                                    table_value.append(dom_html);
                                    break;
                            }
                        }
                    }
                });

                var tableList = $('#table-select');
                var tableLiList = tableList.children('li');
                for (let i = 0; i < tableLiList.length; i++) {
                    var thisReportId = tableLiList[i].childNodes[1].attributes[3].nodeValue;
                    if (thisReportId == reportId){
                        tableLiList[i].childNodes[0].attributes[0].nodeValue = 'dropdown-toggle';
                    }else {
                        tableLiList[i].childNodes[0].attributes[0].nodeValue = '';
                    }
                }
            }

			//增删改按钮命令
			$("#btnAdd").on("click", function(e){
				loadTableName(-1);
				$("#biz_Table_Name").val("");
				par.thisid = this.id;
				msgDialog(e);
			});
			//定义树里的数据来源
			function getTree(tableName) {
				$.ajax({
					type: "POST",
					url: "rest/bi/BIDimController/getTableData?tableName="+tableName,
					cache: false, //禁用缓存
					data: "",
					dataType: "json",
					success: function (result) {
						alert(result.data[i].dim_Field_Name);
						var data = [{
							text: tableName,
							href: '#'+tableName,
							tags: ['4'],
							nodes: [{}]
						}];
						return data;
					},
					error: function(){
						alert("字段添加失败");
					}
				});

			}
			//@段延玉，添加报表
			function addReportData(){
				pageID="${pageId}";
				//ajax请求数据
				$.ajax({
					type: "POST",
					url: "rest/bi/biReportController/saveReport",
					cache: false,  //禁用缓存
					data: par,  //传入组装的参数
					dataType: "json",
					success: function (result) {
						if(result.data == "success"){
							parent.parent.bootbox.alert("添加成功", function(){});
							console.log(par);
							var myTree ='<li class="context-menu-one">'+'<a class="dropdown-toggle">'+'<span class="menu-text">'+par.report_Title+'</span>'+'</a>'+'<ul id=table'+par.report_Id+' class="" style="display:none" value='+par.report_Id+'>'+'</ul>' + '</li>';
							$("#table-select").append(myTree);
							loadTableListData2(par.biz_Table_Name,par.report_Id);
							$( "#fromEdit" ).dialog( "close" );
						}else{
							parent.parent.bootbox.alert("添加失败", function(){});
						}
					},
					error: function(){
						parent.parent.bootbox.alert("添加失败", function(){});
					}
				});
			}
			//添加报表字段
			function loadTableListData2(tableName,reportId) {
				//获取该表的所有字段名
				$.ajax({
					type: "POST",
					url: "rest/bi/BIDimController/getTableData?tableName="+tableName,
					cache: false, //禁用缓存
					data: "",
					dataType: "json",
					success: function (result) {
						console.log(result);
						var data = result.data;
						for (var i=0;i <  data.length;i++) {
							//过滤数据，如果map中为null，代表没添加到行列值中，否则相反
							var c_val = (data[i].field_Desc==null || data[i].field_Desc=="" ? data[i].dim_Field_Name : data[i].field_Desc);
							//@吴登亮 （为字段添加的title属性default)
							var colums = '<li>'+'<a title="default" value='+data[i].dim_Field_Name+' id='+result.data[i].dim_Field_Name+' draggable="true" ondragstart="drag(event)">'+c_val +'</a>'+'<b class="arrow">'+'</b>'+'</li>';
							$("#table"+reportId).append(colums);
						}
					},
					error: function(){
						alert("字段添加失败");
					}
				});
			}

			function deleteReportData(report_Id){
				report_Ids = [];
				report_Ids[0] = report_Id;
				$.ajax({
					url: 'rest/bi/biReportController/deleteReport?report_Ids[]=' + report_Ids,
					async: false,
					data: '',
					type: 'POST',
					dataType: 'json',
					success: function (result) {
						if (result.data == "success") {
							parent.parent.bootbox.alert("删除成功", function () {
							});
							loadGrid();
						} else {
							parent.parent.bootbox.alert("删除失败， 失败的报表id为：" + result.data, function () {
							});
						}
					},
					error: function () {
						parent.parent.bootbox.alert("删除失败", function () {
						});
					}
				});
			}

			//弹出框样式
			$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
				_title: function(title) {
					var $title = this.options.title || '&nbsp;'
					if( ("title_html" in this.options) && this.options.title_html == true )
						title.html($title);
					else title.text($title);
				}
			}));

			//点击编辑时根据主键获取到数据进行填充文本框
			function getReportData(e){
				//ajax请求数据
				$.ajax({
					type: "POST",
					url: "rest/bi/biReportController/getReportInfo",
					cache: false,  //禁用缓存
					data: par,  //传入组装的参数
					dataType: "json",
					success: function (result) {
						$("#report_Name").val(result.data.report_Name);
						$("#report_Title").val(result.data.report_Title);
						// $("#topic_Id").val(result.data.topic_Id);
						$("#biz_Table_Name").val(result.data.biz_Table_Name);//所关联的数据库

						// $("#biz_Table_Name").html("");//清空之前的
						// $("#biz_Table_Name").append("<option value="+result.data.biz_Table_Name+">"+result.data.biz_Table_Name+"</option>");//填充编辑的
						// $("#biz_Table_Name").attr("disabled","disabled");//禁止编辑

						$("#bi_Page").val(result.data.page_Id);
						msgDialog(e);
					},
					error: function(){
						parent.parent.bootbox.alert("编辑获取数据失败", function(){});
					}
				});
			}

			//点击编辑
			function editReportData(){
				//ajax请求数据
				$.ajax({
					type: "POST",
					url: "rest/bi/biReportController/updateReport",
					cache: false,  //禁用缓存
					data: par,  //传入组装的参数
					dataType: "json",
					success: function (result) {
						if(result.data == "success"){
							parent.parent.bootbox.alert("更新成功", function(){});
							//loadGrid();
							$("#table-select").empty();
							loadTableList();
							$( "#fromEdit" ).dialog( "close" );
						}else{
							parent.parent.bootbox.alert("更新失败", function(){});
						}
					},
					error: function(){
						parent.parent.bootbox.alert("更新失败", function(){});
					}
				});
			}

			function msgDialog(e){
				e.preventDefault();
				var dialog = $( "#fromEdit" ).removeClass('hide').dialog({
					modal: true,
					width:325,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>报表设置</h4></div>",
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
								par.report_Name = $("#report_Name").val();
								par.report_Title = $("#report_Title").val();
								par.biz_Table_Name = $("#biz_Table_Name").val();
								par.page_Id = "${pageId}";
								if(par.thisid == "btnAdd"){
									addReportData();
								}else if(par.thisid == "btnEdit"){
									par.bi_Page_Id = $("#bi_Page_Id").val();
									editReportData();
								}
							}
						}
					]
				});
			}

			//加载数据表的所有字段名
            function loadTableData(tableName){
                $.ajax({
                    type: "POST",
                    url: "rest/bi/BIDimController/getTableData?tableName="+tableName,
                    cache: false, //禁用缓存
                    data: "",
                    dataType: "json",
                    success: function (result) {
                        return result;
                    },
					error: function(){
						alert("字段添加失败");
					}
                });
            }

			//加载数据库表名
			function loadTableName(value){
				$.ajax({
					type: "POST",
					url: "rest/bi/BIDimController/getDatabaseTableName",
					cache: false, //禁用缓存
					data: "",
					dataType: "json",
					success: function(result){
						if(result.data != "error"){
							$("#biz_Table_Name").html("");
							$("#biz_Table_Name").append("<option value='0'>请选择</option>");
							for(var i=0; i< result.data.length; i++){
								var txt = langData.dimManage.tableName[result.data[i]];
								if(typeof(txt) == "undefined" || txt == "")
									txt = result.data[i];
								if(value == result.data[i]){
									$("#biz_Table_Name").append("<option selected='selected' value="+result.data[i]+">"+txt+"</option>");
								}else{
									$("#biz_Table_Name").append("<option value="+result.data[i]+">"+txt+"</option>");
								}
							}
						}else{
							parent.parent.bootbox.alert("数据表名称加载失败");
						}
					},
					error: function(){
						parent.parent.bootbox.alert("数据表名称加载失败");
					}
				});
			}
    </script>
	<script type="text/javascript">
		function allowDrop(ev) {
			ev.preventDefault();
		}

		function drag(ev) {
			ev.dataTransfer.setData("Text", ev.target.id);
		}

		function drop(ev) {
			ev.preventDefault();
			var data = ev.dataTransfer.getData("Text");
			//ev.target.appendChild(document.getElementById(data));
		}
	</script>
	<script src="jquery/jquery-1.10.2.js"></script>
	<%--<script src="D:\Maven\jquery.js"></script>--%>
<%--	<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>--%>
	<script>
		/*学习拖拽，主要就是学习拖拽事件*/
		var obj = null;//当前被拖拽的地元素

		/*应用于被拖拽元素的事件
          *ondrag         应用于拖拽元素，整个拖拽过程都会调用--持续
          ondragstart    应用于拖拽元素，当拖拽开始时调用
          ondragleave    应用于拖拽元素，当鼠标离开拖拽元素时调用
          ondragend    应用于拖拽元素，当拖拽结束时调用*/
		document.ondragstart = function (e) {
			/*通过事件捕获来获取当前被拖拽的子元素*/
            //用target属性来获取当前事件的节点
			e.target.style.opacity = 0.5; //拖拽开始时设置透明度为0.5
			e.target.parentNode.style.borderWidth = "1.5px";
			obj = e.target;
			/*通过dataTransfer来实现数据的存储与获取
            * setData(format,data):
            * format:数据的类型：text/html   text/uri-list
            * Data:数据:一般来说是字符串值*/
			e.dataTransfer.setData("text/html", e.target.id);
		}
		document.ondragend = function (e) {
			e.target.style.opacity = 1;
			e.target.parentNode.style.borderWidth = "1.5px";
		}
		document.ondragleave = function (e) {

		}
		document.ondrag = function (e) {
		}

		function deleteReportField(obj){
			var report_Field = {};
			report_Field.report_Field_Ids= [];
			report_Field.report_Field_Ids[0] = $(obj).parent().parent().attr("id");
			$.ajax({
				url: 'rest/bi/biReportFieldController/deleteReportField',
				async: false,
				data: report_Field,
				type: 'POST',
				dataType: 'json',
				success: function (result) {
					alert('删除成功！');
					$(obj).parent().parent().parent().remove();
					//追加到数据源
                    var tableId = 'table' + $(obj).parent().parent().attr("value");
                    var report_field_name = $(obj).parent().parent().parent().attr("id");
                    var report_field_title = $(obj).parent().parent().parent().children('button')[0].childNodes[0].nodeValue;
                    console.log(report_field_title);
                    var li = '<li><a title="default" value="recommand_status" id="'+report_field_name+'" draggable="true" ondragstart="drag(event)">'+report_field_title+'</a><b class="arrow"></b></li>';
                    $('#'+tableId).append(li);
                    console.log('tableId:'+tableId+'report_field_name'+report_field_name);
                    console.log(li);
                    var _iframe1 = document.getElementById('mainContent');
                    _iframe1.contentWindow.location.reload(true);
                    $('#');
				},
				error: function(){
					parent.parent.bootbox.alert("全部删除失败", function(){});
				}
			});
		}
		// 字段的编辑方法
		function biReportFieldEdit(obj,e){
            var report_Field_Id = $(obj).parent().parent().attr("id");
            var report_id = $(obj).parent().parent().attr("value");
            clearInputValue();//清空输入框的数据
            // getBiDimName();//获取维表名称
            getDBField(-1, report_id, report_Field_Id);
            getReportData2(report_Field_Id, report_id, e); //点击编辑时根据主键获取到数据进行填充文本框
        }
        //清空字段编辑中输入框的数据
        function clearInputValue() {
            $("#field_Location").val(0);
            $("#dim_Order").val(1);
            $("#display").val(0);
            $("#field_Name").val(0);//字段名称
            $("#field_Caption").val("");//字段别名
            $("#field_Title").val("");//字段标题
            $("#data_Type").val(0);//数据类型（数据库类型）
            $("#field_Type").val(0);//字段类型（业务类型）
            $("#aggregate_Type").val(0);//聚合类型
            $("#unit").val("");//单位
            // $("#dim_Id").val(0);//维表ID
        }
        // 字段编辑信息输入
        function msgDialog2(e, field_Id, report_id){
            // e.preventDefault();
            var dialog = $( "#fromEdit2" ).removeClass('hide').dialog({
                modal: true,
                width:680,
                title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>报表字段设置</h4></div>",
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
                            var par = {};
                            par.report_Field_Id = field_Id;
                            par.field_Location = $("#field_Location").val();
                            par.dim_Order = $("#dim_Order").val();
                            par.display = $("#display").val();
                            par.report_Id = report_id;
                            //新加
                            par.field_Name = $("#field_Name").val();//字段名称
                            par.field_Caption = $("#field_Caption").val();//字段别名
                            par.field_Title = $("#field_Title").val();//字段标题
                            par.data_Type = $("#data_Type").val();//数据类型（数据库类型）
                            par.field_Type = $("#field_Type").val();//字段类型（业务类型）
                            par.aggregate_Type = $("#aggregate_Type").val()==0?"":$("#aggregate_Type").val();//聚合类型
                            par.unit = $("#unit").val();//单位
                            par.dim_Id = $("#dimId").val();//维表ID
                            editReportData2(par);
                        }
                    }
                ]
            });
        }
        //点击编辑（字段编辑）
        function editReportData2(par){
            //ajax请求数据
            $.ajax({
                type: "POST",
                url: "rest/bi/biReportFieldController/updateReportField",
                cache: false,  //禁用缓存
                data: par,  //传入组装的参数
                dataType: "json",
                success: function (result) {
                    if(result.data == "success"){
                        parent.parent.bootbox.alert("更新成功", function(){});
                        //loadGrid();
                        $( "#fromEdit2" ).dialog( "close" );
                    }else{
                        parent.parent.bootbox.alert("更新失败", function(){});
                    }
                },
                error: function(){
                    parent.parent.bootbox.alert("更新失败", function(){});
                }
            });
        }
        //点击字段的编辑时根据主键获取到数据进行填充文本框
        function getReportData2(report_Field_Id, report_id,e){
            var par = {};
            par.report_Field_Id = report_Field_Id;
            par.report_Id = report_id;
		    //ajax请求数据
            $.ajax({
                type: "POST",
                url: "rest/bi/biReportFieldController/getReportField",
                async: false,
                cache: false,  //禁用缓存
                data: par,  //传入组装的参数
                dataType: "json",
                success: function (result) {
                    $("#field_Location").val(result.data.field_Location);
                    $("#dim_Order").val(result.data.dim_Order);
                    $("#display").val(result.data.display);
                    $("#field_Name").val(result.data.field_Name);//字段名称
                    // $("#field_Name").html("<option value='"+ fn +"'>"+ fn +"</option>");
                    $("#field_Caption").val(result.data.field_Caption);//字段别名
                    $("#field_Title").val(result.data.field_Title);//字段标题
                    $("#data_Type").val(result.data.data_Type);//数据类型（数据库类型）
                    $("#field_Type").val(result.data.field_Type);//字段类型（业务类型）
                    $("#aggregate_Type").val(result.data.aggregate_Type==0?"":result.data.aggregate_Type);//聚合类型
                    $("#unit").val(result.data.unit);//单位

                    if(result.data.field_Type == 1){//1：关联唯独表
                        $(".dim_Id").css("display", "block");
                        $(".aggregate_Type").css("display", "none");
                        getBiDimName(result.data.dim_Id);
                    }else if(result.data.field_Type == 2){//2：普通字段
                        $(".dim_Id").css("display", "none");
                        $(".aggregate_Type").css("display", "none");
                    }else if(result.data.field_Type == 3){//3：聚合字段
                        $(".dim_Id").css("display", "none");
                        $(".aggregate_Type").css("display", "block");
                        $("#aggregate_Type").val(result.data.aggregate_Type);
                    }

                    if($("#field_Location").val() == 3){
                        $("#dim").css("display", "none");
                    }else{
                        $("#dim").css("display", "block");
                    }
                    msgDialog2(e, report_Field_Id, report_id);
                }, error: function(){
                    parent.parent.bootbox.alert("编辑获取数据失败", function(){});
                }
            });
        }
        //获取维表名称
        function getBiDimName(value){
            //ajax请求数据
            $.ajax({
                type: "POST",
                url: "rest/bi/biReportFieldController/getBiDimName",
                cache: false,  //禁用缓存
                dataType: "json",
                success: function (result) {
                    $("#dimId").html()
                    $("#dimId").html("<option value='0'>请选择</option>");
                    for(var i=0; i<result.data.length; i++){
                        $("#dimId").append("<option value='"+result.data[i].dim_Id+"'>"+result.data[i].dim_Name+"</option>");
                    }
                    value==null?"":$("#dimId").val(value);

                },
                error: function(){
                    parent.bootbox.alert("获取失败", function(){});
                }
            });
        }
        //加载数据库的表名字
        var json = {};   //设置保存字段名称和字段描述的全局变量中
        function getDBField(value, report_id, report_Field_Id){
            json = {};
            //根据选中的数据表名称加载数据字段
            var parm = {};
            // parm.rows = 10;//页面显示记录条数，在页面显示每页显示多少项的时候
            // parm.start = 0;//开始的记录序号
            // parm.page = 1;//当前页码
            parm.report_Id = report_id;
            $.ajax({
                type: "POST",
                url: "rest/bi/biReportController/getReportInfo",
                cache: false, //禁用缓存
                data: parm,
                dataType: "json",
                success: function(reslut){
                    var fn = reslut.data.biz_Table_Name;
                    $.ajax({
                        type: "POST",
                        url: "rest/bi/BIDimController/getTableData",
                        cache: false, //禁用缓存
                        data: "tableName="+fn,
                        dataType: "json",
                        success: function (result) {
                            json = result;

                            var par2 = {};
                            par2.report_Field_Id = report_Field_Id;
                            par2.report_Id = report_id;
                            //ajax请求数据
                            $.ajax({
                                type: "POST",
                                url: "rest/bi/biReportFieldController/getReportField",
                                async: false,
                                cache: false,  //禁用缓存
                                data: par2,  //传入组装的参数
                                dataType: "json",
                                success: function (result) {
                                    var field_Name =result.data.field_Name;//字段名称
                                    $("#field_Name").html("<option value='"+ field_Name +"'>"+ field_Name +"</option>");
                                    for(var i=0; i<result.data.length; i++){
                                        var txtt = langData.dimManage[fn];
                                        var txt = "";
                                        if(typeof(txtt) == "undefined" || txtt == "")
                                            txt = result.data[i].dim_Field_Name;
                                        else{
                                            txt = txtt[result.data[i].dim_Field_Name];
                                            if(typeof(txt) == "undefined" || txt == "")
                                                txt = result.data[i].dim_Field_Name;
                                        }
                                        if(value == result.data[i].dim_Field_Name){
                                            $("#field_Name").append("<option selected='selected' value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
                                        }else{
                                            $("#field_Name").append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
                                        }
                                    }
                                }, error: function(){
                                    parent.parent.bootbox.alert("编辑获取数据失败", function(){});
                                }
                            });
                        },
                        error: function(){
                            parent.bootbox.alert("字段获取数据失败", function(){});
                        }
                    });
                },
                error: function(){
                    parent.bootbox.alert("信息获取数据失败", function(){});
                }
            });

        }

        //数据类型
        function getDataType(){
            $.ajax({
                type: "POST",
                url: "rest/bi/biReportFieldController/getDataType",
                cache: false,  //禁用缓存
                dataType: "json",
                success: function (result) {
                    $("#data_Type").empty();
                    $("#data_Type").append("<option value='0'>请选择</option>");
                    for(var i=0; i<result.data.length; i++){
                        $("#data_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
                    }
                    // $("#data_Type").val(5);
                },
                error: function(){
                    parent.bootbox.alert("字段获取数据失败", function(){});
                }
            });
        }
        //字段类型
        function getFieldType(){
            $.ajax({
                type: "POST",
                url: "rest/bi/biReportFieldController/getFieldType",
                cache: false,  //禁用缓存
                dataType: "json",
                success: function (result) {
                    $("#field_Type").empty();
                    $("#field_Type").append("<option value='0'>请选择</option>");
                    for(var i=0; i<result.data.length; i++){
                        $("#field_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
                    }
                    // $("#field_Type").val(2);
                },
                error: function(){
                    parent.bootbox.alert("字段获取数据失败", function(){});
                }
            });
        }


		/*应用于目标元素的事件
        *ondragenter    应用于目标元素，当拖拽元素进入时调用
          ondragover    应用于目标元素，当停留在目标元素上时调用
          ondrop        应用于目标元素，当在目标元素上松开鼠标时调用
          ondragleave    应用于目标元素，当鼠标离开目标元素时调用*/
		document.ondragenter = function (e) {
			// console.log(e.target);
		}
		document.ondragover = function (e) {
			/*如果想触发ondrop事件，那么就必须在这个位置阻止浏览器的默认行为*/
			e.preventDefault();
		}
		/*浏览器默认会阻止ondrop事件：我们必须在ondragover中阻止浏览器的默认行为*/
		document.ondrop = function (e) {
			/*添加元素*/
			//e.target.appendChild(obj);
			/*通过e.dataTransfer.setData存储的数据，只能在drop事件中获取*/
			var id = e.dataTransfer.getData("text/html");
			var dom = document.getElementById(id);
			var DOMName = dom.tagName;
            var dom_html = '';
			if(DOMName == 'DIV'){//各个指标互相拖拽
                var ulDom = $(dom).children('ul')[0];
                var par = {};
                par.report_Field_Id = ulDom.id;
                par.report_Id = ulDom.attributes.value.value;
                //ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biReportFieldController/getReportField",
                    async: false,
                    cache: false,  //禁用缓存
                    data: par,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                        var parm = {};
                        var location =  $(e.target).attr('id');
                        if(location == 'column'){
                            par.field_Location = 2;
                        }else if (location == 'row'){
                            par.field_Location = 1;
                        }else if (location == 'value'){
                            par.field_Location = 3;
                        }else {
                            return false;
                        }

                        par.dim_Order = result.data.dim_Order;
                        par.display = result.data.display;
                        par.report_Id = par.report_Id;
                        //新加
                        par.field_Name = result.data.field_Name;//字段名称
                        par.field_Caption = result.data.field_Caption;//字段别名
                        par.field_Title = result.data.field_Title;//字段标题
                        par.data_Type = result.data.data_Type;//数据类型（数据库类型）
                        par.field_Type = result.data.field_Type;//字段类型（业务类型）
                        par.aggregate_Type = result.data.aggregate_Type==0?"":result.data.aggregate_Type;//聚合类型
                        par.unit = result.data.unit;//单位
                        par.dim_Id = result.data.dim_Id;//维表ID
                        dom_html = ' <div class="btn-group" draggable="true" id=' + (id) + ' title="afterStyle">\n' +
                            '          <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle" aria-expanded="false">\n' +
                            '            ' + (result.data.field_Title==null || result.data.field_Title=="" ? result.data.field_Name:result.data.field_Title) + '\n' +
                            '            <span class="ace-icon fa fa-caret-down icon-on-right"></span>\n' +
                            '          </button>\n' +
                            '          <ul class="dropdown-menu dropdown-warning"  id="' + id + '" value="' + value + '">\n' +
                            '            <li>\n' +
                            '              <a href="javascript:void(0);" onclick="biReportFieldEdit(this)">编辑</a>\n' +
                            '            </li>\n' +
                            '            <li>\n' +
                            '              <a href="javascript:void(0);" onclick="deleteReportField(this)">移除</a>\n' +
                            '            </li>\n' +
                            '          </ul>\n' +
                            '        </div>';
                        editReportData2(par);

                    }, error: function(){
                        parent.parent.bootbox.alert("编辑获取数据失败", function(){});
                    }
                });

                $.each($('.mubiao'), function(index, value){
                    //获取容器的坐标范围 (区域)
                    var box_x = $(value).offset().left;     //容器左上角x坐标
                    var box_y = $(value).offset().top;      //容器左上角y坐标
                    var box_width = $(value).outerWidth();  //容器宽
                    var box_height = $(value).outerHeight();//容器高

                    //判断放开鼠标位置是否想允许放置的容器范围内
                    if(e.pageX > box_x && e.pageX < box_x-0+box_width && e.pageY > box_y && e.pageY < box_y-0+box_height) {
                        /*if($(value).offset().left !== document.getElementById("table-select").offsetLeft
                                || $(value).offset().top !== document.getElementById("table-select").offsetTop) {*/
                        //@吴登亮增加了title属性值的判断
                        if(document.getElementById(id).title=="afterStyle"){
                            e.target.appendChild(document.getElementById(id));
                        }
                        else{
                            document.getElementById(id).innerHTML=dom_html;
                            document.getElementById(id).title="afterStyle";
                            e.target.appendChild(document.getElementById(id));
                        }

                        /*}*/
                    }
                });
            }
			else if (DOMName =='A'){//从数据源拖拽到指标
                var value = $(dom).parent().parent().attr('value');
                // console.log(value);
                //@吴登亮增加了title值的判断

                var report={};
                report.report_Id = $('#'+id).parent().parent().attr('value');
                report.field_Name = $('#'+id).attr('value');
                var location =  $(event.target).attr('id');
                if(location == 'column'){
                    field_Location = 2;
                }else if (location == 'row'){
                    field_Location = 1;
                }else if (location == 'value'){
                    field_Location = 3;
                }else {
                    return false;
                }
                report.field_Location = field_Location;
                report.field_Caption = $('#'+id).attr('value');
                report.field_Title = dom.innerText;
                report.dim_Order = 1;
                report.field_Type = 1;
                report.aggregate_Type = '';
                report.display= 1;
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biReportFieldController/saveReportField",
                    cache: false, //禁用缓存
                    data: report,
                    dataType: "json",
                    success: function(result){
                        var parm = {};
                        parm.report_Id = report.report_Id;
                        parm.rows = 10//页面显示记录条数，在页面显示每页显示多少项的时候
                        parm.start = 1;//开始的记录序号
                        parm.page = 1;//当前页码
                        $.ajax({
                            type: "POST",
                            url: "rest/bi/biReportFieldController/getReportFieldList",
                            cache: false,  //禁用缓存
                            data: parm,  //传入组装的参数
                            dataType: "json",
                            success: function (rsData) {
                                console.log(parm);
                                if(document.getElementById(id).title!="afterStyle") {
                                    //@吴登亮添加了id和title属性
                                    dom_html = ' <div class="btn-group" draggable="true" id=' + (id) + ' title="afterStyle">\n' +
                                        '          <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle" aria-expanded="false">\n' +
                                        '            ' + (dom.innerText) + '\n' +
                                        '            <span class="ace-icon fa fa-caret-down icon-on-right"></span>\n' +
                                        '          </button>\n' +
                                        '          <ul class="dropdown-menu dropdown-warning"  id="' + rsData.data[0].report_Field_Id + '" value="' + value + '">\n' +
                                        '            <li>\n' +
                                        '              <a href="javascript:void(0);" onclick="biReportFieldEdit(this)">编辑</a>\n' +
                                        '            </li>\n' +
                                        '            <li>\n' +
                                        '              <a href="javascript:void(0);" onclick="deleteReportField(this)">移除</a>\n' +
                                        '            </li>\n' +
                                        '          </ul>\n' +
                                        '        </div>';

                                    //document.getElementById(id).innerHTML=dom_html;
                                    //@吴登亮
                                    $.each($('.mubiao'), function(index, value){
                                        //获取容器的坐标范围 (区域)
                                        var box_x = $(value).offset().left;     //容器左上角x坐标
                                        var box_y = $(value).offset().top;      //容器左上角y坐标
                                        var box_width = $(value).outerWidth();  //容器宽
                                        var box_height = $(value).outerHeight();//容器高

                                        //判断放开鼠标位置是否想允许放置的容器范围内
                                        if(e.pageX > box_x && e.pageX < box_x-0+box_width && e.pageY > box_y && e.pageY < box_y-0+box_height) {
                                            /*if($(value).offset().left !== document.getElementById("table-select").offsetLeft
                                                    || $(value).offset().top !== document.getElementById("table-select").offsetTop) {*/
                                            //@吴登亮增加了title属性值的判断
                                            if(document.getElementById(id).title=="afterStyle"){
                                                e.target.appendChild(document.getElementById(id));
                                            }
                                            else{
                                                document.getElementById(id).innerHTML=dom_html;
                                                document.getElementById(id).title="afterStyle";
                                                e.target.appendChild(document.getElementById(id));
                                            }

                                            /*}*/
                                        }
                                    });
                                    //结束
                                    // console.log(document.getElementById(id));
                                }


                            }
                        });

                        var _iframe1 = document.getElementById('mainContent');
                        _iframe1.contentWindow.location.reload(true);
                    },
                    error: function(){
                    }
                });
            }


			// e.target.appendChild(document.getElementById(id));

			// e.target.appendChild(dom_html);

		}
		document.ondragleave = function (e) {
		}



		/*应用于被拖拽元素的事件
            *ondrag         应用于拖拽元素，整个拖拽过程都会调用--持续
            ondragstart    应用于拖拽元素，当拖拽开始时调用
            ondragleave    应用于拖拽元素，当鼠标离开拖拽元素时调用
            ondragend    应用于拖拽元素，当拖拽结束时调用*/
		function ondragstart (e) {
			/*通过事件捕获来获取当前被拖拽的子元素*/
			e.target.style.opacity = 0.5;
			e.target.parentNode.style.borderWidth = "1.5px";
			obj = e.target;
			/*通过dataTransfer来实现数据的存储与获取
            * setData(format,data):
            * format:数据的类型：text/html   text/uri-list
            * Data:数据:一般来说是字符串值*/
			e.dataTransfer.setData("text/html", e.target.id);
		}

		function ondragend (e) {
			e.target.style.opacity = 1;
			e.target.parentNode.style.borderWidth = "1.5px";

        }

		function ondragleave(e) {
            var location2 =  $(event.target).attr('id');
            console.log('+++++' + location2);
		}

		function ondrag(e) {

        }

		/*应用于目标元素的事件
        *ondragenter    应用于目标元素，当拖拽元素进入时调用
          ondragover    应用于目标元素，当停留在目标元素上时调用
          ondrop        应用于目标元素，当在目标元素上松开鼠标时调用
          ondragleave    应用于目标元素，当鼠标离开目标元素时调用*/
		function ondragenter(e) {
			// console.log(e.target);
		}

		function ondragover(e) {
			/*如果想触发ondrop事件，那么就必须在这个位置阻止浏览器的默认行为*/
			e.preventDefault();
		}

		/*浏览器默认会阻止ondrop事件：我们必须在ondragover中阻止浏览器的默认行为*/
		function ondrop (e) {
			/*添加元素*/
			//e.target.appendChild(obj);
			/*通过e.dataTransfer.setData存储的数据，只能在drop事件中获取*/
			var id = e.dataTransfer.getData("text/html");
			/*console.log("id="+id);*/
            //@吴登亮
			$.each($('.mubiao'), function(index, value){

				//获取容器的坐标范围 (区域)
				var box_x = $(value).offset().left;     //容器左上角x坐标
				var box_y = $(value).offset().top;      //容器左上角y坐标
				var box_width = $(value).outerWidth();  //容器宽
				var box_height = $(value).outerHeight();//容器高

				//判断放开鼠标位置是否想允许放置的容器范围内
				if(e.pageX > box_x && e.pageX < box_x-0+box_width && e.pageY > box_y && e.pageY < box_y-0+box_height) {

					/*if($(value).offset().left !== drag.old_elm.parent().offset().left
							|| $(value).offset().top !== drag.old_elm.parent().offset().top) {*/
				/*	if($(value).offset().left !== document.getElementById("table-select").offsetLeft
							|| $(value).offset().top !== document.getElementById("table-select").offsetTop) {*/

						e.target.appendChild(document.getElementById(id));

				/*	}*/
				}});
            //结束
		}

		function ondragleave(e) {
		}

	</script>

	<!-- 菜单折叠与展开的js -->
	<script>
		var list = document.querySelectorAll('.list');

		function accordion(e) {
			e.stopPropagation();
			if (this.classList.contains('active')) {
				this.classList.remove('active');
			} else
			if (this.parentElement.parentElement.classList.contains('active')) {
				this.classList.add('active');
			} else {
				for (i = 0; i < list.length; i++) {
					list[i].classList.remove('active');
				}
				this.classList.add('active');
			}
		}
		for (i = 0; i < list.length; i++) {
			list[i].addEventListener('click', accordion);
		}
	</script>
  </body>
</html>
