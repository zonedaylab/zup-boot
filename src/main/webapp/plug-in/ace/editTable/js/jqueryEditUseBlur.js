
   
$(document).ready(function(){
    var tdNods = $('td[class!="noEdit"]');
    tdNods.click(tdClick);
    //用于需求订单管理页面
    $('#demandChangeDetailTable').on('click','td[class!="noEdit"]',tdClick);
    //用于售电公司认定基数配置页面
    $('#cardinalDataTable').on('click','td[class!="noEdit"]',tdClick);
   
});  
function tdClick(){
    var td = $(this);
    var tdText = td.text();
    td.empty();
    var input = "";
    if(td.attr("name") == "memo"){
    	input = $("<textarea rows='2' style='width:100%'></textarea>");
    	input.html(tdText);
    }else{
    	input = $("<input type='number' style='width:100%'>");
    	input.attr("value",tdText);
    }
    td.append(input);
    input.blur(function(){
        var input2 = $(this);
       //电量,价差统一保留4位小数
        var inputText = input2.val();
        var inputText2;
        if(typeof(input2.attr("type")) == "undefined"){
        	inputText2 = inputText;
        }else{
        	 inputText2 = toDecimal3(inputText);
        }
       
        var td = input2.parent("td");
        td.html(inputText2);
        //鼠标移开重新set total
        setDemandPlanTotal();
        setApplyPlanTotal();
        setPurchasePlanTotal();
        setTradeAmountTotal();
        setTradePriceTotal();
        setTotalLastActual();
        setTotalLastPlan();
        setLastOffset();
        setMonthOffset();
        setLongTradeAmountTotal();//以后可以删
        setLongAmountAndMonthAmount();//零售交易自动计算长协电量和月竞电量
        setTotalLongtermPlan();//以后可以删除
        setThisLongTrade();//本次长协成交总电量
        setLongSurplusAmount();//长协剩余电量
        td.click(tdClick);
    });
    input.keyup(function(event){
           var myEvent = event || window.event;
           var keyCode = myEvent.keyCode;
           if(keyCode == 27){
               input.val(tdText);
           }
    });
    var inputDom = input.get(0);
    inputDom.select();
    td.unbind("click");
}
