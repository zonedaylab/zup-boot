/**
 * Created by Andot on 2017/7/5.
 */
var AntTree = {
    getSetting:function(){
        // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
        var setting = {
            check:{
                enable:true,
                chkStyle:"checkbox"
            },
            view: {
                showIcon: true,
                nameIsHTML: true
            },
            callback:{
                onClick: nodeClick,
                onCheck: nodeCheck,
                onDblClick: nodeDbClick,
                onCollapse: nodeClose,
                onExpand: nodeOpen
            },
            check:{
                enable:true
            },
            async:{
            	enable:true
            }
        };
        return setting;
    },
    getAndNodes: function(model){
        return model;
    },
    getNodesId: function(obj){
        var ids = new Array();
        var nodes = obj.getCheckedNodes(true);
        var j = 0;
        for(var i=0; i<nodes.length; i++){
            if(!nodes[i].open){
                ids[j] = nodes[i].tId.split('_')[1];
                console.log("复选框选中的第"+i+"个Id为："+nodes[i].tId.split('_')[1]);
            }
            j++;
        }
    }
}

//节点点击事件
function nodeClick(event, treeId, treeNode){
    console.log("节点ID====="+treeNode.id);
    console.log("节点名称====="+treeNode.name);
    console.log("节点是否打开====="+treeNode.open);
}
//获取复选框选中的值
function nodeCheck(event, treeId, treeNode){
    console.log(treeNode);
    console.log("节点ID====="+treeNode.tId.split('_')[1]);
    console.log("节点名称====="+treeNode.name);
    console.log("节点是否打开====="+treeNode.open);
}
//节点双击事件
function nodeDbClick(event, treeId, treeNode){
    console.log("节点ID====="+treeNode.id);
    console.log("节点名称====="+treeNode.name);
    console.log("节点是否打开====="+treeNode.open);

}
//获取复选框选中的id
function getNodesId(){
    antExportMethod.getNodesId(antTreeObj);
}
//节点打开事件
function nodeOpen(event, treeId, treeNode){
    console.log("节点ID====="+treeNode.id);
    console.log("节点名称====="+treeNode.name);
    console.log("节点是否打开====="+treeNode.open);
}
//节点关闭事件
function nodeClose(event, treeId, treeNode){
    console.log("节点ID====="+treeNode.id);
    console.log("节点名称====="+treeNode.name);
    console.log("节点是否打开====="+treeNode.open);
}


// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
var setting = {
    check:{
        enable:true,
        chkStyle:"checkbox"
    },
    view: {
        showIcon: true,
        nameIsHTML: true
    },
    callback:{
        onClick: nodeClick,
        onCheck: nodeCheck,
        onDblClick: nodeDbClick,
        onCollapse: nodeClose,
        onExpand: nodeOpen
    },
    check:{
        enable:true
    }
};

var model = {
    id:"0",
    name:"系统菜单",
    /*iconOpen:"icon iconfont ad-folder-open",
     iconClose:"icon iconfont ad-folder-close",
     antType:"class",*/
    iconOpen:"<i class='icon iconfont ad-folder-open' style='color:#3498DB'></i>",
    iconClose:"<i class='icon iconfont ad-folder-close' style='color:#3498DB'></i>",
    antType:"html",
    open:true,
    children:[
        {
            id:"1",
            name:"系统设置",
            iconOpen:"<i class='icon iconfont ad-folder-open' style='color:#3498DB'></i>",
            iconClose:"<i class='icon iconfont ad-folder-close' style='color:#3498DB'></i>",
            antType:"html",
            children:[
                {
                    name:"菜单管理",
                    icon:"<i class='icon iconfont ad-file' style='color:#3498DB'></i>",
                    antType:"html"
                },
                {
                    name:"菜单操作项",
                    icon:"<i class='icon iconfont ad-file' style='color:#3498DB'></i>",
                    antType:"html"
                }
            ]
        },
        {
            id:"2",
            name:"组织管理",
            iconOpen:"<i class='icon iconfont ad-folder-open' style='color:#3498DB'></i>",
            iconClose:"<i class='icon iconfont ad-folder-close' style='color:#3498DB'></i>",
            antType:"html",
            children:[
                {
                    name:"组织管理",
                    icon:"<i class='icon iconfont ad-file' style='color:#3498DB'></i>",
                    antType:"html"
                },
                {
                    name:"用户管理",
                    icon:"<i class='icon iconfont ad-file' style='color:#3498DB'></i>",
                    antType:"html"
                },
                {
                    name:"岗位管理",
                    icon:"<i class='icon iconfont ad-file' style='color:#3498DB'></i>",
                    antType:"html"
                }
            ]
        }
    ]
}

// zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
var zNodes = [
    model
];