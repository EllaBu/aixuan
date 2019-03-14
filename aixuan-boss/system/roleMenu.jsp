<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
	String pageName = "角色管理";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>编辑角色权限</title>
<style type="text/css">
input[type="checkbox"],input[type="radio"] {
	opacity: 1;
	position: static;
	z-index: 12;
	width: 18px;
	height: 18px;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">权限管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="/pmsn/rolelist.jsp">权限管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li>编辑角色权限</li>
			</ul>
			<!--.breadcrumb-->
		</div>
		<!--#breadcrumbs-->

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑角色权限</h1>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<table id="table_bug_report"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>一级</th>
								<th>二级</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="listgroup">
							<!-- 
							<tr>
								<td>@{getName1}</td>
								<td>@{getName2}</td>
								<td>@{getOpt}</td>
							</tr>
						-->
						</tbody>
					</table>
					<input type="button" value=" 保存 " class="btn btn-success" onclick="updateRoleMenu()" /> 
					<input type="button" value=" 返回 " class="btn btn-success" onclick="javascript:history.go(-1);"/>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	XCOTemplate.pretreatment('listgroup');

	var roleId = getURLparam('roleId');
	var gAllMenuList = [];
	var userMenu = '';
	var treeNode = null;//权限数表
	var treeMap = null;

	/* 获取角色权限列表 */
	function getRoleMenu() {
		var xco = new XCO();
		xco.setLongValue("roleId", roleId);
		var options = {
			url : "/system/getRoleMenu.xco",
			data : xco,
			success : getRoleMenuCallBack
		};
		$.doXcoRequest(options);
	}
	/* 获取角色权限列表成功回调 */
	function getRoleMenuCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		xco = xco.getData();
		var allMenuList = xco.get('allMenuList');
		var userMenuList = xco.get('userMenuList');

		if (null == allMenuList) {
			return;
		}

		gAllMenuList = allMenuList;
		listToTree();
		
		var html = traversalTree(treeNode);
		document.getElementById('listgroup').innerHTML = html;
		// 回显
		echoUserMenu(userMenuList);
	}
	
	function traversalTree(node){
		var html = '';
		if(null != node.parent){
			
			var name1 = '';
			var name2 = '';
			var opt = '<input type="checkbox" id="box_' + node.id + '" name="box_' + node.id + '" onclick="chooseMenu(' + node.id + ')" />';
			
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

	function echoUserMenu(userMenuList) {
		if (null == userMenuList || 0 == userMenuList.length) {
			return;
		}
		var len = userMenuList.length;
		var list = [];
		for ( var i = 0; i < len; i++) {
			var xco = userMenuList[i];
			var box = document.getElementById('box_' + xco.get('menu_id'));
			box.checked = true;
			list.push(xco.get('menu_id'));
		}
		userMenu = list.toString();
	}

	function chooseMenu(id) {
		var box = document.getElementById('box_' + id);
		if (box.checked) {
			var node = treeMap['' + id];
			if (node) {
				// 向下: 递归选中
				traversalDown(node, true, false);
				// 向上: 递归选中
				traversalUp(node, true);
			}
		} else {
			var node = treeMap['' + id];
			if (node) {
				traversalDown(node, false, false);
				traversalUp(node, false);
			}
		}
	}

	/* 向下: 递归选中 */
	function traversalDown(node, flag, self) {
		if (self) {
			var box = document.getElementById('box_' + node.id);
			box.checked = flag;
		}
		var children = node.children;
		var len = children.length;
		for ( var i = 0; i < len; i++) {
			traversalDown(children[i], flag, true);
		}
	}

	/* 向上: 递归选中 */
	function traversalUp(node, flag) {
		var parent = node.parent;
		if (null == parent || '0' == parent.id) {
			return;
		}
		if (flag) {
			var box = document.getElementById('box_' + parent.id);
			box.checked = flag;
			traversalUp(parent, flag);
		} else {
			var children = parent.children;
			var len = children.length;
			var up = true;
			for ( var i = 0; i < len; i++) {
				var box = document.getElementById('box_' + children[i].id);
				if (box.checked) {
					up = false;
					break;
				}
			}
			if (up) {
				var box = document.getElementById('box_' + parent.id);
				box.checked = flag;
				traversalUp(parent, flag);
			}
		}
	}
	
	/*修改菜单权限*/
	function updateRoleMenu() {
		var len = gAllMenuList.length;
		var umList = [];
		for ( var i = 0; i < len; i++) {
			var xco = gAllMenuList[i];
			var box = document.getElementById('box_' + xco.get('menu_id'));
			if (box.checked) {
				umList.push(xco.get('menu_id'));
			}
		}

		if (userMenu == umList.toString()) {
			axError('菜单权限无变化，无需修改.');
			return;
		}

		var xco = new XCO();
		xco.setLongValue("roleId", roleId);
		xco.setLongArrayValue("menuIds", umList);
		var options = {
			url : "/system/updateRoleMenu.xco",
			data : xco,
			success : updateRoleMenuCallBack
		};
		$.doXcoRequest(options);
	}

	/*修改菜单权限成功回调 */
	function updateRoleMenuCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		location.replace("/system/roleList.jsp");
	}
	
	function listToTree() {
		treeNode = {
			parent : null,
			id : '0',
			level : 0,
			name : '',
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
				level : '' + xco.get('menu_level'),
				name : xco.get('menu_name'),
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

	getRoleMenu();
</script>