<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>${ reportName}预览 - BI商务智能  - 积成能源</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
    <!--        引入外部样式库css        -->
    <jsp:include page="../include/mainHead.jsp"></jsp:include>
    
    <style type="text/css">
    	thead > tr > th{
    		text-align:center;
    	}
    </style>
    
	<!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    <script type="text/javascript" src="plug-in/ace/jqtool/js/vendor/jquery.touch-punch.min.js" ></script>
    <script type="text/javascript" src="plug-in/ace/jqtool/js/jquery.shapeshift.js"></script>
    <!-- pdf  word ppt excel json plugins -->
	<script type="text/javascript" src="plug-in/ace/adIcon/js/plugins/tableExport.js"></script>
	<script type="text/javascript" src="plug-in/ace/adIcon/js/plugins/jquery.base64.js"></script>
	<script type="text/javascript" src="plug-in/ace/adIcon/js/plugins/html2canvas.js"></script>
	<script type="text/javascript" src="plug-in/ace/adIcon/js/plugins/libs/sprintf.js"></script>
	<script type="text/javascript" src="plug-in/ace/adIcon/js/plugins/jspdf.js"></script>
	<script type="text/javascript" src="plug-in/ace/adIcon/js/plugins/libs/base64.js"></script>
  </head>
	<body style="background:#FFFFFF;">
		<div class="row" style="padding:20px;">
			<div class="col-lg-1 col-md-1 col-xs-2">
				<button id="btnBalck" class="btn btn-sm btn-primary" onclick="javascript:history.back(-1);"><i class="glyphicon glyphicon-circle-arrow-left"></i>后退</button>
			</div>
			<div class="col-lg-10 col-md-10 col-xs-8">
				<div style="height: 40px; width: 300px; margin: 10px auto;">
					<button id="tables" style="border: 1px solid #3080cc; background-color:#ffffff;"><span style="color: #3080cc; font-family:'黑体'; background-color:#ffffff;">表格</span></button>
		            <button id="bar" style="border: 1px solid #3080cc; background-color:#ffffff;"><span style="color: #3080cc; font-family:'黑体'; background-color:#ffffff;">柱状图</span></button>
		            <button id="pies" style="border: 1px solid #3080cc; background-color:#ffffff;"><span style="color: #3080cc; font-family:'黑体'; background-color:#ffffff;">饼图</span></button>
		            <button id="line" style="border: 1px solid #3080cc; background-color:#ffffff;"><span style="color: #3080cc; font-family:'黑体'; background-color:#ffffff;">折线图</span></button>
				</div>
			</div>
			<div class="col-lg-1 col-md-1 col-xs-2">
				<button id="btnExcel" class="btn btn-sm btn-primary">Excel</button>
			</div>
		</div>
		<!--	标题	-->
		<div class="row" style="text-align:center;">
				<h2 id="title">${ reportTitle}</h2>
			</div>
			<div class="row" style="text-align:left; margin-left:30px;">
				报表名称：<span id="reportName">${ reportName}</span>
			</div>
		<!--	表格展示	-->
		<div class="row" id="biao">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<table id="all" cellpadding="0" cellspacing="0" border="1px" align="center" width="98%">
					<thead id="thead" style="text-align:center;">
						<c:forEach items="${colTH}" var="colunm">
							<th
								<c:if test="${colunm == hidden}">
									style="display: none"
								</c:if>
							>${colunm }</th>
						</c:forEach>
					</thead>
					<tbody id="tbody" style="text-align:center;">
						<c:forEach items="${list}" var="m">
							<tr>
							<c:forEach items="${col}" var="a">
								<td 
									<c:if test="${a == hidden}">
										style="display: none"
									</c:if>
								>
									<c:if test="${a == ahref}">
										<a href="${address }&${parm}=${m[cur] }">${m[a] }</a>
									</c:if>
									<c:if test="${a != ahref}">
										${m[a] }
									</c:if>
								</td>
							</c:forEach>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!--	Echarts 图标展示	-->
		<div id="pic" style="height: 500px; widht:99%;">
			
		</div>
		<div id="pie" style="height: 500px; widht:99%;">
			
		</div>
		
		
		<!--  import javascript	-->
		<script type="text/javascript" src="plug-in/ace/bi/js/echarts-plain.js"></script>
		<script type="text/javascript" src="plug-in/ace/bi/js/json.js"></script>
		<script type="text/javascript">
			setTimeout(function(){
				_w_table_rowspan("#all",1);
			}, 3000);
		
			var pic = echarts.init(document.getElementById("pic"));
			var pie = echarts.init(document.getElementById("pie"));
				option = {
				    title : {
				        text: '',
				        subtext: ''
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:[]
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {show: true, type: ['line', 'bar', 'pie']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : []
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				       {
				       		name: '',
				       		type:'',
				       		itemStyle: {
				                normal: {
				                    color: 'tomato',
				                    barBorderColor: 'tomato'
				            	}
				            },
				       		data:[]
				       }
				    ]
				};
				
				optionpie = {
				    title : {
				        text: '',
				        subtext: '',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:[]
				    },
				    calculable : true,
				    series : [
				        {
				            name:'',
				            type:'pie',
				            radius : '55%',
				            center: ['50%', 225],
				            data:[ 
								//{value:6, name:'山东'},{value:1, name:'河北'}
								6,1
                			]
				        }
				    ]
				};
            
           
            var list = '${ data}';
            var json = JSON.parse(list);
            var x = new Array();
            var y = new Array();
            var py = new Array();
            for(var i=0; i<json.data.length; i++){
            	for(var j=0; j<json.jcol.length; j++){
	            	if(json.jcol[j] == '${ hidden}'){
	            	}	
	            	else if(json.jcol[j] == '${ ahref}'){
	            		x[i] = json.data[i][json.jcol[j]];
	            	}
	            	else{
	            		y[i] = json.data[i][json.jcol[j]]
	            	}
            	}
            	py[i] = {
				        value:y[i],
				        name:x[i]
				}
	        }
	        
	        option.series[0].name = json.colTH[0];
	        option.series[0].type = 'bar';
	        option.series[0].data = y;
	        option.xAxis[0].data = x;
	        option.legend.data = x;
	        pic.setOption(option);
	        
	        $(document).ready(function(){
	        	$("#biao").css("display", "block");
	        	$("#pic").css("display", "none");
	        	$("#pie").css("display", "none");
	        });
	        
	        $("#tables").on("click", function(){
	           $("#pic").css("display", "none");
		       $("#biao").css("display", "block");
		       $("#pie").css("display", "none");
	        });
	        
	        $("#line").on("click", function(){
	        	if("${ address}"=="javascript:void(0)"){
	        		alert("你已经进入最后一级，不能查看图表");
	        		return;
	        	}
		        option.series[0].type = 'line';
		        option.series[0].data = y;
		        pic.setOption(option);
		        $("#pic").css("display", "block");
		        $("#biao").css("display", "none");
		        $("#pie").css("display", "none");
	        });
	        
	        $("#bar").on("click", function(){
	        	if("${ address}"=="javascript:void(0)"){
	        		alert("你已经进入最后一级，不能查看图表");
	        		return;
	        	}
	        	$("#pic").css("display", "block");
		        $("#biao").css("display", "none");
		        option.series[0].data = y;
		        option.series[0].type = 'bar';
		        pic.setOption(option);
		        $("#pie").css("display", "none");
	        });
	        
	        $("#pies").on("click", function(){
	        	if("${ address}"=="javascript:void(0)"){
	        		alert("你已经进入最后一级，不能查看图表");
	        		return;
	        	}
		        optionpie.series[0].type = 'pie';
		        optionpie.series[0].name = json.colTH[0];
		        optionpie.legend.data = x;
		        optionpie.series[0].data = py;
		        pie.setOption(optionpie);
		        $("#pie").css("display", "block");
		        $("#pic").css("display", "none");
		        $("#biao").css("display", "none");
	        });
	        
		</script>
		
	  </body>
</html>
