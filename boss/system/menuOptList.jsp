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
				<li>菜单管理</li>

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
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
                           <div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addOneMenu" type="reset">新增一级菜单</button>
                                <button class="btn mar-t-15 mar-l-15  btn-success" id="addTwoMenu" type="reset">新增二级菜单</button>
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
										<th>一级</th>
										<th>二级</th>
										<th>地址</th>
										<th>排序</th>
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
	//
	var renderPage = true;
	var gAllMenuList = [];
	var userMenu = '';
	var treeNode = null;//权限数表
	var treeMap = null;

	/* 获取菜单列表 */
	function getMenuList() {
		var xco = new XCO();
		
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
			axError(xco.getMessage());
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
			var url = node.url;
			var sort = '';
			var opt = node.opt;
			
			if(node.level == 1){
				name1 = node.name;
				opt = '<a href="../system/updateOneMenu.jsp?menu_id='+node.id+'">编辑</a>'
						//&nbsp;<a href="javascript:delOneMenuAndRoleMenu(\''+node.id+'\')">删除</a>
			} else {
				name2 = node.name;
				sort = node.sort;
				opt = '<a href="../system/updateTwoMenu.jsp?menu_id='+node.id+'">编辑</a>'
						//&nbsp;<a href="javascript:delTwoMenuAndRoleMenu(\''+node.id+'\')">删除</a>
			}
			
			html += '<tr>';
			html += '	<td>'+name1+'</td>';
			html += '	<td>'+name2+'</td>';
			html += '	<td>'+url+'</td>';
			html += '	<td>'+sort+'</td>';
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
			sort : '',
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
				sort : xco.get('menu_sort'),
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
	
	getMenuList();
	
	/* 新增一级菜单按钮点击事件 */
	$("#addOneMenu").click(function(){
		location.href="../system/addOneMenu.jsp";
	})

	/* 新增二级菜单按钮点击事件 */
	$("#addTwoMenu").click(function(){
		location.href="../system/addTwoMenu.jsp";
	})

	/* 删除一级菜单项 */
	function delOneMenuAndRoleMenu(menuId){
		var xco = new XCO();
		xco.setLongValue("menuId",menuId);
		
		var options = {
			url : "/system/delOneMenuAndRoleMenu.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					location.reload();
				}
			}
		};
		axConfirm("确定删除该菜单项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	
	/* 删除一级菜单项 */
	function delTwoMenuAndRoleMenu(menuId){
		var xco = new XCO();
		xco.setLongValue("menuId",menuId);
		
		var options = {
			url : "/system/delTwoMenuAndRoleMenu.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					location.reload();
				}
			}
		};
		axConfirm("确定删除该菜单项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
</script>