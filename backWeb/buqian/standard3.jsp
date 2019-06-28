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
<title>核保操作管理</title>
<style>
table p {
	margin-bottom: 3px;
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
				<li><span>核保操作管理</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>核保操作管理</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline">
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
							              	<dt>评分点选择</dt>
							              	<dd>
							              		<input class="ace" type="radio" /><span class="lbl">爱选</span>
							              		<input class="ace" type="radio" /><span class="lbl">慕再</span>
							              		<input class="ace" type="radio" /><span class="lbl">太平再</span>
							              	</dd>			
							            </dl>
							            <dl class="search-wrap">
							              	<dt>评分点选择</dt>
							              	<dd>
							              		<input type="text" style="width:166px;" />
							              		<input type="text" style="width:166px;" />
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
										<th>标准项名称</th>
										<th>所属器官</th>
										<th>检查项</th>
										<th>相关险种</th>
										<th>影响</th>
										<th>评分点来源</th>
										<th>评分点</th>
										<th>条件</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
										</td>
									</tr>
									<tr>
										<td>1</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>预警</td>
										<td>慕再</td>
										<td>30</td>
										<td>>3.8</td>
										<td>2019-06-13</td>
										<td>
											<a href="javascript:;">编辑</a>
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
