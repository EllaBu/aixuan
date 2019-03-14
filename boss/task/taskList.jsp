<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "任务列表";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>任务列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-user-md"></i><a>任务管理</a><span class="divider"><i
						class="icon-angle-right"></i> </span></li>
				<li>任务列表<span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>任务列表</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
							<div class="form-group" style="line-height:30px;">
                           		<label class="mar-t-15">任务标题</label>
                          		<input type="text" class="form-control w150" id="title" placeholder="任务标题">
                          		<label class="mar-l-15 mar-t-15">当前状态</label>
								<select class="form-control mar-t-15 w150" id="state">
									<option value="">选择当前状态</option>
									<option value="0">未处理</option>
									<option value="10">处理中</option>
									<option value="100">处理完成</option>
									<option value="30">处理失败</option>
								</select> 
	                       </div>
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="find" type="reset">查询</button>
                                <button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
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
										<th>任务总数</th>
										<th>当前完成数</th>
										<th>当前状态</th>
										<th>完成时间</th>
										<th>错误描述</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{list[i].id}</td>
										<td>#{list[i].title}</td>
										<td>#{list[i].task_total}</td>
										<td>#{list[i].task_completed}</td>
										<td>@{getState}</td>
										<td>#{list[i].complete_time@formatDateTime}</td>
										<td>#{list[i].error_desc}</td>
										<td>#{list[i].create_time@formatDateTime}</td>
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

<script type="text/javascript">
	$("#reset").click(function(){
		var array = ["#title","#state"];
		resetInput(array);
	})
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#find").click(function(){
		renderPage = true;
		getTaskListPage(0,pageSize);
		//$("#title").val("");
	});
	
	getTaskListPage(0,pageSize);
	
	/*获取任务列表*/
	function getTaskListPage(_start,_pageSize) {
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
		var options = {
			url : "/task/getTaskListPage.xco",
			data : xco,
			success : getTaskListPageCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取任务列表成功回调*/
	function getTaskListPageCallBack(data) {
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
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getTaskListPage, pageSize);
			}
		}
	}
</script>