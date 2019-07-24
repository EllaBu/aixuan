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
<title>修改产品规则</title>
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
	height: 36px;
	line-height: 36px;
	margin: -1px 0 10px;
	border-bottom: 1px solid #ddd;
	background-color: #e6e6e6;
}
.tab-title a {
	float: left;
	width: 200px;
	text-align: center;
	color: #666;
}
.tab-title a:hover {
	text-decoration: none;
}
.tab-title a.active {
	background-color: #f7f7f7;
	font-weight: bold;
	height: 37px;
	color: #3096d9;
}
.tab-row {
	background: #f7f7f7;
	border: 1px solid #ddd !important;
	margin-top: -4px;
}

.tab-wrap {
	padding: 5px 10px;
}
table input[type="text"] {
	margin-bottom: 0;
	width: 80%;
}

.user-add-save {
	margin: 10px 10px 0 0;
	width: auto;
}
.tab-wrap table tbody div.point {
	background-color: #ff9933;
	padding: 4px 0;
}
.btns-tool {
	padding: 50px 0 10px;
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
			<li><span>修改产品规则</span><span class="divider"></span></li>
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
							<label><span style="color:red;"></span>当前版本</label>
							<input type="text" class="form-control" id="" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label><span style="color:red;"></span>产品分类</label>
							<select>
								<option>重疾险</option>
								<option>重疾险</option>
							</select>
						</div>
						<div class="from-group mar-t-15">
							<label><span style="color:red;"></span>创建时间</label>
							<input type="text" class="form-control" id="" placeholder="">
						</div>
					</div>						
				</div>	
			</div>
			<div class="form-title">规则信息</div>
			<div class="row-fluid">
				<div class="span12 tab-row">
				<div class="tab-title">
					<a class="active" href="javascript:;">已选择的规则</a>
					<a href="javascript:;">所有规则</a>
				</div>
				<div class="tab-wrap">
					<%-- <jsp:include page="./common_search.jsp" /> --%>
					<%@ include file="./common_search.jsp"%>
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>选择</th>
								<th>标准项</th>
								<th>器官</th>
								<th>检查项</th>
								<th>相关险种</th>
								<th>影响</th>
								<th>评点分</th>
								<th>辅助单位</th>
								<th>数值下线</th>
								<th>数值上线</th>
								<th>前置条件</th>
								<th>重要项</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input class="ace" type="checkbox"/><span class="lbl"></span>
								</td>
								<td>甲状腺结节</td>
								<td>甲状腺</td>
								<td>甲状腺彩超</td>
								<td>重疾险</td>
								<td>
									<select>
										<option>预警</option>
										<option>预警</option>
										<option>预警</option>
									</select>
								</td>
								<td>
									<div class="point" title="提示显示信息">
										<input type="text"/>
									</div>									
								</td>
								<td>mm</td>
								<td>
									<input type="text"/>
								</td>
								<td>
									<input type="text"/>
								</td>
								<td>
									<input type="text"/>
								</td>
								<td>
									<input class="ace" type="checkbox"/><span class="lbl"></span>
								</td>
								<td>2019-06-13</td>
								<td>
									<a href="javascript:;">原始描述</a>
									<a href="javascript:;">分布统计</a>
									<a href="javascript:;">删除</a>
								</td>
							</tr>
						</tbody>
					</table>
					<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
					<jsp:include page="../common/page.jsp" />
					<div class="btns-tool">
						<button class="user-add-save" type="reset">批量删除</button>
						<button class="user-add-save" type="reset">保存-当前版本</button>
						<button class="user-add-save" type="reset">保存-新版本</button>
						<button class="user-add-save" type="reset">导出规则</button>
					</div>
				</div>
				<div class="tab-wrap">
					<%-- <jsp:include page="./common_search.jsp" /> --%>
					<%@ include file="./common_search.jsp"%>
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>选择</th>
								<th>标准项</th>
								<th>器官</th>
								<th>检查项</th>
								<th>相关险种</th>
								<th>影响</th>
								<th>评点分</th>
								<th>辅助单位</th>
								<th>数值下线</th>
								<th>数值上线</th>
								<th>前置条件</th>
								<th>重要项</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input class="ace" type="checkbox"/><span class="lbl"></span>
								</td>
								<td>甲状腺结节</td>
								<td>甲状腺</td>
								<td>甲状腺彩超</td>
								<td>重疾险</td>
								<td>
									<select>
										<option>预警</option>
										<option>预警</option>
										<option>预警</option>
									</select>
								</td>
								<td>
									<input type="text"/>
								</td>
								<td>mm</td>
								<td>
									<input type="text"/>
								</td>
								<td>
									<input type="text"/>
								</td>
								<td>
									<input type="text"/>
								</td>
								<td>
									<input class="ace" type="checkbox"/><span class="lbl"></span>
								</td>
								<td>2019-06-13</td>
								<td>
									<a href="javascript:;">原始描述</a>
									<a href="javascript:;">分布统计</a>
									<a href="javascript:;">删除</a>
								</td>
							</tr>
						</tbody>
					</table>
					<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
					<jsp:include page="../common/page.jsp" />
					<div class="btns-tool">
						<button class="user-add-save" type="reset">批量删除</button>
					</div>
				</div>
				</div>
			</div>					
		</div>
		
	</div>
</div>
<script> 
$(".tab-wrap:eq(1)").hide();
$(".tab-title a").click(function() {
	$(this).addClass("active").siblings().removeClass("active")
	$(".tab-wrap").css("display","none").eq($(this).index()).css("display","block")
})
</script>
</body>
</html>

