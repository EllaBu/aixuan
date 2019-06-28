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
<title>责任项值管理</title>
<style>
	.table textarea {
		width: 96%;
		height: 70px;
		margin: 0;
		resize: none;
	}
	.tab-title {
		line-height: 30px;
	}
	.tab-title a {
		display: inline-block;
		padding: 0 20px;
		color: #333;
		background-color: #eee;
	}
	.tab-title a.active {
		background-color: #2679b5;
		color: #fff;
	}
	.t-header {
		background-color: #f1f1f1;
		padding: 10px 10px 1px;
		border-radius: 4px;
		font-weight: bold;
	}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-star"></i><span class="divider"></span><span>数据字典</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>责任项维护</span><span class="divider"><i class="icon-angle-right"></i></span>
				</li>
				<li><span>责任项值管理</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>责任项值管理</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="t-header">
							<p>二级责任项：疾病身故</p>
						</div>
						<div class="tab-title  mar-t-15">
							<a href="javascript:;" class="active">全部</a>
							<a href="javascript:;">非标准项值</a>
							<a href="javascript:;">标准项</a>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						
						<table class="table table-bordered">
							<thead>
								<tr>
									<td style="width: 60px;">SN</td>
									<td style="width: 120px;">产品编号</td>
									<td>拆解项值</td>
									<td style="width: 80px;">是否是标准项</td>
									<td style="width: 80px;">操作</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>1008A</td>
									<td>
										<textarea rows="" cols=""></textarea>
									</td>
									<td>是</td>
									<td>
										<a href="javascript:;">更新</a>
									</td>
								</tr>
								<tr>
									<td>1</td>
									<td>1008A</td>
									<td>
										<textarea rows="" cols=""></textarea>
									</td>
									<td>是</td>
									<td>
										<a href="javascript:;">更新</a>
									</td>
								</tr>
								<tr>
									<td>1</td>
									<td>1008A</td>
									<td>
										<textarea rows="" cols=""></textarea>
									</td>
									<td>是</td>
									<td>
										<a href="javascript:;">更新</a>
									</td>
								</tr>
							</tbody>
						</table>
						<table class="table table-bordered">
							<thead>
								<tr>
									<td style="width: 60px;">SN</td>
									<td>拆解项值</td>
									<td style="width: 80px;">是否是标准项</td>
									<td style="width: 80px;">操作</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>
										<textarea rows="" cols=""></textarea>
									</td>
									<td>是</td>
									<td>
										<a href="javascript:;">更新</a>
									</td>
								</tr>
								<tr>
									<td>1</td>
									<td>
										<textarea rows="" cols=""></textarea>
									</td>
									<td>是</td>
									<td>
										<a href="javascript:;">更新</a>
									</td>
								</tr>
								<tr>
									<td>1</td>
									<td>
										<textarea rows="" cols=""></textarea>
									</td>
									<td>是</td>
									<td>
										<a href="javascript:;">更新</a>
									</td>
								</tr>
							</tbody>
						</table>
						<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
						<jsp:include page="../common/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
