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
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
			</div>
			<div class="col-md-7"></div>
		</div>
  	</div>
  	<div class="row col-md-2 table-data">
		<ul class=" nav nav-list" id="table-select">
		</ul>
	</div>




	<div class="data-search-show col-md-10">
		<div class="row data-line">
			<div class="col-md-2 text-right"><b>列：</b></div>
			<div class="col-md-10 data-title" ondrop="drop(event)" ondragover="allowDrop(event)" id="column">

			</div>
		</div>
		<div class="row data-line">
			<div class="col-md-2 text-right"><b>行：</b></div>
			<div class="col-md-10 data-title" ondrop="drop(event)" ondragover="allowDrop(event)" id="row">

			</div>
		</div>
		<div class="row data-line">
			<div class="col-md-2 text-right"><b>值：</b></div>
			<div class="col-md-10 data-title" ondrop="drop(event)" ondragover="allowDrop(event)" id="value"></div>
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

  	<!--  import javascript	-->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-treeview/1.2.0/bootstrap-treeview.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>
    <script>
        //增加右键功能
        $(function(){
            //注册右键菜单的项与动作
            $("#table-select").contextMenu({
                selector: '.context-menu-one', // 选择器，为某一类元素绑定右键菜单
                callback: function(key, options) {
                    if(key == 'delete'){
                        $(this).remove();
                    }
                },
                items: {
                    "delete": {name: "Delete", icon: "delete"},
                    "quit": {name: "Quit", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
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
    		});

    		//@段延玉，加载报表
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
						console.log(resulet);

						var table_column = $("#column");
						var table_row = $("#row");
						var table_value = $("#value");


						//拿到返回的map<key,val>  每一个key都是Report_Id:而Report_Id对应着
						var  biReportFieldMaps = resulet.biReportFieldMaps;

						for (var key in biReportFieldMaps) {

							var biReportFields = biReportFieldMaps[key];

							//加载已经添加的字段 行 列 值
							for (var i = 0; i < biReportFields.length; i++) {
								var dataname = "";
								// var d_val = (biReportFields[i].field_Title==null || biReportFields[i].field_Title==""?biReportFields[i].field_Name:biReportFields[i].field_Title);

								//构造Dom元素
								var dom_html = buildDomHtml(biReportFields[i].report_Field_Id,biReportFields[i].report_Id,biReportFields[i].field_Name,biReportFields[i].field_Title);

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


						//加载数据列表
						for (var i = 0; i < resulet.biReportLists.length; i++) {
							var reportId = resulet.biReportLists[i].report_Id;
							var myTree ='<li class="context-menu-one">'+'<a class="dropdown-toggle">'+'<span class="menu-text">'+resulet.biReportLists[i].report_Title+'</span>'+'</a>'+'<ul id=table'+reportId+' class="">'+'</ul>' + '</li>';
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
				var dom_html = '\t<div class="btn-group">\n' +
						'\t'+'<input class="hidden_report_Field_Id" hidden value="'+report_Field_Id+'">'+
						'\t'+'<input class="hidden_report_Id" hidden value="'+report_Id+'">'+
						'\t<button data-toggle="dropdown" class="btn btn-warning dropdown-toggle" aria-expanded="false">\n' +
						'\t\t'+(field_Title==null || field_Title==""?field_Name:field_Title)+'\n' +
						'\t\t<span class="ace-icon fa fa-caret-down icon-on-right"></span>\n' +
						'\t</button>\n' +
						'\t<ul class="dropdown-menu dropdown-warning">\n' +
						'\t<li>\n' +
						'\t\t<a href="#">聚合</a>\n' +
						'\t</li>\n' +
						'\t<li>\n' +
						'\t\t<a href="#">筛选</a>\n' +
						'\t</li>\n' +
						'\t<li>\n' +
						'\t\t<a href="#">排序</a>\n' +
						'\t</li>\n' +
						'\t<li class="divider"></li>\n' +
						'\t<li>\n' +
						'\t\t\t<a href="#">设置别名</a>\n' +
						'\t\t</li>\n' +
						'\t\t<li>\n' +
						'\t\t\t<a href="#">移除</a>\n' +
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
						console.log(result);
						var data = result.data;

						for (var i=0;i <  data.length;i++) {

							//过滤数据，如果map中为null，代表没添加到行列值中，否则相反
							if(mapMap[data[i].dim_Field_Name]==null){
								var c_val = (data[i].field_Desc==null || data[i].field_Desc=="" ? data[i].dim_Field_Name : data[i].field_Desc);

								var colums = '<li>'+'<a id='+result.data[i].dim_Field_Name+' draggable="true" ondragstart="drag(event)">'+c_val +'</a>'+'<b class="arrow">'+'</b>'+'</li>';
								$("#table"+reportId).append(colums);
							}
						}


					},
					error: function(){
						alert("字段添加失败");
					}
				});

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
							nodes: [{
								text: 'Child 1',
								href: '#child1',
								tags: ['2'],
							}]
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
							loadGrid();
							var myTree ='<li class="context-menu-one">'+'<a class="dropdown-toggle">'+'<span class="menu-text">'+par.report_Title+'</span>'+'</a>'+'<ul id='+par.biz_Table_Name+' class="">'+'</ul>' + '</li>';
							$("#table-select").append(myTree);

                            //获取表中的字段名
							$.ajax({
								type: "POST",
								url: "rest/bi/BIDimController/getTableData?tableName="+par.biz_Table_Name,
								cache: false, //禁用缓存
								data: "",
								dataType: "json",
								success: function (result) {
									for (var i=0; result.data.length;i++) {
										var colums = '<li>'+'<a id='+result.data[i].dim_Field_Name+' draggable="true" ondragstart="drag(event)">'+ result.data[i].dim_Field_Name+'</a>'+'<b class="arrow">'+'</b>'+'</li>';
										$("#"+par.biz_Table_Name).append(colums);
									}
								},
								error: function(){
									alert("字段添加失败");
								}
							});
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

			function deleteReportData(){

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
			ev.target.appendChild(document.getElementById(data));
		}
	</script>
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
			e.target.style.opacity = 0.5;
			e.target.parentNode.style.borderWidth = "5px";
			obj = e.target;
			/*通过dataTransfer来实现数据的存储与获取
            * setData(format,data):
            * format:数据的类型：text/html   text/uri-list
            * Data:数据:一般来说是字符串值*/
			e.dataTransfer.setData("text/html", e.target.id);
		}
		document.ondragend = function (e) {
			e.target.style.opacity = 1;
			e.target.parentNode.style.borderWidth = "1px";
		}
		document.ondragleave = function (e) {
		}
		document.ondrag = function (e) {
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
			/*console.log("id="+id);*/

			var dom = document.getElementById(id);

			var dom_html=' <div class="btn-group" draggable="true">\n' +
					'          <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle" aria-expanded="false">\n' +
					'            '+(dom.innerText)+'\n' +
					'            <span class="ace-icon fa fa-caret-down icon-on-right"></span>\n' +
					'          </button>\n' +
					'          <ul class="dropdown-menu dropdown-warning">\n' +
					'            <li>\n' +
					'              <a href="#">聚合</a>\n' +
					'            </li>\n' +
					'            <li>\n' +
					'              <a href="#">筛选</a>\n' +
					'            </li>\n' +
					'            <li>\n' +
					'              <a href="#">排序</a>\n' +
					'            </li>\n' +
					'            <li class="divider"></li>\n' +
					'            <li>\n' +
					'              <a href="#">设置别名</a>\n' +
					'            </li>\n' +
					'            <li>\n' +
					'              <a href="#">移除</a>\n' +
					'            </li>\n' +
					'          </ul>\n' +
					'        </div>';

			// console.log(document.getElementById(id));
			// console.log(e);
			document.getElementById(id).innerHTML=dom_html;

			e.target.appendChild(document.getElementById(id));
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
			e.target.parentNode.style.borderWidth = "5px";
			obj = e.target;
			/*通过dataTransfer来实现数据的存储与获取
            * setData(format,data):
            * format:数据的类型：text/html   text/uri-list
            * Data:数据:一般来说是字符串值*/
			e.dataTransfer.setData("text/html", e.target.id);
		}

		function ondragend (e) {
			e.target.style.opacity = 1;
			e.target.parentNode.style.borderWidth = "1px";
		}

		function ondragleave(e) {
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
			e.target.appendChild(document.getElementById(id));
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
