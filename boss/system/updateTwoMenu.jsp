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
<title>编辑二级菜单</title>
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
				<li><a>编辑二级菜单</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>编辑二级菜单</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15" style="width:70%;float:left;">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label>一级菜单名称</label>
								<span id="menuFid"></span>
							</div>
							<div class="from-group mar-t-15">
								<label>二级菜单名称</label>
								<input type="text" class="form-control" id="menuName" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>菜单地址</label>
								<input type="text" class="form-control" id="menuUrl" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label>菜单排序</label>
								<input type="text" class="form-control" id="menuSort" name="title">
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="updateTwoMenu">保存</button>
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
									<th>二级菜单名</th>
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
			url : "/system/getOneMenu2.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					data = data.getData();
					$("#menuName").val(data.getStringValue("menu_name"));
					$("#menuSort").val(data.getIntegerValue("menu_sort"));
					$("#menuUrl").val(data.getIntegerValue("menu_url"));
					$("#menuFid").text(data.getIntegerValue("menu_fid_name"));
					getSysMenuForSortList(data.getIntegerValue("menu_fid"));
				}
			}
		};
		$.doXcoRequest(options);
	}
	//修改按钮点击事件监听
	$("#updateTwoMenu").click(function(){
		var xco = new XCO();
		xco.setLongValue("menuId",menuId);
		
		var menuName = $("#menuName").val();
		if(menuName){
			xco.setStringValue("menuName",menuName);
		}else{
			axError("请输入二级菜单名称");
			return;
		}
		var menuUrl = $("#menuUrl").val();
		if(menuUrl){
			xco.setStringValue("menuUrl",menuUrl);
		}else{
			axError("请输入菜单地址");
			return;
		}
		
		var menuSort = $("#menuSort").val();
		if(menuSort){
			xco.setIntegerValue("menuSort",menuSort);
		}else{
			axError("请输入菜单排序");
			return;
		}

		xco.setStringValue("sys_op_log","编辑二级菜单-编辑："+menuName);
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
		axConfirm("确定保存二级菜单吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../system/menuOptList.jsp";
	})
	
	XCOTemplate.pretreatment('listgroup');
	
	/* 获取菜单列表 */
	function getSysMenuForSortList(menuFid) {
		var xco = new XCO();
		xco.setIntegerValue("menuLevel",2);
		xco.setLongValue("menuFid",menuFid);
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