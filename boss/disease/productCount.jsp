<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String pageName = "产品数量统计";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>产品数量统计</title>
</head>
<body>

	<div id="main-content" class="clearfix">
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据统计</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>产品数量统计</li>

			</ul>
		</div>

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>产品数量统计</h1>
			</div>
			<!--/page-header-->
			<!--<div class="row-fluid"></div>-->
			<div class="row-fluid">
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th style="width:15%;">序号</th>
										<th style="width:25%;">一级分类</th>
										<th style="width:25%;">二级分类</th>
										<th>产品数量(一级)</th>
										<th>产品数量(二级)</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- <tr>
										<td>@{getIndex}</td>
										<td>@{getTypeName}</td>
										<td>@{getSubTypeName}</td>
										<td>@{getNum}</td>
										<td>@{getSuoNum}</td>
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
<script type="text/javascript">
	var renderPage = true;
	XCOTemplate.pretreatment('listgroup');
    
	getLabelsList();
	
	/*获取标签列表*/
	function getLabelsList() {
		var xco = new XCO();

		var options = {
			url : "/productDisease/productQuantityStatistics.xco",
			data : xco,
			success : getLabelsListCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取系统用户列表成功回调*/
	function getLabelsListCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
		} else {
			data = data.getData();
			var len = 0;
			var html = "";
			if (data) {
				len = data.length;
			}
			var index = 1;
			var extendedFunction = {
				getTypeName : function(xco){
					if(xco.get("type_name")){
						return xco.get("type_name");
					}
					return "";
				},
				getSubTypeName : function(xco){
					if(xco.get("sub_type_name")){
						return xco.get("sub_type_name");
					}
					return "";
				},
				getNum : function(xco){
					if(xco.get("num")){
						return xco.get("num");
					}
					return "";
				},
				getSuoNum : function(xco){
					if(xco.get("sub_num")){
						return xco.get("sub_num");
					}
					return "";
				},
				getIndex: function(xco){
					return index++;
				},
				
			};
 			for (var i = 0; i < len; i++) {
 				var a = data[i].get("type_id");
				html += XCOTemplate.execute('listgroup', data[i], extendedFunction);
			}
			document.getElementById('listgroup').innerHTML = html;
		}
	}
</script>