<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "操作日志";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>操作日志</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">权限管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>操作日志<span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>操作日志</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline">
							<div class="form-group" style="line-height: 30px;">
								<label class="mar-l-15 mar-t-15">操作员</label> 
								<input type="text" class="form-control mar-t-15 w150" id="nick_name"> 
								<label class="mar-l-15 mar-t-15">业务内容</label>
								<input type="text" class="form-control mar-t-15 w150" id="content"> 
								<label class="mar-l-15 mar-t-15">起始日期</label> 
								<input type="text" class="form-control mar-t-15 Wdate w150" id="startTime" placeholder="请选择起始日期" onfocus="WdatePicker({readOnly:true})"> 
								<label class="mar-l-15 mar-t-15">结束日期</label> 
								<input type="text" class="form-control mar-t-15 Wdate w150" id="endTime" placeholder="请选择结束日期" onfocus="WdatePicker({readOnly:true})">
							</div>
							<div class="form-group mar-l-15">
								<button class="btn mar-t-15 mar-l-15  btn-info" id="search" type="reset">查询</button>
								<button class="btn mar-t-15 mar-l-15  btn-info" id="reset" type="reset">条件重置</button>
							</div>
						</div>
					</div>
				</div>

				<div class="row-fluid">
					<div class="row-fluid mar-t-15">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>操作员</th>
										<th style="width:60%;">业务内容</th>
										<th>操作时间</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>#{i+1}</td>
										<td>#{list[i].nick_name}</td>
										<td style="text-align:left !important;">#{list[i].content}</td>
										<td>@{getTime}</td>
									</tr> -->
								</tbody>
							</table>

							<jsp:include page="../common/page.jsp" />
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
		var array = ["#nick_name","#content","#startTime","#endTime"];
		resetInput(array);
	})
	
    var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	$("#search").click(function(){
		renderPage = true;
		getOpLogList(0,pageSize);
	});
	
	$("#addProduct").click(function(){
		location.href = "../product/addProduct.jsp";
	});
	
	getOpLogList(0,pageSize);
	
	/*获取产品总列表*/
	function getOpLogList(_start,_pageSize) {
		var xco = new XCO();
		
		var nick_name = $("#nick_name").val();
		if(nick_name){
			xco.setStringValue("nickName", nick_name);
		}
		
		var content = $("#content").val();
		if(content){
			xco.setStringValue("content", content);
		}
		
		var startTime = $("#startTime").val();
		if(startTime){
			xco.setStringValue("startTime", startTime);
		}
		
		var endTime = $("#endTime").val();
		if(endTime){
			xco.setStringValue("endTime", endTime);
		}
		
		xco.setIntegerValue("start", _start);
		xco.setIntegerValue("pageSize", _pageSize);

		var options = {
			url : "/system/getOpLogList.xco",
			data : xco,
			success : getOpLogListCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取公司列表成功回调*/
	function getOpLogListCallBack(data) {
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
				getTime : function(){
					return data.getStringValue("list[i].create_time");
				}
			};
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
			if (renderPage) {
				renderPage = false;
				pageUtil('pagination_1', parseInt(total), getOpLogList, pageSize);
			}
		}
	}
</script>