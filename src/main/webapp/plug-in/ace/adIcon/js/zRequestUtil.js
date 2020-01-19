/**
 * title：JQuery Ajax pre 
 * desc：first create one object，var zone = new Zone();  zone.get(options); 
 * method name is request type
 * author： andot
 * version： 1.0.0
 * date：2018-10-26
 * param： options this is json object
 * 	url：request net address
 *  async：synchronize status
 *  data: transmission data param
 *  success: this is option data success callback function
 * */

(function(){
	var Zone = function(){}
	
	Zone.prototype.post = function(options){
		$.ajax( {
			type : "POST",
			async : options.async, 
            url: options.url, 
            data: JSON.stringify(options.data),
			contentType:'application/json;charset=utf-8',
			dataType : "json",
			success : function(result) { 
				options.success(result);
			},
            error : function(XMLHttpRequest, textStatus, errorThrown) {
                alert("添加数据出现异常，请联系管理员告知异常信息："+textStatus,"error");
            }
		});
	}
	
	Zone.prototype.put = function(options){
		$.ajax( {
			type : "PUT",
			async : options.async, 
            url: options.url, 
            data: JSON.stringify(options.data),
			contentType:'application/json;charset=utf-8',
			dataType : "json",
			success : function(result) { 
				options.success(result);
			},
            error : function(XMLHttpRequest, textStatus, errorThrown) {
            	alert("编辑数据出现异常，请联系管理员告知异常信息："+textStatus,"error");
            }
		});
	}
	
	Zone.prototype.del = function(options){
		$.ajax( {
			type : "DELETE",
			async : options.async, 
            url: options.url,
			dataType : "json",
			success : function(result) { 
				options.success(result);
			},
            error : function(XMLHttpRequest, textStatus, errorThrown) {
            	bootbox.alert("删除数据出现异常，请联系管理员告知异常信息："+textStatus,"error");
            }
		});
	}
	
	Zone.prototype.get = function(options){
		$.ajax( {
			type : "GET",
			async : options.async, 
            url: options.url,
            data: options.data,
			dataType : "json",
			success : function(result) { 
				options.success(result);
			},
            error : function(XMLHttpRequest, textStatus, errorThrown) {
            	alert("获取数据出现异常，请联系管理员告知异常信息："+textStatus,"error");
            }
		});
	}
	
	window.Zone = Zone;
}())