/*
	jQuery Autocomplete(自动完成)
*/

(function($){
	$.extend({
		setAutoComplete : function(parameter){
			var ain = $(parameter.ainId);//搜索输入框
			var url = parameter.url || '';//请求地址
			
			var now_ain;//当前输入框
			ain.focus(function(){
				now_ain = $(this);
			})
			
			ain.autocomplete({
				autoFocus:parameter.isAutoFocus||false,//如果设为true，在菜单显示时，将默认选中第一项。
				minLength : parameter.minLength||1,//默认值为 1。指定触发自动完成的最小输入字符数，如果输入的字符小于该长度，将不会触发自动完成功能。将该值设为0，可以在不输入字符的情况下显示菜单
				delay : 500,
				source : function(request, response) {//指定显示菜单的数据来源，必须指定该参数。
					var xco = new XCO();
					if(parameter.setXCO){
						if(typeof parameter.setXCO=="function"){
							xco = parameter.setXCO(now_ain);
						}
					}else{
						xco.setStringValue("inputValue",now_ain.val());
					}
					var options = {
						url : url,
						data : xco,
						success : function(data){//请求成功回调
							data = data.getData();
							var list = data.getXCOListValue("list");
							if(null!=list){
								if(list.length!=0){
									response($.map(list, function(item) {
										if(parameter.callback){
											if(typeof parameter.callback=="function"){
												return parameter.callback(item);
											}
										}
									}));
								}
							}else{
								axError("暂无匹配数据！");
								now_ain.val("");
							}
						}
					};
					$.doXcoRequest(options);
				},
				focus : function(event, ui) {
					if(parameter.focus){
						if(typeof parameter.focus=="function"){
							parameter.focus(now_ain,ui.item)
						}
					}
					return false;
				},
				select : function(event, ui) {
					if(parameter.select){
						if(typeof parameter.select=="function"){
							parameter.select(now_ain,ui.item)
						}
					}
					return false;
				}
			});
		},
		setAutoComplete2 : function(parameter){
			var ain = $(parameter.ainId);//搜索输入框
			var url = parameter.url || '';//请求地址
			
			var now_ain;//当前输入框
			ain.focus(function(){
				now_ain = $(this);
			})
			
			ain.autocomplete({
				autoFocus:parameter.isAutoFocus||false,//如果设为true，在菜单显示时，将默认选中第一项。
				minLength : parameter.minLength||1,//默认值为 1。指定触发自动完成的最小输入字符数，如果输入的字符小于该长度，将不会触发自动完成功能。将该值设为0，可以在不输入字符的情况下显示菜单
				delay : 500,
				source : function(request, response) {//指定显示菜单的数据来源，必须指定该参数。
					var xco = new XCO();
					if(parameter.setXCO){
						if(typeof parameter.setXCO=="function"){
							xco = parameter.setXCO(now_ain);
						}
					}else{
						xco.setStringValue("inputValue",now_ain.val());
					}
					var options = {
						url : url,
						data : xco,
						success : function(data){//请求成功回调
							data = data.getData();
							var list = data.getXCOListValue("list");
							if(null!=list){
								if(list.length!=0){
									response($.map(list, function(item) {
										if(parameter.callback){
											if(typeof parameter.callback=="function"){
												return parameter.callback(item);
											}
										}
									}));
								}
							}else{
								axError("暂无匹配数据！");
							}
						}
					};
					$.doXcoRequest(options);
				},
				focus : function(event, ui) {
					event.preventDefault();
					return false;
				},
				select : function(event, ui) {
					event.preventDefault();
					return false;
				}
			});
		}
	})
})(jQuery);