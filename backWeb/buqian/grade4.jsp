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
.f-tip {
	color: #2679b5;
	margin-left: 20px;
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
			<li><span>责任分配置</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>选择项</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>新增/修改</span><span class="divider"></span></li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i>新增（重疾险-[基础项目]等待期）</h1>
<!-- 			<div class="form-add-new">
                <button class="btn btn-info" type="reset">保存 ✔</button>
         	</div> -->
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选项内容</label>
								<input type="text" class="" id="std_code" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选项分值</label>
								<input type="text" class="form-control" id="std_cn_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选项顺序</label>
								<input type="text" class="form-control" id="std_key" placeholder="">
								<span class="f-tip">建议以10为单位递增</span>
							</div>
							<div class="from-group">
								<button class="user-add-save" id="add" type="reset">保存</button>
							</div>
						</div>
						
					</div>		
				</div>
			</div>
	</div>
</div>
</body>
</html>

