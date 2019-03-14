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
<style>
.tl {
	text-align: left !important;
}
.color1 {
	background-color: #c6e9f2;
}
.color2 {
	background-color: #f6e0d4;
}
.color3 {
	background-color: #f3ebbd;
}
.color4 {
	background-color: #f0ebd5;
}
.color5 {
	background-color: #dfdff5;
}
table tr:last-of-type {
	background-color: #ddd;
}
.t-header {
	background-color: #f1f1f1;
	padding: 10px 10px 1px;
	border-radius: 4px;
	/* color: #2679b5; */
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-star"></i><span class="divider"></span><span>医学管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>评分列表</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>评分列表</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="t-header">
							<p>产品编号：1090010</p>
							<p>产品名称：光大永明至爱家传终身保险</p>
						</div>
						<table class="table table-bordered">
							<tr>
								<td rowspan="3" class="color1">基本信息</td>
								<td>等待期</td>
								<td class="tl">
									<select class="form-control wid200">
										<option value="0">请选择</option>
										<option value="1">90天及以内</option>
										<option value="2">90天及以内</option>
										<option value="3">90天及以内</option>
									</select>
								</td>
								<td>10</td>
							</tr>
							<tr>
								<td>犹豫期</td>
								<td class="tl">
									<input type="checkbox" name="" checked class="ace">
									<span class="lbl">90天及以内</span>
									<br/>
									<input type="checkbox" name="" class="ace">
									<span class="lbl">90天及以内</span>
								</td>
								<td>10</td>
							</tr>
							<tr>
								<td>缴费期间</td>
								<td class="tl">
									<input type="radio" name="jiaofei" value="1" checked class="ace">
									<span class="lbl">启用</span>
									<br/>
									<input type="radio" name="jiaofei" value="0" class="ace">
									<span class="lbl">停用</span>
								</td>
								<td>10</td>
							</tr>
							<tr>
								<td rowspan="2" class="color2">保险责任</td>
								<td>身故</td>
								<td class="tl"></td>
								<td>2</td>
							</tr>
							<tr>
								<td>全残</td>
								<td class="tl"></td>
								<td>12</td>
							</tr>
							<tr>
								<td class="color3">免除责任</td>
								<td>免除数量</td>
								<td class="tl"></td>
								<td>2</td>
							</tr>
							<tr>
								<td rowspan="3" class="color4">创新点</td>
								<td>优选产品</td>
								<td class="tl"></td>
								<td>2</td>
							</tr>
							<tr>
								<td>终末期疾病提前给付</td>
								<td class="tl"></td>
								<td>12</td>
							</tr>
							<tr>
								<td>养老转换</td>
								<td class="tl"></td>
								<td>12</td>
							</tr>
							<tr>
								<td>最终分数</td>
								<td>分数</td>
								<td class="tl"></td>
								<td>90</td>
							</tr>
						</table>
						<div class="from-group">
							<button class="user-add-save" type="reset" style="margin-left: 0;">保存</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
