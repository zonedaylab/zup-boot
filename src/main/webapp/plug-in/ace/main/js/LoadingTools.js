/**
 * Created by andot on 2017/7/20.
 */
var css = "";
var LoadingTools = function(){
	LoadingTools.prototype.start = function(btnId, loadingName, ajaxFun) {
		css = $("#"+btnId+"").attr('class');
		$("#"+btnId+"").attr("class", css+" disabled");
        $("#"+btnId+"").html("<i class='fa fa-spinner fa-pulse' id></i>"+loadingName+"...");
        setTimeout(ajaxFun, 100);
    }
	
	LoadingTools.prototype.end = function(btnId, loadedName) {
        $("#"+btnId+"").html(loadedName);
        $("#"+btnId+"").attr("class", css);
    }
};


