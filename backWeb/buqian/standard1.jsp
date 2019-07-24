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
<title>标准项规则</title>
<style>
table p {
	margin-bottom: 3px;
}
table ul {
	list-style: none;
	margin: 0;
}
table li {
    display: inline-block;
	margin-bottom: 2px;
}	
table td {
	position: relative;
}
table .show-more {
	position: absolute;
	right: 5px;
	width: 34px;
	height: 34px;
	top: 50%;
	margin-top: -17px;
	background-color: #ddd;
	border-radius: 50%;
	text-align: center;
	line-height: 34px;
	cursor: pointer;
}
table .more-point {
	position: absolute;
	right: 8px;
	bottom: 8px;
	font-weight: bold;
	font-size: 28px;
}
.show-box {
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1111;
	background-color: #eee;
	text-align: left;
	box-sizing: border-box;
	border: 1px solid #ddd;
	display: none;
}
.show-box li {
	display: block;
	padding-left: 20px;
	line-height: 30px;
}
.show-box li:hover {
	background-color: #fff;
}
.close-more {
	position: absolute;
	top: 10px;
	right: 10px;
	display: block;
	font-size: 20px;
	z-index: 1112;
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>首页</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>标准项规则</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>标准项规则</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
						  	<div class="row-fluid">
	                            <div class="span12">
	         						<div class="search-container">
	         							<dl class="search-wrap">
							              	<dt>标准项名称</dt>
							              	<dd>
							              		<input type="text" />
							              	</dd>			
							            </dl>
	         							<jsp:include page="./common_search.jsp" />
							            <dl class="search-wrap">
							              	<dt>时间查询</dt>
							              	<dd>
							              		<input type="text" style="width: 166px;" />
							              		<input type="text" style="width: 166px;" />
							              	</dd>			
							            </dl>
									</div>                       
	                            </div>	                            
                        	</div>
                        	
						</div>
						<div class="row-fluid  mar-t-15">
                            <div class="span12">
                                <div class="form-group">
                                    <button class="btn  btn-info mar-l-15" id="search" type="reset">查询</button>
                                    <button class="btn  btn-info mar-l-15" id="search" type="reset">重置</button>
                                    <button class="btn  btn-info mar-l-15" id="search" type="reset">批量导入</button>
                                    <button class="btn  btn-info mar-l-15" id="search" type="reset">导出标准项</button>
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
										<th style="width: 4%">选择</th>
										<th style="width: 6%">标准项名称</th>
										<th style="width: 15%">所属器官</th>
										<th style="width: 12%">所属检查项</th>
										<th style="width: 15%">相关险种</th>
										<th style="width: 15%">使用数据源</th>
										<th style="width: 13%">相关子集</th>
										<th style="width: 4%">状态</th>
										<th style="width: 7%">创建时间</th>
										<th style="width: 7%">操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input class="ace" type="checkbox" /><span class="lbl"></span></td>
										<td>甲状腺结节</td>
										<td>
											<ul>
												<li>肝</li>
												<li>肺</li>
												<li>甲状腺</li>
												<li>肝</li>
												<li>肺</li>
												<li>甲状腺</li>
												<li>肝</li>
												<li>肺</li>
												<li>甲状腺</li>
											</ul>											
										</td>
										<td> 
											<ul>
												<li>甲状腺彩超</li>
												<li>胸部正位</li>
												<li>甲状腺彩超</li>
												<li>胸部正位</li>
												<li>甲状腺彩超</li>
												<li>胸部正位</li>
											</ul>
										</td>
										<td>
											<ul>
												<li>重疾险</li>
												<li>防癌险</li>
											</ul>
										</td>
										<td>
											<ul>
												<li>体检医院</li>
												<li>健康告知</li>
											</ul>
										</td>
										<td>
											<ul>
												<li>爱康</li>
												<li>天方达</li>
											</ul>
										</td>
										<td>正式</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a><br>
											<a href="javascript:;">使用记录</a><br>
											<a href="javascript:;">数据统计</a><br>
											<a href="javascript:;">审核</a>
										</td>
									</tr>
									<tr>
										<td><input class="ace" type="checkbox" /><span class="lbl"></span></td>
										<td>甲状腺结节</td>
										<td title="肝 肺 甲状腺 肝 肺 甲状腺 肝 肺 甲状腺 肝 肺 甲状腺">肝 肺 甲状腺</td>
										<td title="甲状腺彩超 胸部正位">甲状腺彩超 胸部正位</td>
										<td>
											<p>重疾险</p>
											<p>防癌险</p>
										</td>
										<td>体检医院健康告知</td>
										<td>
											<p>爱康</p>
											<p>天方达</p>
										</td>
										<td>正式</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a><br>
											<a href="javascript:;">使用记录</a><br>
											<a href="javascript:;">数据统计</a><br>
											<a href="javascript:;">审核</a>
										</td>
									</tr>
								</tbody>
							</table>
							<label class="result-total">查询结果总条数：<span id="total"></span>条</label>
							<jsp:include page="../common/page.jsp" />
						</div>
					</div>
				</div>
				<div class="row-fluid  mar-t-15">
                     <div class="span12">
                         <div class="form-group">
                             <button class="btn  btn-info mar-l-15" id="search" type="reset">批量审核</button>
                         </div>
                     </div>
               	</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
	$(function() {
		
		/* var showMore = "<div class=\"show-more\">全部</div><span class=\"more-point\">...</span>" */
		var showMore = "<span class=\"more-point\">...</span>"
		
		$("table td ul").each(function () {
			var ulLength = $(this).find("li").length;
			if(ulLength>3) {
				$(this).find("li").filter(":lt(3)").show().end().filter(":gt(2)").hide()
			}
			console.log(ulLength)
			var ulCopy = $(this).html();
			/* var moreBox = "<div class=\"show-box\"><ul>" + ulCopy + "</ul><i class=\"icon-remove close-more\"></i></div>" */
			var moreBox = "<div class=\"show-box\"><ul>" + ulCopy + "</ul></div>"
			if(ulLength > 3) {
				$(this).parents("td").append(showMore).append(moreBox);
				/* console.log("div宽度")
				console.log($(this).parents("td").width())
				$(".show-box").width($(this).parents("td").width()-5)
				console.log("后宽度" + $(".show-box").width()) */
				$(".show-box li").css("display", "block")
			}
		})
		$("table td").bind("mouseover", function() {
			/* $(this).children(".show-more").show(); */
			$(this).children(".show-box").width($(this).width()+15).show();
		}).bind("mouseout", function() {
			/* $(this).children(".show-more").hide(); */
			$(this).children(".show-box").hide();
		})
		
		/* $("table td").on("click", ".show-more", function() {
			console.log($(this).parents("td").width())
			$(this).siblings(".show-box").width($(this).parents("td").width()+15).show();
		})
		
		$("table td").on("click", ".close-more", function() {
			$(this).parents(".show-box").hide();
		}) */
	})
</script>
