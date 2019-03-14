<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "定时任务";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>定时任务列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>任务管理</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>定时任务列表<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>定时任务列表</h1>
			</div>

			<div class="row-fluid">
				<!-- <div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
							<div class="form-group" style="line-height:30px;">
                           		<label>任务标题</label>
                          		<input type="text" class="form-control w150" id="title" placeholder="任务标题">
	                       </div>
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">查询</button>
	                       </div>
                        </div>
					</div>
				</div> -->
				
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
							<div class="form-group" style="line-height: 30px;">
								<label class="mar-t-15">任务名称</label>
								<input type="text" class="form-control mar-t-15 w150" id="title" placeholder="请输入任务名称"> 
								<label class="mar-l-15 mar-t-15">任务状态</label>
								<select class="form-control mar-t-15 w150" id="state">
									<option value="">选择任务状态</option>
									<option value="0">未处理</option>
									<option value="10">处理中</option>
									<option value="100">处理完成</option>
									<option value="30">处理失败</option>
								</select> 
								<label class="mar-l-15 mar-t-15">起始日期</label> 
								<input type="text" class="form-control mar-t-15 Wdate w150" id="startTime" placeholder="预计执行起始时间" onfocus="WdatePicker({readOnly:true})"> 
								<label class="mar-l-15 mar-t-15">结束日期</label> 
								<input type="text" class="form-control mar-t-15 Wdate w150" id="endTime" placeholder="预计执行结束时间" onfocus="WdatePicker({readOnly:true})">
							</div>
                           <div class="form-group">
                           		<button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">查询</button>
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="add">新增定时任务</button>
	                       </div>
                        </div>
					</div>
				</div>
				
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
                        <div class="span12">
                            <table id="table_result_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>任务ID</th>
										<th>任务名称</th>
										<th>开始执行时间</th>
										<th>当前状态</th>
										<th>创建时间</th>
										<th>完成时间</th>
										<th>错误描述</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].task_id}</td>
										<td>#{list[i].title}</td>
										<td>#{list[i].expe_exec_time@formatDateTime}</td>
										<td>@{getState}</td>
										<td>#{list[i].create_time@formatDateTime}</td>
										<td>#{list[i].complete_time@formatDateTime}</td>
										<td>#{list[i].error_desc}</td>
										<td>@{getOpt}</td>
									</tr> -->
                                </tbody>
							</table>
                            
                            <jsp:include page="../common/page.jsp"/>
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
    $("#reset").click(function(){
		var array = ["#title","#state","#startTime","#endTime"];
		resetInput(array);
	})
	
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#find").click(function(){
		renderPage = true;
		getTimeTaskListPage(0,pageSize);
		//$("#title").val("");
	});
	
	getTimeTaskListPage(0,pageSize);
	
	/*获取定时任务列表*/
	function getTimeTaskListPage(_start,_pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);
		var title = $("#title").val();
		if(title){
			xco.setStringValue("title", title);
		}
		var state = $("#state").val();
		if(state){
			xco.setIntegerValue("state", state);
		}
		var startTime = $("#startTime").val();
		if(startTime){
			xco.setStringValue("startTime", startTime);
		}
		var endTime = $("#endTime").val();
		if(endTime){
			xco.setStringValue("endTime", endTime);
		}
		var options = {
			url : "/task/getTimeTaskListPage.xco",
			data : xco,
			success : getTimeTaskListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取定时任务列表成功回调*/
	function getTimeTaskListPageCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			var total = 0;
			data = data.getData();
			total = data.getIntegerValue("total");
			var len = 0;
			var list = data.getXCOListValue("list");
		
			var html = "";
			if (list) {
				len = list.length;
			}
			
			var extendedFunction = {
				getState : function(){
					var state = list[i].getIntegerValue("state");
					if(state == 10){
						return "处理中";
					}else if(state == 30){
						return "处理失败";
					}else if(state == 100){
						return "处理完成";
					}else{
						return "未处理";
					}
				},
				getOpt : function(){
					var state = list[i].getIntegerValue("state");
					var delId = list[i].getLongValue("task_id");
					if(state == 0){
						return "<a href=\"javascript:del("+delId+")\">删除</a>";
					}else{
						return "";
					}
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getTimeTaskListPage, pageSize);
			}
		}
	}
	
	$("#add").click(function(){
		window.location.href="../task/addTimeTask.jsp";
	});
	
	/*删除未开始的任务*/
	function del(taskId){
		var xco = new XCO();
		xco.setLongValue("task_id", taskId);
		xco.setStringValue("sys_op_log","定时任务-删除ID："+taskId);
		var options = {
			url : "/task/delSysTask.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("删除成功！",function(){
						location.href="../task/timeTaskList.jsp";
					});
				}
			}
		};
		axConfirm("确定删除定时任务吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	
	/*查看进行中的或者已完成的任务*/
	function look(taskId){
		alert("查看任务："+taskId);
	}
</script>