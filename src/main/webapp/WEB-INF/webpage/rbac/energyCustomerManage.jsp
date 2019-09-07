<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en"  style="height:100%;">
<head>
	<base href=" <%=basePath%>">
    <meta charset="UTF-8">
    <title>客户信息展示管理</title>
    <!--	引入外部样式库css	-->
    <jsp:include page="../include/mainHead.jsp"></jsp:include>
    <style type="text/css">
    	.amap-marker-label{
		    border:1px solid red;
		    background-color:#fff;  
		    border-radius:5px; 
		    color:#222;			
		}
		
		.mapBtn {
			z-index: 10;
			float: right;
			position: absolute;
			right: 15px;
			top: 10px;
			height: 30px;
			width: 30px;
			line-height: 30px;
			text-align: center;
			border-radius: 50%;
			background: #5C95D5;
			color:#fff;
			font-size: 16px;
			cursor: pointer;
			margin: 0;
		    padding: 0;
		    border: 0;
		    box-shadow: -1px 1px 5px rgba(0, 0, 0, .5);
		    outline-style: none;
		}
		
		#btnSearchIcon{
			right: 50px;
		}
    </style>
</head>
<body oncontextmenu=self.event.returnValue=false style="height:100%;">
	<div id="mapBox" style="width:100%; float:left; border:1px solid #e1e1e1;height:100%;">
		 <div class="listS" style="position: relative;height:100%;">
			<div style="width: 60px; height: 200px; float: left; position: absolute; z-index: 10; left: 8px; top:6px" id="reName"></div>
			<button id="btnSearchIcon" class="icon iconfont icon-sousuo mapBtn"></button>
			<button id="btnAddIcon" class="icon iconfont icon-fangda mapBtn "></button>
			<div style="width: 100%; height:100%;" id="map"> </div>
		</div>
	</div>
	
	<!-- 添加及展示客户信息弹出框 -->
	<div class="hide" align="left" id="energyCustomerClueEdit" style="margin-top:15px;">
			<div class="col-sm-12 col-xs-12 col-lg-12 widget-body"align="left">
			<div class="row center center-block">
				<div class="container"align="left">
					<div class="row clearfix"align="left">
						<div class="col-md-20 column" align="left">
							<div class="form-horizontal" role="form">
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >公司名称：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="customerNameEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b" >
									<div class=" program-b-b"></div>
									<div>
										<div class="col-md-2 col-xs-2"></div>
										<div class="col-md-5 col-xs-5">
											<label class="col-xs-4 col-md-3 control-label">所在地区：</label>
											<div class="input-group col-xs-5 col-md-7">
												<select class="form-control" id="provinceEdit" type="text"></select>
											</div>
											<label class="col-xs-1 col-md-1 control-label">省</label>
										</div>
										<div class="col-md-4 col-xs-4 col-lg-4">
											<div class="col-xs-5 col-md-7">
												<select type="text" id="cityEdit" class="form-control" style=" height:34px"></select>
											</div>
											<div class="col-xs-5 col-md-7">
												<select type="text" id="cityEditShow" class="form-control" style=" height:34px"></select>
											</div>
											<label class="col-xs-1 col-md-1 control-label">市</label>
										</div>
									</div>
								</div>
								<div class="form-group program-b" id = "getCoordinateEdit">
									<div class=" program-b-b"></div>
									<div>
										<div class="col-md-2 col-xs-2"></div>
										<div class="col-md-5 col-xs-5">
											<label class="col-xs-4 col-md-3 control-label">纬度：</label>
											<div class="input-group col-xs-5 col-md-7">
												<input class="form-control" id="latitudeEdit" type="text">
											</div> 
										</div>
										<div class="col-md-4 col-xs-4 col-lg-4">
											<label class="col-xs-4 col-md-3 control-label">经度：</label>
											<div class="col-xs-5 col-md-7">
												<input type="text" id="longitudeEdit" class="form-control" style=" height:34px">
											</div>
											<button class="btn btn-primary btn-sm" id="getCoordinate" onclick="openWin()">获取坐标</button>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >公司地址：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="customerAddressEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >联系人：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="linkmanNameEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >联系电话：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="linkmanPhoneEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >电压等级：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="voltageClassEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >年用电量(兆瓦时)：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="yearQuantityEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >项目概况：</label>
										<div class="input-group col-xs-5 col-md-7">
											<textarea class="form-control" id="projectSituationEdit" type="text" ></textarea>
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >登记人：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="regUserNameEdit"/>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >登记时间：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="regDateEdit" type="text" readonly="readonly" />
										</div>
									</div>
								</div>
								
							</div>
							<div class="col-md-11 col-xs-11" align="right" style="margin-top: 10px;margin-right: 10px;margin-bottom: 5px" id="buttonDiv">
								<button class="btn btn-primary btn-sm" id="btnSave">保存</button>
							</div>
						</div>
					</div> 
				</div>
			</div>
		</div>
	</div>
	<!-- 添加及展示客户信息弹出框 -->	
	<!--查询客户信息弹窗开始-->
	<div id="formSeach" class="hide">
    	<div class="container">
             <strong>客户名称：</strong>
             <select id="customerNameQuery" class="form-group text-info" style="width:162px;">
             	<option value="">&nbsp;</option> 
             </select>	<br>
             <strong>时间：</strong>
             <input class="form-control date-picker" id="startTimeQuery" type="text" data-date-format="dd-mm-yyyy" style="width:162px;"/><br>
             <strong>至</strong>
             <input class="form-control date-picker" id="endTimeQuery" type="text" data-date-format="dd-mm-yyyy" style="width:162px;"/><br>
             <strong class="spans">销售人员：</strong>
             <input id="regUserNameQuery" class="form-group text-info inputs" type="text" style="width:160px; margin-left:2px;"/><br>
             <strong>签约状态：</strong>
             <select id="StationStat" class="form-group text-info" style="width:162px;">
             	<option value="0">&nbsp;</option>
             	<option value="1">已签约</option>
             	<option value="2">未签约</option> 
             </select>	<br>
             <input type="button" id="btnSearch" class="btn btn-samll btn-primary" style="float: right;" value="搜索">
		</div> 
	</div> 
	<!--查询客户信息弹窗结束-->
    
	<!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>   
    <script src="http://webapi.amap.com/maps?v=1.4.0&key=0bf3e08ca06f8aeb94e40daec867011d"></script>
    <!-- UI组件库 1.0 -->
	<script src="http://webapi.amap.com/ui/1.0/main.js?v=1.0.10 "></script>
	
    <script type="text/javascript">
	 	var param = {};
    	var mapParam = {};
    	var paradd={};
    	$(document).ready(function(){
    		amap();
    		dateDom();
    		getSelectInfo();
    		getCityShow();
    		$("#regUserNameEdit").val("${usersession.realName}");
    		$("#regDateEdit").val(FormatDate(new Date()));
    	});
    	
     	//弹出框  头部样式
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title;
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
		function FormatDate(strTime){
    		var date = new Date(strTime);
    		return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    	}
  	  	//日期控件js
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
    	//地图上的搜索按钮
    	$("#btnSearchIcon").click(function(e){
			msgDialog(e, "客户搜索", "#formSeach", 300);
		});
    	//地图上的添加按钮
		$("#btnAddIcon").click(function(e){
    		$("#btnSave").show();
			$("#getCoordinateEdit").show();
			$("#cityEdit").show();
			$("#cityEditShow").hide();
			$("#customerNameEdit").val("");
    		$("#provinceEdit").val("");
    		$("#cityEdit").val("");
    		$("#customerAddressEdit").val("");
    		$("#linkmanNameEdit").val("");
    		$("#linkmanPhoneEdit").val("");
    		$("#voltageClassEdit").val("");
    		$("#yearQuantityEdit").val("");
    		$("#projectSituationEdit").val("");
    		$("#regUserNameEdit").val("");
    		//$("#regDateEdit").val("");
    		msgDialog(e, "添加客户信息", "#energyCustomerClueEdit", 1000);
    	});
		
		 //搜索按钮 
  	   $("#btnSearch").on("click", function(e){
		 amap(0, 284);
		 $("#customerNameQuery").val("");;
		 $('#startTimeQuery').val("");
		 $('#endTimeQuery').val("");
		 $('#regUserNameQuery').val("");
		 $('#StationStat').val("");
	   });
		//保存
	   $("#btnSave").on("click",function(e){
    		paradd.customer_Name = $("#customerNameEdit").val();
    		paradd.region_Code = $("#cityEdit").val(); 
    		paradd.latitude = $("#latitudeEdit").val();
    		paradd.longitude = $("#longitudeEdit").val();
    		paradd.address = $("#customerAddressEdit").val();
    		paradd.legal_Person = $("#linkmanNameEdit").val();
    		paradd.phone = $("#linkmanPhoneEdit").val();
    		paradd.voltage_Class = $("#voltageClassEdit").val();
    		paradd.year_Quantity = $("#yearQuantityEdit").val();
    		paradd.project_Situation = $("#projectSituationEdit").val();
    		paradd.reg_User_Name= $("#regUserNameEdit").val();
    		paradd.reg_Date = new Date($("#regDateEdit").val());
    		addCustomerInfo(paradd);
	   });
       //弹出框
       function msgDialog(e, title, formid, kuan){
			//e.preventDefault();
			var dialog = $(formid).removeClass('hide').dialog({
				modal: true,
				width: kuan,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-cog'></i>"+title+"</h4></div>",
				title_html: true
			});
			fl = 1;
		}
    	//高德地图初始化
	    function amap(){
    		let mapParam = {};
    		if($("#customerNameQuery").val()!=null && $("#customerNameQuery").val()!=""&& $("#customerNameQuery").val()!=0){
    			mapParam.customer_Id = $("#customerNameQuery").val();
    		}else{
    			delete mapParam.customer_Id;
    		}
			if( $("#startTimeQuery").val()!=null &&  $("#startTimeQuery").val()!=""&&  $("#startTimeQuery").val()!=0){
				mapParam.startDate = $("#startTimeQuery").val();
    		}else{
    			delete mapParam.startDate;
    		}
			if($("#endTimeQuery").val()!=null && $("#endTimeQuery").val()!=""&& $("#endTimeQuery").val()!=0){
				mapParam.endDate = $("#endTimeQuery").val();
			}else{
				delete mapParam.endDate;
			}
			if($("#regUserNameQuery").val()!=null && $("#regUserNameQuery").val()!=""&&$("#regUserNameQuery").val()!=0){
				mapParam.reg_User_Name = $("#regUserNameQuery").val();
			}else{
				delete mapParam.reg_User_Name;
			}
			if($("#StationStat").val()!=null && $("#StationStat").val()!=""&& $("#StationStat").val()!=0){
				mapParam.check_State = $("#StationStat").val();
			}else{
				delete mapParam.check_State;
			}
	   		map = new AMap.Map('map', {   //创建地图
				resizeEnable: true,
				zoom: 2,
				center: [117.066594, 36.681224],
				mapStyle: 'amap://styles/a2ddad7c929de166bb8d54749e6d2c19'
			});
			$.ajax({
				type: "post",
				async : true, //同步执行  
				url: "rest/rbac/energyCustomerManageController/getMapData",
				data: mapParam,
				dataType: "json", //返回数据形式为json  
				success: function(result) {
					var p,ms=[];
					if(result) {
						markers = result.mapdata;
						for(var index = 0; index < markers.length; index++) {
							var marker, icon;
							if(markers[index].check_State == 1) { // 1代表正常
								icon = "plug-in/ace/main/img/map/mmg1.png";
							} else if(markers[index].check_State == 2) { //2代表通讯关闭
								icon = "plug-in/ace/main/img/map/mmp1.png";
							} else if(markers[index].check_State == 3) { //3代表外网告警
								icon = "plug-in/ace/main/img/map/mmy1.png";
							} else if(markers[index].check_State == 4) { //3代表电站告警
								icon = "plug-in/ace/main/img/map/mmr1.png";
							} else if(markers[index].check_State == 5) { //运维提示
								icon = "plug-in/ace/main/img/map/mmb1.png";
							}
							marker = new AMap.Marker({
								position: [markers[index].longitude, markers[index].latitude],
								map: map
							});
							marker.setLabel({
								offset: new AMap.Pixel(-20, 26),
								content: markers[index].customer_Name
							});
							marker.setIcon(icon);
							marker.customerId = markers[index].customer_Id;
							marker.customerName = markers[index].customer_Name;
							//给Marker绑定单击事件
							marker.on('click', function(e) {
								$("#btnSave").hide();
								$("#getCoordinateEdit").hide();
								$("#cityEdit").hide();
								$("#cityEditShow").show();								
								getCustomerModelInfo(e,e.target.customerId, e.target.customerName);
							});
							ms.push(marker);
						}
					}
					map.setFitView(ms); //地图自适应
					
				}
			});
			//addArea('province', '山东省');
	    }

	     //绘制行政区域边界线
		 function addArea(areaLevel, name) {
			//加载行政区划插件
			AMap.service('AMap.DistrictSearch', function() {
				var opts = {
					subdistrict: 1, //返回下一级行政区
					extensions: 'all' //返回行政区边界坐标组等具体信息
				};
				//实例化DistrictSearch
				district = new AMap.DistrictSearch(opts);
				district.setLevel(areaLevel);
				//行政区查询
				district.search(name, function(status, result) {
					var bounds = result.districtList[0].boundaries;
					var polygons = [];
					if(bounds) {
						for(var i = 0, l = bounds.length; i < l; i++) {
							//生成行政区划polygon
							var polygon = new AMap.Polygon({
								map: map,
								strokeWeight: 2,
								path: bounds[i],
								fillOpacity: 0,
								fillColor: '#CCF3FF',
								strokeColor: '#F00'
							});
							polygons.push(polygon);
						}
					}
				});
			});
		 }
	    function getCustomerModelInfo(e, customerId, customerName){
	    	 param.customer_Id = customerId;
	    	 param.customer_Name = customerName;
    		$.ajax({
        		 type: "POST",
                 url: 'rest/rbac/energyCustomerManageController/getAllCustomer', 
                 data: param,
                 secureuri: false, //是否需要安全协议，一般设置为false
                 async:false,
                 dataType: 'json', //返回值类型 一般设置为json
                 success: function (result){  //服务器成功响应处理函数
                   if(result.success = "success"){
	            		$("#customerNameEdit").val(result.data[0].customer_Name);
	            		$("#provinceEdit").val(result.data[0].provinceString);
	            		$("#cityEditShow").val(result.data[0].region_Code);
	            		$("#customerAddressEdit").val(result.data[0].address);
	            		$("#linkmanNameEdit").val(result.data[0].legal_Person);
	            		$("#linkmanPhoneEdit").val(result.data[0].phone);
	            		$("#voltageClassEdit").val(result.data[0].voltage_Class);
	            		$("#yearQuantityEdit").val(result.data[0].year_Quantity);
	            		$("#projectSituationEdit").val(result.data[0].project_Situation);
	            		$("#regUserNameEdit").val(result.data[0].reg_User_Name);
	            		$("#regDateEdit").val(result.data[0].reg_Date);
	            		msgDialog(e, "客户信息", "#energyCustomerClueEdit", 1000);
	            	}else{
	            		parent.bootbox.alert("获取客户信息失败" ,function(){});
	            	}
                 },
                 error: function (){//服务器响应失败处理函数
                	 parent.bootbox.alert("获取客户信息失败", function(){});
                 }
           	});
	     }
	    function addCustomerInfo(paradd){
	    	$.ajax({
       		 type: "POST",
                url: 'rest/rbac/energyCustomerManageController/addCustomerInfo', 
                data: paradd,
                secureuri: false, //是否需要安全协议，一般设置为false
                async:false,
                dataType: 'json', //返回值类型 一般设置为json
                success: function (result){  //服务器成功响应处理函数
                  if(result.success = "success"){
                	  amap();
	            	}else{
	            		parent.bootbox.alert("添加客户信息失败" ,function(){});
	            	}
                },
                error: function (){//服务器响应失败处理函数
               	 parent.bootbox.alert("添加客户信息失败", function(){});
                }
          	});
	    }
	</script>
	<script type="text/javascript">
		//获取下拉框数据
		function getSelectInfo(){	
	 	   $.ajax({
	            type: "POST",
	            url: "rest/rbac/energyCustomerManageController/getAllCustomer", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            async:false,
	            success: function (result) {
	       	    $("#customerNameQuery").html("");
	       	    $("#customerNameQuery").append("<option value='0'selected='selected'>"+"全部"+"</option>");
	            	for(var i=0;i<result.data.length;i++){
	             		$("#customerNameQuery").append("<option value='"+result.data[i].customer_Id+"'>"+result.data[i].customer_Name+"</option>");
	            	}
	           },
	            error:function(){	            	
	           	}
	       	});
	 	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/energyMarketConfigController/getAllRegion", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            async:false,
	            success: function (result) {
	       	    $("#provinceEdit").html("");
	       	    $("#provinceEdit").append("<option value='0'selected='selected'>"+"全部"+"</option>");
	            	for(var i=0;i<result.data.length;i++){
	             		$("#provinceEdit").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
	            	}
	           },
	            error:function(){	            	
	           	}
	       	});
		}
		$("#provinceEdit").change(function(e){
		      getCity($("#provinceEdit option:selected").val());
		    });
       function getCity(id){	
      	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getCity", 
	            data: 'id='+id,
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#cityEdit").html(""); 
	       	   $("#cityEdit").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#cityEdit").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
	            	}
	           },
	            error:function(){	            	
          	}
      	});
      } 
       function getCityShow(){	
       	  $.ajax({
 	            type: "POST",
 	            url: "rest/rbac/MerchantRegistFlowController/getCity", 
 	            cache: false,  //禁用缓存
 	            dataType: "json",
 	            success: function (result) {
 	       	   $("#cityEditShow").html(""); 
 	       	   $("#cityEditShow").append("<option value='0'>请选择</option>");		   	       			
 	            	for(var i=0;i<result.data.length;i++){
 	             		$("#cityEditShow").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
 	            	}
 	           },
 	            error:function(){	            	
           	}
       	});
       } 
       
      function openWin(){
	  	window.open ("http://api.map.baidu.com/lbsapi/getpoint/index.html", "newwindow", "height=650, width=1200, top=200, left=300,toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=n o, status=no");  
	  }
	</script>
</body>
</html>