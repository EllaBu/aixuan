<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "数值引擎";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>生成文件</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>生成文件</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>生成文件</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>生成文件列表</h1>
				<!-- <div class="form-add-new">
					<button class="btn btn-success" id="addProduct" onclick="window.location.href='/medstd/addNumberEngin.jsp'" type="reset">+新增</button>
           		</div> -->
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
							 <div class="row-fluid">

	                            <div class="span4">
									<button class="btn btn-info" id="" type="reset">生成数据</button>
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
										<th>文件名</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<tr>
										<td>1</td>
										<td>文件名称。。</td>
										<td>
											<a href="javascript:;">下载</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>文件名称。。</td>
										<td>
											<a href="javascript:;">下载</a>
											<a href="javascript:;">删除</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>文件名称。。</td>
										<td>
											<a href="javascript:;">下载</a>
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
