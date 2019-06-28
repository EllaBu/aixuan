<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项";
%>
<jsp:include page="/common/comm_css.jsp"></jsp:include>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>添加特殊标准项</title>
<style>
table p {
	margin-bottom: 3px;
}
.search-container input[type="text"] {
	height: 30px;
}
table {
	font-size: 13px;
}

</style>
</head>
<body>
	<div class="clearfix">
		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
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
										<!-- 通用部分 -->
										<jsp:include page="./common_search.jsp" />
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
										<th>选择</th>
										<th>标准项名称</th>
										<th>所属器官</th>
										<th>所属检查项</th>
										<th>相关险种</th>
										<th>使用数据源</th>
										<th>相关子集</th>
										<th>状态</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input class="ace" type="checkbox" /><span class="lbl"></span>
										</td>
										<td>甲状腺结节</td>
										<td>肝肺</td>
										<td>甲状腺彩超胸部正位</td>
										<td>重疾险</td>
										<td>体检医院 健康告知</td>
										<td>
											<p>爱康</p>
											<p>天方达</p>
										</td>
										<td>临时</td>
										<td>2019-06-13</td>
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
                            <button class="btn  btn-info mar-l-15" id="search" type="reset">添加到特殊范围</button>
                        </div>
                    </div>
               	</div>
			</div>
		</div>
	</div>
</body>
</html>
<!-- basic scripts -->
<script src="/js/jquery-1.11.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<!-- page specific plugin scripts -->

<!--[if lt IE 9]>
    <script type="text/javascript" src="/js/excanvas.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="/js/xco-1.0.1.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js" ></script>
<script type="text/javascript" src="/js/xco.databinding-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.jquery-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.template-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.validate-1.0.1.js"></script>
<script type="text/javascript" src="/js/xco.variable-1.0.1.js"></script>
<!-- ace scripts -->
<script src="/js/ace-elements.min.js"></script>
<script src="/js/ace.min.js"></script>
<script type="text/javascript" src="/js/bootstrap-datepicker.min.js"
	charset="utf-8"></script>
<script type="text/javascript" src="/js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="/js/jqPaginator.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/autocomplete.js"></script>
<script src="/js/layer/layer.js"></script>
