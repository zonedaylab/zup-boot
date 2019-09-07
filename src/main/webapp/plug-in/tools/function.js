
//下拉列表加载年份：应该获取服务器时间
  function getSchemeYear(){	
        var myDate= new Date(); 
		var startYear=myDate.getFullYear();//起始年份 
		var endYear=myDate.getFullYear()+1;//结束年份 
	    $("#schemeYearQuery").html(""); 
   	    $("#schemeYearQuery").append("<option value=''></option>");		  
		for (var i=startYear;i<=endYear;i++) 
		{ 
			$("#schemeYearQuery").append("<option value='"+i+"'>"+i+"</option>");
		} 
	}
   
 //可编辑表格非空验证
   var flag = true;
	function tdIsEmptyValidate(){
		   var trList = $("#tab tbody").children("tr");
		   var num = 0
		   trList.each(function(){
			   if(num < (trList.length)){
				   var tdList = $(this).find("td");
				   var num2 = 0;
				   tdList.each(function(){
					  if(num2 < (tdList.length)){
						  var thisTd = $(this).html();
						  if(thisTd == ""){
							  flag = false;   					
							  return false;
						  }
					  }
					  num2++;
				   });
				   if(flag == false){
					 alert("表格内容不允许有空值");
					 return false;
				   }
			   }
			 	num++;
		   });
		if(flag == true){
			alert("ok");
			saveTableData();
		}
	}
	//售电公司需求电量求和
	function setDemandPlanTotal(){
		var total = 0;
		$(".demandAmountDemand").each(function(){
	   		var count = 0;
	   		var value = $(this).html();
	   		if(value == ""){
	   			count = 0;
	   		}else{
	   			count = parseFloat(value);
	   		}
	   		total += count;
	   	});
		$("#demandPlanDemand").html(toDecimal3(total));
	}
	//售电公司请购计划，请购计划总量
	function setApplyPlanTotal(){
		var total = 0;
		$(".applyAmountTd").each(function(){
	   		var count = 0;
	   		var value = $(this).html();
	   		if(value == ""){
	   			count = 0;
	   		}else{
	   			count = parseFloat(value);
	   		}
	   		total += count;
	   	});
		$("#applyAmountTotal").html(toDecimal3(total));
	}
	//售电公司采购计划，采购计划总量
	function setPurchasePlanTotal(){
		var total = 0;
		$(".purchaseAmountPurchase").each(function(){
	   		var count = 0;
	   		var value = $(this).html();
	   		if(value == ""){
	   			count = 0;
	   		}else{
	   			count = parseFloat(value);
	   		}
	   		total += count;
	   	});
		$("#purchaseAmountTotal").html(toDecimal3(total));
	}
	//售电公司采购订单，计算采购电量
	function setTradeAmountTotal(){
		var total = 0;
		$(".tradeAmount").each(function(){
	   		var count = 0;
	   		var value = $(this).html();
	   		if(value == ""){
	   			count = 0;
	   		}else{
	   			count = parseFloat(value);
	   		}
	   		total += count;
	   	});
		$("#tradeAmountTotal").html(toDecimal3(total));
	}
	//售电公司采购订单，计算采购价格
	function setTradePriceTotal(){
		var total = 0;
		$(".tradePrice").each(function(){
	   		var count = 0;
	   		var value = $(this).html();
	   		if(value == ""){
	   			count = 0;
	   		}else{
	   			count = parseFloat(value);
	   		}
	   		total += count;
	   	});
		$("#tradePriceTotal").html(toDecimal3(total));
	}
    //去年实际用电量合计
	function setTotalLastActual(){
    	var total = 0;
    	$(".lastActual").each(function(){
    		var count = 0;
    		var value = $(this).html();
    		if(value == ""){
    			count = 0;
    		}else{
    			count = parseFloat(value);
    		}
    		total += count; 
    	});
    	$("#lastActualTotal").html(toDecimal3(total));
    }
    //去年计划电量
	function setTotalLastPlan(){
    	var total = 0;
    	$(".lastPlan").each(function(){
    		var count = 0;
    		var value = $(this).html();
    		if(value == ""){
    			count = 0;
    		}else{
    			count = parseFloat(value);
    		}
    		total += count;
    	});
    	$("#lastPlanTotal").html(toDecimal3(total));
    }
  
	
	//本年度计划电量总和
	function setTotalPlan(){
    	var total = 0;
    	$("td[name='yearPlan']").each(function(){
    		var count = 0;
    		var value = $(this).html();
    		if(value == ""){
    			count = 0;
    		}else{
    			count = parseFloat(value);
    		}
    		total += count;
    	});
    	$("#longPlanYearTotal").html(toDecimal4(total));
    }
    
	//长协电量总和
	function setTotalLongtermPlan(){
    	var total = 0;
    	$("td[name='longtermPlan']").each(function(){
    		var count = 0;
    		var value = $(this).html();
    		if(value == ""){
    			count = 0;
    		}else{
    			count = parseFloat(value);
    		}
    		total += count;
    	});
    	$("#longtermPlanTotal").html(toDecimal4(total));
    }
	
	//已成交长协电量总和
	function setLongTradeAmountTotal(){
    	var total = 0;
    	$("td[name='longTradeAmount']").each(function(){
    		var count = 0;
    		var value = $(this).html();
    		if(value == ""){
    			count = 0;
    		}else{
    			count = parseFloat(value);
    		}
    		total += count;
    	});
    	$("#longTradeAmountTotal").html(toDecimal4(total));
    }
	
	//本次长协交易总量
	function setThisLongTrade(){
    	var total = 0;
    	$("#longtermTradeTab").find("td[name='thisLongtermTrade']").each(function(){
    		var count = 0;
    		var value = $(this).html();
    		if(value == ""){
    			count = 0;
    		}else{
    			count = parseFloat(value);
    		}
    		total += count;
    	});
    	$("#thisLongtermTradeTotal").html(toDecimal4(total));
    }
    
    //上年度偏差,以及偏差率
	function setLastOffset(){
    	var trList = $("#resalePlanTab").find("tr");
    	var num = 0;
    	trList.each(function(){
    		num += 1;
    		if(num <= trList.length){
    			
	    		var lastActual = $(this).find("td").eq(2).html();//找到该行的上年度实际电量
	    		var lastPlan = $(this).find("td").eq(3).html();//找到改行的上年度计划电量
	    		if(lastActual != "" && lastPlan != "" && parseInt(lastPlan) != 0){
	    			var lastOffset = parseFloat(lastActual) - parseFloat(lastPlan);//实际-计划
	    			var lastOffsetPercent = ( parseFloat(lastActual) - parseFloat(lastPlan))/parseFloat(lastPlan);//（实际-计划）/计划
	    			$(this).find("td").eq(4).html(toDecimal3(lastOffset));
	    			$(this).find("td").eq(5).html(toDecimal2(lastOffsetPercent*100));
	    		}else{
	    			$(this).find("td").eq(4).html("");
	    			$(this).find("td").eq(5).html("");
	    		}
    		}else{
    			return false;
    		}
    	});
	}
	 //lixin月度电量计划中自动计算月竞计划电量
     function setMonthOffset(){
    	 var trList = $("#currentYearAmount").find("tr");
     	trList.each(function(){
     		var longtermPlan = $(this).find("td").eq(1).html();//找到长协成交电量
     		var tradeAmount = $(this).find("td").eq(3).html();//找到更新计划电量
     		if(longtermPlan == ""){
     			longtermPlan = 0;
     		}
     		if(tradeAmount == ""){
     			tradeAmount = 0;
     		}
 			var longSurplusAmount = parseFloat(tradeAmount) - parseFloat(longtermPlan);
 			
 			if(longSurplusAmount<0){
 				longSurplusAmount=0;
 			}
 			$(this).find("td").eq(4).html(toDecimal3(longSurplusAmount));//长协剩余电量
     	});
    }
     //lixin零售交易中自动计算长协电量和月竞电量
     function setLongAmountAndMonthAmount(){
    	 var trList = $("#resaleTradeTable").find("tr");
     	trList.each(function(){
     		var longtermPlan = $(this).find("td").eq(1).html();//找到本年度成交电量
     		var longtRadio = $(this).find("td").eq(3).html();//长协占比
     		var monthRadio = $(this).find("td").eq(6).html();//月竞占比
     		if(longtermPlan == ""){
     			longtermPlan = 0;
     		}
 			var longAmount = parseFloat(longtermPlan)* parseFloat(longtRadio)*0.01;
 			var monthAmount = parseFloat(longtermPlan)* parseFloat(monthRadio)*0.01;
 			if(longAmount<0){
 				longAmount=0;
 			}
 			if(monthAmount<0){
 				monthAmount=0;
 			}
 			$(this).find("td").eq(4).html(toDecimal3(longAmount));//长协电量
 			$(this).find("td").eq(7).html(toDecimal3(monthAmount));//月竞电量
     	});
    }
   
     //长协剩余电量,统一保留3位小数
     function setLongSurplusAmount(){
    	
    	var trList = $("#longtermTradeTab").find("tr");
    	
    	trList.each(function(){
    		
    		
    		var longtermPlan = $(this).find("td").eq(1).html();//找到长协计划电量
    		var tradeAmount = $(this).find("td").eq(2).html();//找到已成交长协 
    		var thisTradeAmount = $(this).find("td").eq(3).html();//找到本次长协成交电量
    		if(longtermPlan == ""){
    			longtermPlan = 0;
    		}
    		if(tradeAmount == ""){
    			tradeAmount = 0;
    		}
    		if(thisTradeAmount == ""){
    			thisTradeAmount = 0;
    		}
			var longSurplusAmount = parseFloat(longtermPlan) - parseFloat(tradeAmount) - parseFloat(thisTradeAmount);
			if(longSurplusAmount<0){
				$(this).find("td").eq(5).html(0);//长协剩余电量
			}else{
				$(this).find("td").eq(5).html(toDecimal3(longSurplusAmount));//长协剩余电量
			}
    	});
    }
     
     //强制保留4位小数，如：2，会在2后面补上0000.即2.0000    电量、价差统一4位小数
     function toDecimal4(x) {
    	 var f = parseFloat(x);      
         if (isNaN(f)) {    
              return false;    
         } 
         var f = Math.round(x*10000)/10000;    
         var s = f.toString();    
         var rs = s.indexOf('.');    
         if (rs < 0) {    
             rs = s.length;    
             s += '.';    
         }    
         while (s.length <= rs + 4) {    
             s += '0';    
         }    
         return s;    
     }   
     //强制保留3位小数，如：2，会在2后面补上000.即2.000   电量、价差统一3位小数
     function toDecimal3(x) {
    	 var f = parseFloat(x);      
         if (isNaN(f)) {    
              return false;    
         } 
         var f = Math.round(x*1000)/1000;    
         var s = f.toString();    
         var rs = s.indexOf('.');    
         if (rs < 0) {    
             rs = s.length;    
             s += '.';    
         }    
         while (s.length <= rs + 3) {    
             s += '0';    
         }    
         return s;    
     }  
     //强制保留2位小数，如：2，会在2后面补上00.即2.00   计算百分比
     function toDecimal2(x) { 
	    var f = parseFloat(x);      
        if (isNaN(f)) {    
             return false;    
        } 

         var f = Math.round(x*100)/100;    
         var s = f.toString();    
         var rs = s.indexOf('.');    
         if (rs < 0) {    
             rs = s.length;    
             s += '.';    
         }    
         while (s.length <= rs + 2) {    
             s += '0';    
         }    
         return s;    
     }    
