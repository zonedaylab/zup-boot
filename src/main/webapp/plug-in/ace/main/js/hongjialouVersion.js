/**
 * Created by xie yan on 6/19/2016.
 * 获取系统的时间
 * 显示在顶部菜单栏
 */

$(document).ready(function(){
	$("#version").html("能效管理系统由积成提供技术支持 Version 1.0.0");
	$("#edsVersion").html("能效管理系统由积成提供技术支持 Version beta 0.1");
	$("#esaleVersion").html("版权归积成能源有限公司所有 Version 1.0");
	//页面动态时间
    setInterval(function () {
        var mydate = new Date();
        var year = mydate.getFullYear()+"年";
        var month = (mydate.getMonth()+1)+"月";
        var day = mydate.getDate()+"日";
        var h = mydate.getHours()+":";
        var m = mydate.getMinutes()+":";
        var s = mydate.getSeconds();
        var ymd = year+month+day;
        var hms = h+m+s;
        var ymdhm = year+month+day+" "+h+mydate.getMinutes();
        $("#nowTimeYMD").html(ymdhm);
        $("#nowTimeHMS").html(hms);
    },1000);
});

