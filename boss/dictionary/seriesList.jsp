<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String pageName = "分类维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>分类维护</title>
</head>
<body>

	<div id="main-content" class="clearfix">
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a>分类维护</a></li>

			</ul>
			<!--.breadcrumb-->
		</div>
		<!--#breadcrumbs-->

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>分类维护</h1>
			</div>
			<!--/page-header-->
			<!--<div class="row-fluid"></div>-->
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addLevelOne" type="reset">新增一级分类</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addLevelTwo" type="reset">新增二级分类</button>
	                       </div>
                        </div>
					</div>
				</div>
				<div class="row-fluid">
                    <div class="row-fluid mar-t-15">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>一级分类名称</th>
										<th>二级分类名称</th>
										<th>前端显示名称</th>
										<th>二级分类序号</th>
										<th>分类说明</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup"></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	var renderPage = true;//分页
	var getAllSeriesList = [];//分类列表
	var treeNode = null;
	var treeMap = null;
	var serialNum = 0;//序号

	
	/* 获取分类列表 */
	function getSeriesList() {
		var xco = new XCO();
		var options = {
			url : "/dic/getSeriesList.xco",
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
		
		var total = data.getXCOValue("total");
		if(total==0){
			return;
		}

		getAllSeriesList = data.getXCOListValue("list");
		listToTree();
		
		var html = traversalTree(treeNode);
		document.getElementById('listgroup').innerHTML = html;
	}

	function traversalTree(node){
		var html = '';
		if(null != node.parent){
			
			var seriesName1 = '';
			var seriesName2 = '';
			var typeName = node.typeName;
			var sort = '';
			var opt = node.opt;
			var content = node.content;
			
			if(node.level == 1){
				seriesName1 = node.seriesName;
			} else {
				seriesName2 = node.seriesName;
				sort = node.sort;
			}
			
			html += '<tr>';
			html += '	<td>'+(++serialNum)+'</td>';
			html += '	<td>'+seriesName1+'</td>';
			html += '	<td>'+seriesName2+'</td>';
			html += '	<td>'+typeName+'</td>';
			html += '	<td>'+sort+'</td>';
			html += '	<td>'+content+'</td>';
			if(node.level==1){
				html += '	<td><a href="updateLevelOne.jsp?seriesNo='+opt+'">编辑</a></td>';
			}else{
				html += '	<td><a href="updateLevelTwo.jsp?seriesNo='+opt+'">编辑</a></td>';
			}
			html += '</tr>';
		}
		var children = node.children;
		for(var i=0; i<children.length; i++){
			html += traversalTree(children[i]);
		}
		return html;
	}
	
	function listToTree() {
		treeNode = {
			parent : null,
			seriesNo : '0',
			seriesName : '',
			typeName : '',
			level : 0,
			sort : '',
			opt : '',
			children : []
		};
		treeMap = [];
		treeMap[treeNode.seriesNo] = treeNode;
		var len = getAllSeriesList.length;
		for ( var i = 0; i < len; i++) {
			var xco = getAllSeriesList[i];
			var parent = treeMap['' + xco.get('f_id')];
			var node = {
				parent : parent,
				seriesNo : '' + xco.get('series_no'),
				seriesName : xco.get('series_name'),
				typeName : xco.get('type_name'),
				level : xco.get('level'),
				content : xco.get('content'),
				sort : xco.get('sort'),
				opt : xco.get('series_no'),
				children : []
			};
			if (parent) {
				parent.children.push(node);
			} else {
				throw "Missing parent:" + xco.get('series_name');
			}
			treeMap[node.seriesNo] = node;
		}
	}
	
	getSeriesList();
	
	/* 新增一级分类按钮点击事件 */
	$("#addLevelOne").click(function(){
		location.href="../dictionary/addLevelOne.jsp";
	})

	/* 新增二级分类按钮点击事件 */
	$("#addLevelTwo").click(function(){
		location.href="../dictionary/addLevelTwo.jsp";
	})
</script>