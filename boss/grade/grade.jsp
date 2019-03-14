<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "产品总表";
%>
<%@ include file="../common/menu_and_navbar_ung.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>产品打分</title>
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
	<div id="selectView">
		<!--
		 <select class="form-control wid200 ov" oc_id='#{oc_id}' onchange="change(this,#{oc_id})">
			<option value="0">请选择</option>
			@{options}
		</select>
		 -->
	</div>
	<div id="checkboxView">
		<!--
			 <input type="checkbox" name="#{oc_id}" value="#{ov_value}" @{checked} class="ace ck#{oc_id} ov" oc_id='#{oc_id}' ov_id='#{ov_id}' onchange="changeCK(this,#{oc_id})">
			 <span class="lbl">#{ov_name}</span>
			 </br>
		 -->
	</div>
	<div id="radioView">
		<!--
			<input type="radio" name="#{oc_id}" value="#{ov_value}" @{checked} class="ace ov" oc_id='#{oc_id}' ov_id='#{ov_id}' onchange="change(this,#{oc_id})">
			<span class="lbl">#{ov_name}</span>
			 </br>
		-->
	</div>
	<div id="lastTr">
		<!--
			<tr>
				<td>最终分数</td>
				<td></td>
				<td class="tl"></td>
				<td class="tl"></td>
				<td class="tl"></td>
				<td id="totalScore">@{totalScore}</td>
			</tr>
		-->
	</div>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-star"></i><span class="divider"></span><span>保险产品</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>产品总表</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>产品打分</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1 id="type"><i class="icon-th-list"></i></h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="t-header">
							<p id="productNo">产品编号：</p>
							<p id="productName">产品名称：</p>
							<p id="subTypeName">产品分类：</p>
						</div>
						<table class="table table-bordered">
							<thead>
								<td >分项类型</td>
								<td>分项名称</td>
								<td class="tl">打分项</td>
								<td>选项原始分</td>
								<td>分项占比</td>
								<td>分项得分</td>
							</thead>
							<tbody id="grade_temp">
							<!--
							<tr>
								@{firstColumn}
								<td>#{oc_name}</td>
								<td class="tl">
									@{contentView}
								</td>
								<td id="#{oc_id}">#{oldValueShow}</td>
								<td>#{oc_ratio/100}%</td>
								<td oc_ratio="#{oc_ratio}" id="r#{oc_id}">#{total}</td>
							</tr>
							-->
							</tbody>
						</table>
						<table class="table table-bordered" style="display: none">
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
							<button class="user-add-save" type="button" style="margin-left: 0;" onclick="save()">保存</button>
							<button class="user-add-save" type="button" style="margin-left: 20px;" onclick="javaScript:history.go(-1)">返回</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="../js/grade.js?version=20190128"></script>
</body>
</html>
