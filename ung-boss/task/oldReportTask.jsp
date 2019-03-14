<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>历史报告任务列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>历史报告</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>任务列表</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>历史报告任务列表</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
 							 <div class="row-fluid" id="resultDiv">
	                            <div class="span4">
	                                <label>开始时间</label> 
									<input type="text" class="form-control mar-t-15 Wdate w150" id="startTime" placeholder="请选择开始时间" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd' })">
	                            </div>
	                            <div class="span4">
	                                <label>参数</label> 
									<input type="text" class="form-control mar-t-15  w150" id="param" >
	                            </div>	                            
                         	</div> 
                         	<div class="row-fluid" id="btnDiv" style="margin-top: 20px">
	                            <div class="span4">
	                            	<button class="btn btn-info"  onclick="createTask()" type="reset">生成任务</button>
									<button class="btn btn-info"  onclick="deleteData()" type="reset">清除临时表</button>
	                            </div>
	                            <span id="resultSpan"></span>
                         	 </div>                       	
						</div>
				</div>

				<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>任务总数</th>
										<th>已处理数</th>
										<th>处理状态</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>@{getIndex}</td>
										<td>#{total}</td>
										<td>#{already}</td>
										<td>@{getState}</td>
										<td>#{create_time@formatdate}</td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    XCOTemplate.pretreatment(['datalist']);
	getTaskList();
	//获取任务列表
	function getTaskList() {
		var xco = new XCO();
		var options = {
			url : "/reportTask/getTasks.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	function doRequestCallBack(data){
		if(0 != data.getCode()){
			axError(data.getMessage());
			return;
		}
		var dataList = data.getData();
		if(!dataList){
			dataList=new Array();	
		}
		var index = 1;
	    var html = '';
	    var ext = {
			getIndex: function(){
				return index++;
			},
			getState: function(xco){
				var state = xco.get("status");
				var name = "";
				if(state==0){
					name = "未处理";
				}
				if(state==10){
					name = "正在处理";
				}
				if(state==20){
					name = "处理完成";
				}
				return name;
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
	}
	//生成数据
	function createTask(){
    	var xco = new XCO();
    	var startingTime = $("#startTime").val();
    	if(startingTime){
    		xco.setStringValue("startingTime",startingTime);
    	}else{
    		axError("请选择开始时间");
    		return;
    	}
     	var param = $("#param").val();
    	if(param){
    		xco.setStringValue("param",param);
    	}else{
    		axError("请录入参数");
    		return;
    	}   	
		var options = {
			url : "/reportTask/taskGeneration.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("生成任务成功！",function(){
						window.location.reload();
					});
				}
			}
		};
		axConfirm("确定生成任务吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	};
	
	
	//清除数据
	function deleteData(){
    	var xco = new XCO();
		var options = {
			url : "/reportTask/taskClean.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("清除临时表成功！",function(){
						window.location.reload();
					});
				}
			}
		};
		axConfirm("确定清除临时表吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	
	function formatdate(time){
		var date = new Date(time);
	    var year =  date.getFullYear(),
			        month = date.getMonth() + 1,//月份是从0开始的
			        day = date.getDate(),
			        hour = date.getHours(),
			        min = date.getMinutes(),
			        sec = date.getSeconds();
			        if(day<10) day='0'+day;	
			        if(month<10) month='0'+month;
			        if(hour<10) hour= '0'+hour;
			        if(min<10) min= '0'+min;
			        if(sec<10) sec= '0'+sec;	
		var newTime = year + '-' +  month + '-' +day + ' ' +
				                hour + ':' +min + ':' +sec;
	    return newTime;         
	}
    
</script>
