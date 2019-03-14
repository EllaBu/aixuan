<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "综合分计算（新版）";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>综合分计算（新版）</title>
<style type="text/css">
#cover {
	display: none;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.44);
}

#coverShow {
	display: none;
	position: fixed;
	z-index: 2;
	top: 50%;
	left: 50%;
	border: 0px solid #127386;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i> <span class="divider"><i class="icon-angle-right"></i> </span>任务管理<span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>综合分计算（新版）</li>
			</ul>
		</div>

		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>综合分计算（新版）</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">计算综合分的相关产品的要求：</span>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">1. 导入过价格分</p>
								<p style="margin:6px 0px 6px 60px;font-size: 14px;">2. 补充过剩余分</p>								
							</h5>
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">一. 计算产品综合分：所有产品</span>
							</h5>
							<div class="from-group mar-t-15" >
								<button class="btn btn-success" style="margin-left:140px;" type="submit"id="adjustAllScore">生成任务</button>
							</div>							
							
							
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">二. 计算产品综合分：基于选定的一级类目</span>
							</h5>
							<div class="from-group mar-t-15" style="line-height: 30px;position: relative;" id="levelOneDiv">
								<label style="display: inline-block;position: absolute;top:6px;">一级分类:</label>
								<div style="display: inline-block;width:70%;position: relative;left: 224px;">
									<button id="levelOne" class="btn btn-info" onclick="getLevelOne()">+</button>
								</div>
							</div>							
							<div class="from-group mar-t-15" >
								<button class="btn btn-success" style="margin-left:140px;" type="submit"id="adjustLevelOneScore">生成任务</button>
							</div>
							
							
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">三. 计算产品综合分：基于选定的二级类目</span>
							</h5>
							<div class="from-group mar-t-15" style="line-height: 30px;position: relative;" id="levelTwoDiv">
								<label style="display: inline-block;position: absolute;top:6px;">二级分类:</label>
								<div style="display: inline-block;width:70%;position: relative;left: 224px;">
									<button id="levelTwo" class="btn btn-info" onclick="getLevelTwo()">+</button>
								</div>
							</div>							
							<div class="from-group mar-t-15" >
								<button class="btn btn-success" style="margin-left:140px;" type="submit"id="adjustLevelTwoScore">生成任务</button>
							</div>
							
							
							
							<hr style="height:1px;border:none;border-top:1px solid #185598;width:80%;margin-top:20px;margin-left:100px;">
							<h5 style="margin-left:120px;">
								<span style="color: red;">四. 计算产品综合分：基于指定的产品</span>
								<p style="margin:6px 0px 6px 20px;font-size: 14px;">说明: 产品编号之间使用逗号（英文）隔开</p>
							</h5>
							<div class="from-group mar-t-15" style="position: relative;top:1px;">
								<textarea rows="10" cols="600" style="margin-left: 140px; width: 450px;" id="arg_info"></textarea> 
							</div>								
							<div class="from-group mar-t-15" >
								<button class="btn btn-success"  style="margin-left:140px;" type="submit"id="addOrgScoreTask">生成任务</button>
							</div>							
							
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
	//实现js在数组中直接删除指定值
   Array.prototype.indexOf = function(val) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] == val) return i;
            }
            return -1;
        };
     Array.prototype.remove = function(val) {
         var index = this.indexOf(val);
         if (index > -1) {
             this.splice(index, 1);
         }
     };
	var type_id_arr = [];
	var sub_type_id_arr = [];
	
	//计算所有综合分
	$("#adjustAllScore").click(function(){
		var xco = new XCO();
		xco.setStringValue("sys_op_log","计算产品综合分：所有产品");
 		var options = {
			url : "/calcCompScoreService/calc.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("任务提交成功，可以到'任务列表'页面查看进度。");
				}
			}
		};
		axConfirm("确定计算综合分吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
	
	//根据一级分类计算综合分
	$("#adjustLevelOneScore").click(function(){
		var xco = new XCO();
		var type_id_list = [];
		if($(".series-no-one").length!=0){
			$(".series-no-one").each(function(e,v){
				type_id_list.push($(v).attr("data-label"));
			})
			xco.setLongArrayValue("type_id_list", type_id_list);
		}else{
			axError("请选择一级分类");
			return;
		}
		xco.setStringValue("sys_op_log","计算产品综合分：基于选定的一级类目");		
 		var options = {
			url : "/calcCompScoreService/calc.xco",
			data : xco,
			success : function(data){
				//alert("xx="+data.toString());
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("任务提交成功，可以到'任务列表'页面查看进度。");
				}
			}
		};
		axConfirm("确定计算所有综合分吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})	

	//根据二级分类计算综合分
	$("#adjustLevelTwoScore").click(function(){
		var xco = new XCO();
		var sub_type_id_list = [];
		if($(".series-no-two").length!=0){
			$(".series-no-two").each(function(e,v){
				sub_type_id_list.push($(v).attr("data-label"));
			})
			xco.setLongArrayValue("sub_type_id_list", sub_type_id_list);
		}else{
			axError("请选择二级分类");
			return;
		}	
		xco.setStringValue("sys_op_log","计算产品综合分：基于选定的二级类目");	
 		var options = {
			url : "/calcCompScoreService/calc.xco",
			data : xco,
			success : function(data){
				//alert("xx="+data.toString());
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("任务提交成功，可以到'任务列表'页面查看进度。");
				}
			}
		};
		axConfirm("确定计算综合分吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})	

	//根据产品计算综合分
	$("#addOrgScoreTask").click(function(){
		var xco = new XCO();
		
		var arg_info = $("#arg_info").val();
		arg_info = arg_info.trim();
		if(","==arg_info){
			axError("请按照说明输入正确的产品编号！");
			return;			
		}
		if(arg_info){
			var orgs = [];
			var arg_array = arg_info.split(",");
			for(var i=0; i<arg_array.length; i++){
				if(orgs.includes(arg_array[i].trim())){
					axError(arg_array[i].trim()+"不可重复录入！");
					return;	
				}else{
					if(""!==arg_array[i].trim()){
						orgs.push(arg_array[i].trim());
					}
				}
			}
			xco.setStringArrayValue("product_no_list", orgs);//产品编号					
		}else{
			axError("产品编号不能为空！");
			return;		
		}
		xco.setStringValue("sys_op_log","计算产品综合分：基于指定的产品");	
 		var options = {
			url : "/calcCompScoreService/calc.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("任务提交成功，可以到'任务列表'页面查看进度。");
				}
			}
		};
		axConfirm("确定计算综合分吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})


	function getLevelOne(){
		layer.open({
			type: 1,  
	        title:'选择标签',  
	        skin:'layui-layer-rim',  
	        area:['800px', '600px'],
	        zIndex: 13,
	        content: 
            '<div class="row" style="width: 770px;  margin-left:15px; margin-top:10px;">'  
	            +'<div class="input-group scrollbar" style="margin-top:10px;overflow:auto;">'  
	           		+'<table class="table table-striped table-bordered table-hover" style="margin-top:0px;margin-bottom:0px;">' 
	       				+'<thead>' 
	       					+'<tr>' 
	       						+'<th style="width:10%;">序号</th>' 
	       						+'<th style="width:70%;">一级分类名称</th>' 
	       						+'<th style="width:20%;">操作</th>' 
	       					+'</tr>' 
	       				+'</thead>' 
	       				+'<tbody id="listgroup2">'
	       				+'</tbody>'
	       			+'</table>' 
	            +'</div>'  
	        +'</div>'
	        ,  
	        success: function(index,layero){
	        	var xco = new XCO();

	    		var options = {
	    			url : "/dic/getSeriesList.xco",
	    			data : xco,
	    			success : function(data){
	    				if (data.getCode() != 0) {
	    					axError(data.getMessage());
	    				} else {
	    					data = data.getData();
	    					var len = 0;
	    					var total = data.getXCOValue("total");
	    					var list = data.getXCOListValue("list");
	    					var html = "";
	    					if (list) {
	    						len = list.length;
	    					}
	    					
	    					if(len!=0){
	    						for(var i = 0; i<len; i++){
	    							var level = list[i].getIntegerValue("level");
	    							if(level==1){
		    							html += '<tr>';
		    							html += '	<td>'+(i+1)+'</td>';
		    							html += '	<td>'+list[i].getStringValue("series_name")+'</td>';
		    							html += '	<td><a href="javascript:callbackOne('+list[i].getLongValue("series_no")+',\''+list[i].getIntegerValue("series_name")+'\');">使用</a></td>';
		    							html += '</tr>';	    							
	    							}
	    						}
	    						$("#listgroup2").html(html);
	    					}
	    				}
	    			}
	    		};
	    		$.doXcoRequest(options);
	        },
			scrollbar:false
		});
	}
	
	function getLevelTwo(){
		layer.open({
			type: 1,  
	        title:'选择标签',  
	        skin:'layui-layer-rim',  
	        area:['800px', '600px'],
	        zIndex: 13,
	        content: 
            '<div class="row" style="width: 770px;  margin-left:15px; margin-top:10px;">'  
	            +'<div class="input-group scrollbar" style="margin-top:10px;overflow:auto;">'  
	           		+'<table class="table table-striped table-bordered table-hover" style="margin-top:0px;margin-bottom:0px;">' 
	       				+'<thead>' 
	       					+'<tr>' 
	       						+'<th style="width:10%;">序号</th>' 
	       						+'<th style="width:70%;">二级分类名称</th>' 
	       						+'<th style="width:20%;">操作</th>' 
	       					+'</tr>' 
	       				+'</thead>' 
	       				+'<tbody id="listgroup3">'
	       				+'</tbody>'
	       			+'</table>' 
	            +'</div>'  
	        +'</div>'
	        ,  
	        success: function(index,layero){
	        	var xco = new XCO();

	    		var options = {
	    			url : "/dic/getSeriesList.xco",
	    			data : xco,
	    			success : function(data){
	    				if (data.getCode() != 0) {
	    					axError(data.getMessage());
	    				} else {
	    					data = data.getData();
	    					var len = 0;
	    					var total = data.getXCOValue("total");
	    					var list = data.getXCOListValue("list");
	    					var html = "";
	    					if (list) {
	    						len = list.length;
	    					}
	    					
	    					if(len!=0){
	    						for(var i = 0; i<len; i++){
	    							var level = list[i].getIntegerValue("level");
	    							if(level==2){
		    							html += '<tr>';
		    							html += '	<td>'+(i+1)+'</td>';
		    							html += '	<td>'+list[i].getStringValue("series_name")+'</td>';
		    							html += '	<td><a href="javascript:callbackTwo('+list[i].getLongValue("series_no")+',\''+list[i].getIntegerValue("series_name")+'\');">使用</a></td>';
		    							html += '</tr>';	    							
	    							}
	    						}
	    						$("#listgroup3").html(html);
	    					}
	    				}
	    			}
	    		};
	    		$.doXcoRequest(options);
	        },
			scrollbar:false
		});
	}	
	
	function callbackOne(series_no,name){
		if(type_id_arr.includes(series_no)){
			axError("一级分类不能重复选择");
		}else{
			type_id_arr.push(series_no);
			var seriesNoLabel = '<span data-label="'+series_no+'" class="series-no-one mar-r-15 label label-success label-white middle">'+name+'&nbsp;&nbsp;<a style="color: white;" onclick="delLabel(this,1,'+series_no+');">x</a></span>';//子产品标签
    		$("#levelOne").before(seriesNoLabel);	
    		layer.closeAll("page");
		}
    	  
	}
	function callbackTwo(series_no,name){
		if(sub_type_id_arr.includes(series_no)){
			axError("二级分类不能重复选择");
		}else{
			sub_type_id_arr.push(series_no);
			var seriesNoLabel = '<span data-label="'+series_no+'" class="series-no-two mar-r-15 label label-success label-white middle">'+name+'&nbsp;&nbsp;<a style="color: white;" onclick="delLabel(this,2,'+series_no+');">x</a></span>';//子产品标签
	    	$("#levelTwo").before(seriesNoLabel);
	    	layer.closeAll("page"); 
		}
	}	
	
	/* 删除label标签 */
	function delLabel(e,index,series_no){
		if(index==1){
			type_id_arr.remove(series_no);
		}else{
			sub_type_id_arr.remove(series_no);
		}
		$(e).parent().remove();
	}
</script>