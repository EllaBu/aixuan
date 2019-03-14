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
<title>病种拆分管理</title>
<style>
	table > tbody tr td:nth-of-type(7) {
		text-align: left!important;
	}
	table > tbody tr td:nth-of-type(7) p {
		margin-bottom: 1px!important;
	}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>病种库</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>病种拆分管理</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>病种拆分列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="window.location.href='/medstd/addMedStd.jsp'" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
						  	<div class="row-fluid">
	                            <div class="span3">
	                                <label>产品编号：</label> 
									<input type="text" class="form-control" id="" placeholder="请输入产品编号"> 
	                            </div>
	                            <div class="span3">
	                                <label>保险公司：</label>
									<input type="text" class="form-control" id="" placeholder="请输入保险公司"> 
	                            </div>
	                             <div class="span3">
	                                <label>产品名称：</label> 
									<input type="text" class="form-control" id="" placeholder="请输入产品名称"> 
	                            </div>
	                            <div class="span3">
	                                <label>病种拆分：</label> 
									<input type="text" class="form-control" id="" placeholder="请输入病种拆分"> 
	                            </div>
                        	</div>
                        	<div class="row-fluid  mar-t-15">
	                            <div class="span3">
	                                <label>拆分项：</label>
									<input type="text" class="form-control" id="" placeholder="请输入拆分项"> 
	                            </div>
                            </div>
						</div>
						<div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn  btn-info mar-l-15" id="search" type="reset">查询</button>
                                </div>
                            </div>
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
										<th>SN</th>
										<th>产品编号</th>
										<th>产品名称</th>
										<th>保险公司</th>
										<th>病种分类</th>
										<th>病种拆分</th>
										<th>病种编号/拆分项</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<tr>
										<td>1</td>
										<td>1008A</td>
										<td>天安人寿健康源（优享）终身重大疾病保险</td>
										<td>天安人寿</td>
										<td>重症</td>
										<td>胰岛素依赖型糖尿病（I型糖尿病</td>
										<td>
											<p>[46]I型糖尿病</p>
											<p>[47]糖尿病导致双足截除</p>
										</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1008A</td>
										<td>天安人寿健康源（优享）终身重大疾病保险</td>
										<td>天安人寿</td>
										<td>重症</td>
										<td>胰岛素依赖型糖尿病（I型糖尿病</td>
										<td>
											<p>[46]I型糖尿病</p>
											<p>[47]糖尿病导致双足截除</p>
										</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1008A</td>
										<td>天安人寿健康源（优享）终身重大疾病保险</td>
										<td>天安人寿</td>
										<td>重症</td>
										<td>胰岛素依赖型糖尿病（I型糖尿病</td>
										<td>
											<p>[46]I型糖尿病</p>
											<p>[47]糖尿病导致双足截除</p>
										</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1008A</td>
										<td>天安人寿健康源（优享）终身重大疾病保险</td>
										<td>天安人寿</td>
										<td>重症</td>
										<td>胰岛素依赖型糖尿病（I型糖尿病</td>
										<td>
											<p>[46]I型糖尿病</p>
											<p>[47]糖尿病导致双足截除</p>
										</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">删除</a>
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
	</div>
</body>
</html>
