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
<title>责任分配置详情</title>
<style>
.t-title {
	display:box;
	display:-webkit-box;
	display:-webkit-flex;
	display:-moz-box;
	display:-ms-flexbox;
	display:flex; 
	margin: 15px 0 10px 0;
	font-weight: bold;
	font-size: 16px;
}
.t-title li {
	-prefix-box-flex: 1; 
	-webkit-box-flex: 1; 
	-webkit-flex: 1; 
	-moz-box-flex: 1; 
	-ms-flex: 1; 
	flex: 1;
	list-style: none;
	margin: 0;
}
.t-title li:last-of-type {
	text-align: right;
	font-weight: normal;
}
.t-title li:last-of-type a {
	font-size: 14px;
	color: red;
	margin-left: 6px;
}
.t-title span {
	font-weight: normal;
}
.table {
	margin-top: 0;
}
.table td {
	width: 33%;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-star"></i><span class="divider"></span><span>打分管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>责任分配置</span><span class="divider"><i class="icon-angle-right"></i></span>
				</li>
				<li><span>详情</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>重疾险</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="window.location.href='/medstd/addMedStd.jsp'" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">

				<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12">
							<!-- <div class="t-title">
								<h4>[基础项目]等待期</h4>
								<p>
									<a href="javascript:;">编辑</a>
									<a href="javascript:;">添加子项</a>
								</p>
							</div> -->
							<ul class="t-title">
								<li>[基础项目]等待期</li>
								<li>打分类型：<span>责任</span></li>
								<li>分项类型：<span>基本信息</span></li>
								<li>选择类型：<span>列表</span></li>
								<li>顺序：<span>顺序</span></li>
								<li>
									<a href="javascript:;">编辑</a>
									<a href="javascript:;">添加子项</a>
								</li>
							</ul>
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>选择项目</th>
										<th>对应分数</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>90天及以内</td>
										<td>20</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>91-120天</td>
										<td>10</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>121-180天</td>
										<td>5</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
								</tbody>
							</table>
							
							<ul class="t-title">
								<li>[基础项目]等待期</li>
								<li>打分类型：<span>责任</span></li>
								<li>分项类型：<span>基本信息</span></li>
								<li>选择类型：<span>列表</span></li>
								<li>顺序：<span>顺序</span></li>
								<li>
									<a href="javascript:;">编辑</a>
									<a href="javascript:;">添加子项</a>
								</li>
							</ul>
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>选择项目</th>
										<th>对应分数</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>90天及以内</td>
										<td>20</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>91-120天</td>
										<td>10</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>121-180天</td>
										<td>5</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
								</tbody>
							</table>
							
							<ul class="t-title">
								<li>[基础项目]等待期</li>
								<li>打分类型：<span>责任</span></li>
								<li>分项类型：<span>基本信息</span></li>
								<li>选择类型：<span>列表</span></li>
								<li>顺序：<span>顺序</span></li>
								<li>
									<a href="javascript:;">编辑</a>
									<a href="javascript:;">添加子项</a>
								</li>
							</ul>
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>选择项目</th>
										<th>对应分数</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>√</td>
										<td>20</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>-</td>
										<td>0</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
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