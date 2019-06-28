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

.tab-wrap {
	padding: 5px 10px;
}
table input[type="text"] {
	margin-bottom: 0;
	width: 80%;
}

.user-add-save {
	margin: 10px 10px 0 0;
}

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
.add-agoup {
	float: right;
	font-size: 16px;
	color: #6fb3e0;
	margin: 10px 20px;
	font-weight: bold;
}
.add-agoup:hover{
	text-decoration: none;
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
					<div class="search-container">
						<dl class="search-wrap">
			              	<dt>标准项名称</dt>
			              	<dd>
			              		<input type="text"/>			              		
			              		<!-- <button class="user-add-search" id="" type="reset">检查</button> -->
			              	</dd>			
			            </dl>
			            <dl class="search-wrap">
			              	<dt>预警编码</dt>
			              	<dd>
			              		<input type="text"/>			              		
			              	</dd>			
			            </dl>
			            <dl class="search-wrap">
			              	<dt>辅助单位</dt>
			              	<dd>
			              		<input type="text"/>
			              	</dd>			
			            </dl>
						<jsp:include page="./common_search.jsp" />
			            </div>
			            
			            <!-- <button class="user-add-search" id="" type="reset">检查</button> -->
					
					</div>						
				</div>	
			</div>
			<div class="form-title">核保信息</div>
			<div class="row-fluid">
				<div class="span12 form-inline bord1dd">

					<table class="table table-str>iped table-bordered table-hover">
						<thead>
							<tr>
								<th>SN</th>
								<th>险种</th>
								<th>影响</th>
								<th>辅助单位</th>
								<th>数值下线</th>
								<th>数值上线</th>
								<th>评点分（1）</th>
								<th>评点分（2）</th>
								<th>评点分（3）</th>
								<th>评点分（4）</th>
								<th>评点分（5）</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>
									<select>
										<option>选择</option>
										<option>重疾险</option>
										<option>防癌险</option>
									</select>
								</td>
								<td>
									<select>
										<option>选择</option>
										<option>预警</option>
										<option>拒保</option>
									</select>
								</td>
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
									<input type="text"/>
								</td>
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
									<input type="text"/>
								</td>
								<td>
									<a class="delete" href="javascript:;">删除</a>
								</td>
							</tr>
						</tbody>
					</table>
					<a href="javascript:;" class="add-agoup">新增+</a>
				</div>
			</div>					
		</div>
		<div class="row-fluid">
			<button class="user-add-save" type="reset">保存</button>
		</div>
	</div>
</div>
<script> 
var addHtml = "<tr>\n" +
        "<td>1</td>\n" +
        "<td>\n" +
        "<select>\n" +
        "<option>选择</option>\n" +
        "<option>重疾险</option>\n" +
        "<option>防癌险</option>\n" +
        "</select>\n" +
        "</td>\n" +
        "<td>\n" +
        "<select>\n" +
        "<option>选择</option>\n" +
        "<option>预警</option>\n" +
        "<option>拒保</option>\n" +
        "</select>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +        
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<input type=\"text\"/>\n" +
        "</td>\n" +
        "<td>\n" +
        "<a class=\"delete\" href=\"javascript:;\">删除</a>\n" +
        "</td>\n" +
        "</tr>"
$(".add-agoup").click(function() {
	$("table").append(addHtml)
})
$("table").on("click", ".delete", function() {
	console.log(111)
	$(this).parents("tr").remove();
})

</script>
</body>
</html>

