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
<title>新增二级分类</title>
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
				<li><a>新增二级分类</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>新增二级分类</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="width:70%;float:left;">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>一级名称</label>
								<select id="fId" class="form-control" onchange="getSeriesList()"></select>
							</div>
							<div class="from-group mar-t-15">
								<label>二级名称</label>
								<input type="text" class="form-control" id="seriesName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>前端显示名称</label>
								<input type="text" class="form-control" id="typeName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>分类排序</label>
								<input type="text" class="form-control" id="sort" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>是否导入价格分</label>
								<label class="pos-rel" style="text-align: left;width: auto;">
									<input type="radio" class="ace" name="remark1" value="Y"/>
									<span class="lbl">是</span>
								</label>
								<label class="pos-rel" style="text-align: left;width: auto;">
									<input type="radio" class="ace" name="remark1" value="" checked="checked"/>
									<span class="lbl">否</span>
								</label>
							</div>
							<div class="from-group mar-t-15"
								style="position: relative;top:20px;">
								<label style="position: relative;bottom:48px;">分类说明</label>
								<textarea class="form-control" style="resize:none;overflow-x:hidden" cols="40" rows="5" id="content"
				                    name="content" maxlength="100" value="" onkeyup="this.value=this.value.substring(0, 100)" placeholder="最多可输入100字"></textarea>
							</div>
							<div class="from-group" style="margin-top:20px;">
								<label></label>
								<span id="text-count2" value="">0</span>/100
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="addLevelTwo">添加</button>
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
									<th>二级分类名</th>
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

	$('#content').keyup(function() {
        var len=this.value.length;
        $('#text-count2').text(len);
    });
    
	//初始化一级名称
	initSelectOption("fId","/dic/oneLevelSeriesList.xco","series_no","series_name");

	//添加按钮点击事件监听
	$("#addLevelTwo").click(function(){
		var xco = new XCO();
		
		var seriesName = $("#seriesName").val();
		if(seriesName){
			xco.setStringValue("seriesName",seriesName);
		}else{
			axError("请输入二级分类名称");
			return;
		}
		var typeName = $("#typeName").val();
		if(typeName){
			xco.setStringValue("typeName",typeName);
		}else{
			axError("请输入二级前端显示名称");
			return;
		}
		
		var sort = $("#sort").val();
		if(sort){
			xco.setIntegerValue("sort",sort);
		}else{
			axError("请输入分类排序");
			return;
		}
		
		var remark1 = $("input[name='remark1']:checked").val();
		xco.setStringValue("remark1",remark1);
		
		var content = $("#content").val();
		if(content){
			xco.setStringValue("content",content);
		}else{
			axError("请输入分类说明");
			return;
		}

		var fId = $("#fId").val();
		if(fId){
			xco.setLongValue("fId",fId);
		}else{
			axError("请选择一级分类");
			return;
		}
		
		xco.setIntegerValue("level",2);
		xco.setStringValue("sys_op_log","新增二级分类-新增："+seriesName);
		var options = {
			url : "/dic/addSeries.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("添加成功！",function(){
						location.href="../dictionary/seriesList.jsp";
					});
				}
			}
		};
		axConfirm("确定添加二级分类吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/seriesList.jsp";
	})
	
	XCOTemplate.pretreatment('listgroup');
	
	/* 获取分类列表 */
	function getSeriesList() {
		var fId = $("#fId").val();
		var xco = new XCO();
		xco.setLongValue("fId",fId);
		xco.setIntegerValue("level",2);
		
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