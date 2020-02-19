<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.net.URLDecoder"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" /> 
		<title><%=java.net.URLDecoder.decode(request.getParameter("title") , "UTF-8") %>流程配置</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<script src="../../plug-in/gooflow/jquery.min.js"></script>
		<script src="../../plug-in/gooflow/GooFunc.js"></script>
    	<link rel="stylesheet" href="../../plug-in/gooflow/GooFlow.css" type="text/css"></link>
		<script src="../../plug-in/gooflow/GooFlowWorkflow.js"></script>
		<script src="../../plug-in/gooflow/underscore.js"></script>
		<!--        引入外部样式库css        -->
        <jsp:include page="../include/relativeMainHead.jsp"></jsp:include>
	    
	    <!--[if lt IE 9]>
    <?import namespace="v" implementation="#default#VML" ?>
    <![endif]-->
    <style type="text/css">
   		.bootbox-form strong{
   		    width: 106px;
		    text-align: right;
		    display: inline-block;
		}
    	.handlers-from strong{
    		cursor:pointer;
    	    width: 90px;
		    text-align: center;
		    display: inline-block;
		    padding: 5px 0;
		    border-radius: 4px;
		    border: 1px solid #428bca;
		    font-size: 14px !important;
		    font-weight: normal;
		    margin-right: 10px;
		}
		.handlers-from strong.on{
			background: #428bca;
			color:#FFF;
		}
		#searchMsg font{
			vertical-align: baseline !important;
		}
		
    </style>
    <script type="text/javascript">
   	var params = {};    
    var property = {
        width: $(window).width(),
        height: $(window).height(),
        toolBtns: ["task", "node", "chat", "state", "plug"],
        haveHead: true,
        headBtns: ["save"], //如果haveHead=true，则定义HEAD区的按钮
        haveTool: true,
        useOperStack: true,
        initLabelText:"<%=java.net.URLDecoder.decode(request.getParameter("title") , "UTF-8") %>"
    };
    var remark = {
        cursor: "选择指针",
        direct: "转换连线",
        start: "开始结点",
        end: "结束结点",

        task: "任务结点",
        node: "自动结点",
        chat: "决策结点",
        state: "状态结点",
        plug: "附加插件",
        fork: "分支结点",

        join: "联合结点",
        complex: "复合结点",
        group: "组织划分框编辑开关"
    };
    var demo;

    $(document).ready(function () {
        demo = $.createGooFlow($("#demo"), property);
        demo.setNodeRemarks(remark);
        demo.onItemDel = function (id, type) {
            return confirm("确定要删除该单元吗?");
        }


        var nodeattribute = {};
        var node = {};
        var arr = {};
        nodeattribute["name"] = "工程测量";
        nodeattribute["left"] = 5;
        nodeattribute["top"] = 80;
        nodeattribute["type"] = "node";
        nodeattribute["state"] = "nodeState.Normal";
        node["node1"] = nodeattribute;
        arr["nodes"] = node;
        arr["title"] = "项目图"


        function showDraw(jsondata) {
            demo.loadData(jsondata);
        }
        function pageInit() {
            var flowID = 0;
            var jsondata;
            var arr = {};
            jsondata = getJsonData(flowID);
            var cs=JSON.stringify(jsondata);
            //jsondata = "{\"title\":\"营销管理导航图\"}" 
            
			cs = cs.replace(/\[/g,'');
			cs = cs.replace(/\]/g,'');
			cs = cs.replace(/\}\,\{/g,',');
            arr = eval('(' + cs + ')');
            demo.loadData(arr);
        }
        function getJsonData(flowID) {  
        	params.flowID=GetQueryString("flowId"); 
            var jsondata=""; 
            $.ajax({
                type: "post",
                cache: false,  //禁用缓存
                async: false,
	            dataType: 'json',
                url: "design/getWorkFlowData", 
                data:params,
   	            success: function (result) {
                    jsondata = result.attributes.data;
   	            },
   	            error: function (result) {
   	   	            alert(0);
   	            }
            });  
            return jsondata;
        }
        $(document).ready(function () {
            //var navigationSchemeID = GetQueryString("navigationSchemeID");
            pageInit();
            //禁用鼠标右键菜单
            $(document).bind("contextmenu", function (e) { return false; })
        });
        demo.onFreshClick = function () {
            window.location.reload();
        };
        demo.onBtnSaveClick = function () {
            //var myjson = demo.exportData().toString(); //报错'undefined' 为空或不是对象 行: 79 
            //var myjson = JSON.stringify(demo.exportData());
            //alert(myjson);
            var myjson = {}; 
            var flowID = params.flowID;
            if (flowID == 0 || flowID == null) {
                alert("请先选择项目");
                return;
            }
            myjson = demo.exportData();
            //节点数据绑定
            var arrnodes = [];
            var nodes = myjson.nodes;
            for (var key in nodes) {
                var node = nodes[key];
                var item = {};
                item["FLOW_ID"] = flowID;
                item["ACTIVITY_ID"]=node.nodeId;
                item["ACTIVITY_CODE"] = key;
                item["ACTIVITY_NAME"] = node.name;
                item["ACTIVITY_LEFT"] = node.left;
                item["ACTIVITY_TOP"] = node.top;
                item["ACTIVITY_ICON"] = node.type;
                arrnodes.push(item);
            }
            arrnodes = JSON.stringify(arrnodes);
            params.arrNodes = arrnodes;

            //连线数据绑定

            //连线数据绑定
            var arrlines = [];
            var lines = myjson.lines;
            for (var key in lines) {
                var line = lines[key];
                var item = {};
                item["FLOW_ID"] = flowID;
                item["LINE_ID"] = line.nodeId;
                //item["LINE_CODE"] = key;
                item["LINE_INFLECTION"] = line.M;
                item["BEGIN_CODE"] = line.from;
                item["END_CODE"] = line.to;
                item["LINE_CONTENT"] = line.name;
                arrlines.push(item);
            }
            arrlines = JSON.stringify(arrlines);
            params.arrLines = arrlines;

            $.ajax( {
    			type : "post",
    			async : false, //同步执行  
                url: "design/saveWorkFlowData", 
                data: params,
    			dataType : "json", //返回数据形式为json  
    			success : function(result) { 
        			if(result.result=="success"){
    				alert("保存成功");
    				}
    				else if(result.result=="line"){
    				alert("抱歉，保存失败。节点之间请用连接线连接。");
    				return;
    				}
    			},
    			error : function(errorMsg) {
    				alert("图表请求数据失败!");
    			}
    		});
            window.location.reload();
        };

    });


    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
   
    //步骤文件管理
    function fileManage(nodecode){ 
        if(demo.$nodeData[nodecode].nodeid == undefined )
        {
            alert("节点数据尚未保存，请先保存节点数据");
            return;
        }
        fileSet(nodecode);
    } 

     //获取悬浮框信息
     function GetActivityInfo(acitivityCode) {
         var dataInfo = "";
         $.ajax({
             type: "post",
             contentType: "application/json;charset=utf-8",
             dataType: "json",
             async: false,
             url: "GetActivityInfo",
             data: "{'acitivityCode':'" + acitivityCode + "','flowID':'"+ 0+"'}",
             success: function (data)
             {
                 dataInfo= data;
             }
         });
         return dataInfo;
     }

 
    </script>
    </head>
   <body>
    	<div id="demo">
    	</div>
    	<div class="iconOperate"></div>
    	
    	
    <!--弹出框放置位置  添加 删除  查看详情-->
    <div id="dialogactivity-message" class="hide"> 
		<form class="bootbox-form">   
            <strong>活动序号：</strong>
            <input id="activityCode" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" readonly="readonly"><br/> 
            <strong>活动名称：</strong>
            <input id="activityName" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" readonly="readonly"><br/> 
            <strong>关联表单：</strong>
            <input id="formName" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" ><br/> 
            <strong>活动类型：</strong>
            <select id="activityType"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
	           </select><br/> 
            <strong>评审模式：</strong>
            <select id="reviewType"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
	           </select> <br/> 
            <strong>活动属性：</strong>
            <select id="activityProperty"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
	           </select> <br/> 
            <strong>活动选择模式：</strong>
            <select id="BranchSelType"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
	           </select><br/> 
            <strong>默认关联节点：</strong>
            <select id="relationNode"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
	           </select><br/> 
            <strong>允许最长时间：</strong>
            <input id="activityInterval" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" ><br/> 
        </form>
	</div>
	<!--菜单操作项弹出框-->
    <div id="formMessage" class="hide">
    	<form class="bootbox-form" id="rnss">
            <strong>系统选择 ：</strong>
            <select class="ipt" id="systemList" style="height: 30px; width: 180px;"><br/>
            	
            </select>
       </form>
       <br />
        <!-- 左侧树形图开始 -->
		<div class="col-sm-12 col-xs-12 col-lg-12" style="margin-top:-3px; paading:0px;" id="tree">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">菜单</h4>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8" id = "formTree">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
    <!--弹出框放置位置  流转规则信息-->
    <div id="dialogrulemanage-message" class="hide" >
		<form class="bootbox-form">
            <strong>活动序号：</strong>
            <input id= "ruleActivityCode"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/></br>
            <strong>活动名称：</strong>
            <input id= "ruleActivityName"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/>  
        </form>
		<div class="table-header">流转规则</div>
		<div class="row">
			<div style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">					
				<button class="btn btn-primary btn-sm" id="btnRuleAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnRuleEdit">编辑</button> 
				<button class="btn btn-primary btn-sm" id="btnRuleDelete">删除</button>
			</div> 
		</div>
		<div class="table-responsive">
			<table id="ruleTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
				<thead>
					<tr>
						<th>
							<label>
								<input type="checkbox" class="ace" id="allCheck" />
								<span class="lbl"></span>
							</label>
						</th>
						<th>
							组件名称
						</th>
						<th>
							组件文本名称
						</th>
						<th>
							判断条件
						</th>
						<th>
							判断依据
						</th>
						<th>
							转到活动
						</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div> 
	
	
    <!--弹出框放置位置  可写字段信息-->
    <div id="dialogformcontrol-message" class="hide" >
		<form class="bootbox-form">
            <strong>活动序号：</strong>
            <input id= "ruleActivityCode"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/></br>
            <strong>活动名称：</strong>
            <input id= "ruleActivityName"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/>  
        </form>
		<div class="table-header">组件状态设置</div> 
		<div class="table-responsive">
			<table id="formControlTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
				<thead>
					<tr> 
						<th>
							组件名称
						</th>
						<th>
							组件文本名称
						</th>
						<th>
							组件状态
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ parmenulist}" var ="menu"> 
						 <tr>
			                <td>Tiger Nixon</td>
			                <td>Tiger Nixon</td>
			                <td><select size="1" id="row-1-office" name="row-1-office">
			                    <option value="Edinburgh" selected="selected">
			                        Edinburgh
			                    </option>
			                    <option value="London">
			                        London
			                    </option>
			                    <option value="New York">
			                        New York
			                    </option>
			                    <option value="San Francisco">
			                        San Francisco
			                    </option>
			                    <option value="Tokyo">
			                        Tokyo
			                    </option>
			                </select></td>
			            </tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div> 
	 
    <!--流转规则弹出框放置位置  添加 删除  查看详情-->
    <div id="dialogrule-message" class="hide"> 
		<form class="bootbox-form">    
            <strong>组件名称：</strong>
			<select id="controlName"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
            </select><br/>
            <strong>判断条件：</strong>
			<select id="conditionsName"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
            </select><br/>
            <strong>判断依据：</strong>
            <input id="judgeBasis" type="text" style="height: 30px; width: 180px; margin-bottom:5px;"/><br/> 
            <strong>转到活动：</strong>
			<select id="gotoActivityName"  style="height: 30px; width: 180px; margin-bottom:5px;">
	              <option value="">&nbsp;</option> 
            </select><br/>
        </form>
	</div>
	
	<!--操作者弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="formOperatorEdit" class="hide">
		<form class="bootbox-form" id="addOrEditForm">
            <strong>活动序号：</strong>
            <input type="text" id="operatorActivityCode" style="height: 30px; width: 180px; margin-bottom:5px;" readonly="readonly"/><br/> 
			<strong>活动名称： </strong>
			<input id="operatorActivityName" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" readonly="readonly"/><br/>
			<strong>操作者选择模式：</strong>
			<select id="handlerSetType" style="height: 30px; width: 180px; margin-bottom:5px;">
				<option value='0'>全部</option>
			</select><br/>
			<strong>所属系统：</strong>
			<select id="OperatorSystem" style="height: 30px; width: 180px; margin-bottom:5px;">
				<option value='0'>全部</option>
			</select><br/>
			<strong>操作者：</strong>
			<input  id="receiversDialogShow" type="text" style="height: 30px; width: 160px; margin-bottom:5px;" /><br/>
			
			
			
			<strong class="hide">操作者配置的：&nbsp;&nbsp;&nbsp;</strong>
			<input class="hide" id="receiversDialogConfig" type="text" style="height: 30px; width: 160px; margin-bottom:5px;" /><br/>
			
			
			<strong class="hide" >操作者隐藏：&nbsp;&nbsp;&nbsp;</strong>
			<input class="hide" id="receiversDialogHide" type="text"  style="height: 30px; width: 160px; margin-bottom:5px;" /><br/>
			<strong class="hide" >操作者全部：&nbsp;&nbsp;&nbsp;</strong>
			<input class="hide" id="receiversDialogAll" type="text"  style="height: 30px; width: 160px; margin-bottom:5px;" /><br/>
			
			<strong class="hide" >操作者保存：&nbsp;&nbsp;&nbsp;</strong>
			<input class="hide" id="receiversDialog" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" />
        </form>
       
	</div>
	
	<!--通知者弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="formMsgEdit" class="hide">
		<form class="bootbox-form" id="addOrEditForm">
            <strong>活动序号：</strong>
            <input type="text" id="msgActivityCode" style="height: 30px; width: 180px; margin-bottom:5px;" readonly="readonly"/><br/> 
			<strong>活动名称：</strong>
			<input id="msgActivityName" type="text" style="height: 30px; width: 180px; margin-bottom:5px;" readonly="readonly"/><br/>
			<strong>所属系统：</strong>
			<select id="MsgSystem" style="height: 30px; width: 180px; margin-bottom:5px;">
				<option value='0'>全部</option>
			</select><br/>
			<strong>操作者：</strong>
			<input id="receiverssDialog" type="text" style="height: 30px; width: 180px; margin-bottom:5px;"/>
        </form>
        <div class="row" id="btnMsgTree" style="mrgin-left:10px;"> 
			<button class="btn btn-primary btn-sm col-md-12" id="btnMsgUser" style="border: 1px solid #FFFFFF;">用户选择</button> 
        </div>
         
	</div>
		 <div id="messageStrategyPerson" class="hide">
		<form class="bootbox-form handlers-from">
			<strong id="organButton">组 织</strong>
			<strong id="postButton">岗 位</strong>
			<strong id="roleButton">角 色</strong>
			<br/>
            <strong class=" hide" >组织机构：</strong>
            <input class="diaorgan hide" id="receiverDialog" type="text" />
		</form>
		<div class="panel panel-default" style="margin-top:10px; height:388px;margin-bottom:0">
	        <div id="receiverTreeDialog" class="col-xs-4 panel-title" style="display:none;height: 357px; overflow-x: hidden;"> 
				<div class="widget-box">
					<div class="widget-header header-color-blue2">
						<h5 class="lighter smaller">接收者</h5>
					</div>
					<div class="widget-body">
						<div class="widget-main padding-8" id = "parentTreess" style="display:none">
							
						</div>
						<div class="widget-main padding-8" id = "parentTreessPost" style="display:none">
							
						</div>
						<div class="widget-main padding-8" id = "parentTreessRole" style="display:none">
							
						</div>
						<div class="widget-main padding-8" id = "parentTreessUser" style="display:none">
							
						</div>
					</div>
				</div>
			</div>
			
	        <div class="panel-body col-xs-8 panel-title">
	        	<div class="row">
					<form class="form-inline">
						<div class="input-group col-sm-5" style="margin-bottom: 10px; ">
							<span class="input-group-addon" id="basic-addon1">查询条件</span>
							<input id="queryData" type="text" class="form-control" placeholder="查询条件" aria-describedby="basic-addon1">
						</div>
						<div class="input-group col-sm-5  col-sm-offset-2" style="margin-bottom: 10px;">
							<span class="input-group-addon" id="basic-addon1">查询条件</span>
							<input id="queryResult" type="text" class="form-control" placeholder="查询条件" aria-describedby="basic-addon1">
						</div>
					</form>
				</div>
	            <span class="col-md-7 col-lg-7 panel-title" >待分配用户<span class="leftCount" style="margin-left: 5px;font-size: 14px"></span></span>
         		<span class="col-md-5 col-lg-5 panel-title" >已分配用户<span class="rightCount" style="margin-left: 5px;font-size: 14px"></span></span>
	           <div id="pickList" style="height:260px;"></div>
         		
	            <div class="panel-heading" style="margin-top:10px;">	           
	        	</div>
	           <br><br>
	        </div>
     	</div>
	</div>
	<!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/relativeMainFooter.jsp"></jsp:include>
	<script src="../../plug-in/jquery-plugs/form/jquery.form.js"></script>
    <script type="text/javascript">
	    $(function(){
	    	selectPick("#pickList", "#queryData", "left");//初始picklist查询功能
			selectPick("#pickList", "#queryResult", "right");//初始picklist查询功能
	    });
    	$("#organButton").click(function(){
    		//修改其他按钮的样式
    		$(this).addClass("on").siblings("strong").removeClass("on");
    		//初始化组织树结构
    		$("#parentTreess").css("display","block");
    		$("#parentTreessRole").css("display","none");
    		$("#parentTreessUser").css("display","none");
    		$("#parentTreessPost").css("display","none");
    		$("#receiverTreeDialog").css("display","block");
			parsOperatorAdd.parentMenuId = -1;
			parsOperatorAdd.systemId = 1;
			parsOperatorAdd.postMark = 0;
			parsOperatorAdd.modelMark=0;
			$("#treeReceiverAdd").remove();
    		$("#parentTreess").append("<div id='treeReceiverAdd' class='tree'></div>");//追加一个div承载tree
			treeReceiverAdd(parsOperatorAdd);
			if(parsOperatorAdd.parentMenuId == -1){
				parsOperatorAdd.parentMenuId = 0;
   			}
    	});
    	var parsOperatorPost={};
    	$("#postButton").click(function(){
    		//修改其他按钮的样式
    		$(this).addClass("on").siblings("strong").removeClass("on");
    		$("#parentTreess").css("display","none");
    		$("#parentTreessRole").css("display","none");
    		$("#parentTreessUser").css("display","none");
    		$("#parentTreessPost").css("display","block");
    		//初始化组织树结构
    		$("#receiverTreeDialog").css("display","block");
    		parsOperatorPost.parentMenuId = -1;
    		parsOperatorPost.systemId = 1;
    		parsOperatorPost.postMark = 0;
    		parsOperatorPost.modelMark=0;
			$("#treeReceiverPost").remove();
    		$("#parentTreessPost").append("<div id='treeReceiverPost' class='tree'></div>");//追加一个div承载tree
			treeReceiverPost(parsOperatorPost);
			if(parsOperatorPost.parentMenuId == -1){
				parsOperatorPost.parentMenuId = 0;
   			}
    		
    	});
    	var parsOperatorRole={};
    	$("#roleButton").click(function(){
    		//修改其他按钮的样式
    		$(this).addClass("on").siblings("strong").removeClass("on");
    		$("#parentTreess").css("display","none");
    		$("#parentTreessRole").css("display","block");
    		$("#parentTreessUser").css("display","none");
    		$("#parentTreessPost").css("display","none");
    		//初始化组织树结构
    		$("#receiverTreeDialog").css("display","block");
    		parsOperatorRole.parentMenuId = -1;
    		parsOperatorRole.systemId = 1;
    		parsOperatorRole.postMark = 0;
    		parsOperatorRole.modelMark=0;
			$("#treeReceiverRole").remove();
    		$("#parentTreessRole").append("<div id='treeReceiverRole' class='tree'></div>");//追加一个div承载tree
			treeReceiverRole(parsOperatorRole);
			if(parsOperatorRole.parentMenuId == -1){
				parsOperatorRole.parentMenuId = 0;
   			}
    		
    	});
    
    </script>
	<script type="text/javascript">

	 //在my.js中调用
    var par={};
    function ActivityEdit(nodecode)
    {
        //var flowID = 1;
        if(demo.$nodeData[nodecode].nodeId == undefined )
        {
            alert("节点数据尚未保存，请先保存节点数据");
            return;
        }
		$("#activityCode").val('');
		$("#activityCode").removeAttr("readonly"); 
		$("#activityName").val("");
		$("#activityName").removeAttr("readonly"); 
		$("#formName").val("");
		$("#formName").removeAttr("readonly"); 
		$("#activityType").val("");
		$("#activityType").removeAttr("readonly"); 
		$("#reviewType").val("");
		$("#reviewType").removeAttr("readonly"); 
		$("#activityProperty").val("");
		$("#activityProperty").removeAttr("readonly"); 
		$("#BranchSelType").val("");
		$("#BranchSelType").removeAttr("readonly"); 
		$("#relationNode").val("");
		$("#relationNode").removeAttr("readonly"); 
		$("#activityInterval").val("");
		$("#activityInterval").removeAttr("readonly"); 
    	par.activityId = nodecode;
   	    if(par.activityId == null || par.activityId == ""){
   			bootbox.alert("请先选择活动信息", function(){});
   			return;
   		}else{ 
   	        //初始化下拉框  
   			$.ajax({
   		        type: "POST",
   		        url: "design/getActivityType", 
   		        cache: false,  //禁用缓存
   		        dataType: "json",
   		         async: false,
   		        success: function (result) {
   		   			$("#activityType").html("");  
   		        	for(var i=0;i<result.data.length;i++){
   		         		$("#activityType").append("<option value='"+result.data[i].SUB_ID+"'>"+result.data[i].SUB_NAME+"</option>");
   		        	}
   		        },
   		        error:function(){	            	
   		        }
   		    });
   			$.ajax({
   		        type: "POST",
   		        url: "design/getReviewType", 
   		        cache: false,  //禁用缓存
   		        dataType: "json",
   		         async: false,
   		        success: function (result) {
   		   			$("#reviewType").html("");  
   		        	for(var i=0;i<result.data.length;i++){
   		         		$("#reviewType").append("<option value='"+result.data[i].SUB_ID+"'>"+result.data[i].SUB_NAME+"</option>");
   		        	}
   		        },
   		        error:function(){	            	
   		        }
   		    });
   			$.ajax({
   		        type: "POST",
   		        url: "design/getActivityProperty", 
   		        cache: false,  //禁用缓存
   		        dataType: "json",
   		         async: false,
   		        success: function (result) {
   		   			$("#activityProperty").html("");  
   		        	for(var i=0;i<result.data.length;i++){
   		         		$("#activityProperty").append("<option value='"+result.data[i].SUB_ID+"'>"+result.data[i].SUB_NAME+"</option>");
   		        	}
   		        },
   		        error:function(){	            	
   		        }
   		    });
   			$.ajax({
   		        type: "POST",
   		        url: "design/getBranchSelType", 
   		        cache: false,  //禁用缓存
   		        dataType: "json",
   		         async: false,
   		        success: function (result) {
   		   			$("#BranchSelType").html("");  
   		        	for(var i=0;i<result.data.length;i++){
   		         		$("#BranchSelType").append("<option value='"+result.data[i].SUB_ID+"'>"+result.data[i].SUB_NAME+"</option>");
   		        	}
   		        },
   		        error:function(){	            	
   		        }
   		    });
   			par.FLOW_ID = 1; 
   			$.ajax({
   		        type: "POST",
   		        url: "design/getRelationNode", 
   		        cache: false,  //禁用缓存
   		        dataType: "json",
	            data: 'flowID='+params.flowID+"&activityId="+par.activityId,
   		        success: function (result) {
   		   			$("#relationNode").html("");  
   		        	for(var i=0;i<result.data.length;i++){
   		         		$("#relationNode").append("<option value='"+result.data[i].ACTIVITY_ID+"'>"+result.data[i].ACTIVITY_NAME+"</option>");
   		        	}
   		        },
   		        error:function(){	            	
   		        }
   		    }); 
   	   		
   			setTimeout(function(){
   				$.ajax({
   	                type: "POST",
   	                url: "design/getActivityInfo", 
   	                cache: false,  //禁用缓存
   	                dataType: "json",
   	                data:par,
   	                async: false,
   	                success: function (result) {  
   	                   	$("#activityCode").val(result.data[0].activityCode); 
   	                   	$("#activityName").val(result.data[0].activityName);
   	                   	param.FormID = result.data[0].formId;
   	                   	$("#formName").val(result.data[0].formName);
   	                   	$("#activityType").val(result.data[0].activityType);
   	                   	$("#reviewType").val(result.data[0].reviewType);
   	                   	$("#activityProperty").val(result.data[0].activityProperty);
   	                   	$("#BranchSelType").val(result.data[0].branchSelType);
   	                   	$("#relationNode").val(result.data[0].relationNode);
   	                   	$("#activityInterval").val(result.data[0].activityInterval); 
   	                   	$("#receiversDialog").val(result.operator);  
   	   	                activitytInput();
   	                },
   	                error:function(){	   
   	   	            	parent.bootbox.alert("查看数据失败", function(){});
   	   	            	return;         	
   	                }
   	            });
   	   		}, 200);
   		} 
    }

    var param = {};
    function activitytInput(){ 
			var dialog = $( "#dialogactivity-message" ).removeClass('hide').dialog({
				modal: true,
				title: "活动基本属性",
				title_html: true, 
				width:400,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							$("#activityCode").val('');
							$("#activityCode").removeAttr("readonly"); 
							$("#activityName").val("");
							$("#activityName").removeAttr("readonly"); 
							$("#formName").val("");
							$("#formName").removeAttr("readonly"); 
							$("#activityType").val("");
							$("#activityType").removeAttr("readonly"); 
							$("#reviewType").val("");
							$("#reviewType").removeAttr("readonly"); 
							$("#activityProperty").val("");
							$("#activityProperty").removeAttr("readonly"); 
							$("#BranchSelType").val("");
							$("#BranchSelType").removeAttr("readonly"); 
							$("#relationNode").val("");
							$("#relationNode").removeAttr("readonly"); 
							$("#activityInterval").val("");
							$("#activityInterval").removeAttr("readonly"); 
						}
					},
					{
						text: "保存",
						"class" : "btn btn-primary btn-xs",
						click: function() {
								par.ACTIVITY_ID = par.activityId;
								par.ACTIVITY_CODE = $("#activityCode").val();  
								par.ACTIVITY_NAME = $("#activityName").val(); 
								par.FORM_ID = param.FormID; 
								par.ACTIVITY_TYPE = $("#activityType").val(); 
								par.REVIEW_TYPE = $("#reviewType").val(); 
								par.ACTIVITY_PROPERTY = $("#activityProperty").val(); 
								par.BRANCH_SEL_TYPE = $("#BranchSelType").val(); 
								par.RELATION_NODE = $("#relationNode").val(); 
								par.ACTIVITY_INTERVAL = $("#activityInterval").val();  
								editActivity(par); 
								$( this ).dialog( "close" );
								$("#activityCode").val('');
								$("#activityCode").removeAttr("readonly"); 
								$("#activityName").val("");
								$("#activityName").removeAttr("readonly"); 
								$("#formName").val("");
								$("#formName").removeAttr("readonly"); 
								$("#activityType").val("");
								$("#activityType").removeAttr("readonly"); 
								$("#reviewType").val("");
								$("#reviewType").removeAttr("readonly"); 
								$("#activityProperty").val("");
								$("#activityProperty").removeAttr("readonly"); 
								$("#BranchSelType").val("");
								$("#BranchSelType").removeAttr("readonly"); 
								$("#relationNode").val("");
								$("#relationNode").removeAttr("readonly"); 
								$("#activityInterval").val("");
								$("#activityInterval").removeAttr("readonly"); 
						}
					}
				]
			});
	}


	$("#formName").click(function(e){  
		btnFormSetting(e, this.id);
		formTreeselect();
	});

	//菜单操作项设置   弹出框
	function btnFormSetting(e, thisid){
		e.preventDefault();
		var dialog = $("#formMessage").removeClass('hide').dialog({
			modal: true,
			title: "<div class='widget-header widget-header-small' style='width:300px;'><h4 class='smaller'><i class='icon-ok'></i>设置</h4></div>",
			title_html: true,
			width:330,
			height:650,
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
						$("#formName").val(param.FormName) 
						$( this ).dialog( "close" ); 
					} 
				}
			]
		});
		
	}
	var pars = {};
	function formTreeselect(){
		$.ajax({
            type: "POST",
            url: "../rbac/menuController/getSystemList",
            cache: false,  //禁用缓存
            dataType: "json",
            success: function (result) {
            	$("#systemList").find("option").remove();
          		for(var i=0; i<result.systemList.length; i++){
          			$("#systemList").append("<option value='"+result.systemList[i].systemId+"'>"+result.systemList[i].systemName+"</option>");
          		}
          		//网页加载时 装载树形图
			$(".tree").remove();
			pars.rootOnly = true;
   			pars.parentMenuId = -1;
   			pars.roleId = par.roleId;
			pars.systemId =  $("#systemList").val();
   			$("#formTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
   			treeSelect(pars);
   			if(pars.parentMenuId == -1){
  					pars.parentMenuId = 0;
  				}
				$("#systemList").change(function(){
					$(".tree").remove();
    			pars.rootOnly = true;
    			pars.parentMenuId = -1;
					pars.systemId =  $("#systemList").val();
    			$("#formTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
    			treeSelect(pars);
    			if(pars.parentMenuId == -1){
      					pars.parentMenuId = 0;
      				}
    		});
            },
            error:function(){
            	alert("系统平台名称加载失败");
            }
        });
	}
	function treeSelect(pars){
  			var DataSourceTree = function (options) {
  	        	this.url = options.url;
   	    }
       	 DataSourceTree.prototype.data = function (options, callback) {
       	    var self = this;
       	    var $data = null;
       	    if (!("name" in options) && !("type" in options) && pars.parentMenuId != -1) {
       	        pars.parentMenuId = 0; //当父节点不为-1时赋值为0，可以到根节点 
       	    } else if ("type" in options && options.type == "folder") {
       	       	if (options.id!="0") {
	       	    	pars.parentMenuId = options.id;
       	        }
       	    }
      	        $.ajax({
                 type: "POST",
                 url: this.url,
                 cache: false,  //禁用缓存
                 data:pars,
                 dataType: "json",
                 success: function (result) {
                		callback(result);
                 },
                 error: function (jqXHR, textStatus, errorThrown) {
               	  	showError(jqXHR.responseText);
                 }
             	});
       	};
       	$('#treeMenu'+pars.systemId).ace_tree({
       		dataSource: new DataSourceTree({
       	    	url: 'workForm/getChildNode'
       	    })
       	});
       	//加载grid数据（叶子节点）
       	$('#treeMenu'+pars.systemId).on('selected', function(evt, data) {
         	//取出ID
         	param.FormID=data.info[0].id; 
         	param.FormName=data.info[0].name; 
       	});
      	//加载grid数据（父节点）
        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
        	param.FormID=null;//data.id; 
    	});
    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
    		param.FormID=data.id; 
    	});
       	
  		}
	
	//编辑活动的保存方法
	function editActivity(par){ 
		$.ajax({
	            url: 'design/editActivityInfo',
	            data: par,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	if(result.result == "success"){
		                	parent.bootbox.alert("更新成功", function(){});
	                	}else{
	                		parent.bootbox.alert("更新失败", function(){});
	                	} 
   	            },
   	            error: function(){
   	            	parent.bootbox.alert("更新数据失败", function(){});
   	            	return;
   	            }
	      });
	} 
    
	//格式化编辑时加载的 时间格式
	function FormatDate (strTime) {
	    var date = new Date(strTime);
	    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	}


	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
		_title: function(title) {
			var $title = this.options.title || '&nbsp;'
			if( ("title_html" in this.options) && this.options.title_html == true )
				title.html($title);
			else title.text($title);
		}
	})); 


    //流转规则设置
    function ActivityRuleSet(nodecode){
        var flowID = params.flowID; 
        if(demo.$nodeData[nodecode].nodeId == undefined )
        {
            alert("节点数据尚未保存，请先保存节点数据");
            return;
        }
        var activityID = demo.$nodeData[nodecode].nodeId; 
 
		rulepar.activityId = activityID;
		if(rulepar.activityId== null || rulepar.activityId == ""){
			bootbox.alert("请先选择操作信息", function(){});
			return;
		} 
		$.ajax({
            url: 'design/getActivityInfo',
            async: false,
            data: 'activityId='+rulepar.activityId,
            type: 'POST',
            dataType: 'json',
            success: function (result) {  
        		$("#ruleActivityCode").val(result.data[0].activityCode); 
        		$("#ruleActivityName").val(result.data[0].activityName);
        		$("#receiversDialog").val(result.operator);  
            },
            error: function(){
        		$("#ruleActivityCode").val(""); 
        		$("#ruleActivityName").val("");
        		$("#receiversDialog").val(""); 
            }
	     }); 
		msgRuleManageInput();
		loadRuleTableData();
    }


    var rulepar = {};   //声明ajax传输参数的数组变量 

	function msgRuleManageInput(){
			var dialog = $( "#dialogrulemanage-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 流转规则设置</h4></div>",
				title_html: true,
				width:800,
				height:600,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" ); 
						} 
					}
				]
			});
	}

    </script> 
    
    <!-- 子页面的 数据操作处理js 增删该查 -->
    <script type="text/javascript">

    var ruleparam = {};
    function loadRuleTableData(){
		//提示信息
        var lang = {
            "sProcessing": "处理中...",
            "sLengthMenu": "每页 _MENU_ 项",
            "sZeroRecords": "没有匹配结果",
            "sInfo": "当前第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
            "sInfoEmpty": "当前显示第 0 至 0 项，共 0 项",
            "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
            "sInfoPostFix": "",
            "sSearch": "搜索:",
            "sUrl": "",
            "sEmptyTable": "表中数据为空",
            "sLoadingRecords": "载入中...",
            "sInfoThousands": ",",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "上页",
                "sNext": "下页",
                "sLast": "末页",
                "sJump": "跳转"
            },
            "oAria": {
                "sSortAscending": ": 以升序排列此列",
                "sSortDescending": ": 以降序排列此列"
            }
        };   
		//初始化表格
    	var table = $("#ruleTable").dataTable({
    	    "dom": '<t><"col-md-4"i><"col-md-5"p><"col-md-3"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
       		language:lang,  //提示信息
        	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
            serverSide: true,  //启用服务器端分页
            searching: false,  //禁用原生搜索
            bAutoWidth:false, //自适应宽度 
            bDestroy:true,//重新加载使用
            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
            ordering:false,
            ajax: function (data, callback, settings) { 
				ruleparam.activityId = rulepar.activityId;
                ruleparam.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
                ruleparam.start = data.start;//开始的记录序号
                ruleparam.page = (data.start / data.length)+1;//当前页码
                //console.log(ruleparam);
                //ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "design/gridRule",
                    cache: false,  //禁用缓存
                    data: ruleparam,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                        //console.log(result);
                        //setTimeout仅为测试延迟效果
                        setTimeout(function () {
                            //封装返回数据
                            var returnData = {};
                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
                            returnData.recordsTotal = result.total;//返回数据全部记录
                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
                            returnData.data = result.data;//返回的数据列表
                            //console.log(returnData);
                            //调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
                            //此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
                            callback(returnData);
                        }, 200);
                        
                    }
                });
        	},
        	columnDefs: [
            	{
			    	"targets": [0], // 目标列位置，下标从0开始
			        "data": "RULE_ID", // 数据列名
			        "orderable":false,
			        "sWidth":"40px",
			        "render": function(data, type, full) { // 返回自定义内容
			       		return "<label><input type='checkbox' class='ace' id='ruleId' value = '" + data + "' /><span class='lbl' id='' value = '" + data + "'></span></label>";
			         }
                },
                {
				  	"targets": [1], // 目标列位置，下标从0开始
				   	"data": "CONTROL_NAME",
				   	 "sWidth":"20%"
                },
                {
				   	"targets": [2], // 目标列位置，下标从0开始
				   	"data": "CONTROL_TEXT", // 数据列名
				   	 "sWidth":"20%"
                },
                {
				   	"targets": [3], // 目标列位置，下标从0开始
				   	"data": "CONDITIONS_NAME", // 数据列名
				   	 "sWidth":"20%"
                },
                {
				   	"targets": [4], // 目标列位置，下标从0开始
				   	"data": "JUDGE_BASIS", // 数据列名
				   	 "sWidth":"20%"
                },
                {
				   	"targets": [5], // 目标列位置，下标从0开始
				   	"data": "GOTO_ACTIVITY_NAME", // 数据列名
				   	 "sWidth":"20%"
                }
        ]
    }).api();
    //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
    }

   //流转规则管理
  
    var thisid = null;
	$( "#btnRuleAdd" ).on('click', function(e) {
		thisid = this.id;  //获取当前点击按钮的id 
		$("#controlName").val('');
		$("#controlName").removeAttr("readonly");
		$("#conditionsName").val('');
		$("#conditionsName").removeAttr("readonly");
		$("#judgeBasis").val("");
		$("#judgeBasis").removeAttr("readonly"); 
		$("#gotoActivityName").val("");
		$("#gotoActivityName").removeAttr("readonly");  
		ruleInput(e); 
	});

	function ruleInput(e){

	    //加载下拉框信息
		$.ajax({
	        type: "POST",
	        url: "design/getControl", 
	        cache: false,  //禁用缓存
            data: rulepar,  //传入组装的参数
	        dataType: "json",
	        success: function (result) {
	   			$("#controlName").html("");  
	        	for(var i=0;i<result.data.length;i++){
	         		$("#controlName").append("<option value='"+result.data[i].CONTROL_ID+"'>"+result.data[i].CONTROL_NAME+"</option>");
	        	}
	        },
	        error:function(){	            	
	        }
	    });
		$.ajax({
	        type: "POST",
	        url: "design/getCondition", 
	        cache: false,  //禁用缓存
	        dataType: "json",
	        success: function (result) {
	   			$("#conditionsName").html("");  
	        	for(var i=0;i<result.data.length;i++){
	         		$("#conditionsName").append("<option value='"+result.data[i].SUB_ID+"'>"+result.data[i].SUB_NAME+"</option>");
	        	}
	        },
	        error:function(){	            	
	        }
	    });
		$.ajax({
	        type: "POST",
	        url: "design/getGotoActivity", 
	        cache: false,  //禁用缓存
            data: rulepar,  //传入组装的参数
	        dataType: "json",
	        success: function (result) {
	   			$("#gotoActivityName").html("");  
	        	for(var i=0;i<result.data.length;i++){
	         		$("#gotoActivityName").append("<option value='"+result.data[i].ACTIVITY_ID+"'>"+result.data[i].ACTIVITY_NAME+"</option>");
	        	}
	        },
	        error:function(){	            	
	        }
	    }); 
	    
		e.preventDefault();
			var dialog = $( "#dialogrule-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 账号设置</h4></div>",
				title_html: true, 
				width:350,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							$("#controlName").val('');
							$("#controlName").removeAttr("readonly");
							$("#conditionsName").val('');
							$("#conditionsName").removeAttr("readonly");
							$("#judgeBasis").val("");
							$("#judgeBasis").removeAttr("readonly"); 
							$("#gotoActivityName").val("");
							$("#gotoActivityName").removeAttr("readonly"); 
						}
					},
					{
						text: "保存",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							if(thisid == "btnRuleAdd"){
								rulepar.ACTIVITY_ID = rulepar.activityId;
								rulepar.CONTROL_ID = $("#controlName").val(); 
								rulepar.CONDITIONS = $("#conditionsName").val();  
								rulepar.JUDGE_BASIS = $("#judgeBasis").val(); 
								rulepar.GOTO_ACTIVITY = $("#gotoActivityName").val();
								ruleAdd(rulepar); 
			  	      			loadRuleTableData(); 
							}
							if(thisid == "btnRuleEdit"){
								rulepar.ACTIVITY_ID = rulepar.activityId;
								rulepar.CONTROL_ID = $("#controlName").val(); 
								rulepar.CONDITIONS = $("#conditionsName").val();  
								rulepar.JUDGE_BASIS = $("#judgeBasis").val(); 
								rulepar.GOTO_ACTIVITY = $("#gotoActivityName").val();
								ruleEdit(rulepar);
			  	      			loadRuleTableData(); 
							}
							$( this ).dialog( "close" );
							$("#controlName").val('');
							$("#controlName").removeAttr("readonly");
							$("#conditionsName").val('');
							$("#conditionsName").removeAttr("readonly");
							$("#judgeBasis").val("");
							$("#judgeBasis").removeAttr("readonly"); 
							$("#gotoActivityName").val("");
							$("#gotoActivityName").removeAttr("readonly"); 
						}
					}
				]
			});
	}

	//添加流转规则信息
	function ruleAdd(rulepar){ 
		$.ajax({
  	            url: 'design/addRule',
  	            data: rulepar,
  	            type: 'POST',
  		        cache: false,  //禁用缓存
  	            dataType: 'json',
  	            success: function (result) {
  	            	if(result.result == "success"){
                	parent.bootbox.alert("添加成功", function(){});
                	}else{
                		parent.bootbox.alert("添加失败", function(){});
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("添加失败", function(){});
  	            }
  	        });
	}
 
	//流转规则编辑
	$( "#btnRuleEdit" ).on('click', function(e) {
		if($("#ruleId:checked").length>1)
		{
			bootbox.alert("只能选择一个操作信息", function(){});
        	return;
		}
		thisid = this.id;  //获取当前点击按钮的id  
		editRuleAction(e);   
	});
	
	//编辑流转规则赋值方法
	function editRuleAction(e){
		rulepar.ruleId = $("#ruleId:checked").val();
	     if(rulepar.ruleId == null || rulepar.ruleId == ""){
			bootbox.alert("请先选择操作信息", function(){});
			return;
		}else{
			$.ajax({
	            url: 'design/getRuleInfo',
	            data: 'ruleId='+rulepar.ruleId,
	            type: 'POST',
		        cache: false,  //禁用缓存
	            dataType: 'json',
	            success: function (result) { 
                	$("#controlName").val(result.data[0].CONTROL_ID); 
	                $("#conditionsName").val(result.data[0].CONDITIONS);  
	                $("#judgeBasis").val(result.data[0].JUDGE_BASIS); 
	                $("#gotoActivityName").val(result.data[0].GOTO_ACTIVITY); 
	                ruleInput(e);
	            },
	            error: function(){
	            	parent.bootbox.alert("查看数据失败", function(){});
	            	return;
	            }
	        	});
		} 
	} 
	
	//流转规则的保存方法
	function ruleEdit(rulepar){ 
	    rulepar.RULE_ID = $("#ruleId:checked").val(); 
		console.log(rulepar);
		$.ajax({
	            url: 'design/editRuleInfo',
	            data: rulepar,
	            type: 'POST',
		        cache: false,  //禁用缓存
	            dataType: 'json',
	            success: function (result) {
	            	if(result.result == "success"){
		                	parent.bootbox.alert("更新成功", function(){});
	                	}else{
	                		parent.bootbox.alert("更新失败", function(){});
	                	} 
   	            },
   	            error: function(){
   	            	parent.bootbox.alert("更新数据失败", function(){});
   	            	return;
   	            }
	        	});
	}
 
	//删除流转规则信息
	$( "#btnRuleDelete" ).on('click', function(e) { 
		ruledel(rulepar); 
	});
	
	function ruledel(rulepar){
		rulepar.RULE_ID = $("#ruleId:checked").val();
	     if(rulepar.RULE_ID == null || rulepar.RULE_ID == ""){
			bootbox.alert("请先选择操作信息", function(){});
			return;
		 }else{
			bootbox.confirm("你确定要删除吗？", function(result) {
			if(result){
				var eventmgr = "";
				for(var i=0; i<$("#ruleId:checked").length;i++){
					rulepar.RULE_ID = $("#ruleId:checked")[i].defaultValue;
					$.ajax({
	    	            url: 'design/delRuleInfo',
	    	            async: false,
	    	            data: 'ruleId='+rulepar.RULE_ID,
	    	            type: 'POST',
	    	            dataType: 'json',
	    	            success: function (result) { 
	    	            	
	    	            },
	    	            error: function(){ 
	    	            	eventmgr= rulepar.ruleId+"删除失败";
	    	            }
		   	        });
	   	        }
	   	        if(eventmgr=="")
            		parent.bootbox.alert("删除成功", function(){});
	   	        else
            		parent.bootbox.alert(eventmgr, function(){});
	   	     loadRuleTableData();
			}else{
				return;
			}
		});
	  } 
	} 

	//操作者设置 
	var paramOperator = {};
	var parsOperator = {}; 
	
    function ActivityOperatorSet(nodecode){
        var flowID = params.flowID; 
        if(demo.$nodeData[nodecode].nodeId == undefined )
        {
            alert("节点数据尚未保存，请先保存节点数据");
            return;
        }
        var activityID = demo.$nodeData[nodecode].nodeId; 
 
        paramOperator.activityId = activityID;
		if(paramOperator.activityId== null || paramOperator.activityId == ""){
			bootbox.alert("请先选择操作信息", function(){});
			return;
		} 

		$.ajax({
	        type: "POST",
	        url: "design/getHandlerSetType", 
	        cache: false,  //禁用缓存
            async: false,
	        dataType: "json",
	        success: function (result) {
	   			$("#handlerSetType").html("");  
	        	for(var i=0;i<result.data.length;i++){
	         		$("#handlerSetType").append("<option value='"+result.data[i].SUB_ID+"'>"+result.data[i].SUB_NAME+"</option>");
	        	}
	        },
	        error:function(){	            	
	        }
	    });
	    
		$.ajax({
            url: 'design/getActivityInfo',
            async: false,
            data: 'activityId='+paramOperator.activityId,
            type: 'POST',
            dataType: 'json',
            success: function (result) {  
        		$("#operatorActivityCode").val(result.data[0].activityCode); 
        		$("#operatorActivityName").val(result.data[0].activityName); 
        		$("#handlerSetType").val(result.data[0].handlerSelType); 
        		//需要过滤用户
        		//全部有权限用户
        		var allUserIds = $("#receiversDialogAll").val().split(",");
        		//全部配置的用户
        		$("#receiversDialogConfig").val(result.operator);
				var configUserIds =$("#receiversDialogConfig").val().split(",");
        		//要展示的有权限且配置的用户
        		var showUserIds = _.intersection(allUserIds,configUserIds);
        		$("#receiversDialogShow").val(showUserIds);  
        		//需要隐藏的用户，是配置的用户与展示的用户的差集
        		var hideUserIds=_.difference(configUserIds, showUserIds);
        		$("#receiversDialogHide").val(hideUserIds);  
        		//要保存的编辑框是展示的内容+隐藏的内容
        		var saveUserIds=_.union(showUserIds,hideUserIds);
        		$("#receiversDialog").val(saveUserIds);  
            },
            error: function(){
        		$("#operatorActivityCode").val(""); 
        		$("#operatorActivityName").val(""); 
        		$("#handlerSetType").val(""); 
        		$("#receiversDialog").val(""); 
            }
	     });  



    	$.ajax({
            type: "POST",
            url: "wfConfigManage/SystemName", 
            cache: false,  //禁用缓存
            dataType: "json",
            success: function (result) { 
       			$("#OperatorSystem").empty();
       			$("#OperatorSystem").append("<option value=0>全部</option>");
            	for(var i=0;i<result.system.length;i++){ 
             		$("#OperatorSystem").append("<option value='"+result.system[i].systemId+"'>"+result.system[i].systemName+"</option>");
            	}
            	//网页加载时 装载树形图
				$(".tree").remove();
    			/*parsOperator.parentMenuId = -1;
				parsOperator.systemId =  $("#OperatorSystem").val();
				parsOperator.postMark = 0;
				parsOperator.modelMark = 0;
				parsOperator.activityId = -1;
    			$("#parentOperatorTree").append("<div id='treeOperatorMenu"+parsOperator.systemId+"' class='tree'></div>");
    			treeOperator(parsOperator);
    			if(parsOperator.parentMenuId == -1){
   					parsOperator.parentMenuId = 0;
   				}*/
				$("#OperatorSystem").change(function(){
					$(".tree").remove();
	    			parsOperator.parentMenuId = -1;
	    			parsOperator.postMark = 0;
	    			parsOperator.activityId = -1;
					parsOperator.systemId =  $("#OperatorSystem").val();
	    			$("#parentOperatorTree").append("<div id='treeOperatorMenu"+parsOperator.systemId+"' class='tree'></div>");
	    			treeOperator(parsOperator);
	    			if(parsOperator.parentMenuId == -1){
       					parsOperator.parentMenuId = 0;
       				}
	    		});
            }
        });
        
		 msgOperatorDialog();
    }
	//经办人
	//弹出框js函数
	function msgOperatorDialog(){ 
			var dialog = $( "#formOperatorEdit" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>操作者设置</h4></div>",
				title_html: true,
				width:400,
				height:300,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							//初始化组织树结构
				    		$("#parentTreess").css("display","none");
				    		$("#parentTreessRole").css("display","none");
				    		$("#parentTreessUser").css("display","none");
				    		$("#parentTreessPost").css("display","none");
				    		$("#receiverTreeDialog").css("display","none");
						} 
					},
					{
						text: "保存",
						"class" : "btn btn-primary btn-xs",
						click: function() { 
							saveOperator(); 
						} 
					}
				]
			});
	}
	
	$("#allCheck").on('click' , function(){
		var that = this;
		$(this).closest('table').find('tr > td:first-child input:checkbox')
		.each(function(){
			this.checked = that.checked;
			$(this).closest('tr').toggleClass('selected');
		});
	});
	 
	function treeOperator(parsOperator){
		var DataSourceTree = function (options) {
	        	this.url = options.url;
	    }
       	 DataSourceTree.prototype.data = function (options, callback) {
       	    var self = this;
       	    var $data = null;
       	    if (!("name" in options) && !("type" in options) && parsOperator.parentMenuId != -1) {
       	        parsOperator.parentMenuId = 0; //load the first level 
       	        parsOperator.activityId = paramOperator.activityId;
       	    } else if ("type" in options && options.type == "folder") {
       	        //if ("additionalParameters" in options && "children" in options.additionalParameters) {
       	        if (options.id!=0) {
       	            parsOperator.parentMenuId = options.id;
       	            parsOperator.postMark = options.postMark;
       	            parsOperator.activityId = paramOperator.activityId;
       	             parsOperator.modelMark = options.modelMark;
       	        }
       	    }
   	        $.ajax({
              type: "POST",
              url: this.url,
              cache: false,  //禁用缓存
              data:parsOperator,
              dataType: "json",
              success: function (result) {
            			console.log(result);
            			callback(result);
              },
              error:function(){
              	alert("系统树加载失败");
              }
          	});
       	};
       	$('#treeOperatorMenu'+parsOperator.systemId).ace_tree({
       		dataSource: new DataSourceTree({
       	    	url: 'design/getOperatorUserTree'
       	    }),
       	    multiSelect: true,
       	    cacheItems: true,
            folderSelect: false
       	});
       	paramOperator.handlers = [];
       	paramOperator.handlerName = [];
       	//加载grid数据（叶子节点）
       	$('#treeOperatorMenu'+parsOperator.systemId).on('selected', function(evt, data) {
         	//遍历被选中的id并且存放到数组中
         	for(var i=0; i<data.info.length; i++){
         		paramOperator.handlers[i] = data.info[i].id; 
         		paramOperator.handlerName[i] = data.info[i].name;
         	}
       	});
      	//加载grid数据（父节点）
        $('#treeOperatorMenu'+parsOperator.systemId).on('closed', function(evt, data) {
        	//paramOperator.menuId=null;//data.id;
   	     	//loadTableData();
    	});
    	$('#treeOperatorMenu'+parsOperator.systemId).on('opened', function(evt, data) {
    		//paramOperator.userId=data.id;    //把菜单id放入param中
    		parsOperator.postMark=data.postMark; 
    	});
    	 $('#treeOperatorMenu'+parsOperator.systemId).on('loaded', function(evt, data) {
        	if("item-selected" == this.additionalParameters){
        		console.log(data);
        	}
    	});
	}

	//编辑中的树形菜单信息
	function saveOperator(){
		paramOperator.handlerSetType= $("#handlerSetType").val();
		paramOperator.handlerString=$("#receiversDialog").val();
		if(paramOperator.handlerString==""){
			parent.bootbox.alert("您没有配置操作者");
			return;
		}
		$.ajax({
			cache: true,
			type: "POST",
			url: "design/addOperatorUser",
			data: paramOperator,
			dataType:"json",
			success: function(data) {
				if(data.info == "success"){
					parent.bootbox.alert("保存成功", function(){}); 
					$( "#formOperatorEdit" ).dialog( "close" );
					//初始化组织树结构
		    		$("#parentTreess").css("display","none");
		    		$("#parentTreessRole").css("display","none");
		    		$("#parentTreessUser").css("display","none");
		    		$("#parentTreessPost").css("display","none");
		    		$("#receiverTreeDialog").css("display","none");
					paramOperator.handlers = [];
				}else if(data.info == "operator"){
					parent.bootbox.alert("您没有保存操作者");
				}else{
					parent.bootbox.alert("添加失败的activityId为："+data.info, function(){});
				}
			},
               error: function (jqXHR, textStatus, errorThrown) {
             	  showError(jqXHR.responseText);
               }
		});
	}

	//通知者设置 
	var paramMsg = {};
	var parsMsg = {}; 
	
    function ActivityMessageSet(nodecode){
        var flowID = params.flowID; 
        if(demo.$nodeData[nodecode].nodeId == undefined )
        {
            alert("节点数据尚未保存，请先保存节点数据");
            return;
        }
        var activityID = demo.$nodeData[nodecode].nodeId; 
 
        paramMsg.activityId = activityID;
		if(paramMsg.activityId== null || paramMsg.activityId == ""){
			bootbox.alert("请先选择操作信息", function(){});
			return;
		}  
	    
		$.ajax({
            url: 'design/getActivityInfo',
            async: false,
            data: 'activityId='+paramMsg.activityId,
            type: 'POST',
            dataType: 'json',
            success: function (result) {  
        		$("#msgActivityCode").val(result.data[0].activityCode); 
        		$("#msgActivityName").val(result.data[0].activityName); 
        		$("#receiversDialog").val(result.operator);  
            },
            error: function(){
        		$("#msgActivityCode").val(""); 
        		$("#msgActivityName").val("");
        		$("#receiversDialog").val("");  
            }
	     });   

    	$.ajax({
            type: "POST",
            url: "wfConfigManage/SystemName", 
            cache: false,  //禁用缓存
            dataType: "json",
            success: function (result) { 
       			$("#MsgSystem").empty();
       			$("#MsgSystem").append("<option value=0>全部</option>");
            	for(var i=0;i<result.system.length;i++){ 
             		$("#MsgSystem").append("<option value='"+result.system[i].systemId+"'>"+result.system[i].systemName+"</option>");
            	}
            	//网页加载时 装载树形图
				$(".tree").remove();
    			parsMsg.parentMenuId = -1;
				parsMsg.systemId =  $("#MsgSystem").val();
				parsMsg.postMark = 0;
				parsMsg.activityId = -1;
    			$("#parentMsgTree").append("<div id='treeMsgMenu"+parsMsg.systemId+"' class='tree'></div>");
    			treeMsg(parsMsg);
    			if(parsMsg.parentMenuId == -1){
   					parsMsg.parentMenuId = 0;
   				}
				$("#MsgSystem").change(function(){
					$(".tree").remove();
	    			parsMsg.parentMenuId = -1;
	    			parsMsg.postMark = 0;
	    			parsMsg.activityId = -1;
					parsMsg.systemId =  $("#MsgSystem").val();
	    			$("#parentMsgTree").append("<div id='treeMsgMenu"+parsMsg.systemId+"' class='tree'></div>");
	    			treeMsg(parsMsg);
	    			if(parsMsg.parentMenuId == -1){
       					parsMsg.parentMenuId = 0;
       				}
	    		});
            }
        });
        
		 msgMsgDialog();
    }
	//通知者
	//弹出框js函数
	function msgMsgDialog(){ 
			var dialog = $( "#formMsgEdit" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>通知者设置</h4></div>",
				title_html: true,
				width:450,
				height:600,
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
							saveMsg(); 
						} 
					}
				]
			});
	}
	
	function treeMsg(parsMsg){
		var DataSourceTree = function (options) {
	        	this.url = options.url;
	    }
       	 DataSourceTree.prototype.data = function (options, callback) {
       	    var self = this;
       	    var $data = null;
       	    if (!("name" in options) && !("type" in options) && parsMsg.parentMenuId != -1) {
       	        parsMsg.parentMenuId = 0; //load the first level 
       	        parsMsg.activityId = paramMsg.activityId;
       	    } else if ("type" in options && options.type == "folder") {
       	        //if ("additionalParameters" in options && "children" in options.additionalParameters) {
       	        if (options.id!=0) {
       	            parsMsg.parentMenuId = options.id;
       	            parsMsg.postMark = options.postMark;
       	            parsMsg.activityId = paramMsg.activityId;
       	        }
       	    }
   	        $.ajax({
              type: "POST",
              url: this.url,
              cache: false,  //禁用缓存
              data:parsMsg,
              dataType: "json",
              success: function (result) {
            			console.log(result);
            			callback(result);
              },
              error:function(){
              	alert("系统树加载失败");
              }
          	});
       	};
       	$('#treeMsgMenu'+parsMsg.systemId).ace_tree({
       		dataSource: new DataSourceTree({
       	    	url: 'design/getMsgUserTree'
       	    }),
       	    multiSelect: true,
       	    cacheItems: true,
            folderSelect: false
       	});
       	paramMsg.msgs = [];
       	//加载grid数据（叶子节点）
       	$('#treeMsgMenu'+parsMsg.systemId).on('selected', function(evt, data) {
         	//遍历被选中的id并且存放到数组中
         	for(var i=0; i<data.info.length; i++){
         		paramMsg.msgs[i] = data.info[i].id; 
         	}
       	});
      	//加载grid数据（父节点）
        $('#treeMsgMenu'+parsMsg.systemId).on('closed', function(evt, data) {
        	//paramMsg.menuId=null;//data.id;
   	     	//loadTableData();
    	});
    	$('#treeMsgMenu'+parsMsg.systemId).on('opened', function(evt, data) {
    		//paramMsg.userId=data.id;    //把菜单id放入param中
    		parsMsg.postMark=data.postMark; 
    	});
    	 $('#treeMsgMenu'+parsMsg.systemId).on('loaded', function(evt, data) {
        	if("item-selected" == this.additionalParameters){
        		console.log(data);
        	}
    	});
	}

	//编辑中的树形菜单信息
	function saveMsg(){ 
		$.ajax({
			cache: true,
			type: "POST",
			url: "design/addMsgUser",
			data: paramMsg,
			dataType:"json",
			success: function(data) {
				if(data.info == "success"){
					parent.bootbox.alert("保存成功", function(){}); 
					$( "#formMsgEdit" ).dialog( "close" );
					paramMsg.msgs = [];
				}else{
					parent.bootbox.alert("添加失败的activityId为："+data.info, function(){});
				}
			},
               error: function (jqXHR, textStatus, errorThrown) {
             	  showError(jqXHR.responseText);
               }
		});
	}

    function ActivityPermissionSet(nodecode){
        var flowID = params.flowID; 
        if(demo.$nodeData[nodecode].nodeId == undefined )
        {
            alert("节点数据尚未保存，请先保存节点数据");
            return;
        }
        var activityId = demo.$nodeData[nodecode].nodeId; 
  
		if(activityId== null || activityId == ""){
			bootbox.alert("请先选择操作信息", function(){});
			return;
		}  
        var url="design/activityPermissionSet";
        var paramater = "?activityId="+activityId;
        window.open(url+paramater, 'projectDesign', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
	}
    
	</script>
	<script type="text/javascript">
	//点击添加接收人，弹出树结构
	 var parsOperatorAdd = {}; //加载增加接收者的树的参数
	 var operateFlag=0;
	  var datapar = {};
	  var flags = 0;
			function receiverTreeInput(){
				var dialog = $( "#receiverTreeDialog" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 接收者</h4></div>",
					title_html: true,
					width:930,
					height:400,
					buttons: [ 
						{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" );
							} 
						},
						{
							text: "确定",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								$("#receiverDialog").val(param.name);
								$( this ).dialog( "close" );
							} 
						}
					]
				});
			}
			 //加载树形结构方法
        	function treeReceiverAdd(parsOperatorAdd){         	
     	    	var params = {};  //声明保存树信息的数组
	   			params.parentOrganId = -1;
	   			tree(params);
	   			if(params.parentOrganId == -1){
	   				params.parentOrganId = 0;
	   			}
	   			function tree(params){
		   			var DataSourceTree = function (options) {
		   	        	this.url = options.url;
		    	    }
			       	 DataSourceTree.prototype.data = function (options, callback) {
			       	    var self = this;
			       	    var $data = null;
			       	    if (!("name" in options) && !("type" in options) && params.parentOrganId != -1) {
			       	        params.parentOrganId = 0; //load the first level  
			       	    } else if ("type" in options && options.type == "folder") {
			       	        if (options.id!=0) {
			       	            params.parentOrganId = options.id;
			       	        }
			       	    }
		       	        $.ajax({
		                  type: "POST",
		                  url: this.url,
		                  cache: false,  //禁用缓存
		                  data: params,
		                  dataType: "json",
		                  success: function (result) {
	                			callback(result);
	                			var cobj = $('#treeReceiverAdd .tree-folder:eq(1)')[0].childNodes[1];
					            if(result.data[0].id == 0){
					           	    cobj.click();
					            }
		                  },
		                  error:function(){
		                  	alert("系统树加载失败");
		                  }
		              	});
			       	};
		       	$('#treeReceiverAdd').ace_tree({
		       		dataSource: new DataSourceTree({
		       	    	url: 'design/getMyChildOrgan'
		       	    })
		       	});
		      	//加载grid数据（叶子节点）
		       	$('#treeReceiverAdd').on('selected', function(evt, data) {
		         	//取出ID
		         	param.organId=data.info[0].id;
		         	param.name = data.info[0].name;
		         	//调用获取用户列表的方法，在picklist中加载数据
		         	operateFlag=1;//标志是通过组织过滤
		         	getDaiFen(operateFlag);
		       	});
		      	//加载grid数据（父节点）
		        $('#treeReceiverAdd').on('closed', function(evt, data) {
		        	param.organId=null;//data.id;
		        	param.name = null;//data.name;
		    	});
		    	$('#treeReceiverAdd').on('opened', function(evt, data) {
		    		param.organId=data.id;
		    		param.name = data.name;
		    	});	
		      }
	     }
	       //点击角色账户设置中的查询按钮
		$("#searchMsg").click(function(){
			getDaiFen();
		});
		  //待分配账户
		function getDaiFen(operateFlag){
			//通过组织过滤
			datapar.operateFlag=operateFlag;
			if(operateFlag==1){
				datapar.organId = param.organId;
			}else if(operateFlag==2){
				datapar.postId = param.postId;
			}
			else if(operateFlag==3){
				datapar.roleId = param.roleId;
			}
			var cacheUserIds = ""
			for (var i = 0; i < pick.getValues().length; i++) {
				cacheUserIds += $("#pickListResult option")[i].value+",";
			}
			cacheUserIds = cacheUserIds.substring(0,cacheUserIds.length-1);
			datapar.userIds = cacheUserIds;
			$.ajax({
	            url: 'design/getUserInfoByOrganId',
	            data: datapar,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	if(flags == 0){
	            		pick = $("#pickList").pickList({data: result.data});
	            		flags++;
	            	}
            		$("#pickData").empty();
            		//pick = $("#pickList").pickList({data: result.data});            		
	            	for(var i=0;i<result.data.length;i++){
	             		$("#pickData").append("<option value='"+result.data[i].userId+"'>"+result.data[i].realName+"</option>");
	            	}
	            },
	            error: function(){
	                parent.bootbox.alert("加载失败", function(){});
	            }
	        });
	    }
	    
			//消息策略添加人员弹出框
			function messageStrategyPerson(e){
				e.preventDefault();
				var dialog = $( "#messageStrategyPerson" ).removeClass('hide').dialog({
					modal: true,
					width:860,
					height:550,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>操作者配置信息</h4></div>",
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
							"class" : "btn btn-xs btn-primary",
							 click: function() {
							 	  var userIds = "";
							 	 var pickListResultLength=pick.getValues().length;
								/* if(pickListResultLength <= 0){
						    		parent.bootbox.alert("请选择用户。", function(){});
						    	 }else{ */	    	
						    	 	$("#receiversDialogShow").val(""); 		
						       	    for(var i=0; i<pick.getValues().length; i++){ 
						       	   		userIds += $("#pickListResult option")[i].value+",";
						       	   	}	   
						       	   	userIds = userIds.substring(0,userIds.length-1);
						       	   	//展示的信息
									$("#receiversDialogShow").val(userIds);
						       	   	var hideUserIds=$("#receiversDialogHide").val().split(",");
        							//保存的信息是展示的信息+隐藏的信息
        							var showUserIds =$("#receiversDialogShow").val().split(",");
        							var saveUserIds=_.union(showUserIds,hideUserIds);
        							$("#receiversDialog").val(saveUserIds);  
								 	$( this ).dialog( "close" );
								 	flags = 0;
								 	$("#pickList").empty();
							 	//}
							 } 
						}
					]
				});
			}
			//点击添加接收人，弹出树结构
			$("#receiversDialogShow").on('click', function(e) {
				//******************************************************
				messageStrategyPerson(e);
				datapar.operateFlag=1;
				datapar.organId = 0;
				datapar.userIds = $("#receiversDialogShow").val();
				$.ajax({
		            url: 'design/getUserInfoByOrganId',
		            data: datapar,
		            type: 'POST',
		            dataType: 'json',
		            success: function (result) {
		            	if(flags == 0){
		            		pick = $("#pickList").pickList({data: result.data});
		            		flags++;
		            	}
	            		$("#pickListResult").empty();
		            	for(var i=0;i<result.dataSe.length;i++){
		             		$("#pickListResult").append("<option value='"+result.dataSe[i].userId+"'>"+result.dataSe[i].realName+"</option>");
		            	}
		            },
		            error: function(){
		                parent.bootbox.alert("加载失败", function(){});
		            }
		        });
			});
			</script>
			<script type="text/javascript">
				$(document).ready(function(){
					getMyUserIds();
				});
				function getMyUserIds(){
					$.ajax({
			            url: 'design/getMyUserList',
			            data: datapar,
			            type: 'POST',
			            dataType: 'json',
			            async:false,
			            success: function (result) {
			            	$("#receiversDialogAll").val(result.data);
			            },
			            error: function(){
			                parent.bootbox.alert("加载失败", function(){});
			            }
			        });
				}
			</script>
			<script type="text/javascript">
			 //加载树形结构方法
        	function treeReceiverPost(parsOperatorPost){         	
     	    	var params = {};  //声明保存树信息的数组
	   			params.parentOrganId = -1;
	   			tree(params);
	   			if(params.parentOrganId == -1){
	   				params.parentOrganId = 0;
	   			}
	   			function tree(params){
		   			var DataSourceTree = function (options) {
		   	        	this.url = options.url;
		    	    }
			       	 DataSourceTree.prototype.data = function (options, callback) {
			       	    var self = this;
			       	    var $data = null;
			       	    if (!("name" in options) && !("type" in options) && params.parentOrganId != -1) {
			       	        params.parentOrganId = 0; //load the first level  
			       	    } else if ("type" in options && options.type == "folder") {
			       	        if (options.id!=0) {
			       	            params.parentOrganId = options.id;
			       	        }
			       	    }
		       	        $.ajax({
		                  type: "POST",
		                  url: this.url,
		                  cache: false,  //禁用缓存
		                  data: params,
		                  dataType: "json",
		                  success: function (result) {
	                			callback(result);
	                			var cobj = $('#treeReceiverPost .tree-folder:eq(1)')[0].childNodes[1];
					            if(result.data[0].id == 0){
					           	    cobj.click();
					            }
		                  },
		                  error:function(){
		                  	alert("系统树加载失败");
		                  }
		              	});
			       	};
		       	$('#treeReceiverPost').ace_tree({
		       		dataSource: new DataSourceTree({
		       	    	url: 'design/treeReceiverPost'
		       	    })
		       	});
		      	//加载grid数据（叶子节点）
		       	$('#treeReceiverPost').on('selected', function(evt, data) {
		         	//取出ID
		         	param.postId=data.info[0].id;
		         	param.name = data.info[0].name;
		         	operateFlag=2;//标志是通过岗位过滤
		         	getDaiFen(operateFlag);
		       	});
		      	//加载grid数据（父节点）
		        $('#treeReceiverPost').on('closed', function(evt, data) {
		        	param.organId=null;//data.id;
		        	param.name = null;//data.name;
		    	});
		    	$('#treeReceiverPost').on('opened', function(evt, data) {
		    		param.organId=data.id;
		    		param.name = data.name;
		    	});	
		      }
	     }
			 //角色树结构
        	function treeReceiverRole(parsOperatorRole){         	
     	    	var params = {};  //声明保存树信息的数组
	   			params.parentOrganId = -1;
	   			tree(params);
	   			if(params.parentOrganId == -1){
	   				params.parentOrganId = 0;
	   			}
	   			function tree(params){
		   			var DataSourceTree = function (options) {
		   	        	this.url = options.url;
		    	    }
			       	 DataSourceTree.prototype.data = function (options, callback) {
			       	    var self = this;
			       	    var $data = null;
			       	    if (!("name" in options) && !("type" in options) && params.parentOrganId != -1) {
			       	        params.parentOrganId = 0; //load the first level  
			       	    } else if ("type" in options && options.type == "folder") {
			       	        if (options.id!=0) {
			       	            params.parentOrganId = options.id;
			       	        }
			       	    }
		       	        $.ajax({
		                  type: "POST",
		                  url: this.url,
		                  cache: false,  //禁用缓存
		                  data: params,
		                  dataType: "json",
		                  success: function (result) {
	                			callback(result);
	                			var cobj = $('#treeReceiverRole .tree-folder:eq(1)')[0].childNodes[1];
					            if(result.data[0].id == 0){
					           	    cobj.click();
					            }
		                  },
		                  error:function(){
		                  	alert("系统树加载失败");
		                  }
		              	});
			       	};
		       	$('#treeReceiverRole').ace_tree({
		       		dataSource: new DataSourceTree({
		       	    	url: 'design/treeReceiverRole'
		       	    })
		       	});
		      	//加载grid数据（叶子节点）
		       	$('#treeReceiverRole').on('selected', function(evt, data) {
		         	//取出ID
		         	param.roleId=data.info[0].id;
		         	param.name = data.info[0].name;
		         	operateFlag=3;//标志是通过角色过滤
		         	getDaiFen(operateFlag);
		       	});
		      	//加载grid数据（父节点）
		        $('#treeReceiverRole').on('closed', function(evt, data) {
		        	param.organId=null;//data.id;
		        	param.name = null;//data.name;
		    	});
		    	$('#treeReceiverRole').on('opened', function(evt, data) {
		    		param.organId=data.id;
		    		param.name = data.name;
		    	});	
		      }
	     }
			 
			 
        	/**
			 * picklist查询功能
			 * 参数1pickId：picklistID
			 * 参数2inputId：条件文本框ID
			 * 参数3which：要查询左边还是右边 值为left||right
			 */
			function selectPick(pickId, inputId, which) {
				if(pickId == null) {
					alert("请给selectPick方法传递picklistID值，例如：\"#Id\" 或者 \".class\"");
					return false;
				}
				if(inputId == null) {
					alert("请给selectPick方法传递id值，指定用来输入查询条件的文本框，例如：\"#Id\" 或者 \".class\"");
					return false;
				}
				if(which == "left") {
					which = "#pickData";
				} else if(which == "right") {
					which = "#pickListResult";
				} else {
					alert("请给selectPick方法传递which值，要对哪一个框查询，可传递 \"left\" 或 \"right\" ");
					return false;
				}
				$(inputId).on("input", function() {
					var count = 0,
						thisInput = $(this),
						pickList = $(pickId).find(which);
					pickList.find("option").prop("selected", false);
					pickList.find("option").each(function() {
						var thisOption = $(this);
						if(thisOption.text().indexOf(thisInput.val()) > -1 && thisInput.val() != "") {
							count++;
							thisOption.prop("selected", true);
						}
					});
					
					if(which == "#pickData") {
						$(".leftCount").text("- 查询到" + count + "条");
					}
					if(thisInput.val() == "" && which == "#pickData"){
						$(".leftCount").text("");
					}
					
					if(which == "#pickListResult") {
						$(".rightCount").text("- 查询到" + count + "条");
					}
					if(thisInput.val() == "" && which == "#pickListResult"){
						$(".rightCount").text("");
					}
				});
			}
	     </script>
	</body>
	
</html>
