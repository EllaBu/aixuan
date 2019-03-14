<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "分类维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>编辑一级分类</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../dictionary/seriesList.jsp">分类维护</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><a>编辑一级分类</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑一级分类</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="width:70%;float: left;">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>一级名称</label>
								<input type="text" class="form-control" id="seriesName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>分类排序</label>
								<input type="text" class="form-control" id="sort" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="updateLevelOne">保存</button>
								<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid mar-t-15" style="width:27%;float: right;">
					<div class="span12">
						<table border="0" id="table_bug_report" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>一级分类名</th>
									<th>排序</th>
								</tr>
							</thead>
							<tbody id="listgroup">
								<!-- 
								<tr>
									<td>#{list[i].series_name}</td>
									<td>#{list[i].sort}</td>
								</tr>
								 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var seriesNo = getURLparam("seriesNo");
	getOneSeries();

	/* 获取单个分类详情 */
	function getOneSeries(){
		var xco = new XCO();
		xco.setLongValue("seriesNo", seriesNo);
		
		var options = {
			url : "/dic/getOneSeries.xco",
			data : xco,
			success : getOneSeriesCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取单个分类详情成功回调 */
	function getOneSeriesCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			var xco = data.getData();
			$("#seriesName").val(xco.getStringValue("series_name"));
			$("#sort").val(xco.getIntegerValue("sort"));
		}
	}

	//修改按钮点击事件监听
	$("#updateLevelOne").click(function(){
		var xco = new XCO();
		xco.setLongValue("seriesNo", seriesNo);
		
		var seriesName = $("#seriesName").val();
		if(seriesName){
			xco.setStringValue("seriesName",seriesName);
		}else{
			axError("请输入一级分类名称");
			return;
		}
		
		var sort = $("#sort").val();
		if(sort){
			xco.setIntegerValue("sort",sort);
		}else{
			axError("请输入分类排序");
			return;
		}
		
		xco.setStringValue("typeName","");
		xco.setStringValue("remark1","");
		xco.setStringValue("sys_op_log","编辑一级分类-编辑："+seriesName);
		var options = {
			url : "/dic/updateSeries.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						location.href="../dictionary/seriesList.jsp";
					});
				}
			}
		};
		axConfirm("确定保存一级分类吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/seriesList.jsp";
	})
	
	XCOTemplate.pretreatment('listgroup');
	
	getSeriesList();
	/* 获取分类列表 */
	function getSeriesList() {
		var xco = new XCO();
		var options = {
			url : "/dic/oneLevelSeriesList.xco",
			data : xco,
			success : getSeriesListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取分类列表成功回调 */
	function getSeriesListCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		var data = xco.getData();
		if (null == data) {
			return;
		}
		
		var total = 0;
		total = data.getIntegerValue("total");
		var len = 0;
		var list = data.getXCOListValue("list");
	
		var html = "";
		if (list) {
			len = list.length;
		}
		
		for (var i = 0; i < len; i++) {
			data.setIntegerValue("i", i);
			html += XCOTemplate.execute('listgroup', data, null);
		}
		document.getElementById('listgroup').innerHTML = html;
	}
</script>