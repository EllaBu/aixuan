<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String pageName = "菜单管理";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>菜单管理</title>
</head>
<body>

	<div id="main-content" class="clearfix">
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">权限管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a>菜单管理</a></li>

			</ul>
			<!--.breadcrumb-->
		</div>
		<!--#breadcrumbs-->

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>菜单管理</h1>
			</div>
			<!--/page-header-->
			<!--<div class="row-fluid"></div>-->
			<div class="row-fluid">
				<div class="span12">
					<table id="table_bug_report"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>一级</th>
								<th>二级</th>
								<th>地址</th>
								<!-- <th>操作</th> -->
							</tr>
						</thead>
						<tbody id="listgroup"><!-- 
							<tr>
								<td>@{getName1}</td>
								<td>@{getName2}</td>
								<td>#{$$DATA[i].menu_url}</td>
							</tr>
						--></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	//
	var renderPage = true;
	var gAllMenuList = [];
	var userMenu = '';
	var treeNode = null;//权限数表
	var treeMap = null;

	XCOTemplate.pretreatment('listgroup');
	
	/* 获取菜单列表 */
	function getMenuList(start, pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		var options = {
			url : "/system/getMenuList.xco",
			data : xco,
			success : getMenuListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取菜单列表成功回调 */
	function getMenuListCallBack(xco) {
		if (0 != xco.getCode()) {
			alert(xco.getMessage());
			return;
		}
		var data = xco.getData();
		if (null == data) {
			return;
		}

		gAllMenuList = data;
		listToTree();
		
		var html = traversalTree(treeNode);
		document.getElementById('listgroup').innerHTML = html;
	}

	function traversalTree(node){
		var html = '';
		if(null != node.parent){
			
			var name1 = '';
			var name2 = '';
			var opt = node.url;
			
			if(node.level == 1){
				name1 = node.name;
			} else {
				name2 = node.name;
			}
			
			html += '<tr>';
			html += '	<td>'+name1+'</td>';
			html += '	<td>'+name2+'</td>';
			html += '	<td>'+opt+'</td>';
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
			id : '0',
			level : 0,
			name : '',
			url : '',
			children : []
		};
		treeMap = [];
		treeMap[treeNode.id] = treeNode;
		var len = gAllMenuList.length;
		for ( var i = 0; i < len; i++) {
			var xco = gAllMenuList[i];
			var parent = treeMap['' + xco.get('menu_fid')];
			var node = {
				parent : parent,
				id : '' + xco.get('menu_id'),
				level : xco.get('menu_level'),
				name : xco.get('menu_name'),
				url : xco.get('menu_url'),
				children : []
			};
			if (parent) {
				parent.children.push(node);
			} else {
				throw "Missing parent:" + xco.get('menu_name');
			}
			treeMap[node.id] = node;
		}
	}
	
	getMenuList(0, 100);
</script>