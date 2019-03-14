<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "菜单管理";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>编辑一级菜单</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">权限管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a>菜单管理</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><a>编辑一级菜单</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑一级菜单</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="width:70%;float: left;">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>菜单名称</label>
								<input type="text" class="form-control" id="menuName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>菜单图标</label>
								<input type="text" class="form-control" id="menuIcon" name="title">
								<a href="https://v2.bootcss.com/base-css.html#icons" target="_blank">点击查询图标</a>
							</div>
							<div class="from-group mar-t-15">
								<label>菜单排序</label>
								<input type="text" class="form-control" id="menuSort" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="addOneMenu">保存</button>
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
									<th>一级菜单名</th>
									<th>排序</th>
								</tr>
							</thead>
							<tbody id="listgroup">
								<!-- 
								<tr>
									<td>#{list[i].menu_name}</td>
									<td>#{list[i].menu_sort}</td>
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
	var menuId = getURLparam("menu_id");
	getOneMenu();
	function getOneMenu(){
		var xco = new XCO();
		xco.setLongValue("menuId",menuId);
		var options = {
			url : "/system/getOneMenu.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					data = data.getData();
					$("#menuName").val(data.getStringValue("menu_name"));
					$("#menuIcon").val(data.getStringValue("menu_icon"));
					$("#menuSort").val(data.getIntegerValue("menu_sort"));
				}
			}
		};
		$.doXcoRequest(options);
	}

	//添加按钮点击事件监听
	$("#addOneMenu").click(function(){
		var xco = new XCO();
		
		xco.setLongValue("menuId",menuId);
		
		var menuName = $("#menuName").val();
		if(menuName){
			xco.setStringValue("menuName",menuName);
		}else{
			axError("请输入菜单名称");
			return;
		}

		var menuIcon = $("#menuIcon").val();
		if(menuIcon){
			xco.setStringValue("menuIcon",menuIcon);
		}else{
			axError("请输入菜单图标");
			return;
		}
		
		var menuSort = $("#menuSort").val();
		if(menuSort){
			xco.setIntegerValue("menuSort",menuSort);
		}else{
			axError("请输入菜单排序");
			return;
		}
		
		xco.setStringValue("sys_op_log","编辑一级菜单-编辑："+menuName);
		var options = {
			url : "/system/updataMenu.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("保存成功！",function(){
						location.href="../system/menuOptList.jsp";
					});
				}
			}
		};
		axConfirm("确定保存一级菜单吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../system/menuOptList.jsp";
	})
	XCOTemplate.pretreatment('listgroup');
	
	getSysMenuForSortList();
	/* 获取菜单列表 */
	function getSysMenuForSortList() {
		var xco = new XCO();
		xco.setIntegerValue("menuLevel",1);
		
		var options = {
			url : "/system/getSysMenuForSort.xco",
			data : xco,
			success : getSysMenuForSortListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取菜单列表成功回调 */
	function getSysMenuForSortListCallBack(xco) {
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