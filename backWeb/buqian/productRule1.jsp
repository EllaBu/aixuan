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
<title>产品管理规则</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>首页</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>产品管理规则</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>产品管理规则</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
						  	<div class="row-fluid">
	                            <div class="span3">
	                                <label>产品名称</label> 
									<input type="text" class="form-control" id="std_code" placeholder="请输入标准项编码"> 
	                            </div>
	                            <div class="span3">
	                               <label>产品分类</label>
									<select class="form-control" id="std_type">
										<option>选择</option>
										<option>分类</option>
									</select> 
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
										<th>规则编号</th>
										<th>产品名称</th>
										<th>保险公司</th>
										<th>产品分类</th>
										<th>规则数量</th>
										<th>版本数量</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>XB00125</td>
										<td>优选重疾一号</td>
										<td>爱康</td>
										<td>重疾险</td>
										<td>30</td>
										<td>2</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
											<a href="javascript:;">修改规则</a>
											<a href="javascript:;">导出</a>
											<a href="javascript:;">复制</a>
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
<script type="text/javascript">

</script>