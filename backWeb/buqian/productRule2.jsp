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
<title>新增/修改</title>
<style>
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
.tab-title {
	height: 40px;
	line-height: 40px;
}
.tab-title a {
	display: inline-block;
	width: 100px;
	text-align: center;
	color: #666;
}
.tab-row {
	background: #f7f7f7;
	border: 1px solid #ddd !important;
	margin-top: -4px;
}

.user-add-save {
	margin: 10px 10px 0 0;
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
			<li><span>产品规则管理</span><span class="divider"><i class="icon-angle-right"></i></span></li>
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
			<div class="form-title">基本信息</div>
			<div class="row-fluid">
				<div class="span12">
					<div class="form-inline form-inline-detail bord1dd form-add1">
						<div class="from-group mar-t-15">
							<label><span style="color:red;">*</span>产品名称</label>
							<input type="text" class="" id="" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label><span style="color:red;"></span>产品分类</label>
							<select>
								<option>重疾险</option>
								<option>重疾险</option>
							</select>
						</div>
						<div class="from-group mar-t-15">
							<label>保险公司</label>
							<input type="text" class="" id="" placeholder="">
						</div>
					</div>						
				</div>	
			</div>
			<div class="form-title">数据范围（标签）</div>
			<div class="row-fluid">
				<div class="span12 tab-row">
					<jsp:include page="./common_search.jsp" />
				</div>
			</div>
			<div class="form-title">数据范围（特殊） <a href="javascript:;" class="icon-plus"></a> </div>
			<div class="row-fluid">
				<div class="span12">
					<div class="form-inline form-inline-detail bord1dd form-add1">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>SN</th>
									<th>标准项名称</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>甲状腺结节</td>
									<td><a href="javascript:;">删除</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>					
		</div>
		<div class="row-fluid">
			<button class="user-add-save" type="reset">保存</button>
		</div>
	</div>
</div>
<script> 

</script>
</body>
</html>

