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
<title>角色管理</title>
</head>
<body>

	<div id="main-content" class="clearfix">
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-sitemap"></i> <a href="#">权限管理</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				</li>
				<li>角色管理
				</li>

			</ul>
			<!--.breadcrumb-->
		</div>
		<!--#breadcrumbs-->

		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>角色管理</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
	                        <div class="form-group">
	                            <button class="btn mar-t-15 mar-l-15 btn-success" onclick="openAddRoleDialog()" type="reset">新增角色</button>
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
										<th>角色名称</th>
										<th>角色描述</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="listgroup">
									<!-- 
									<tr>
										<td>#{$$DATA[i].role_name}</td>
										<td>#{$$DATA[i].role_desc}</td>
										<td>@{getState}</td>
										<td>@{getOpt}</td>
									</tr>
								-->
								</tbody>
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
	var renderPage = true;

	XCOTemplate.pretreatment('listgroup');
	
	/*获取角色列表*/
	function getRoleListPage(start, pageSize) {
		var xco = new XCO();
		xco.setIntegerValue("start", start);
		xco.setIntegerValue("pageSize", pageSize);
		var options = {
			url : "/system/getRoleList.xco",
			data : xco,
			success : getRoleListPageCallBack
		};
		$.doXcoRequest(options);
	}
	/*获取角色列表成功回调*/
	function getRoleListPageCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		var data = xco.getData();
		if (null == data) {
			return;
		}

		var len = data.length;
		var html = "";
		var extendedFunction = {
			getOpt : function() {
				var aHtml = '';
				var roleState = data[i].get("role_state");
				var roleId = data[i].get("role_id");
				if (1 == roleState) {
					aHtml = '<a href="###" onclick="updateState(0, ' + roleId + ')">冻结</a> ';
				} else {
					aHtml = '<a href="###" onclick="updateState(1, ' + roleId + ')">启用</a> ';
				}
				aHtml += '<a href="/system/roleMenu.jsp?roleId=' + roleId + '">编辑权限</a>';
				return aHtml;
			},
			getState : function() {
				var roleState = data[i].get("role_state");
				if (1 == roleState) {
					return '正常';
				}
				return '冻结';
			}
		};

		for ( var i = 0; i < len; i++) {
			xco.setIntegerValue("i", i);
			html += XCOTemplate.execute('listgroup', xco, extendedFunction);
		}
		document.getElementById('listgroup').innerHTML = html;
	}

	/* 设置角色停用启用 */
	function updateState(roleState, roleId) {
		var xco = new XCO();
		xco.setLongValue("roleId", roleId);
		xco.setIntegerValue("roleState", roleState);
		var options = {
			url : "/system/updateRoleState.xco",
			data : xco,
			success : updateStateCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 设置角色停用启用成功回调 */
	function updateStateCallBack(xco) {
		if (0 != xco.getCode()) {
			axError(xco.getMessage());
			return;
		}
		location.reload();
	}
	
	/* 打开添加角色弹窗 */
	function openAddRoleDialog() {
		layer.open({
			type: 1,  
	        title:'新增角色',  
	        skin:'layui-layer-rim',  
	        area:['450px', 'auto'],
	        content: 
        	 '<div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'  
	            +'<div class="input-group" style="position: relative;">'  
		            +'<lable style="position: relative;bottom:15px;left:15px;">角色名称</lable>'  
		            +'<input id="roleName" type="text" class="form-control" placeholder="请输入角色名称" style="margin-left:25px;">'  
	            +'</div>'  
	            +'<div class="input-group" style="margin-top:10px;position: relative;">'  
		            +'<lable style="position: relative;bottom:23px;left:15px;">角色描述</lable>'  
		            +'<textarea id="roleDesc" rows="3" type="text" class="form-control" placeholder="请输入角色描述" style="resize:none;margin-left:25px;"></textarea>'  
	            +'</div>'  
            +'</div>'  
	        ,  
	        btn:['保存','取消'],  
	        btn1: function (index,layero) {  
	        	var roleName = jQuery.trim($('#roleName').val());
				var roleDesc = jQuery.trim($('#roleDesc').val());
				if ('' == roleName || '' == roleDesc) {
					axError('角色名称和描述不能为空.');
					return;
				}
				//运营人员

				var xco = new XCO();
				xco.setStringValue("roleName", roleName);
				xco.setStringValue("roleDesc", roleDesc);
				var options = {
					url : "/system/addRole.xco",
					data : xco,
					success : function(data) {
						if (0 != data.getCode()) {
							axError(data.getMessage());
							return;
						}
						layer.close(index);  
						parent.location.reload();
					}
				};
				$.doXcoRequest(options);
	        },  
	        btn2:function (index,layero) {  
	             layer.close(index);  
	        },  
			scrollbar:false
		});
	}

	getRoleListPage(0, 100);
</script>