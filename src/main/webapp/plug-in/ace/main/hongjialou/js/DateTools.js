/**
 * Created by andot on 2017/4/13.
 */
var DateTools = function(){
    DateTools.prototype.getWeekDateByNowDate = function(date, day, role) {
        var d7 = new Date(date- day * 24 * 3600 * 1000);
        var myDate = new Date(d7);
        var ds = "";
        switch(role){
            case "yyyy":
                ds = myDate.getFullYear();
                break;
            case "mm":
            	var mon = (myDate.getMonth() + 1)<10?"0"+(myDate.getMonth() + 1):(myDate.getMonth() + 1);
                ds = mon;
                break;
            case "dd":
                ds = myDate.getDate();
                break;
            case "yyyy-mm":
            	var mon = (myDate.getMonth() + 1)<10?"0"+(myDate.getMonth() + 1):(myDate.getMonth() + 1);
                ds = myDate.getFullYear() + "-" + mon;
                break;
            case "mm-dd":
                ds = (myDate.getMonth() + 1) + "-" + myDate.getDate();
                break;
            case "yyyy-mm-dd":
            	var mon = (myDate.getMonth() + 1)<10?"0"+(myDate.getMonth() + 1):(myDate.getMonth() + 1);
                ds = myDate.getFullYear() + "-" + mon + "-" +
                    myDate.getDate();
                break;
            case "yyyy-mm-dd hh":
            case "yyyy":
            	var mon = (myDate.getMonth() + 1)<10?"0"+(myDate.getMonth() + 1):(myDate.getMonth() + 1);
                ds = myDate.getFullYear() + "-" + mon + "-" +
                    myDate.getDate()+" "+myDate.getHours();
                break;
            case "yyyy-mm-dd hh:mm":
            	var mon = (myDate.getMonth() + 1)<10?"0"+(myDate.getMonth() + 1):(myDate.getMonth() + 1);
                ds = myDate.getFullYear() + "-" + mon + "-" +
                    myDate.getDate()+" "+myDate.getHours()+":"+myDate.getMinutes();
                break;
            case "yyyy-mm-dd hh:mm:ss":
            	var mon = (myDate.getMonth() + 1)<10?"0"+(myDate.getMonth() + 1):(myDate.getMonth() + 1);
                ds = myDate.getFullYear() + "-" + mon + "-" +
                    myDate.getDate()+" "+myDate.getHours()+":"+myDate.getMinutes()+":"+myDate.getSeconds();
                break;
            default:
                alert("你输入的格式，我们还不支持！,请反馈给我");
                break;
        }
        console.log("你要获取的时间为："+ ds);
        return ds;
    }
};


