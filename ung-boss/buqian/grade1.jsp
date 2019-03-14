<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>评分列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-star"></i><span class="divider"></span><span>打分管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>责任分配置</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>责任分配置</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<table class="table table-bordered">
							<thead>
								<tr>
								<td>SN</td>
								<td>分类名称（一级）</td>
								<td>分类名称（二级）</td>
								<td>操作</td>
							</tr>
							</thead>
							<tbody>
								<tr>
								<td>1</td>
								<td>重大疾病保险</td>
								<td>重大疾病保险</td>
								<td>
									<a href="javascript:;">配置</a>
									<a href="javascript:;">重新计算</a>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>终身寿险</td>
								<td>终身寿险</td>
								<td>
									<a href="javascript:;">配置</a>
									<a href="javascript:;">重新计算</a>
								</td>
							</tr>
							<tr>
								<td>3</td>
								<td>定期寿险</td>
								<td>定期寿险</td>
								<td>
									<a href="javascript:;">配置</a>
									<a href="javascript:;">重新计算</a>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
