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
<title>新增标准项</title>
<style>
.user-add-search {
	display: inline-block;
	width: 80px;
	height: 30px;
	line-height: 30px;
	background-color: #6fb3e0;
	color: #fff;
	border-radius: 4px;
	border: none;
	margin-left: 10px;
}
.form-title {
	background-color: #6fb3e0;
	color: #fff;
	height: 40px;
	line-height: 40px;
	margin-top: 15px;
	padding-left: 10px;
}
.form-title a {
	float: right;
	font-size: 20px;
	margin: 10px;
	cursor: pointer;
	color: #fff;
}
.form-title a:hover {
	text-decoration: none;
}
.split-item {
	display: inline-block;
}
.split-item p input:first-of-type {
	width: 100px;
}
.split-item p input:last-of-type {
	width: 232px;
}
.split-item span {
	margin-left: 10px;
}
.split-item a {
	display: inline-block;
	width: 40px;
	text-align: center;
	font-size: 20px;
	color: #333;
	font-weight: bold;
}
.split-item a:hover {
	color: #6fb3e0;
}
.add-agoup {
	float: right;
	font-size: 30px;
	color: #6fb3e0;
	margin: 20px;
}
.add-agoup:hover{
	text-decoration: none;
}
.user-add-save {
	margin-left: 0;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><i class="icon-star"></i><span class="divider"></span><span>病种库</span>
				<span class="divider"><i class="icon-angle-right"></i> </span>
			</li>
			<li><span>病种拆分管理</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>新增/修改</span><span class="divider"></span></li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i>新增</h1>
<!-- 			<div class="form-add-new">
                <button class="btn btn-info" type="reset">保存 ✔</button>
         	</div> -->
		</div>
		<div class="row-fluid">
			<div class="form-title">基本项</div>
			<div class="row-fluid">
				<div class="span12">
					<div class="form-inline form-inline-detail bord1dd form-add1">
						<div class="from-group mar-t-15">
							<label><span style="color:red;">*</span>产品编号</label>
							<input type="text" class="" id="" placeholder="">
							<button class="user-add-search" id="" type="reset">检查</button>
						</div>
						<div class="from-group mar-t-15">
							<label><span style="color:red;"></span>产品名称</label>
							<input type="text" class="form-control" id="" placeholder="" readonly>
						</div>
						<div class="from-group mar-t-15">
							<label><span style="color:red;"></span>保险公司</label>
							<input type="text" class="form-control" id="" placeholder="" readonly>
						</div>
					</div>						
				</div>	
			</div>
			<div class="form-title">拆分组 <a href="javascript:;" class="icon-remove"></a></div>
			<div class="row-fluid">
				<div class="span12" style="margin-top: -4px;">
					<div class="form-inline form-inline-detail bord1dd form-add1">
						<div class="from-group mar-t-15">
							<label><span style="color:red;">*</span>标准病种编号</label>
							<input type="text" class="" id="" placeholder="">
							<button class="user-add-search" id="" type="reset">检查</button>
						</div>
						<div class="from-group mar-t-15">
							<label></label>
							<input type="text" class="form-control" id="" placeholder="" readonly>
						</div>
						<div class="from-group mar-t-15">
							<label style="vertical-align: top; margin-top: 3px;">拆分项</label>
							<div class="split-item">
								<p>
									<input type="text">
									<input type="text">
									<span>请填写条款编号和拆分项</span>
								</p>
								<p>
									<input type="text">
									<input type="text">
									<a class="add-split" href="javascript:;">+</a>
								</p>
								<p>
									<input type="text">
									<input type="text">
									<a class="delete-split" href="javascript:;">-</a>
								</p>
							</div>
						</div>
					</div>						
				</div>	
			</div>					
		</div>
		<div class="row-fluid">
			<button class="user-add-save" id="add" type="reset">保存</button>
			 <a href="javascript:;" class="icon-plus add-agoup"></a>
		</div>
	</div>
</div>
<script> 
	$(".split-item").on("click", ".add-split", function () {
		var addHtml = "<p><input type=text>\n" +
							"<input type=text>\n" +
							"<a class=delete-split href=javascript:;>-</a>\n" +
						"</p>"
		$(".split-item").append (addHtml)
	})
	$(".split-item").on("click", ".delete-split", function () {
		$(this).parents("p").remove();
	})
</script>
</body>
</html>

